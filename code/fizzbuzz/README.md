# Running the Sample

The sample uses Jasmine to test the WebAssembly modules. Code for the tests is in the `specs` folder. You'll need to assemble/compile the WebAssembly modules before you can run the tests. Follow the instructions for [WebAssembly Text Format](wat/README.md) and [Rust](rust/README.md) versions to do that.

You'll also need a web server of some sort to make this work. I like to use Python for this. Python 3, specifically. The simplest thing is to do...

    $ python -m http.server

...and you'll have an instant web server in the current folder. However, this web server may not be aware of the correct content type for `.wasm` files (which is `application/wasm`). If this happens to you, fear not! `server.py` will spin up a simple web server in this folder that knows about `.wasm` files. Just run it like this:

    $ python server.py

Once the web server is running, point your favorite browser at http://localhost:8000/spec-runner.html and watch the specs fly!
