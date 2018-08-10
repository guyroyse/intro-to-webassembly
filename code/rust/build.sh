rm fizzbuzz.wasm
rm fizzbuzz.big.wasm

# In order to build a WebAssembly library with rust, you need to add
# the wasm32-unknown-unknown target. You can do that with the
# following command:
#
#   rustup target add wasm32-unknown-unknown
#

# compile the
rustc --target wasm32-unknown-unknown -O --crate-type=cdylib fizzbuzz.rs -o fizzbuzz.big.wasm

# Rust creates somewhat large .wasm files. This tool will reduce the
# size of them significantly. To install the tool, enter the following
# command:
#
#  cargo install --git https://github.com/alexcrichton/wasm-gc
#

wasm-gc fizzbuzz.big.wasm fizzbuzz.wasm