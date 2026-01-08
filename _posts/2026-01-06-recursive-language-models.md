---
layout: post
title: "Inner-Loop Deliberation vs Outer-Loop Orchestration in Recursive Language Models"
subtitle: "The Shift to Programmatic Recursive Inference for Infinite Context and Agentic Memory"
date: 2026-01-06
keywords: ["rlm", "recursive language models", "thinking models", "agentic loops", "agentic orchestration", "context folding", "ai agents", "long context", "reinforcement learning", "inference scaling"]
author: "Praveen Palanisamy"
header-img: "img/post-bg-rl-robots.jpg"
categories: ["Agents", "AI Architecture"]
tags: ["rlm", "recursive language models", "thinking models", "agentic loops", "agentic orchestration", "context folding", "ai agents", "long context"]
permalink: /blog/2026/deliberation-orchestration-recursive-language-models-20260106/
identifier: "recursive-language-models-20260106"
academic_post: true
references:
  - id: zhang2025rlm
  - id: prime2026rlm
  - id: arxiv2025rlm
  - id: dao2022flashattention
  - id: liu2023lostmiddle
  - id: liu2024hcot
  - id: yao2022react
  - id: schick2023toolformer
  - id: packer2023memgpt
  - id: kwon2023vllm
  - id: openai2024reasoning
  - id: semianalysis2024hbm
  - id: edn2025hbm4
---

# Test-Time Compute Meets Agentic Memory Hierarchies 

Recent LLM systems increasingly get better long-horizon behavior by wrapping the model in an iterative agent loop (retrieve/compute/write state → re-prompt) rather than trying to fit all required information into one prompt.
​
This “recursive outer-loop” framing is a practical response to two issues with very large context windows:  
1. **Cost grows quickly with sequence length**, and  
2. **Models do not reliably use all tokens in long prompts** (e.g., evidence placed in the middle is often underutilized).  

Approaches like Recursive Language Models (RLMs) {% include wiki-citation.html ref_id="zhang2025rlm" %} represent a shift from "one-shot" inference to "programmatic recursive inference."

## The Shift to Programmatic Recursive Inference

A common baseline for “hard” tasks is still one-shot prompting: concatenate large amounts of text/code into the prompt and rely on attention to surface what matters {% include wiki-citation.html ref_id="liu2023lostmiddle" %}.
​
That approach pushes both compute and memory bandwidth: attention has unfavorable scaling with sequence length and repeatedly reads the accumulated KV-cache during decoding, so longer prompts increase per-token work and memory traffic {% include wiki-citation.html ref_id="dao2022flashattention" %}.
​
Empirically, more context is not automatically more usable; long-context evaluations show strong position effects (“lost in the middle”), which is one concrete reason large prompts can feel brittle even when the answer is present.

## Architectural Analogy: Flat Prompt vs Memory Hierarchy

A “single huge prompt” behaves like a flat memory model: everything is placed in the same addressable space (the attention window) and is in principle accessible at each decode step.
​
In practice, this is expensive (sequence-length scaling + KV-cache traffic) and reliability-limited (attention does not allocate capacity uniformly across positions).
​
A recursive outer-loop makes the hierarchy explicit by splitting **active working** set from **backing store**:

- **L1 (active context)**: the bounded prompt window + KV-cache that the model attends over at low latency.

- **L2 (managed KV working set)**: serving-time memory management that treats KV as paged blocks to reduce fragmentation and improve multiplexing across requests (an OS-like technique applied to KV).
​
- **L3 (external memory / tools)**: documents, code, logs, and computations accessed by explicit fetch/execute steps; outputs are then summarized or pasted back into L1 as needed.

The trade-off is straightforward: the system pays additional round-trip latency and extra LLM calls, but it can keep the hot context small and targeted, which tends to improve robustness on long tasks compared with “stuff everything into the prompt.”

## Beyond the Context Window: Paging Memory and Compute Through Iterative LLM REPLs

For years, the dominant approach to reasoning has been to blindly scale the context window: stuffing (chunked/summarized/RAGed) megabytes of documents, codebases, and history into a single prompt. This is the "unified memory" model: fast, but brittle, and prone to "context rot."

