---
title: Vector Embeddings DB using Prisma and PostgreSQL with PgVector extension
date: 2023-04-23
desc: Creating a vector embeddings database using Prisma and PostgreSQL
keywords: [LLMs, embeddings, prisma, postgresql, supabase]
categories: [Blog]
tags: [LLMs, embeddings, supabase]
icon: fa-book
thumbnail: /static/assets/img/blog/apps/prisma-postgres-pgvector_sm.jpg
---

# Setting up a Vector Database store using Prisma and PostgreSQL with PgVector extension

[Prisma](https://prisma.io) is useful as an object-relational mapper (ORM) and Postgres is one of the supported database backend. Prisma is used to define the database schema in a simple Schema Definition Language (SDL) and can help with migrations and to auto generate the Prisma Client with type declarations for Javascript/Typescript. The generated Prisma Client is tailored to the models and views in the Schema and is used to interact with the database.

<!-- toc -->

- [Setting up a Vector Database store using Prisma and PostgreSQL with PgVector extension](#setting-up-a-vector-database-store-using-prisma-and-postgresql-with-pgvector-extension)
  - [0. Setup VectorDB using Prisma](#0-setup-vectordb-using-prisma)
  - [0. Setup Schema](#0-setup-schema)
  - [1. Update VectorDB schema](#1-update-vectordb-schema)
  - [2. Using Prisma for storing Vector Embeddings in PostgreSQL with PgVector extension](#2-using-prisma-for-storing-vector-embeddings-in-postgresql-with-pgvector-extension)
    - [Inserting/Upserting to the Database](#insertingupserting-to-the-database)
  - [Issues and Troubleshooting](#issues-and-troubleshooting)

<!-- tocstop -->

## 0. Setup VectorDB using Prisma

1. Define DB `provider` and `url` in `prisma/schema.prisma` file as follows:

```prisma
datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
  directUrl = env("DIRECT_DATABASE_URL")
}
```

1. Setup `.env` file with the following variables:

```bash
DATABASE_URL="postgres://<user>:<password>@<host>:<port>/<database>?pgbouncer=true"
DIRECT_DATABASE_URL="postgresql://<user>:<password>@<host>:<port>/<database>"
```

**Notes:**

- Remember to replace the `<user>`, `<password>`, `<host>`, `<port>`, and `<database>` placeholders with the actual values.
- Notice that the `DATABASE_URL` is prefixed with `postgres://` and the `DIRECT_DATABASE_URL` is prefixed with `postgresql://`.
- (optional) Use percent encoding to escape special characters (if any) in the password.

## 0. Setup Schema

1. Use Prisma Schema Language to define the data model in a schema file. The schema file is named `prisma/schema.prisma` by convention.
1. When the schema is in a relatively stable state, create the DB schema for the first time Run: `npx prisma migrate dev --name init` to create the database schema and generate Prisma Client.
1. Update `schema.prisma` to include `postgresqlExtensions` `previewFeatures`

```prisma
generator client {
  provider        = "prisma-client-js"
  previewFeatures = ["postgresqlExtensions"]
}
```

1. (optional) Pull the extensions list from the database: `npx prisma db pull`
1. Add the `pgvector` extension to the `datasource` block in `schema.prisma`:

```prisma
datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
  directUrl = env("DIRECT_DATABASE_URL")
  extensions = [pgvector(map: "vector", schema: "extensions")]
}
```

> NOTE: The `map` and `schema` are optional arguments for the extension. You could just use: `extensions = [vector]`. The `extensions = [pgvector(map: "vector", schema: "extensions")]` is useful when using [Supabase](https://supabase.com).

## 1. Update VectorDB schema

1. Make changes to prototype and develop the Prisma schema file as necessary.
1. Run `npx prisma db push` to update the database schema and generate Prisma Client. This will generate Prisma Client but not record the schema change history in the database.
1. When the schema is in a relatively stable state, run `npx prisma migrate dev --name <migration-name>` to create a new migration and apply it to the database.
1. Run `npx prisma migrate dev --name <migration-name>` to create a new migration and apply it to the database.
1. Run `npx prisma generate` to generate Prisma Client.
1. (Optional) Run `npx prisma studio` to open the Prisma Studio GUI to view the data in the database.

## 2. Using Prisma for storing Vector Embeddings in PostgreSQL with PgVector extension

For a complete reference sample, let's define the data model in `schema.prisma` as follows:

```prisma
generator client {
  provider        = "prisma-client-js"
  previewFeatures = ["postgresqlExtensions"]
}

datasource db {
  provider   = "postgresql"
  url      = "DATABASE_URL"
  extensions = [vector]
}

model Embedding{
  id     Int    @id @default(autoincrement())
  text   String
  vector Unsupported("vector(4)")  // vector(n) for a n-dimensional vector.
}
```

> Note: We have to use `Unsupported("vector(4)")` for the `vector` field because Prisma Schema Language (Schema) does not support the `vector` type (as of Prisma 4.13.0).

With the above Data model, we can use Prisma to store and retrieve vector embeddings in PostgreSQL with PgVector extension. The `vector` field is of type `Unsupported("vector(4)")` which is a 4-dimensional vector. You can update this to suit your actual embedding size for example `1536` when using OpenAI's `text-embedding-*-002` models.The `vector` field is stored in the `vector` column in the `Embedding` table in the database.

Apply the above schema to the database depending on your situation:

1. If you don't have an existing database, you can use `npx prisma migrate dev --name init` to create the database schema and generate Prisma Client.
1. If you have an existing database, you can use `npx prisma introspect` to generate the Prisma schema from the database schema and then use `npx prisma generate` to generate Prisma Client. OR you can use baselining to initialize the database schema and generate Prisma Client. See [Baselining](https://www.prisma.io/docs/guides/migrate/developing-with-prisma-migrate/baselining) for more details.

The generated SQL migration script under `prisma/migrations/` will look like this:

```sql
-- CreateExtension
CREATE EXTENSION IF NOT EXISTS "vector" WITH SCHEMA "extensions";

-- CreateTable
CREATE TABLE "Embedding" (
    "id" SERIAL NOT NULL,
    "text" TEXT NOT NULL,
    "vector" vector(4) NOT NULL,

    CONSTRAINT "Embedding_pkey" PRIMARY KEY ("id")
);
```

After you have applied the above schema to the database (using `prisma migrate` or `prisma db push`), the database will have the `vector` field type created in the corresponding (`Embedding`) table as per the SQL above.

Since the Prisma Schema language does not support the `vector` type, the generated Prisma Client will not include the `vector` field in the `Embedding` model.
For example, the following Application code to insert vector data into a PostgreSQL database using Prisma does not work:

```ts
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

async function main() {
  const embedding = await prisma.embedding.create({
    data: {
      text: "Hello World",
      // vector: [1, 2, 3, 4], // This does not work.
    },
  });
  console.log(embedding);
}

main()
  .catch((e) => {
    throw e;
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
```

See [Prisma docs on Unsupported field types](https://www.prisma.io/docs/concepts/components/prisma-schema/features-without-psl-equivalent#unsupported-field-types) for more information. You can still execute raw SQL to insert vector data into your database via Prisma. Let's see how in the next section below.

### Inserting/Upserting to the Database

The following sample script uses `prisma.$executeRaw` to insert vector embeddings into a postgreSQL database with the `pgvector` extension installed and updated using the Prisma data model and migration/SQL script discussed above.

```ts
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

async function main() {
  // Generate embeddings
  const vectorEmbedding1 = JSON.stringify([1, 2, 3, 4]);
  const vectorEmbedding2 = JSON.stringify([64, 256, 512, 1024]);

  // Insert embeddings into DB
  await prisma.$executeRaw`INSERT INTO embedding (vector) VALUES (${vectorEmbedding1}::vector), (${vectorEmbedding2}::vector)`;

  // Search/Query and retrieve embeddings
  const results =
    await prisma.$queryRaw`SELECT id, embedding::text FROM embedding ORDER BY vector >-> ${vecEmbed}::vector LIMIT 2`;
}

main()
  .catch((e) => {
    throw e;
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
```

## Issues and Troubleshooting

1. Composite types are ignored by Prisma. Prisma only supports composite types for MongoDB.

The following simple model is not feasible with Prisma:

```prisma
model File {
  id        Int      @id @default(autoincrement())
  name      String
  chunks Embedding[]  // Composite type. Not supported by Prisma.
}

model Embedding{
  id     Int    @id @default(autoincrement())
  embedding Unsupported("vector")
}
```

The generated Prisma Client will not include the `chunks` field in the `File` model.

The generated `migrations.sql` looks like this:

```sql
-- CreateExtension
CREATE EXTENSION IF NOT EXISTS "vector" WITH SCHEMA "extensions";

-- CreateTable
CREATE TABLE "File" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "File_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Embedding" (
    "id" SERIAL NOT NULL,
    "text" TEXT NOT NULL,
    "embedding" vector,

    CONSTRAINT "TextEmbedding_pkey" PRIMARY KEY ("id")
);
```

Related issues/feature-requests [Reuse collections of fields inside models](https://github.com/prisma/prisma/issues/2371) and, [Support for native DB composite types](https://github.com/prisma/prisma/issues/4263) has been open since 2020!

There is a helpful troubleshooting section for some of the common issues when using Prisma with Supabase [here](https://supabase.com/docs/guides/integrations/prisma#troubleshooting).
