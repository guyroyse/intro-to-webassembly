#[no_mangle]
pub fn fizzbuzz(n: i32) -> i32 {
  match (n % 3 == 0, n % 5 == 0) {
    (true, false) => -1,
    (false, true) => -2,
    (true, true) => -3,
    _ => n
  }
}
