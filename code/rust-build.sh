# clear out old files
test -f fizzbuzz.rs.wasm && rm fizzbuzz.rs.wasm
test -f fizzbuzz.rs.big.wasm && rm fizzbuzz.rs.big.wasm

# In order to build a WebAssembly library with rust, you need to add
# the wasm32-unknown-unknown target. You can do that with the
# following command:
#
#   rustup target add wasm32-unknown-unknown
#

# compile to WebAssembly
rustc --target wasm32-unknown-unknown -O --crate-type=cdylib fizzbuzz.rs -o fizzbuzz.rs.big.wasm

# it's executable for some reason, make it not that way
chmod -x fizzbuzz.rs.big.wasm

# Rust creates somewhat large .wasm files. This tool will reduce the
# size of them significantly. To install the tool, enter the following
# command:
#
#  cargo install wasm-gc
#

# reduce the .wasm file size
wasm-gc fizzbuzz.rs.big.wasm fizzbuzz.rs.wasm
