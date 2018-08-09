class JsFizzBuzz {
  constructor(callback) {
    this.callback = callback
  }

  fizzbuzz(n) {

    let result;
    if (this._isFizzBuzz(n)) result = -3
    else if (this._isBuzz(n)) result = -2
    else if (this._isFizz(n)) result = -1
    else result = n

    this.callback(result)
    return result
  }

  _isFizzBuzz(n) {
    return n % 15 === 0
  }

  _isBuzz(n) {
    return n % 5 === 0
  }

  _isFizz(n) {
    return n % 3 === 0
  }

}
