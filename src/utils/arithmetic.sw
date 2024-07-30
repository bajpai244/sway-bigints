library;
use std::u128::*;

pub fn add_with_carry_u64(a: u64, b: u64, c: u8) -> (u64, u8) {
    let a_u128: U128 =   a.into();
    let b_u128: U128 =   b.into();
    let c_u128: U128 =   c.into();

    let sum: U128 = a_u128 + b_u128 + c_u128;

    let (sum_msw, sum_lsw): (u64, u64) = (sum).into();

    (sum_lsw, sum_msw.try_as_u8().unwrap())
}

pub fn mac_with_carry_u64(acc: u64, a: u64, b: u64, c: u64) -> (u64, u64) {
    let acc_u128: U128 = acc.into();
    let a_u128: U128 = a.into();
    let b_u128: U128 = b.into();
    let c_u128: U128 = c.into();

    let res: U128 = acc_u128 + a_u128 * b_u128 + c_u128;

    let (res_msw, res_lsw): (u64, u64) = (res).into();

    (res_lsw, res_msw)
}
