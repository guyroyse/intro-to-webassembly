#[no_mangle]
pub extern "C" fn fizzbuzz(n: i32) -> i32 {

  if n % 15 == 0 {
    -3
  } else if n % 5 == 0 {
    -2
  } else if n % 3 == 0 {
    -1
  } else {
    n
  }

}