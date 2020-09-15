async function loadWasm(path) {
  let response = await fetch(path + '?x=' + Math.random())
  let bytes = await response.arrayBuffer()
  let module = await WebAssembly.instantiate(bytes)
  return module.instance.exports
}
