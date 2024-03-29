---
title: Platform and Tools for the AI Era - Microsoft Build 2023
date: 2023-05-23 00:00:00 Z
desc: Newly announced suite of AI tools and services for every developer on a single platform with AI Copilots.
keywords: Microsoft CoPilot
categories: [blog]
tags: Microsoft CoPilot
icon: fa-robot
thumbnail: /static/assets/img/blog/msbuild23/ai-era-tools-msbuild23.jpg
---

Here's a quick, key summary of the key announcements from Microsoft Build 2023.

## Microsoft CoPilot Stack, Plugins, Orchestration

The Copilot Stack that Microsoft used to build CoPilot is now available for developers to build their own CoPilots. The stack groups Copilots and Plugin extensibility under the Apps layer and has an AI Orchestration Layer that uses Prompts & response filtering coupled with "Metaprompt". This layers interacts with an underlying Grounding and Plugin execution Layer all of which take AI safety into account. Underlying these layers is the AI Orchestration Layer that is on top of the Foundation Models (FMs) and the AI Infrastructure Layer (aka Azure). It's great to see that Microsoft recognizes and supports OSS FMs under the "BYO" (Bring Your Own) models.

The stack includes the following components:

![Microsoft Copilot Stack Overview](/static/assets/img/blog/msbuild23/msft-copilot-stack-overview.png){:class="img-responsive"}

![Microsoft CoPilot Stack](/static/assets/img/blog/msbuild23/msft-copilot-stack.png){:class="img-responsive"}

### Microsoft 365 CoPilot

GPT-powered CoPilot with plugins(!) integrated into all of Microsoft 365: Word, Excel, PowerPoint, Outlook, Teams, and more.

![Microsoft 365 CoPilot](/static/assets/img/blog/msbuild23/msft-365-copilot.jpg){:class="img-responsive"}

## Windows CoPilot

GPT-powered CoPilot with plugins(!) integrated into all of Windows: Apps, Settings, and more.

<div class="image-grid-container">
  <div class="image-grid-row">
    <div class="image-grid-column">
      <img src="https://github.com/praveen-palanisamy/praveen-palanisamy.github.io/assets/4770482/f26e66db-4ca0-4016-a0b8-15767867e6ac" alt="Windows Copilot DevHome VSCode">
    </div>
    <div class="image-grid-column">
      <img src="https://github.com/praveen-palanisamy/praveen-palanisamy.github.io/assets/4770482/44f46742-c32b-4679-b230-8212d5eb30c1" alt="Windows Copilot Calendar">
    </div>
  </div>
  <div class="image-grid-row">
    <div class="image-grid-column">
      <img src="https://github.com/praveen-palanisamy/praveen-palanisamy.github.io/assets/4770482/7882ce3f-e3fa-4ea8-bce0-871066b9216c" alt="Windows Copilot DevHome">
    </div>
    <div class="image-grid-column">
      <img src="https://github.com/praveen-palanisamy/praveen-palanisamy.github.io/assets/4770482/98051d58-4a96-4789-9e34-985a0502f1f7" alt="Windows Copilot Documents Q&A">
    </div>
  </div>
</div>

<div class="auto-resizable-iframe">
  <div>
    <iframe frameborder="0" rel="0" controls="0" allowfullscreen="" src="https://youtube.com/embed/FCfwc-NNo30?rel=0"></iframe>
  </div>
</div>

## Azure AI Studio

![Azure-AI-Studio](https://github.com/praveen-palanisamy/praveen-palanisamy.github.io/assets/4770482/a1f31609-7e0e-4557-8469-17a3a9090d82){:class="img-responsive"}

![Azure-AI-Studio-Safety](https://github.com/praveen-palanisamy/praveen-palanisamy.github.io/assets/4770482/62c2ecde-6f35-4e3e-9e54-c27cfc80ed63){:class="img-responsive"}

### Model Catalog

1. Open Source Models, 2. Hugging Face Hub, 3. Azure OpenAI Service offering LLMs from OpenAI powered by Azure OpenAI Service for Prompt Engineering, finetuning, evaluation and deployment.

![Azure-AI-Studio-Model-Catalog](https://github.com/praveen-palanisamy/praveen-palanisamy.github.io/assets/4770482/ef6c9dad-ee7f-4965-a931-91ce5d12af44){:class="img-responsive"}

### PromptFlow

Integrates with LangChain, Semantic Kernel, custom prompt templates, Vector Databases, FAISS Index, Serp API and, more tools.

![PromptFlow](/static/assets/img/blog/msbuild23/announcing-prompt-flow.png){:class="img-responsive"}

Prompt Flow is integrated into Azure ML Studio:
![prompt-flow on AML studio](https://github.com/praveen-palanisamy/praveen-palanisamy.github.io/assets/4770482/5caae380-2acc-4e63-8b93-e85766748586){:class="img-responsive"}

<div class="auto-resizable-iframe">
  <div>
    <iframe frameborder="0" rel="0" controls="0" allowfullscreen="" src="https://youtube.com/embed/DaIYrlMOj7I?rel=0"></iframe>
  </div>
</div>

### Azure OpenAI Service on Your Data

![AOAI Service on your data](/static/assets/img/blog/msbuild23/aoai-service-on-your-data.png){:class="img-responsive"}

## Microsoft Fabric

An end-to-end analytics platform fro enterprises in the era of AI. It offers a highly integrated, easy-to-use product that offers a suite of services, including data lake, data engineering, and data integration that simplifies analytics needs without having to piece together services from different vendors. The platform is built on a Software as a Service (SaaS) foundation, offering simplicity and integration unmatched by other offerings.

![Microsoft-Fabric-OneLake](https://github.com/praveen-palanisamy/praveen-palanisamy.github.io/assets/4770482/dabf3d36-0341-430d-95bc-245fb6adc236){:class="img-responsive"}

![Microsoft-OneLake-Data-Platform](https://learn.microsoft.com/en-us/fabric/get-started/media/microsoft-fabric-overview/workloads-access-data.png){:class="img-responsive"}

<div class="auto-resizable-iframe">
  <div>
    <iframe frameborder="0" rel="0" controls="0" allowfullscreen="" src="https://youtube.com/embed/X_c7gLfJz_Q?rel=0"></iframe>
  </div>
</div>

## Other exciting announcements

### Vector Search using CosmosDB for MongoDB Atlas

The first MongoDB-compatible fully managed No-SQL offering to support Vector Search. [Read More](https://devblogs.microsoft.com/cosmosdb/introducing-vector-search-in-azure-cosmos-db-for-mongodb-vcore/).
This is a big plus for the AI era and will join PostgresQL + PGVector, Pinecone, Milvus, Qdrant, Chroma, Vespa and other Vector Search offerings.

![CosMos DB for MongoDB Atlas with Vector Search](https://devblogs.microsoft.com/cosmosdb/wp-content/uploads/sites/52/2023/05/vector_search_vcore.png){:class="img-responsive"}

### Nvidia Omniverse Cloud

![Nvidia Omniverse Cloud](/static/assets/img/blog/msbuild23/nvidia-omniverse-cloud.jpg){:class="img-responsive"}
