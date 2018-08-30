document.addEventListener('DOMContentLoaded', onDocumentLoaded)

let valueInput, mechanismRadioButtons, fizzBuzzButton, resultText

function onDocumentLoaded() {

  valueInput = document.getElementById('value')
  mechanismRadioButtons = document.getElementsByName('mechanism')
  fizzBuzzButton = document.getElementById('fizzbuzz')
  resultText = document.getElementById('result')

  fizzBuzzButton.addEventListener('click', onFizzBuzzClicked)

}

function onFizzBuzzClicked() {
  let mechanism = selectedMechanism()
  fetchFizzBuzz(mechanism)
    .then(fizzbuzz => {
      let n = Number(valueInput.value)
      let result = fizzbuzz.fizzbuzz(n)
      displayResult(result)
    })
}

function onFizzBuzzComputed(result) {
  console.log("FizzBuzz callback:", result)
}

function selectedMechanism() {
  return Array.from(mechanismRadioButtons)
    .find(radio => radio.checked)
    .value
}

function fetchFizzBuzz(mechanism) {
  if (mechanism === 'js') return jsFizzBuzz()
  if (mechanism === 'c') return cFizzBuzz()
  if (mechanism === 'rust') return rustFizzBuzz()
  if (mechanism === 'wabt') return wabtFizzBuzz()
}

function displayResult(result) {
  if (result === -1) resultText.value = 'fizz'
  else if (result === -2) resultText.value = 'buzz'
  else if (result === -3) resultText.value = 'fizzbuzz'
  else resultText.value = result
}

function jsFizzBuzz() {
  return Promise.resolve(new JsFizzBuzz(onFizzBuzzComputed))
}

function cFizzBuzz() {
  let imports = {
    env: {
      callback: onFizzBuzzComputed
    }
  }
  return wasmFizzBuzz('c/fizzbuzz.wasm', imports)
}

function rustFizzBuzz() {
  let imports = {
    env: {
      callback: onFizzBuzzComputed
    }
  }
  return wasmFizzBuzz('rust/fizzbuzz.wasm', imports)
}

function wabtFizzBuzz() {
  let imports = {
    fizzbuzz: {
      callback: onFizzBuzzComputed
    }
  }
  return wasmFizzBuzz('webassembly/fizzbuzz.wasm', imports)
}

function wasmFizzBuzz(path, imports) {
  return fetch(path)
    .then(response => response.arrayBuffer())
    .then(bytes => WebAssembly.instantiate(bytes, imports))
    .then(results => {
      return results.instance.exports
    })
}