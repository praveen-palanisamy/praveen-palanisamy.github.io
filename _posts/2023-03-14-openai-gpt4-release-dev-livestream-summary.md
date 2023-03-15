---
title: "OpenAI GPT-4 Release Dev Livestream Summary"
date: 2023-03-14
desc: "Summary of OpenAI GPT-4 Release Dev Livestream Summary"
keywords: "openai, gpt-4, dev, livestream"
categories: [Blog]
tags: openai, gpt-4, dev, livestream
icon: fa-book
thumbnail: /static/assets/img/blog/gpt4/discord-bot-first-output.png
---

OpenAI GPT-4 Release Dev Livestream Summary had several live demos one after the other. Here is a summary of the main segments of the livestream (generated using AI :-))
- [Quick Live comparison with GPT-3.5](#quick-live-comparison-with-gpt-35)
- [Flexibly combine ideas between different articles.](#flexibly-combine-ideas-between-different-articles)
- [Build with GPT-4](#build-with-gpt-4)
- [Rough hand-drawn mock-up to Website front-end code](#rough-hand-drawn-mock-up-to-website-front-end-code)
- [TaxGPT](#taxgpt)

## Quick Live comparison with GPT-3.5

Provide the GPT-4 blog post released hours ago as the input.

**Task:** Summarize this article into a sentence where every word begins with G:

![image-20230314135115632]({{site.img_path}}/gpt4/comparision-with-gpt3.5-playground.png){:class="img-responsive"}

Response to Discord user's real-time input: Try with `Q` instead of `G` :

![image-20230314142851777]({{site.img_path}}/gpt4/gpt4-summarize-with-Qwords.png){:class="img-responsive"}


## Flexibly combine ideas between different articles.

Greg pasted the contents of the following two web pages into the same conversation:

  - GPT-4 blog post: https://openai.com/research/gpt-4

  - Hacker news post yesterday on Pynecone: https://news.ycombinator.com/item?id=35136827

and asked GPT-4 to find one common theme between the GPT-4 blog post and the hacker news post.
![image-20230314144519337]({{site.img_path}}/gpt4/gpt4-response-common-theme-gptblog-HN.png){:class="img-responsive"}

## Build with GPT-4

- System prompt:

  ``` bash
  You are an AI Programming assistant.
  
  - Follow the user's requirements carefully & to the letter.
  - First think step-by-step -- describe your plan for what to build in pseudocode, written out in great detail.
  - Then output the code in a single code block.
  - Minimize any other prose
  ```

- User Prompt:

  - Pasted documentation + (see image below for task prompt )

- Create a Discord bot that accepts messages container text and **images**! 

- ![image-20230314152225896]({{site.img_path}}/gpt4/prompt-to-write-discord-bot-to-process-images-and-text.png){:class="img-responsive"}

  - Write pseudocode\design-doc and then implement :D

  - <video muted autoplay controls type="video/webm" src="{{site.img_path}}/gpt4/gpt4-discord-bot-code-gen.webm"></video>

  - GPT-4 training data was cutoff in Sept 2021

    - It has not seen GPT-4's blog post or know about image tokens
    - Just by providing a summary of the blog post, it knows to produce output based on the new output spec

    ### Errors and follow-up to fix errors

    1. Discord API version mismatch:

    - ![image-20230314155938645]({{site.img_path}}/gpt4/discord-api-version-mismatch-jupyter-err.png){:class="img-responsive"}

  - Paste error as a follow-up and produces fixes

  - ![image-20230314160044572]({{site.img_path}}/gpt4/fix-for-discord-api-version-mismatch-jupyter-err.png){:class="img-responsive"}

    2. Asyncio within Jupyter environment

       ![image-20230314160213677]({{site.img_path}}/gpt4/asyncio-run-err-jupyter.png){:class="img-responsive"}

  - Even though Greg had a typo (`juptyer` instead of `jupyter`), GPT-4 understood the runtime environment and produced the updated code with the fix (`!pip install nest_asyncio`):
    ![image-20230314160443187]({{site.img_path}}/gpt4/fix-asyncio-run-err-jupyter.png){:class="img-responsive"}

- ### Discord bot in action

- ![image-20230314160640826]({{site.img_path}}/gpt4/discord-bot-first-input.png){:class="img-responsive"}

- GPT-4's response: 

- ![image-20230314160828134]({{site.img_path}}/gpt4/discord-bot-first-output.png){:class="img-responsive"}

- Second Bot interaction:

- ![image-20230314160931451]({{site.img_path}}/gpt4/discord-bot-second-interaction.png){:class="img-responsive"}

- Discord bot written by ChatGPT can read msg on discord chat, including images, generate and write messages

- Parse through unformatted docs (copy-pasted) with 10,000-15,000 words to find relevant details in the Note section that describes the changes to version 2.0 made in September 2022:

![image-20230314162557881]({{site.img_path}}/gpt4/pycord-docs-updateNote-sept2022.png){:class="img-responsive"}

<video muted autoplay controls src="{{site.img_path}}/gpt4/clips-openai-gpt4-livestream-2023-03-14_16.30.27.mp4"></video>

## Rough hand-drawn mock-up to Website front-end code

- Screenshot of hand drawn sketch of a webpage mockup provided to GPT-4 to generate HTML, JS webpage

  ![image-20230314163324807]({{site.img_path}}/gpt4/hand-drawn-mockup-webpage.png){:class="img-responsive"}

  Input to the GPT-4 powered Discord bot:

  ![image-20230314163427625]({{site.img_path}}/gpt4/hand-drawn-mockup-webpage-input-to-discordBot.png){:class="img-responsive"}

- Generated code:

- ![image-20230314163522156]({{site.img_path}}/gpt4/hand-drawn-mockup-webpage-output-from-discordBot.png){:class="img-responsive"}

- Output of the generated HTML + Javascript code:
  ![image-20230314163702969]({{site.img_path}}/gpt4/hand-drawn-mockup-webpage-output-from-discordBot-rendered.png){:class="img-responsive"}

## TaxGPT

- Work with the system to accomplish a task: Do Taxes!

  - TaxGPT

  - Not equipped with a calculator!

    <video muted autoplay controls src="{{site.img_path}}/gpt4/taxGPT-gpt4.webm"></video>