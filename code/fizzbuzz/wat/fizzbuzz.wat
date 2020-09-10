(module

  (export "fizzbuzz" (func $fizzbuzz))

  (func $fizzbuzz (param $num i32) (result i32)
    (local $of_5 i32)
    (local $of_3 i32)

    (local.set $of_5
      (call $is_multiple (local.get $num) (i32.const 5)))

    (local.set $of_3
      (call $is_multiple (local.get $num) (i32.const 3)))

    (if (i32.and (local.get $of_5) (local.get $of_3))
      (return (i32.const -3))
    )

    (if (local.get $of_5)
      (return (i32.const -2))
    )

    (if (local.get $of_3)
      (return (i32.const -1))
    )

    (return (local.get $num))
  )

  (func $is_multiple (param $num i32) (param $div i32) (result i32)
    (local $remainder i32)

    (local.set $remainder
      (i32.rem_u (local.get $num) (local.get $div)))

    (return (i32.eqz (local.get $remainder)))
  )
)