Systems like RLM {% include wiki-citation.html ref_id="zhang2025rlm" %} propose a different path: treating context not as a stream of tokens to be consumed, but as an **external variable handle**. In this paradigm, the model is given a "working memory" (the prompt) and access to "external memory" (the REPL variables). It programmatically queries, searches, and decomposes this context using code and recursive sub-calls.

This is part of a larger trend where AI system design is separating into two distinct feedback loops, optimizing for different sets of constraints and objectives.

## The Two Recursions of LLMs: Autoregressive “Thinking” and Tool-Driven “Acting & Remembering”

### 1. The Recursive Inner-Loop: "Thinking"

The inner-loop is inference-time recurrence: each decoded token triggers another transformer forward pass that re-reads prior keys/values (KV-cache) and appends new K/V for the next step, so “more thinking” operationally means more decode steps and more KV traffic. {% include wiki-citation.html ref_id="dao2022flashattention" %}

This is the **inference-time recurrence** of an autoregressive transformer: repeated forward passes that update internal state (KV-cache, residual stream) as tokens are generated. It corresponds to fast pattern completion (**System 1**) and—when extended with extra test-time compute—approaches slower **System 2**, increasingly via *hidden or compact reasoning* rather than always-visible Chain-of-Thought {% include wiki-citation.html ref_id="openai2024reasoning" %}. 

#### Mechanism

Autoregressive “thinking” is inference-time recurrence: each decoded token triggers a new transformer forward pass that reads the accumulated KV-cache and appends fresh keys/values, so additional test-time compute is realized as *more decode steps* (and therefore more KV reads/writes) rather than literal recursion within a single pass. {% include wiki-citation.html ref_id="dao2022flashattention" %}

Long-context behavior is not uniformly reliable: even when relevant evidence is present in the prompt, accuracy can degrade when that evidence is positioned far from the ends of the sequence (the “lost-in-the-middle” effect), which is a concrete mechanism behind perceived context degradation at scale. {% include wiki-citation.html ref_id="liu2023lostmiddle" %}

When “System-2-like” behavior is induced, it increasingly need not correspond to verbose, user-visible chain-of-thought; hidden/compact deliberation approaches attempt to preserve multi-step reasoning signal while compressing or internalizing intermediate reasoning states during decoding. {% include wiki-citation.html ref_id="liu2024hcot" %}

- **Autoregressive recurrence (not literal recursion inside one pass):** Each decoded token triggers another transformer forward pass, where attention reads an ever-growing **KV-cache** and appends new K/V for the next step.
- **Reasoning = additional inference compute:** “Thinking longer” often means allocating more decode steps and/or internal deliberation tokens, increasing the number of forward passes and memory traffic.
- **Visible CoT → hidden/compact reasoning:** Research on “hidden chain-of-thought” and related techniques explicitly aims to retain the benefits of multi-step reasoning while reducing the cost and/or exposure of full textual CoT.

#### Advantages
Inner-loop recurrence provides extremely low-latency pattern completion because all computation stays on-device within a tight decode loop over a bounded active context (prompt + KV-cache), enabling high-throughput token generation when the hot working set fits the memory hierarchy well. {% include wiki-citation.html ref_id="dao2022flashattention" %}

IO-aware attention implementations reduce the effective memory traffic of attention by restructuring reads/writes to better match GPU memory hierarchies, improving realized throughput for long sequences without approximating attention semantics. {% include wiki-citation.html ref_id="dao2022flashattention" %} 

Hidden/compact reasoning techniques can reduce exposure of intermediate reasoning traces while still providing a mechanism for multi-step refinement at inference time, which can be useful for both efficiency and governance constraints around revealing intermediate thoughts. {% include wiki-citation.html ref_id="liu2024hcot" %} 

#### Constraints (the memory wall)

**The hot working set is strictly bounded:**  KV-cache grows with sequence length and must be consulted every step, so context length and deliberation depth translate directly into higher bandwidth pressure and latency per generated token. {% include wiki-citation.html ref_id="dao2022flashattention" %} 

