library;

use ::bigint::BigInt;
use ::utils::arithmetic::add_with_carry_u64;

pub trait Addition {
    fn add_with_carry(ref mut self, other: &BigInt) -> bool;
}

impl Addition for BigInt {
    fn add_with_carry(ref mut self, other: &BigInt) -> bool {
        let mut idx = 0;

        let mut carry = 0;

        while idx < self.number_of_limbs {

            let (sum, c) = add_with_carry_u64(self.limbs.get(idx).unwrap(), other.limbs.get(idx).unwrap(), carry);
            carry = c;

            self.limbs.set(idx, sum);

            idx += 1;
        }

        (carry == 1)
    }
}
