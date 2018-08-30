int fizzbuzz(int n) {

  int result = n;

  if (n % 15 == 0) {
    result = -3;
  } else if (n % 5 == 0) {
    result = -2;
  } else if (n % 3 == 0) {
    result = -1;
  }

  return result;

}
