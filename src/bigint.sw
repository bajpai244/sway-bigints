library;

pub struct BigInt {
    pub number_of_limbs: u64,
    pub limbs: Vec<u64>,
}

impl BigInt {
    pub fn new(number_of_limbs: u64) -> BigInt {
        let mut limbs = Vec::new();

        let mut counter = 0;
        while counter < number_of_limbs {
            limbs.push(0);
            counter += 1;
        }

        BigInt {
            number_of_limbs,
            limbs,
        }
    }

    pub fn has_equal_limb_size(lhs: &BigInt, rhs: &BigInt) -> bool {
        lhs.number_of_limbs == rhs.number_of_limbs
    }
}
