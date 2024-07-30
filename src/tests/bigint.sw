library;

use ::bigint::BigInt;
use ::arithmetic::addition::Addition;
use ::arithmetic::multiplication::Multiplication;
use ::arithmetic::subtraction::Subtraction;

#[test]
fn test_bigint_new() {
    let bigint = BigInt::new(10);

    assert(bigint.number_of_limbs == 10);
    assert(bigint.limbs.len() == 10);

    let mut counter = 0;
    while counter < bigint.number_of_limbs {
        assert(bigint.limbs.get(counter).unwrap() == 0);
        counter += 1;
    }
}

#[test]
fn test_bigint_addition_with_no_carry() {
    let mut a = BigInt::new(1);
    a.limbs.set(0, 10);

    let mut b = BigInt::new(1);
    b.limbs.set(0, 10);

    let (result, carry) = BigInt::add_with_carry(&a, &b);

    assert(result.limbs.get(0).unwrap() == 20);
    assert(carry == false);
}

#[test]
fn test_bigint_addition_with_carry_0() {
    let mut a = BigInt::new(1);
    a.limbs.set(0, u64::max());

    let mut b = BigInt::new(1);
    b.limbs.set(0, 1);
    let (result, carry) = BigInt::add_with_carry(&a, &b);

    assert(result.limbs.get(0).unwrap() == 0);
    assert(carry == true);
}

#[test]
fn test_bigint_addition_with_carry_1() {
    let mut a = BigInt::new(1);
    a.limbs.set(0, u64::max());

    let mut b = BigInt::new(1);
    b.limbs.set(0, u64::max());
    let (result, carry) = BigInt::add_with_carry(&a, &b);

    assert(result.limbs.get(0).unwrap() == (u64::max() << 1));
    assert(carry == true);
}

#[test]
fn test_bigint_add_assign_with_no_carry() {
    let mut a = BigInt::new(1);
    a.limbs.set(0, 10);

    let mut b = BigInt::new(1);
    b.limbs.set(0, 10);

    let carry = a.add_assign_with_carry(&b);

    assert(a.limbs.get(0).unwrap() == 20);
    assert(carry == false);
}

#[test]
fn test_bigint_add_assign_with_carry_0() {
    let mut a = BigInt::new(1);
    a.limbs.set(0, u64::max());

    let mut b = BigInt::new(1);
    b.limbs.set(0, 1);

    let carry = a.add_assign_with_carry(&b);

    assert(a.limbs.get(0).unwrap() == 0);
    assert(carry == true);
}


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

#[test]
fn test_bigint_mul_with_carry() {
    let mut a = BigInt::new(1);
    a.limbs.set(0, u64::max());

    let mut b = BigInt::new(1);
    b.limbs.set(0, 2);

    let (result, carry) = a.mul(&b);

    assert(result.limbs.get(0).unwrap() == u64::max() << 1);
    assert(carry.limbs.get(0).unwrap() == 1);
}

#[test]
fn test_bigint_sub_with_no_borrow() {
    let mut a = BigInt::new(1);
    a.limbs.set(0, 10);

    let mut b = BigInt::new(1);
    b.limbs.set(0, 5);

    let (result, borrow) = BigInt::sub_with_carry(&a, &b);

    assert(result.limbs.get(0).unwrap() == 5);
    assert(borrow == false);
}

#[test]
fn test_bigint_sub_with_borrow() {
    let mut a = BigInt::new(1);
    a.limbs.set(0, 5);

    let mut b = BigInt::new(1);
    b.limbs.set(0, 10);

    let (result, borrow) = BigInt::sub_with_carry(&a, &b);

    assert(result.limbs.get(0).unwrap() == u64::max() - 4);
    assert(borrow == true);
}
