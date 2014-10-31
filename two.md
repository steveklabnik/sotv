% More Rust

![rust logo](http://www.rust-lang.org/logos/rust-logo-256x256-blk.png)

@steveklabnik

# Ownership and Concurrency

```{rust,ignore}
fn main() {
    let mut numbers = vec![1i, 2i, 3i];

    for i in range(0u, 3u) {
        spawn(proc() {
            for j in range(0, 3) {
                numbers[j] += 1
            }
        });
    }
}
```

# Ownership and Concurrency

```{notrust,ignore}
6:71 error: capture of moved value: `numbers`
    for j in range(0, 3) { numbers[j] += 1 }
               ^~~~~~~
7:50 note: `numbers` moved into closure environment here because it has type `proc():Send`, which is non-copyable (perhaps you meant to use clone()?)
    spawn(proc() {
```

# Ownership and Concurrency

```rust
use std::sync::{Arc,Mutex};

fn main() {
    let numbers = Arc::new(Mutex::new(vec![1i, 2i, 3i]));

    for i in range(0u, 3u) {
        let number = numbers.clone();

        spawn(proc() {
            let mut array = number.lock();

            (*array)[i] += 1;

            println!("numbers[{}] is {}", i, (*array)[i]);
        });
    }
}
```

# Ownership and Concurrency

```{rust,ignore}
fn main() {
    let numbers = Arc::new(Mutex::new(vec![1i, 2i, 3i]));

    for i in range(0u, 3u) {
        let number = numbers.clone();

        spawn(proc() {
            // ...
        });
    }
}
```

# Ownership and Concurrency

```{rust,ignore}
spawn(proc() {
    let mut array = number.lock();

    (*array)[i] += 1;

    println!("numbers[{}] is {}", i, (*array)[i]);
});
```

# Channels

```{rust,ignore}
fn main() {
    let (tx, rx) = channel();

    spawn(proc() {
        tx.send(10i);
    });

    assert_eq!(rx.recv(), 10i);
}
```

# Channels

```{rust,ignore}
fn main() {
    let (tx, rx) = channel();

    for i in range(0i, 10i) {
        let tx = tx.clone();
        spawn(proc() {
            tx.send(i);
        })
    }

    for _ in range(0i, 10i) {
        let j = rx.recv();
    }
}
```

# Macros

```{rust,ignore}
fn main() {
    let bad_query = sql!("SELECT * FORM users WHERE name = $1");
}
```

```{notrust}
error: Invalid syntax at position 10: syntax error at or near "FORM"
let bad_query = sql!("SELECT * FORM users WEHRE name = $1");
                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
```

# Macros

```{rust,ignore}
extern crate regex;
use regex::Regex;

fn main() {
    let re = match Regex::new(r"^\d{4}-\d{2}-\d{2}$") {
        Ok(re) => re,
        Err(err) => panic!("{}", err),
    };

    assert_eq!(re.is_match("2014-01-01"), true);
}
```

# FFI

```
extern crate libc;
use libc::size_t;

#[link(name = "snappy")]
extern {
    fn snappy_max_compressed_length(source_length: size_t) -> size_t;
}

fn main() {
    let x = unsafe { snappy_max_compressed_length(100) };
    println!("max compressed length of a 100 byte buffer: {}", x);
}
```

# Embedding

```
#![no_std]
#![feature(lang_items)]
#![feature(intrinsics)]

extern crate core;
use core::str::StrSlice;

#[lang = "stack_exhausted"] extern fn stack_exhausted() {}
#[lang = "eh_personality"] extern fn eh_personality() {}
#[lang = "panic_fmt"] extern fn panic_fmt() {}

#[no_mangle]
pub extern "C" fn hello_rust() -> *const u8 {
    "Hello, world!\0".as_ptr()
}
```

# Thanks!

![rust logo](http://www.rust-lang.org/logos/rust-logo-256x256-blk.png)

@steveklabnik
