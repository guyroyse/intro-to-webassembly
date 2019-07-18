(module

  (export "fizzbuzz" (func $fizzbuzz))

  (func $fizzbuzz (param $n i32) (result i32)
    (if (call $isMultiple (get_local $n) (i32.const 3))
      (return (i32.const -1))
    )

    (if (call $isMultiple (get_local $n) (i32.const 5))
      (return (i32.const -2))
    )

    (return (get_local $n))
  )

  (func $isMultiple (param $n i32) (param $div i32) (result i32)
    (i32.eqz (i32.rem_u (get_local $n) (get_local $div)))
  )
)