(module

  (export "fizzbuzz" (func $fizzbuzz))
  (import "fizzbuzz" "callback" (func $callback (param i32)))

  (func $fizzbuzz (param $n i32) (result i32)
    get_local $n
    i32.const 15
    call $is_multiple
    if
      i32.const -3
      call $callback
      i32.const -3
      return
    end

    get_local $n
    i32.const 5
    call $is_multiple
    if
      i32.const -2
      call $callback
      i32.const -2
      return
    end

    get_local $n
    i32.const 3
    call $is_multiple
    if
      i32.const -1
      call $callback
      i32.const -1
      return
    end

    get_local $n
    call $callback
    get_local $n
    return
  )

  (func $is_multiple (param $n i32) (param $divisor i32) (result i32)
    get_local $n
    get_local $divisor
    i32.rem_u
    i32.eqz
  )

)