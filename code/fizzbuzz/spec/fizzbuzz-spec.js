describe("FizzBuzz", () => {

  [
    { module: '/wat/fizzbuzz.wasm', description: "WebAssembly Text" },
    { module: '/rust/target/wasm32-unknown-unknown/release/fizzbuzz.wasm', description: "Rust" },
  ].forEach(scenario => {

    describe(scenario.description, () => {

      beforeEach(async done => {
        this.subject = await loadWasm(scenario.module)
        done()
      })
    
      it("returns the number it is given", () => {
        expect(this.subject.fizzbuzz(1)).toBe(1)
      })
    
      it("returns other numbers it is given", () => {
        expect(this.subject.fizzbuzz(2)).toBe(2)
      })
    
      it("returns -1 for multiples of 3", () => {
        expect(this.subject.fizzbuzz(3)).toBe(-1)
      })
    
      it("returns -1 for other multiples of 3", () => {
        expect(this.subject.fizzbuzz(6)).toBe(-1)
      })
    
      it("returns -2 for multiples of 5", () => {
        expect(this.subject.fizzbuzz(5)).toBe(-2)
      })
    
      it("returns -2 for other multiples of 5", () => {
        expect(this.subject.fizzbuzz(10)).toBe(-2)
      })
    
      it("returns -3 for multiples of 3 and 5", () => {
        expect(this.subject.fizzbuzz(15)).toBe(-3)
      })
    
      it("returns -3 for other multiples of 3 and 5", () => {
        expect(this.subject.fizzbuzz(30)).toBe(-3)
      })
    
    })
  
  })

})