Long-context reliability failures (e.g., lost-in-the-middle) imply that “just add more tokens” is not a monotonic scaling strategy; beyond capacity/bandwidth costs, effective utilization can degrade due to model positional biases and retrieval inefficiency inside attention. {% include wiki-citation.html ref_id="liu2023lostmiddle" %} 

Compact/hidden deliberation schemes introduce their own failure modes (e.g., dependence on auxiliary latent representations and decoding procedures), shifting complexity from user-visible text to model-/system-level protocols that must be validated under distribution shift. {% include wiki-citation.html ref_id="liu2024hcot" %} 

- **Bandwidth + capacity dominate many inference regimes:** Long-context and long-deliberation decode are frequently bounded by moving weights/activations/KV through HBM/VRAM (and not purely by peak FLOPs), because KV-cache scales with context length and must be accessed every token {% include wiki-citation.html ref_id="semianalysis2024hbm" %}.
- **HBM keeps scaling, but it’s still a packaging-centric problem:** JEDEC finalized **HBM4** in 2025, targeting higher per-stack bandwidth (e.g., up to ~2 TB/s class figures often cited for the standard), but translating that into usable system performance depends on integrating enough stacks close to compute {% include wiki-citation.html ref_id="edn2025hbm4" %}.
- **Advanced packaging is a first-order limiter:** The practical “inner-loop size” is gated by how much high-bandwidth memory can be co-packaged and coherently accessed at speed—constraints that show up as supply/complexity bottlenecks beyond raw logic-node shrink.

- **Strictly bounded hot working set:** The inner loop is bounded by addressable high-bandwidth memory plus effective interconnect bandwidth (when sharding weights/KV across devices) {% include wiki-citation.html ref_id="semianalysis2024hbm" %}.
- **No infinity in the hot path:** “Infinite context” cannot live in KV-cache without exploding capacity/bandwidth costs; longer context directly expands KV and increases per-token decode pressure.
- **Core trade-off:** Context length, batch/throughput, and deliberation depth are coupled knobs constrained by finite HBM capacity and finite memory/interconnect bandwidth {% include wiki-citation.html ref_id="semianalysis2024hbm" %}.


### 2. The Recursive Outer-Loop: "Acting & Remembering"

This is the **System 2 orchestration layer**: an agentic/REPL-style loop that treats the LLM as a fixed-weight “reasoning core” and composes tools, retrieval, and state management around it. The outer loop expands capability by **paging** information into the inner loop on demand, rather than trying to make the inner loop hold everything at once {% include wiki-citation.html ref_id="openai2024reasoning" %}. 

#### Mechanism

The outer-loop is a System-2 orchestration layer that wraps the LLM in an agentic control cycle (observe → reason/plan → act via tools/retrieval → write external state → re-prompt), effectively turning tool calls and state updates into explicit “memory accesses” that feed the inner-loop only what is currently needed. {% include wiki-citation.html ref_id="yao2022react" %}

Tool use can be integrated as a learned policy: models can be trained (or self-trained) to decide when to call external APIs and how to incorporate returned values into subsequent generation, making “fetch” operations a first-class computational primitive rather than an ad hoc wrapper. {% include wiki-citation.html ref_id="schick2023toolformer" %} {% include wiki-citation.html ref_id="zhang2025rlm" %}

External-memory managers can implement OS-like policies for what stays in-context vs. what gets evicted, summarized, or retrieved later (“virtual context”), treating the prompt window as a scarce cache and external stores as a larger address space. {% include wiki-citation.html ref_id="packer2023memgpt" %}


- **Agentic control loop:** Iterate: observe → retrieve/plan → call tools (code execution, search, sub-model calls) → write results to external state → re-prompt the model.
- **Hierarchical memory:** Maintain tiers:
  - *Hot:* prompt + KV-cache in HBM/VRAM (fast, small).
  - *Warm:* host DRAM (larger, slower).
  - *Cold:* NVMe/SSD/object storage (huge, much slower).
- **Compression + indexing:** Summarize, embed, and structure artifacts so the inner loop only sees the task-relevant slice, while the system preserves a large external store.

