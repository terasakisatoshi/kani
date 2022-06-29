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
// -

sample();
