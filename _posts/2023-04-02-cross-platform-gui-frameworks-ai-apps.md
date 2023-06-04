---
title: Cross platform gui frameworks for AI Apps
date: 2023-04-02 00:00:00 Z
desc: Frameworks for building full-stack, AI-powered, cross-platform desktop and web apps
keywords: [cross-platform, gui, app]
categories: blog
tags: [cross-platform, gui, app]
icon: fa-robot
thumbnail: /static/assets/img/blog/apps/cross-platform-app-frameworks.png
---

# Cross platform gui app frameworks

Cross-platform GUI app frameworks are essential for developers who want to create applications that can be seamlessly run on multiple platforms. These frameworks help maintain a consistent user interface and experience across platforms, while reducing development effort and resources. Here's a list of Frameworks for building full-stack, AI-powered, cross-platform desktop and web apps. This is not an exhaustive list and does not include frameworks like QT, Unity 3D, etc. that are not mainstream options for building light-weight, web and desktop GUI apps.

## List of major frameworks:

[Electron.js](https://www.electronjs.org/): A popular framework that combines Node.js with the Chromium engine, allowing developers to create applications with HTML, CSS, and JavaScript. Well-known applications like Visual Studio Code and Slack are built using Electron.js.

[Flutter](https://flutter.dev/): Google's open-source UI toolkit that utilizes the Dart programming language and the Skia rendering engine. It enables developers to build natively compiled applications for mobile, web, and desktop from a single codebase. Apps like Google Ads and Alibaba are built with Flutter.

[tauri](https://tauri.studio/): An emerging framework that combines JavaScript with the Rust programming language to create small, fast, and secure desktop applications. It uses the built-in OS WebView to render interfaces, resulting in a lower memory usage than Electron.js.

[react native](https://reactnative.dev/): Developed by Facebook, React Native is an open-source framework for building native applications for Android and iOS using React, a popular JavaScript library for building user interfaces. Although it currently does not offer official desktop support, there are community-driven solutions like React Native for Windows and React Native for macOS.

## Comparison of major frameworks:

<!-- prettier-ignore-start -->

| **Criteria**             | **Electron.js**                            | **Flutter**                                                  | **Tauri**                                             | **React Native**                                            |
| ------------------------ | ------------------------------------------ | ------------------------------------------------------------ | ----------------------------------------------------- | ----------------------------------------------------------- |
| **Programming Language** | JavaScript/TypeScript                      | Dart                                                         | Rust and JavaScript                                   | JavaScript/TypeScript                                       |
| **UI Rendering**         | Chromium engine                            | Skia                                                         | Built-in OS WebView                                   | Native platform UI components                               |
| **Supported Platforms**  | Windows, macOS, Linux                      | Windows, macOS, Linux, Android, iOS                          | Windows, macOS, Linux                                 | Android, iOS (community solutions for Windows and macOS)    |
| **Performance**          | Relatively high resource usage             | Efficient rendering, lower memory footprint than Electron.js | Low memory usage, comparable with native applications | Native performance, but may vary based on the platform      |
| **Popularity**           | Widely adopted, large community            | Rapidly growing, backed by Google                            | Emerging, smaller community                           | Popular, smaller community than React, but widely supported |
| **Notable Apps**         | Visual Studio Code, Slack                  | Google Ads, Alibaba                                          | SpaceDrive, Xplorer                                   | Instagram, Airbnb, Tesla                                    |
| **Learning Curve**       | Moderate, if familiar with web development | Moderate, may need to learn new language (Dart)              | Moderate, may need to learn new language (Rust)       | Moderate, if familiar with React                            |
{: .table .table-striped .table-bordered}
<!-- prettier-ignore-end -->

## Other Framework Options

- [Sciter](https://sciter.com/)
- [react-expo](https://docs.expo.io/)
- [flet](https://flet.dev/)
- [sockets.sh](https://sockets.sh/)
- [dotnet maui](https://dotnet.microsoft.com/apps/maui)
- [react native desktop]
- [react native windows](https://microsoft.github.io/react-native-windows/)

  [Cross Platform GUI Tool - Ranking \| OSS Insight](https://ossinsight.io/collections/cross-platform-gui-tool/)  
  [https://github.com/Elanis/web-to-desktop-framework-comparison/blob/main/README.md#major-characteristics](https://github.com/Elanis/web-to-desktop-framework-comparison/blob/main/README.md#major-characteristics)

## Categories:

Web browser-based (HTML\Canvas, WebGL) DOM  
   Native Rendering (Qt, Skia, Unity, UE

## Major Characteristics:

<!-- prettier-ignore-start -->

|                                                                                              |                                                                  | Source\license\price                                     | Pros                                                                       | Cons                                                                                                                                           | Example Apps                                                                                                                                |
| :------------------------------------------------------------------------------------------- | :--------------------------------------------------------------- | :------------------------------------------------------- | :------------------------------------------------------------------------- | :--------------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------ |
| **Electron.js**                                                                              | NodeJs + Chromium engine                                         |                                                          | pinned version of chromium shipped with every app on every OS. Same UI/UX. | Bundles a full chromium engine. Multiple Electron apps running along side each other each have their own Chromium engine running & can't share |                                                                                                                                             |
| **Flutter**                                                                                  | Skia + Dart programming language                                 |                                                          | [https://flutterflow.io/](https://flutterflow.io/)                         |                                                                                                                                                |                                                                                                                                             |
| Sciter.com                                                                                   |                                                                  | [https://sciter.com/prices/](https://sciter.com/prices/) |                                                                            |                                                                                                                                                |                                                                                                                                             |
| **tauri.app**                                                                                | JS + Rust                                                        |                                                          |                                                                            | Rust                                                                                                                                           | [https://github.com/spacedriveapp/spacedrive](https://github.com/spacedriveapp/spacedrive) [https://xplorer.space/](https://xplorer.space/) |
| react-expo                                                                                   |                                                                  |                                                          |                                                                            | No desktop support                                                                                                                             |                                                                                                                                             |
| [https://flet.dev/](https://flet.dev/)                                                       |                                                                  |                                                          |                                                                            |                                                                                                                                                |                                                                                                                                             |
| [https://sockets.sh/](https://sockets.sh/)                                                   |                                                                  |                                                          | Has P2P with NAT traversal Supports 5 OSes (Win, Lin, Mac, And, IOS)       |                                                                                                                                                |                                                                                                                                             |
| [https://dotnet.microsoft.com/en-us/apps/maui](https://dotnet.microsoft.com/en-us/apps/maui) |                                                                  |                                                          |                                                                            | C#                                                                                                                                             |                                                                                                                                             |
| [https://github.com/r0x0r/pywebview](https://github.com/r0x0r/pywebview)                     |                                                                  |                                                          |                                                                            |                                                                                                                                                |                                                                                                                                             |
| node-gui                                                                                     |                                                                  |                                                          |                                                                            |                                                                                                                                                |                                                                                                                                             |
| **streamlit**                                                                                | ReactJS + Python                                                 |                                                          |                                                                            |                                                                                                                                                |                                                                                                                                             |
| **[https://atrilabs.com/](https://atrilabs.com/) **                                          | ReactJS + FastAPI based Full-stack web dev framework for Py devs |                                                          |                                                                            |                                                                                                                                                |                                                                                                                                             |
| pynecone.app                                                                                 | ReactJS + Py Backend                                             |                                                          |                                                                            |                                                                                                                                                | [https://pynecone.io/](https://pynecone.io/)                                                                                                |
| **gardio.app**                                                                               | SvelteJS+FastAPI + HF\anyUrl w/ grclient                         |                                                          | Can use\embed existing HF spaces in the Explore tab                        |                                                                                                                                                |                                                                                                                                             |
{: .table .table-striped .table-bordered}
<!-- prettier-ignore-end -->

## Alternative solutions to consider for cross-platform builds and packaging

### **PyInstaller.org**:

Convert python scripts into self-contained executables (windows, mac, linux) that doesn't need a separate Python installation

### nativefier

[https://github.com/nativefier/nativefier](https://github.com/nativefier/nativefier)

Other options that exist but not considered: [https://wave.h2o.ai/](https://wave.h2o.ai/) , Dash plotly  
Good summary: [https://fluentreports.com/blog/?p=1288](https://fluentreports.com/blog/?p=1288)

## Opinionated Shortlists

1.  Flutter: Dart based, smaller memory footprint than Tauri — everything is under control by app on all platforms. Requires slightly better hardware than Tauri as it needs OpenGL/Vulken/Metal support.
    Programming langauge options:  
      - Dart  
      - flet.dev: Python framework to easily build realtime web, mobile and desktop apps

2.  Tauri.app: Rust based, uses the built in OS WebView, so memory footprint is smaller than Electron. Large chunk of shared memory that "hides" memory usage as part of the OS
    Programming langauge options:  
      - Rust  
      - JS

    > Tauri, Mix of rust (which is a sweet integration!) and html/css/JS - memory footprint almost the same as Electron! Many bugs are outside of your control since your app will be running on different underlying engine on each _PLATFORM_ and _VERSION_ of the platform (i.e. Ubuntu 18 LTS has a different Webkit version than 20, 21 & 22. Now think exponentially how many different distro's and versions they all each have... Now include Windows Edge/Blink engine versions, and then also Mac OS Webkit versions... Throw into that different rendering of Blink vs Webkit and different JS gotchas between JSCore & V8 and you have a wonderful recipe for some fun times... 😉 )

3.  Electron.js with Next.js via Nextron

4.  Gradio App via pywebview

    Not worth the dev cost to move to Svelte (though sounds very promising in terms of performance compared to frameworks that use a virtual DOM).

    Svelte adds scripts & css to HTML with syntactic sugars to achieve almost everything that React can. Svelte Kit is ~ Next.js like App framework. Working with Raw HTML may not be good for dev velocity.

### Shortlists comparison

|                                | Flutter via flet.dev                                                                                                                     | Electron.js via Nextron                         | Gradio App via pywebview      |
| :----------------------------- | :--------------------------------------------------------------------------------------------------------------------------------------- | :---------------------------------------------- | :---------------------------- |
| Web-support                    |                                                                                                                                          | Native JS                                       | svelte.js + Python            |
| Desktop: Windows, MacOS, LInux |                                                                                                                                          | Electron.js (dedicated chrome engine) + Node.js | OS-webview + Python           |
| Mobile: IOS, Android           | [https://flet.dev/blog/flet-mobile-update/#flet-mobile-architecture](https://flet.dev/blog/flet-mobile-update/#flet-mobile-architecture) |                                                 | OS-webview + Python\native-ML |

## Other Resources

[Create T3 App](https://create.t3.gg/)
