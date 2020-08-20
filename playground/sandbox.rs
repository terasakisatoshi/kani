// ---
// jupyter:
//   jupytext:
//     text_representation:
//       extension: .rs
//       format_name: light
//       format_version: '1.5'
//       jupytext_version: 1.5.2
//   kernelspec:
//     display_name: Rust
//     language: rust
//     name: rust
// ---

println!("Hello World");

// +
fn f(x:i32)->i32 {x}

fn g(x:i32, y:i32)->i32 {
    x + y
}

let x = 3;
let y = 9;
println!("{}", f(x));
println!("{}", g(x,y));
