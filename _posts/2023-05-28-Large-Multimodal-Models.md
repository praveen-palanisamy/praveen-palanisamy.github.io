---
title: Large Multimodal Models
date: 2023-05-28 00:00:00 Z
desc: Large Multimodal Models
keywords: AI, LLMs, multimodal, models
categories: [blog, AI, LLM]
tags: AI, LLMs, mul
icon: fa-robot
---

## Large Multi-Modal Datasets

Overview of multimodal datasets available for training Large Multimodal Models (LMMs).

<div id="datasets"></div>

<!-- import and parse CSV file data supplied via include parameter csvDataFile, display in a XL like DataGrid -->
<style>
    #grid {
      height: 85%;
    }
</style>

<!-- Papa Parse (to import and parse CSV files) -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/PapaParse/5.3.1/papaparse.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/gridjs/dist/gridjs.umd.js"></script>
<link href="https://cdn.jsdelivr.net/npm/gridjs/dist/theme/mermaid.min.css" rel="stylesheet" />

<script>
    Papa.parse("/static/assets/data/multimodal-models_datasets.csv", {
        download: true,
        header: true,
        dynamicTyping: true,
        complete: function(results) {
            console.log("results:", results);
            console.log("results.data:", results.data);
            console.log(document.getElementById("datasets"));
            grid = new gridjs.Grid({
                data: results.data,
                pagination: {
                    limit: 10
                },
                search: true,
                sort: true,
            }).render(document.getElementById("datasets"));
        }
    });
</script>

## Large Multi-Modal Models

Overview of Large Multimodal Models (LMMs) available/published/used in research.

<div id="models"></div>

<!-- import and parse CSV file data supplied via include parameter csvDataFile, display in a XL like DataGrid -->
<style>
    #grid {
      height: 85%;
    }
</style>

<!-- Papa Parse (to import and parse CSV files) -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/PapaParse/5.3.1/papaparse.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/gridjs/dist/gridjs.umd.js"></script>
<link href="https://cdn.jsdelivr.net/npm/gridjs/dist/theme/mermaid.min.css" rel="stylesheet" />

<script>
    Papa.parse("/static/assets/data/multimodal-models.csv", {
        download: true,
        header: true,
        dynamicTyping: true,
        complete: function(results) {
            console.log("results:", results);
            console.log("results.data:", results.data);
            console.log(document.getElementById("datasets"));
            grid = new gridjs.Grid({
                data: results.data,
                pagination: {
                    limit: 10
                },
                search: true,
                sort: true,
            }).render(document.getElementById("models"));
        }
    });
</script>

## References

[1] [Large-scale Multi-Modal Pre-trained Models: A
Comprehensive Survey](https://arxiv.org/abs/2302.10035)
