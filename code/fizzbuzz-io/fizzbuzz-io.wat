(module

  ;; import WASI function that writes to a file descriptor
  (import "wasi_unstable" "fd_write" (func $fd_write (param i32 i32 i32 i32) (result i32)))

  ;; define and export memory
  (memory 1)
  (export "memory" (memory 0))

  ;; store the string for fizzbuzz in memory
  (data (i32.const 0) "fizzbuzz\n - ")

  ;; run main when executed
  (start $main)

  (func $main
    (local $counter i32)

    (call $setup_iovs)

    ;; set the counter to 0
    (local.set $counter (i32.const 0))

    (block
      (loop
        ;; increment the counter
        (local.set $counter (call $increment (local.get $counter)))

        ;; run the counter through fizzbuzz
        (call $fizzbuzz (local.get $counter))

        ;; break if counter is 50
        (br_if 1 (i32.eq (local.get $counter) (i32.const 50)))

        ;; otherwise carry on
        (br 0)
      )
    )

  )

  (func $setup_iovs
    (i32.store (i32.const 12) (i32.const 0)) ;; location of fizz
    (i32.store (i32.const 16) (i32.const 4)) ;; length of fizz

    (i32.store (i32.const 20) (i32.const 4)) ;; location of buzz
    (i32.store (i32.const 24) (i32.const 4)) ;; length of buzz

    (i32.store (i32.const 28) (i32.const 0)) ;; location of fizzbuzz
    (i32.store (i32.const 32) (i32.const 8)) ;; length of fizzbuzz

    (i32.store (i32.const 36) (i32.const 8)) ;; location of newline
    (i32.store (i32.const 40) (i32.const 1)) ;; length of newline

    (i32.store (i32.const 44) (i32.const 9)) ;; location of a space
    (i32.store (i32.const 48) (i32.const 3)) ;; length of a space

    (i32.store (i32.const 52) (i32.const 64)) ;; location of a number
    (i32.store (i32.const 56) (i32.const 0))  ;; length of a number
  )

  (func $fizzbuzz (param $num i32)
    (local $of_5 i32)
    (local $of_3 i32)

    (local.set $of_5
      (call $is_multiple (local.get $num) (i32.const 5)))

    (local.set $of_3
      (call $is_multiple (local.get $num) (i32.const 3)))

    (call $write_number (local.get $num))

    (if (i32.and (local.get $of_5) (local.get $of_3))
      (block
        (call $write_space)
        (call $write_fizzbuzz)
        (call $write_newline)
        (return)
      )
    )

    (if (local.get $of_5)
      (block
        (call $write_space)
        (call $write_buzz)
        (call $write_newline)
        (return)
      )
    )

    (if (local.get $of_3)
      (block
        (call $write_space)
        (call $write_fizz)
        (call $write_newline)
        (return)
      )
    )

    (call $write_newline)

  )

  (func $is_multiple (param $num i32) (param $div i32) (result i32)
    (local $remainder i32)

    (local.set $remainder
      (i32.rem_u (local.get $num) (local.get $div)))

    (return (i32.eqz (local.get $remainder)))
  )

  (func $write_fizz (call $write_stdio (i32.const 12)))
  (func $write_buzz (call $write_stdio (i32.const 20)))
  (func $write_fizzbuzz (call $write_stdio (i32.const 28)))
  (func $write_newline (call $write_stdio (i32.const 36)))
  (func $write_space (call $write_stdio (i32.const 44)))

  (func $write_number (param $n i32)
    
    ;; call itoa and store the length in the iov for the number
    (i32.store
      (i32.const 56)
      (call $itoa (local.get $n) (i32.const 64)) ;; convert number to string and place at address 64
    )

    ;; write the number to stdio
    (call $write_stdio (i32.const 52))
    ;; (call $write_newline)
  )

  (func $write_stdio (param $iov i32)
    (call $fd_write
        (i32.const 1)    ;; 1 is for stdout
        (local.get $iov) ;; the pointer to the iov array
        (i32.const 1)    ;; the length of the array at the pointer... just one for us
        (i32.const 128)   ;; store the number of bytes written somewhere we can ignore it
    )    
    drop ;; $fd_write returns the number of bytes written but we don't care
  )

  (func $itoa (param $number i32) (param $address i32) (result i32)
    (local $length i32)
    (local $currentNumber i32)
    (local $currentOffset i32)
    (local $currentDigit i32)

    ;; if it's 0, just return it
    (if (i32.eqz (local.get $number))
      (block
        (call $storeDigit (i32.const 0) (i32.const 0) (local.get $address))
        (return (i32.const 1))
      )
    )

    (local.set $length (call $countDigits (local.get $number)))
    (local.set $currentNumber (local.get $number))
    (local.set $currentOffset (local.get $length))

    (block
      (loop
        (local.set $currentOffset (call $decrement (local.get $currentOffset)))
        (local.set $currentDigit (i32.rem_u (local.get $currentNumber) (i32.const 10)))
        (local.set $currentNumber
          (i32.div_u
            (i32.sub
              (local.get $currentNumber)
              (local.get $currentDigit)
            )
            (i32.const 10)
          )
        )

        (call $storeDigit (local.get $currentDigit) (local.get $currentOffset) (local.get $address))

        (br_if 1 (i32.eqz (local.get $currentOffset)))
        (br 0)
      )
    )

    (return (local.get $length))
  )

  (func $storeDigit (param $digit i32) (param $position i32) (param $address i32)
    (call $storeValue 
      (call $digitToUtf8 (local.get $digit))
      (local.get $position)
      (local.get $address)
    )
  )

  (func $storeValue (param $value i32) (param $position i32) (param $address i32)
    (i32.store8
      (i32.add (local.get $address) (local.get $position))
      (local.get $value)
    )
  )

  (func $digitToUtf8 (param $digit i32) (result i32)
    (i32.add (local.get $digit) (i32.const 48))
  )

  (func $countDigits (param $n i32) (result i32)
    (local $length i32)
    (local $divisor i32)

    (local.set $length (i32.const 0))
    (local.set $divisor (i32.const 1))

    (if (i32.eqz (local.get $n))
      (return (i32.const 1))
    )

    (block
      (loop
        (br_if 1 (i32.eqz (i32.div_u (local.get $n) (local.get $divisor))))
        (local.set $length (call $increment (local.get $length)))
        (local.set $divisor (i32.mul (local.get $divisor) (i32.const 10)))
        (br 0)
      )
    )

    (local.get $length)
  )

  (func $increment (param $n i32) (result i32)
    (i32.add (local.get $n) (i32.const 1))
  )

  (func $decrement (param $n i32) (result i32)
    (i32.sub (local.get $n) (i32.const 1))
  )
)
