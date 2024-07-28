library;

pub struct BigInt
{
    number_of_limbs: u64,
    limbs: Vec<u64>
}

impl BigInt {
    fn new(number_of_limbs: u64) -> BigInt {
        let mut limbs = Vec::new();

        let mut counter = 0;
        while counter < number_of_limbs {
            limbs.push(0);
            counter +=1;
        }

        BigInt {
            number_of_limbs,
            limbs
        }
    }
}
