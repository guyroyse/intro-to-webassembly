(module

  (export "fizzbuzz" (func $fizzbuzz))

  (func $fizzbuzz (param $num i32) (result i32)
    (local $of_5 i32)
    (local $of_3 i32)

    (set_local $of_5
      (call $is_multiple (get_local $num) (i32.const 5)))

    (set_local $of_3
      (call $is_multiple (get_local $num) (i32.const 3)))

    (if (i32.and (get_local $of_5) (get_local $of_3))
      (return (i32.const -3))
    )

    (if (get_local $of_5)
      (return (i32.const -2))
    )

    (if (get_local $of_3)
      (return (i32.const -1))
    )

    (return (get_local $num))
  )

  (func $is_multiple (param $num i32) (param $div i32) (result i32)
    (local $remainder i32)

    (set_local $remainder
      (i32.rem_u (get_local $num) (get_local $div)))

    (return (i32.eqz (get_local $remainder)))
  )
)