library;

use ::bigint::BigInt;
use ::utils::arithmetic::sub_with_borrow_u64;

pub trait Subtraction {
    fn sub_with_borrow(lhs: &BigInt, rhs: &BigInt) -> (BigInt, bool);
    fn sub_assign_with_borrow(ref mut self, rhs: &BigInt) -> bool;
}

impl Subtraction for BigInt {
    fn sub_with_borrow(lhs: &BigInt, rhs: &BigInt) -> (BigInt, bool) {
        let mut result = BigInt::new(lhs.number_of_limbs);

        let mut idx = 0;
        let mut borrow = 0;

        while idx < lhs.number_of_limbs {
            let (diff, b) = sub_with_borrow_u64(
                lhs.limbs
                    .get(idx)
                    .unwrap(),
                rhs.limbs
                    .get(idx)
                    .unwrap(),
                borrow,
            );
            borrow = b;

            result.limbs.set(idx, diff);

            idx += 1;
        }
        (result, borrow == 1)
    }

    fn sub_assign_with_borrow(ref mut self, rhs: &BigInt) -> bool {
        let mut idx = 0;
        let mut borrow = 0;

        while idx < self.number_of_limbs {
            let (diff, b) = sub_with_borrow_u64(
                self.limbs
                    .get(idx)
                    .unwrap(),
                rhs.limbs
                    .get(idx)
                    .unwrap(),
                borrow,
            );
            borrow = b;

            self.limbs.set(idx, diff);

            idx += 1;
        }
        (borrow == 1)
    }
}
