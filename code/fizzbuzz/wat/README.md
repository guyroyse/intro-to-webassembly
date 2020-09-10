# Compilation Instructions

To compile this example follow this mildly challenging step and it's subsequent supper easy step.

## 1. Install the WebAssembly Binary Toolkit

Instructions to compile WABT and the code are on GitHub at https://github.com/WebAssembly/wabt. Go there and do what they tell you to. Once build, I like to add WABT to my path so I can easily execute the commands.

## 2. Assemble

We're not compiling here as this is an assembly languages. We're assembling. To assemble fizbuzz, we'll use `wat2wasm` in this folder in the most obvious way possible:

    $ wat2wasm fizzbuzz.wat

This will create a .wasm file that is super tiny with the same name at the source file.
