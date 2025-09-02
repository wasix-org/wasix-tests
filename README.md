# wasix-tests

Collection of small C/C++ test cases for the [WASIX](https://github.com/wasix-org) toolchain.
Each test lives in its own directory with a `Makefile` and a `test.sh` script.
The `mmap-anon` test demonstrates anonymous memory mapping using `mmap`.

## Requirements

* `clang-19` and `clang++-19`
* `emcc` and `em++` (for Emscripten builds)
* a WASIX sysroot – set the `WASIX_SYSROOT` environment variable to its path
* [`wasmer`](https://github.com/wasmerio/wasmer) (override with `WASMER` env var)
* `wasm-tools` or `wabt` (optional, for inspecting generated modules)

## Running tests

Run `bash lib/setup-wasix.sh` once to install the toolchain, then execute
`bash test.sh`. Ensure `WASIX_SYSROOT=/wasix-sysroot` is set in the environment.
Before running any `make` files, prepend the repository's `lib/wrappers/` directory
to your `PATH` and select which wrapper to use:

```bash
# WASIX build
export PATH="$(pwd)/lib/wrappers:$PATH"
export CC=wasix-clang CXX=wasix-clang++ LD=wasix-clang
```

For an Emscripten build use `emscripten`/`emscripten++` instead.

Alternatively:

1. Ensure `WASIX_SYSROOT` points to your WASIX installation.
2. Prepend `lib/wrappers/` to `PATH` and set `CC`, `CXX`, and `LD` to the desired
   wrapper (`wasix-clang` or `emscripten`).
3. If `tput` errors appear when running the tests, export `TERM=xterm` to
   provide a basic terminal description.
4. Execute `bash test.sh` in the repository root.  The script iterates over all
   subdirectories and invokes their individual `test.sh` files.
5. Use `bash clean.sh` to remove build artifacts.

You may also run the `test.sh` inside a specific test directory to build and run
just that test.
When contributing code, run `bash test.sh` before creating a pull request to verify that all tests still pass.

## Available tests

- extern-threadlocal-nopic
- extern-threadlocal
- extern-variable
- helloworld
- minimal-threadlocal
- simple-dynamic-lib
- simple-shared-lib
- weak-symbol-undefined
- dynamic-tls-dtor

## Adding tests

Run `bash create-test.sh <new-test-name>` to create a new test directory based on
the `helloworld` example.  Adjust the generated files as necessary.

### Adding grid tests

Sometimes you want to test a grid of multiple properties. For this simple test grid generators are supported.

Create a test folder, but add a `test-grid.sh` instead of a `test.sh`. The `test-grid.sh` is expected to create test folders in the folder where it is located. Usually this is done by having one template test folder and copying that with slight modifications to real test folders. Name your template test folder `template` or add a `.template` file to your template test folder, to prevent it from beeing discovered as a test itself.

Keep in mind that test grids are currently regenerated every time the test runner is executed. This means you shouldn't put any valuable files in there.
