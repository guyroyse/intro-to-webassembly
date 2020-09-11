# Running the Sample

To assemble and run this rather elaborate example of Web Assembly Text Format, you'll need to follow this steps.

## 1. Install the WebAssembly Binary Toolkit

Instructions to compile WABT and the code are on GitHub at https://github.com/WebAssembly/wabt. Go there and do what they tell you to. Once build, I like to add WABT to my path so I can easily execute the commands.

## 2. Install Wasmtime

Instructions for installing Wasmtime can be found on the official website at https://wasmtime.dev/. It's pretty simple.

## 3. Assemble

Use WABT to assemble to code:

    $ wat2wasm fizzbuzz-io.wat

## 4. Run the Example

Use Wasmtime to run to WebAssembly module and watch all the stuff get written to stdout.

    $ wasmtime fizzbuzz-io.wasm