#### Advantage

Outer-loop recursion converts unbounded information needs into bounded-context interactions by demand-loading only task-relevant slices, which can improve long-horizon correctness when combined with strong retrieval, caching, and verification policies. {% include wiki-citation.html ref_id="packer2023memgpt" %}

By delegating structured computation to tools (code execution, search, solvers), the system can replace fragile pure-text reasoning steps with verifiable intermediate artifacts, and ReAct-style interleavings provide a simple template for this synergy. {% include wiki-citation.html ref_id="yao2022react" %}

At the serving/runtime layer, paging-like KV allocation mechanisms (e.g., PagedAttention) improve utilization and multiplexing across requests by managing KV memory as paged blocks rather than monolithic contiguous buffers, aligning LLM serving more closely with virtual-memory design. {% include wiki-citation.html ref_id="kwon2023vllm" %}


- **Decouples capability scaling from bleeding-edge packaging:** External memory/tooling lets systems scale useful work even when cutting-edge HBM + advanced packaging are scarce, by shifting more work to commodity DRAM/storage and structured computation {% include wiki-citation.html ref_id="semianalysis2024hbm" %} {% include wiki-citation.html ref_id="edn2025hbm4" %}.
- **Better scaling knobs in software:** You can often buy large wins from retrieval quality, cache policy, tool reliability, and evaluation harnesses—without requiring a larger inner-loop working set {% include wiki-citation.html ref_id="openai2024reasoning" %}. 
- **Auditability and control:** Persisted tool outputs and memory artifacts can be logged/inspected, enabling reproducibility and governance beyond what’s possible inside opaque KV-cache state.


The outer loop is latency-dominated: each “page-in” (retrieval/tool call) introduces microsecond–millisecond (or worse) round-trips, so end-to-end performance depends on cache hit rate, batching, and minimizing the number of outer iterations. {% include wiki-citation.html ref_id="kwon2023vllm" %}

Correctness becomes policy-sensitive: failures shift from “model forgot” to “retrieval/tooling selected the wrong evidence or executed the wrong action,” so evaluation must cover the combined system (retriever + tool APIs + controller + LLM). {% include wiki-citation.html ref_id="yao2022react" %}{% include wiki-citation.html ref_id="schick2023toolformer" %}

Virtual-context approaches require robust summarization, indexing, and eviction strategies; otherwise the system either thrashes (too many fetches) or accumulates low-quality compressed state that poisons future prompts. {% include wiki-citation.html ref_id="packer2023memgpt" %}

## Why I Am Excited: The RL Formulation of Attention

What excites me most involves lifting the "attention control" out of the implicit weights and into the explicit **action space** of the agent.

*   **Inner-Loop Attention:** Implicit, learned via gradient descent, hard to interpret, limited by context window.
*   **Outer-Loop Attention:** Explicit, learned via Reinforcement Learning (RL), fully interpretable (e.g., `grep "error" logs.txt`), and effectively infinite.

By using RL to train these Outer Loops, we teach models *how* to manage their own attention economy. The act of "reading a file," "grepping a log," or "calling a sub-model" becomes a discrete action in an RL trajectory {% include wiki-citation.html ref_id="prime2026rlm" %}. This orchestrates the raw, expensive "intelligence" of the Inner Loop with the vast, cheap "memory" of the Outer Loop.

## Key Applications and Value Unlock

The RLM pattern unlocks several high-value applications that were previously impractical or insecure with flat-context models:

