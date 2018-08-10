#[no_mangle]
pub fn fizzbuzz(n: i32) -> i32 {

  let mut result = n;

  if n % 15 == 0 {
    result = -3;
  } else if n % 5 == 0 {
    result = -2;
  } else if n % 3 == 0 {
    result = -1;
  }

  unsafe { callback(result); }

  return result;

}

extern {
  fn callback(n: i32);
}