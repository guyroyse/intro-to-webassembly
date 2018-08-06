# An Introduction to WebAssembly

Want to write a web application? Better get familiar with JavaScript! JavaScript has long been the king of front-end. While there have been various attempts to dethrone it, they have typically involved treating JavaScript as an assembly-language analog that you transpile your code to. This has lead to complex build pipelines that result in JavaScript which the browser has to parse and *you* still have to debug. But what if there were an actual byte-code language you could compile your non-JavaScript code to instead? That is what WebAssembly is.

I'm going to explain how WebAssembly works and how to use it in this talk. I'll cover what it is, how it fits into your application, and how to build and use your own WebAssembly modules. And, I'll demo how to build and use those modules with both Rust and the WebAssembly Text Format. That's right, I'll be live coding in an assembly language. I'll also go over some online resources for other languages and tools that make use of WebAssembly.

When we're done, you'll have the footing you need to start building applications featuring WebAssembly. So grab a non-JavaScript language, a modern browser, and let's and get started!
