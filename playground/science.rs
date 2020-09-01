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

// +
// :dep ndarray = { git = "https://github.com/rust-ndarray/ndarray" }
extern crate ndarray;

use ndarray::prelude::*;

fn sample() {
    let a = array![
                [1.,2.,3.], 
                [4.,5.,6.],
            ]; 
    assert_eq!(a.ndim(), 2);         // get the number of dimensions of array a
    assert_eq!(a.len(), 6);          // get the number of elements in array a
    assert_eq!(a.shape(), [2, 3]);   // get the shape of array a
    assert_eq!(a.is_empty(), false); // check if the array has zero elements

    println!("{:?}", a);
}
