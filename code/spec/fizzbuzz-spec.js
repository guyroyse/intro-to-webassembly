describe("fizzbuzz", () => {

  beforeEach(async done => {
    this.subject = await loadWasm('/fizzbuzz.rs.wasm')
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

})