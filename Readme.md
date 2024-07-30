# Bigint library for sway

Bigints in sway? Let's go :)

<img width="300px" src="https://i.giphy.com/media/v1.Y2lkPTc5MGI3NjExaGI5OWk3cHUwbHBsYXEybjdiMjBueGhrNmg2NDI4azNsNm5lYTI2ZiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/9PyhoXey73EpW/giphy.gif" />

The library aims to provide bigint implementation in the [sway](https://docs.fuel.network/docs/sway/) programming language!

What can I build with it ....

Some ideas:
- Finite Field Library
- Elliptic Curves?
- a zkSNARK verifier .....

<img width="450px" src="https://i.giphy.com/media/v1.Y2lkPTc5MGI3NjExYXMxenh6ZjNyNnIwOHJoNXFwNWdyY29rOHlna3RyZ2J2Z2U5MXY3biZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/WPtzThAErhBG5oXLeS/giphy.gif" />


## How to use

You can create a new `BigInt` by specifying using the `new` associated method.

```rust
    // number of words you want it to be
    // each word is u64
    let big_int = BigInt::new(1)
```

Demo example of doing a multiplication with the library:
```rust
#[test]
fn test_bigint_mul_with_no_carry() {
    let mut a = BigInt::new(1);
    a.limbs.set(0, 10);

    let mut b = BigInt::new(1);
    b.limbs.set(0, 10);

    let (result, carry) = a.mul(&b);

    assert(result.limbs.get(0).unwrap() == 100);
    assert(carry.limbs.get(0).unwrap() == 0);
}
```

There are multiple tests associated in the `tests` directory to help you find how to do other operations!

## Note

The library has a lot of utils and abstractions to make it even more powerful, you will see them coming, but if you feel like contributing, feel free to make a PR.

**The code has not been audited, and a lot of further optimizations can be made! Use at your own risk.**
