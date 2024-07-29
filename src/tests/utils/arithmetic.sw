library;

use ::utils::arithmetic::{add_with_carry_u64};


// Collection of test for add_with_carry_u64

#[test]
pub fn add_with_no_carry() {
    let a: u64 = 1;
    let b: u64 = 4;
    let c: u8 = 0;

    let (sum, carry) = add_with_carry_u64(a, b, c);

    assert(sum == 5);
    assert(carry == 0);
}

#[test]
pub fn add_with_carry() {
    let a = u64::max();
    let b = 1;
    let c = 0;

    let (sum, carry) = add_with_carry_u64(a, b, c);

    assert(sum == 0);
    assert(carry == 1);
}

#[test]
pub fn add_with_carry_u64_max_plus_u64_max() {
    let a = u64::max();
    let b = u64::max();
    let c = 0;

    let (sum, carry) = add_with_carry_u64(a, b, c);

    assert(sum == (a << 1));
    assert(carry == 1);
}
