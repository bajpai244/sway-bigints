library;

use ::utils::arithmetic::{add_with_carry_u64, mac_with_carry_u64, sub_with_borrow_u64};


// Collection of test for add_with_carry_u64

#[test]
pub fn test_add_with_no_carry() {
    let a: u64 = 1;
    let b: u64 = 4;
    let c: u8 = 0;

    let (sum, carry) = add_with_carry_u64(a, b, c);

    assert(sum == 5);
    assert(carry == 0);
}

#[test]
pub fn test_add_with_carry() {
    let a = u64::max();
    let b = 1;
    let c = 0;

    let (sum, carry) = add_with_carry_u64(a, b, c);

    assert(sum == 0);
    assert(carry == 1);
}

#[test]
pub fn test_add_with_carry_u64_max_plus_u64_max() {
    let a = u64::max();
    let b = u64::max();
    let c = 0;

    let (sum, carry) = add_with_carry_u64(a, b, c);

    assert(sum == (a << 1));
    assert(carry == 1);
}

// Collection of test for mac_with_carry_u64

#[test]
pub fn test_mac_with_no_carry() {
    let acc: u64 = 1;
    let a: u64 = 4;
    let b: u64 = 2;
    let c: u64 = 0;

    let (res, carry) = mac_with_carry_u64(acc, a, b, c);

    assert(res == 9);
    assert(carry == 0);
}

#[test]
pub fn test_mac_with_carry_no_acc() {
    let acc = 0;
    let a = u64::max();
    let b = 2;
    let c = 0;

    let (res, carry) = mac_with_carry_u64(acc, a, b, c);

    assert(res == (a << 1));
    assert(carry == 1);
}

#[test]
pub fn test_mac_with_carry_and_acc_0() {
    let acc = 1;
    let a = u64::max();
    let b = 2;
    let c = 0;

    let (res, carry) = mac_with_carry_u64(acc, a, b, c);

    assert(res == a);
    assert(carry == 1);
}

#[test]
pub fn test_mac_with_carry_and_acc_1() {
    let acc = 3;
    let a = u64::max();
    let b = 2;
    let c = 0;

    let (res, carry) = mac_with_carry_u64(acc, a, b, c);

    assert(res == 1);
    assert(carry == 2);
}

#[test]
pub fn test_sub_with_borrow_u64_no_borrow_0() {
    let a = 10;
    let b = 5;
    let c = 0;

    let (diff, borrow) = sub_with_borrow_u64(a, b, c);

    assert(diff == 5);
    assert(borrow == 0);
}

#[test]
fn test_sub_with_borrow_u64_no_borrow_1() {
    let a = 5;
    let b = 10;
    let c = 0;

    let (diff, borrow) = sub_with_borrow_u64(a, b, c);

    assert(diff == u64::max() - 4);
    assert(borrow == 1);
}

#[test]
fn test_sub_with_borrow_u64_with_borrow() {
    let a = 5;
    let b = 10;
    let c = 1;

    let (diff, borrow) = sub_with_borrow_u64(a, b, c);

    assert(diff == u64::max() - 5);
    assert(borrow == 1);
}
