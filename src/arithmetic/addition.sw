library;

use ::bigint::BigInt;
use ::utils::arithmetic::add_with_carry_u64;

pub trait Addition {
     fn add_with_carry(lhs: &BigInt, rhs: &BigInt) -> (BigInt, bool);
     fn add_assign_with_carry(ref mut self, rhs: &BigInt) -> bool;
}

impl Addition for BigInt {
    fn add_with_carry(lhs: &BigInt, rhs: &BigInt) -> (BigInt, bool) {
        let mut result = BigInt::new(lhs.number_of_limbs);

        let mut idx = 0;
        let mut carry = 0;

        while idx < lhs.number_of_limbs {
            let (sum, c) = add_with_carry_u64(lhs.limbs.get(idx).unwrap(), rhs.limbs.get(idx).unwrap(), carry);
            carry = c;

            result.limbs.set(idx, sum);

            idx += 1;
        }

        (result, carry == 1)
    }

        fn add_assign_with_carry(ref mut self, rhs: &BigInt) -> (bool) {
        let mut idx = 0;
        let mut carry = 0;

        while idx < self.number_of_limbs {
            let (sum, c) = add_with_carry_u64(self.limbs.get(idx).unwrap(), rhs.limbs.get(idx).unwrap(), carry);
            carry = c;

            self.limbs.set(idx, sum);

            idx += 1;
        }

        (carry == 1)
    }
}
