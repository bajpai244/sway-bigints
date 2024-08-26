library;

use ::bigint::BigInt;
use ::utils::arithmetic::sub_with_borrow_u64;

pub trait Subtraction {
    fn sub_with_borrow(lhs: &BigInt, rhs: &BigInt) -> Option<(BigInt, bool)>;
    fn sub_assign_with_borrow(ref mut self, rhs: &BigInt) -> Option<bool>;
}

impl Subtraction for BigInt {
    fn sub_with_borrow(lhs: &BigInt, rhs: &BigInt) -> Option<(BigInt, bool)> {
        if !BigInt::has_equal_limb_size(lhs, rhs) {
            return None;
        }

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
        Some((result, borrow == 1))
    }

    fn sub_assign_with_borrow(ref mut self, rhs: &BigInt) -> Option<bool> {
        if !BigInt::has_equal_limb_size(&self, rhs) {
            return None;
        }

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
        Some((borrow == 1))
    }
}
