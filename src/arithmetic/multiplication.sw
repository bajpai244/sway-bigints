library;

use ::bigint::BigInt;
use ::utils::arithmetic::mac_with_carry_u64;

pub trait Multiplication {
    /// Returns the product of `self` and `other`.
    /// The first element of the tuple is the high word and the second element is the low word.
    fn mul(ref mut self, rhs: &BigInt) -> (BigInt, BigInt);
}

impl Multiplication for BigInt {
    fn mul(ref mut self, rhs: &BigInt) -> (BigInt, BigInt) {
        // TODO: This can be optimized even better if a MulBuffer is used!
        // take a look at arkworks for reference [here](https://github.com/arkworks-rs/algebra/blob/dcf73a5f9610ba9d16a3c8e0de0b3835e5e5d5e4/ff/src/const_helpers.rs#L36)
        let mut buffer = BigInt::new(self.number_of_limbs*2);

        let mut i = 0;
        while i < self.number_of_limbs {
            let mut j = 0;
            while j < self.number_of_limbs {
                let acc = buffer.limbs.get(i+j).unwrap();
                let (res, carry) = mac_with_carry_u64(acc, self.limbs.get(i).unwrap(), rhs.limbs.get(j).unwrap(), 0);

                buffer.limbs.set(i+j, res);
                buffer.limbs.set(self.number_of_limbs + i, carry);

                j+=1;
            }

            i+=1;
        }

        // TODO: this needs to be optimized by using a mul buffer
        let mut msw = BigInt::new(self.number_of_limbs);
        let mut lsw = BigInt::new(self.number_of_limbs);

        let mut i = 0;
        while i < self.number_of_limbs {
            lsw.limbs.set(i, buffer.limbs.get(i).unwrap());
            msw.limbs.set(i, buffer.limbs.get(i + self.number_of_limbs).unwrap());

            i+=1;
        }

        (lsw, msw)
    }
}
