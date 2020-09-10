(module

  ;; import WASI function that writes to a file descriptor
  (import "wasi_unstable" "fd_write" (func $fd_write (param i32 i32 i32 i32) (result i32)))

  ;; define and export memory
  (memory 1)
  (export "memory" (memory 0))

  ;; store the string for fizzbuzz in memory
  (data (i32.const 0) "fizzbuzz\n")

  ;; run main when executed
  (start $main)

  (func $main
    (call $setup_iovs)

    (call $fizzbuzz (i32.const 1))
    (call $fizzbuzz (i32.const 2))
    (call $fizzbuzz (i32.const 3))
    (call $fizzbuzz (i32.const 5))
    (call $fizzbuzz (i32.const 6))
    (call $fizzbuzz (i32.const 9))
    (call $fizzbuzz (i32.const 10))
    (call $fizzbuzz (i32.const 12))
    (call $fizzbuzz (i32.const 15))
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
  )

  (func $fizzbuzz (param $num i32)
    (local $of_5 i32)
    (local $of_3 i32)

    (local.set $of_5
      (call $is_multiple (local.get $num) (i32.const 5)))

    (local.set $of_3
      (call $is_multiple (local.get $num) (i32.const 3)))

    (if (i32.and (local.get $of_5) (local.get $of_3))
      (block
        (call $write_fizzbuzz)
        (return)
      )
    )

    (if (local.get $of_5)
      (block
        (call $write_buzz)
        (return)
      )
    )

    (if (local.get $of_3)
      (block
        (call $write_fizz)
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

  (func $write_fizz
    (call $write_stdio (i32.const 12))
    (call $write_newline)
  )

  (func $write_buzz
    (call $write_stdio (i32.const 20))
    (call $write_newline)
  )

  (func $write_fizzbuzz
    (call $write_stdio (i32.const 28))
    (call $write_newline)
  )

  (func $write_newline (call $write_stdio (i32.const 36)))

  (func $write_stdio (param $iov i32)
    (call $fd_write
        (i32.const 1)    ;; 1 is for stdout
        (local.get $iov) ;; the pointer to the iov array
        (i32.const 1)    ;; the length of the array at the pointer... just one for us
        (i32.const 128)  ;; store the number of bytes written somewhere we can ignore it
    )    
    drop ;; $fd_write returns the number of bytes written but we don't care
  )
)
