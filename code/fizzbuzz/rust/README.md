# Compilation Instructions

To compile this example follow these three easy steps:

## 1. Install Rust

To compile Rust code, you need Rust. Go and get it at https://www.rust-lang.org/ and follow the instructions for your system.

## 2. Install the WebAssembly Target

To compile to WebAssembly, you will need to install the `wasm32-unknown-unknown` target. You can do that with the following command:

    $ rustup target add wasm32-unknown-unknown

## 3. Compile

From the folder this README is in, enter the following command:

    $ cargo build --target wasm32-unknown-unknown --release

This will make a release build and place it in `target/wasm32-unknown-unknown/release/fizzbuzz.wasm`. The file should be a couple hundred bytes in size. If you like bigger modules taht do the same thing, you can do a debug build instead.

    $ cargo build --target wasm32-unknown-unknown

This will make a debug build and place it in `target/wasm32-unknown-unknown/debug/fizzbuzz.wasm`. The file should be well over a megabyte. Now that's a fizzbuzz!
