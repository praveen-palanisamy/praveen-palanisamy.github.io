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

[![prisma-postgres-pgvector-db]({{site.img_path}}/apps/prisma-postgres-pgvector_sm.jpg){:class="img-responsive"}](#)

# Setting up a Vector Database store using Prisma and PostgreSQL with PgVector extension

[Prisma](https://prisma.io) is useful as an object-relational mapper (ORM) and Postgres is one of the supported database backend. Prisma is used to define the database schema in a simple Schema Definition Language (SDL) and can help with migrations and to auto generate the Prisma Client with type declarations for Javascript/Typescript. The generated Prisma Client is tailored to the models and views in the Schema and is used to interact with the database.

<!-- toc -->

- [Setting up a Vector Database store using Prisma and PostgreSQL with PgVector extension](#setting-up-a-vector-database-store-using-prisma-and-postgresql-with-pgvector-extension)
  - [0. Setup VectorDB using Prisma](#0-setup-vectordb-using-prisma)
  - [0. Setup Schema](#0-setup-schema)
  - [1. Update VectorDB schema](#1-update-vectordb-schema)
  - [Issues](#issues)

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

> NOTE: The `map` and `schema` values are optional. The values `vector` and `extensions` respectively work when using [Supabase](https://supabase.com).

## 1. Update VectorDB schema

1. Make changes to prototype and develop the Prisma schema file as necessary.
1. Run `npx prisma db push` to update the database schema and generate Prisma Client. This will generate Prisma Client but not record the schema change history in the database.
1. When the schema is in a relatively stable state, run `npx prisma migrate dev --name <migration-name>` to create a new migration and apply it to the database.
1. Run `npx prisma migrate dev --name <migration-name>` to create a new migration and apply it to the database.
1. Run `npx prisma generate` to generate Prisma Client.
1. (Optional) Run `npx prisma studio` to open the Prisma Studio GUI to view the data in the database.

## Issues

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

