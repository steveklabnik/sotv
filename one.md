% Welcome to Rust

![rust logo](http://www.rust-lang.org/logos/rust-logo-256x256-blk.png)

@steveklabnik

# Meta

Rust is a new programming language from Mozilla (and friends).

Rust is a _low-level_ programming language that often feels like a _high level_
one.

Rust makes low-level programming **accessible** to those who haven't done it, and
**safer** for those who have.

# Safety and Ownership

Here's some Ruby:

```ruby
v = [];

v.push("Hello");

x = v[0];

v.push("world");

puts x
```

# Safety and Ownership

Here's some C++:

```cpp
#include<iostream>
#include<vector>
#include<string>

int main() {
    std::vector<std::string> v;

    v.push_back("Hello");

    std::string& x = v[0];

    v.push_back("world");

    std::cout << x;
}
```

# Safety and Ownership

```bash
$ g++ hello.cpp -Wall -Werror
$ ./a.out 
Segmentation fault (core dumped)
```

# Safety and Ownership

```cpp
int main() {
    std::vector<std::string> v;
```

| location | name | value |
|----------|------|-------|
| 0x30     | v    |       |


# Safety and Ownership

```cpp
v.push_back("Hello");
```

| location | name | value    |
|----------|------|----------|
| 0x30     | v    | 0x18     |
| 0x18     |      | "Hello"  |

# Safety and Ownership

```cpp
std::string& x = v[0];
```

| location | name | value    |
|----------|------|----------|
| 0x30     | v    | 0x18     |
| 0x18     |      | "Hello"  |
| 0x14     | x    | 0x18     |


# Safety and Ownership

```cpp
v.push_back("world");
```

| location | name | value    |
|----------|------|----------|
| 0x30     | v    | 0x08     |
| 0x18     |      | GARBAGE  |
| 0x14     | x    | 0x18     |
| 0x08     |      | "Hello"  |
| 0x04     |      | "world"  |

# Safety and Ownership

> If the new `size()` is greater than `capacity()` then all iterators and
> references (including the past-the-end iterator) are invalidated.

# Safety and Ownership

```{rust,ignore}
fn main() {
    let mut v = vec![];

    v.push("Hello");

    let x = &v[0];

    v.push("world");

    println!("{}", x);
}
```

# Safety and Ownership

```{notrust,ignore}
error: cannot borrow `v` as mutable because it is also borrowed as immutable
v.push("world");
^
```

# Safety and Ownership

```{notrust,ignore}
note: previous borrow of `v` occurs here; the immutable borrow prevents subsequent moves or mutable borrows of `v` until the borrow ends
let x = &v[0];
^
```

# Safety and Ownership

```{rust}
fn main() {
    let mut v = vec![];

    v.push("Hello");

    let x = v[0].clone();

    v.push("world");

    println!("{}", x);
}
```

# Zero Cost Abstraction

```rust
fn main() {
    let xs = [1, 2, 3, 4, 5];

    let mut xs = xs.iter()
	           .map(|x| x + 1 )
	           .filter(|x| x % 2i == 0 );

    let xs: Vec<int> = xs.collect();
}
```

# Cargo

```{bash}
$ cargo new hello_world --bin
$ cd hello_world
$ tree .
.
├── Cargo.toml
└── src
    └── main.rs

1 directory, 2 files
```

# Cargo

```{toml}
[package]

name = "hello_world"
version = "0.0.1"
authors = ["Your Name <you@example.com>"]
```

```{rust}
fn main() {
    println!("Hello, world!")
}
```

# Cargo

```{bash}
$ cargo run
   Compiling hello_world v0.0.1 (file:///Users/you/src/hello_world)
     Running `target/hello_world`
Hello, world!
```

# Cargo

```{toml}
[package]

name = "hello_world"
version = "0.0.1"
authors = ["Your Name <someone@example.com>"]

[dependencies.semver]

git = "https://github.com/rust-lang/semver.git"
```

```{bash}
$ cargo run
    Updating git repository `https://github.com/rust-lang/semver.git`
   Compiling semver v0.0.1 (https://github.com/rust-lang/semver.git#bf739419)
   Compiling hello_world v0.0.1 (file:///home/you/projects/hello_world)
     Running `target/hello_world`
Hello, world!
```

# Thanks!

![rust logo](http://www.rust-lang.org/logos/rust-logo-256x256-blk.png)

Rust makes low-level programming **accessible** to those who haven't done it, and
**safer** for those who have.

@steveklabnik
