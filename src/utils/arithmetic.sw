library;
use std::u128::*;

pub fn add_with_carry_u64(a: u64, b: u64, c: u8) -> (u64, u8) {
    let a_u128: U128 =   a.into();
    let b_u128: U128 =   b.into();
    let c_u128: U128 =   c.into();

    let sum: U128 = a_u128 + b_u128 + c_u128;

    let (_, carry_lsb): (u64, u64) = (sum >> 64).into();
    let (_, sum_lsb): (u64, u64) = (sum).into();

    (sum_lsb, carry_lsb.try_as_u8().unwrap())
}
