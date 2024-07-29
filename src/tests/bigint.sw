library;

use ::bigint::BigInt;

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
