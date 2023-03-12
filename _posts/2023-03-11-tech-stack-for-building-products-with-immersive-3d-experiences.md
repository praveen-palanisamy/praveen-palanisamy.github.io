---
title: Technologies and tools for building products with immersive, 3D experiences 
date: 2023-03-11
desc: Tech stack for 3D asset, content data generation, rendering, simulation and User Experiences for extended reality
keywords: 3D, content, generation, tech, stack, extended reality
categories: [Ideas]
tags: 3D, content, generation, tech, stack
icon: fa-book
---

## 3D content generation technologies, tools, and frameworks

|                                    | **Technology/Tool/Framework**        | **Brief Description**                            | **Use Cases**                                                      | **Key Advantage**                                             |
|--------------------------------------------|--------------------------------------|--------------------------------------------------|--------------------------------------------------------------------|---------------------------------------------------------------|
| **3D Asset Creation, Modeling, Animation** | Blender                              | Open-source 3D creation software                 | Asset creation, 3D modeling and animation, rendering               | Advanced toolset, extensive community                         |
| **AI/ML Models**                           |                                      |                                                  |                                                                    |                                                               |
|                                        | NeRFs                                | NeRFs (Neural Radiance Fields)                   | 3D reconstruction of objects and scenery from images               | Accurate and detailed 3D modeling                             |
|                                        | DALL-E, StableDiffusion              | Image Generators (Text/Image2Image)              | Texture Generation, Image Generation                               |                                                               |
|                                        | Imagen, Meta MakeAVideo, SimSwap, SD | Video Generators (Text/Image/Video2Video)        |                                                                    |                                                               |
|                                        | DeepSDF                              | Mesh Generators (Text/Image/Video2Mesh/3DObject) | Creating custom 3D models for games or movies                      | Generating 3D models from text, image or video prompts        |
|                                        | PointGrow                            | Text2Pointcloud                                  | 3D representations of objects or scenes                            | Generating 3D point clouds from text, image or video prompts  |
| **Data Structure/Format/Interface**        |                                      |                                                  |                                                                    |                                                               |
|                                    | ONNX Models                          | Open Neural Network Exchange Models              | Machine learning models for image, speech, and language processing | Interoperability between different neural network frameworks  |
|                                        | USD                                  | Universal Scene Description                      | 3D asset exchange format                                           | Enables collaboration, accelerates 3D projects                |
|                                        | glTF                                 | GL Transmission Format                           | Efficient 3D asset delivery format                                 | Lightweight, supports PBR materials                           |
| **3D UI, Rendering, Visualization**        |                                      |                                                  |                                                                    |                                                               |
|                                    | three.js                             | JavaScript 3D library                            | 3D visualization, 3D UI development                                | Cross-browser compatibility, large community                  |
|                                        | react-three-fiber                    | React bindings for three.js                      | Building 3D content using React                                    | Familiar React development experience                         |
|                                        | Babylon.js                           | JavaScript 3D engine                             | Building 3D games and immersive experiences                        | Cross-platform support, physics engine included               |
|                                        | WASM                                 | WebAssembly                                      | Portable binary code format for web applications                   | High-performance code execution, cross-language compatibility |
|                                        | WebGPU                               | Web Graphics and Compute API                     | Low-level graphics and compute API for the web                     | High-performance, access to GPU features                      |
|                                        | WebGL                                | Web Graphics Library                             | Rendering 2D and 3D graphics in a web browser                      | Hardware-accelerated rendering, no plugins required           |
| **Experience/XR toolkit/platforms**  |                                      |                                                  |                                                                    |                                                               |
|                                        | ARCore                               | Augmented Reality SDK for Android                | Augmented reality app development                                  | Advanced motion tracking, environmental understanding         |
|                                        | ARKit                                | Augmented Reality SDK for iOS                    | Augmented reality app development                                  | Face tracking, gesture recognition                            |
|                                    | Unity                                | Unity Game Engine                                |                                                                    |                                                               |
|                                    | Unreal Engine                        | Unreal Game Engine                               |                                                                    |                                                               |
{: .table .table-striped .table-bordered .table-hover .table-sm}



## Existing startups/companies addressing this space

| **Category**                         | **Startup/Company** | **Description**                                                             |
|--------------------------------------|---------------------|-----------------------------------------------------------------------------|
| **3D Asset Creation Tools**          |                     |                                                                             |
|                              | Sketchfab           | 3D model publishing and discovery platform                                  |
|                                  | TurboSquid          | Marketplace for buying and selling 3D models                                |
|                                  | Artomatix           | AI-powered 3D texture creation software                                     |
|                                  | Unscreen            | AI-powered video background removal tool                                    |
| **AI/ML Deployment**                 |                     |                                                                             |
|                              | Algorithmia         | Platform for deploying and managing AI/ML models                            |
|                                  | Seldon              | Open-source platform for deploying and monitoring machine learning models   |
|                                  | Paperspace          | Cloud-based platform for machine learning and AI development                |
| **3D Scene Reconstruction**          |                     |                                                                             |
|                              | Matterport          | Platform for creating 3D models of physical spaces                          |
| | Meshroom            | Open-source 3D reconstruction software                                      |
|                                  | Photogrammetry.ai   | AI-powered 3D scanning software                                             |
| **3D Rendering on the Web**          |                     |                                                                             |
|                              | Sketchfab           | 3D model publishing and discovery platform                                  |
|                                  | PlayCanvas          | Web-based game engine and development platform                              |
|                                  | Threekit            | Cloud-based platform for creating and visualizing 3D product configurations |
|                                  | Verge3D             | WebGL toolkit for creating interactive 3D web experiences                   |
| **Augmented Reality (AR) Platforms** |                     |                                                                             |
|                              | Niantic             | Developer of Pokemon Go and other AR games                                  |
|                                  | Zappar              | AR platform for creating interactive content and experiences                |
|                                  | 8th Wall            | AR development platform for web and mobile applications                     |
{: .table .table-striped .table-bordered .table-hover .table-sm}