### 1. Infinite-Context OSS Development
For autonomous software engineers (like Devin, Cursor's Agents, etc.), RLM-pattern is critical. You cannot fit an entire legacy codebase into a prompt. An RLM-based agent can recursively "explore" the directory structure, "grep" for usages, and "read" only the relevant files, mimicking how human engineers navigate large codebases. 

### 2. Multi-Modal Agents, Robotics, and World Models
RLMs naturally support "heterogeneous compute" and data types that defy tokenization. Instead of trying to tokenize a massive 3D point cloud or a high-framerate video stream, the RLM can treat these as **variables** (handles) in its environment.

*   **Robotics & VLA (Vision-Language-Action):** In robotics, the "context" is a continuous stream of video and sensor data. Feeding all this into an LLM context window is cost-prohibitive and slow. An RLM-based architecture allows a robot to "watch" its environment by holding a handle to the video stream variable and recursively calling VLA sub-models to query specific frames (e.g., "Is the door open in frame 1024?"). This separation allows the high-level reasoning agent to remain lightweight while leveraging heavy perceptual models only when necessary.
*   **World Models:** As we move toward agents that operate in learned world models, RLMs can act as the navigator. The "world state" is a latent variable in the RLM's environment. The agent proposes actions, the world model simulates the outcome (updating the variable), and the RLM inspects the result—effectively "planning" in a latent space without needing to reconstruct the entire visual scene at every step.

### 3. Secure and Verifiable AI: TEEs, ZK, and FHE
RLM is the missing link for privacy-preserving and verifiable AI. Because the "reasoning" happens in a REPL, we can run that REPL inside a **Trusted Execution Environment (TEE)**, while the model orchestrator remains outside.

*   **Encrypted State & TEEs:** Sensitive user data (e.g., medical records, financial logs) stays in the TEE-backed REPL variable. The RLM orchestrator sees only the *queries* and the *final sanitized answer*, never the raw data.
*   **Fully Homomorphic Encryption (FHE):** RLM is a good candidate for an orchestration layer for FHE. Schemes like **CKKS** (Cheon-Kim-Kim-Song) allow for approximate arithmetic on encrypted real numbers—ideal for deep learning inference. However, FHE operations are complex to construct. An RLM can essentially "write the circuit" by generating Python code that calls FHE libraries (e.g., `fhe_add(encrypted_tensor_a, encrypted_tensor_b)`). The model reasons about *how* to process the data, while the cryptographic primitives execute the math blindly on encrypted ciphertext. This enables "Confidential AI" where the model provider never sees the user's data.
*   **Zero-Knowledge (ZK) Proofs:** Beyond privacy, we need verifiability. How do you know the agent didn't hallucinations or maliciously edit the result? By having the RLM's sub-calls generate ZK proofs (e.g., proving that a specific file was read and summarized correctly), we can create an entirely verifiable chain of thought. Users can verify the *computation* of the answer without needing to see the private context that generated it.


## Future Trends: The Convergence of Loops

### 1. The "Thinking" vs "Remembering" Trade-off
We will likely see a split in model specialization.
*   **Inner-Loop Models:** Specialized for intense, short-context reasoning (Math, Logic, Coding). They will consume massive HBM bandwidth but won't need massive context windows.
*   **Outer-Loop Orchestrators:** Specialized for tool use, planning, and memory management. They will need to be robust "Operating Systems" that can juggle handles to TB-scale external contexts.

### 2. Implicit vs Explicit REPLs
As noted by Prime Intellect, there is a push to reduce the "multiplicative depth" of recursive calls {% include wiki-citation.html ref_id="prime2026rlm" %}. We may move from explicit Python REPLs (which have parsing overhead) to **latent-space REPLs**, where the "program" and "variables" are represented in high-dimensional vectors, and the "execution" happens via specialized neural modules rather than a Python interpreter.

### 3. Test-Time Compute as the New Moore's Law
The "Outer Loop" paradigm effectively uncaps the "test-time compute" budget. If a problem is hard, the model can simply iterate longer in the outer loop—searching more files, running more simulations, calling more sub-models—without being constrained by the fixed forward-pass depth of the neural network. This turns "intelligence" into a resource we can purchase with time and electricity, decoupled from semiconductor node scaling.

## Conclusion

The "Recursive Outer-Loop" paradigm is a necessary evolution. It acknowledges that while silicon scaling (Inner Loop) is hitting physics-based friction, system architectural scaling (Outer Loop) is just getting started.

By decoupling "context storage" from "reasoning capacity," systems like RLM allow us to build agents that don't just *process* tokens, but *navigate* information. As we move toward agents that run for weeks or months, the ability to **programmatically manage state**—to decide what to remember, what to forget, and where to look—will be the defining characteristic of intelligence.
