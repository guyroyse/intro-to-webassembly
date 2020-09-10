async function loadWasm(path) {
  let response = await fetch(path)
  let bytes = await response.arrayBuffer()
  let module = await WebAssembly.instantiate(bytes)
  return module.instance.exports
}
