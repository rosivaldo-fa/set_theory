note
	description: "Test suite for {STI_REAL_NUMBER}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"
	TODO: "AutoTest may confuse {STST_REAL_NUMBER_TESTS} with {REAL_NUMBER_TESTS}."

class
	REAL_NUMBER_EFFECTIVE_TESTS

inherit
	STST_REAL_NUMBER_TESTS
		rename
			some_immediate_natural_number as some_expanded_natural_number,
			some_immediate_integer_number as some_expanded_integer_number,
			some_immediate_rational_number as some_expanded_rational_number,
			some_immediate_real_number as some_expanded_real_number
		undefine
			default_create,
--			multipliable_ok,
			test_element_is_in,
			test_element_is_not_in,
			same_natural_number,
			some_natural_set,
			same_integer_number,
			some_integer_set,
			same_rational_number,
			some_rational_set,
			same_real_number
--			some_real_set
		redefine
			test_all,
			test_value,
--			test_is_in,
--			test_is_not_in,
--			test_sign,
--			test_zero,
--			test_one,
--			test_is_integer,
--			test_is_natural,
--			test_is_invertible,
--			test_equals,
--			test_unequals,
--			test_is_less,
--			test_is_less_equal,
--			test_is_greater,
--			test_is_greater_equal,
--			test_three_way_comparison,
--			test_multipliable,
--			test_divisible,
--			test_min,
--			test_max,
--			test_modulus,
--			test_abs,
--			test_plus,
--			test_minus,
--			test_opposite,
--			test_product,
--			test_quotient,
--			test_reciprocal,
--			test_inverse,
--			test_gcd,
--			test_div,
--			test_rem,
--			test_to_integer_number,
--			test_to_natural_number,
--			test_converted_integer,
--			test_integer_product_overflows
			test_adjusted_value
		end

	REAL_NUMBER_PROPERTIES
		undefine
			default_create
		end

	ELEMENT_EFFECTIVE_TESTS
		rename
			is_not_in_ok as element_is_not_in_ok,
			test_is_in as test_element_is_in,
			test_is_not_in as test_element_is_not_in,
			element_to_be_tested as real_number_to_be_tested
		undefine
			real_number_to_be_tested
		redefine
			test_all
		end

feature -- Access

	negative_infinity: STI_REAL_NUMBER
			-- Representation of negative infinity
		once
			Result := {REAL}.negative_infinity
		ensure
			class
			definition: Result.value.is_negative_infinity
		end

	positive_infinity: STI_REAL_NUMBER
			-- Representation of positive infinity
		once
			Result := {REAL}.positive_infinity
		ensure
			class
			definition: Result.value.is_positive_infinity
		end

	nan: STI_REAL_NUMBER
			-- Representation of not a number (NaN)
		once
			Result := {REAL}.nan
		ensure
			class
			definition: Result.value.is_nan
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {STI_REAL_NUMBER}.
		note
			testing: "covers/{STI_REAL_NUMBER}"
		do
			Precursor {STST_REAL_NUMBER_TESTS}
			test_default_create
			test_make
			test_make_from_reference
			test_out
		end

feature -- Test routines (Initialization)

	test_default_create
			-- Test {STI_REAL_NUMBER}.default_create.
		note
			testing: "covers/{STI_REAL_NUMBER}.default_create"
		do
			assert ("default_create", attached (create {like real_number_to_be_tested}))
		end

	test_make
			-- Test {STI_REAL_NUMBER}.make.
		note
			testing: "covers/{STI_REAL_NUMBER}.make"
		do
			assert ("make", attached (create {like real_number_to_be_tested}.make (some_native_real)))
			assert ("real_from_native", attached real_from_native (some_native_real))
		end

	test_make_from_reference
			-- Test {STI_REAL_NUMBER}.make_from_reference.
		note
			testing: "covers/{STI_REAL_NUMBER}.make_from_reference"
		do
			assert ("make_from_reference", attached (create {like real_number_to_be_tested}.make_from_reference (some_real_number)))
			assert ("real_from_reference", attached real_from_reference (some_real_number))
			assert ("real_from_rational", attached real_from_rational_reference (some_rational_number))
			assert ("real_from_integer", attached real_from_integer_reference (some_integer_number))
			assert ("real_from_natural", attached real_from_natural_reference (some_natural_number))
		end

feature -- Test routines (Primitive)

	test_value
			-- Test {STI_REAL_NUMBER}.value.
		note
			testing: "covers/{STI_REAL_NUMBER}.value"
		local
			x: like real_number_to_be_tested
		do
			Precursor {STST_REAL_NUMBER_TESTS}
			x := real_number_to_be_tested
			assert ("native_from_real", attached native_from_real (x))
			assert ("native_ref_from_real", attached native_ref_from_real (x))
			assert ("numeric_from_real", attached numeric_from_real (x))
			assert ("comparable_from_real", attached comparable_from_real (x))
			assert ("hashable_from_real", attached hashable_from_real (x))

			x := Nan
			assert ("NaN", x.value.is_nan)

			x := - x.value
			assert ("negative NaN", x.value.is_nan and - x.value = Nan.value)
			assert ("negative NaN sign bit ", {like real_number_to_be_tested}.value_sign_bit (x.value) = 1)

			x := Zero
			assert ("negative zero", - x.value = 0)
			assert ("negative zero sign bit ", {like real_number_to_be_tested}.value_sign_bit (- x.value) = 1)
		end

--feature -- Test routines (Membership)

--	test_is_in
--			-- Test {STS_REAL_NUMBER}.is_in.
--			-- Test {STI_REAL_NUMBER}.is_in.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.is_in"
--			testing: "covers/{STI_REAL_NUMBER}.is_in"
--		do
--			Precursor {STST_REAL_NUMBER_TESTS}
--		end

--	test_is_not_in
--			-- Test {STS_REAL_NUMBER}.is_not_in.
--			-- Test {STI_REAL_NUMBER}.is_not_in.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.is_not_in"
--			testing: "covers/{STI_REAL_NUMBER}.is_not_in"
--		do
--			Precursor {STST_REAL_NUMBER_TESTS}
--		end

--feature -- Test routines (Access)

--	test_sign
--			-- Test {STI_REAL_NUMBER}.sign.
--		note
--			testing: "covers/{STI_REAL_NUMBER}.sign"
--		do
--			Precursor {STST_REAL_NUMBER_TESTS}
--		end

--	test_zero
--			-- Test {STI_REAL_NUMBER}.zero.
--		note
--			testing: "covers/{STI_REAL_NUMBER}.zero"
--		do
--			Precursor {STST_REAL_NUMBER_TESTS}
--		end

--	test_one
--			-- Test {STI_REAL_NUMBER}.one.
--		note
--			testing: "covers/{STI_REAL_NUMBER}.one"
--		do
--			Precursor {STST_REAL_NUMBER_TESTS}
--		end

--feature -- Test routines (Quality)

--	test_is_integer
--			-- <Precursor>
--			-- Test {STI_REAL_NUMBER}.is_integer.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.is_integer"
--			testing: "covers/{STI_REAL_NUMBER}.is_integer"
--		do
--			Precursor {STST_REAL_NUMBER_TESTS}
--		end

--	test_is_natural
--			-- <Precursor>
--			-- Test {STI_REAL_NUMBER}.is_natural.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.is_natural"
--			testing: "covers/{STI_REAL_NUMBER}.is_natural"
--		do
--			Precursor {STST_REAL_NUMBER_TESTS}
--		end

--	test_is_invertible
--			-- <Precursor>
--			-- Test {STI_REAL_NUMBER}.is_invertible.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.is_invertible"
--			testing: "covers/{STI_REAL_NUMBER}.is_invertible"
--		do
--			Precursor {STST_REAL_NUMBER_TESTS}
--		end

feature -- Test routines (Output)

	test_out
			-- Test {STI_REAL_NUMBER}.out.
		note
			testing: "covers/{STI_REAL_NUMBER}.out"
		do
			assert ("out", attached real_number_to_be_tested.out)
		end

--feature -- Test routines (Comparison)

--	test_equals
--			-- <Precursor>
--			-- Test {STI_REAL_NUMBER}.equals.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.equals"
--			testing: "covers/{STI_REAL_NUMBER}.equals"
--		do
--			Precursor {STST_REAL_NUMBER_TESTS}
--		end

--	test_unequals
--			-- <Precursor>
--			-- Test {STS_REAL_NUMBER}.unequals.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.unequals"
--			testing: "covers/{STI_REAL_NUMBER}.unequals"
--		do
--			Precursor {STST_REAL_NUMBER_TESTS}
--		end

--	test_is_less
--			-- <Precursor>
--			-- Test {STI_REAL_NUMBER}.is_less.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.is_less"
--			testing: "covers/{STI_REAL_NUMBER}.is_less"
--		do
--			Precursor {STST_REAL_NUMBER_TESTS}
--		end

--	test_is_less_equal
--			-- <Precursor>
--			-- Test {STI_REAL_NUMBER}.is_less_equal.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.is_less_equal"
--			testing: "covers/{STI_REAL_NUMBER}.is_less_equal"
--		do
--			Precursor {STST_REAL_NUMBER_TESTS}
--		end

--	test_is_greater
--			-- <Precursor>
--			-- Test {STI_REAL_NUMBER}.is_greater.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.is_greater"
--			testing: "covers/{STI_REAL_NUMBER}.is_greater"
--		do
--			Precursor {STST_REAL_NUMBER_TESTS}
--		end

--	test_is_greater_equal
--			-- <Precursor>
--			-- Test {STI_REAL_NUMBER}.is_greater_equal.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.is_greater_equal"
--			testing: "covers/{STI_REAL_NUMBER}.is_greater_equal"
--		do
--			Precursor {STST_REAL_NUMBER_TESTS}
--		end

--	test_three_way_comparison
--			-- <Precursor>
--			-- Test {STI_REAL_NUMBER}.three_way_comparison.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.three_way_comparison"
--			testing: "covers/{STI_REAL_NUMBER}.three_way_comparison"
--		do
--			Precursor {STST_REAL_NUMBER_TESTS}
--		end

--	test_min
--			-- Test {STI_REAL_NUMBER}.min.
--		note
--			testing: "covers/{STI_REAL_NUMBER}.min"
--		do
--			Precursor {STST_REAL_NUMBER_TESTS}
--		end

--	test_max
--			-- Test {STI_REAL_NUMBER}.max.
--		note
--			testing: "covers/{STI_REAL_NUMBER}.max"
--		do
--			Precursor {STST_REAL_NUMBER_TESTS}
--		end

--feature -- Test routines (Relationship)

--	test_multipliable
--			-- Test {STI_REAL_NUMBER}.multipliable.
--		note
--			testing: "covers/{STI_REAL_NUMBER}.multipliable"
--		local
--			pq_1: like real_number_to_be_tested
--			pq_2: like some_real_number
--		do
--			Precursor {STST_REAL_NUMBER_TESTS}
--			pq_1 := real_number_to_be_tested
--			pq_2 := some_real_number
--			check
--				good_divisor_1: pq_1.q.divisible (gcd (pq_2.p, pq_1.q)) -- pq_1.q /= 0
--				good_divisor_2: pq_2.q.divisible (gcd (pq_1.p, pq_2.q)) -- pq_2.q /= 0
--			end
--			assert (
--					"even when overflows",
--					pq_1.integer_product_overflows (pq_1.q // gcd (pq_2.p, pq_1.q), pq_2.q // gcd (pq_1.p, pq_2.q)) and
--					(pq_1.q // gcd (pq_2.p, pq_1.q)) ⋅ (pq_2.q // gcd (pq_1.p, pq_2.q)) ≭ Zero.p ⇒
--					pq_1.multipliable (pq_2)
--				)
--			assert ("even when overflows ok", multipliable_ok (pq_1, pq_2))
--		end

--	test_divisible
--			-- <Precursor>
--			-- Test {STI_REAL_NUMBER}.divisible.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.divisible"
--			testing: "covers/{STI_REAL_NUMBER}.divisible"
--		local
--			pq_1: like real_number_to_be_tested
--			pq_2: like some_real_number
--		do
--			Precursor {STST_REAL_NUMBER_TESTS}
--			pq_1 := real_number_to_be_tested
--			pq_2 := some_real_number
--			check
--				good_divisor_1: pq_1.q.divisible (gcd (pq_2.q, pq_1.q)) -- pq_1.q, pq_2.q /= 0
--				good_divisor_2: pq_2 ≭ zero ⇒ pq_2.p.divisible (gcd (pq_1.p, pq_2.p)) -- pq_2.p /= 0 ⇐ pq_2 ≭ zero
--			end
--			assert (
--					"even when overflows",
--					pq_2 ≭ zero and then pq_1.integer_product_overflows (pq_1.q // gcd (pq_2.q, pq_1.q), pq_2.p // gcd (pq_1.p, pq_2.p)) and
--					(pq_1.q // gcd (pq_2.q, pq_1.q)) ⋅ (pq_2.p // gcd (pq_1.p, pq_2.p)) ≭ Zero.p ⇒
--					pq_1.divisible (pq_2)
--				)
--			assert ("even when overflows ok", divisible_ok (pq_1, pq_2))
--		end

--feature -- Test routines (Operation)

--	test_modulus
--			-- Test {STI_REAL_NUMBER}.modulus.
--		note
--			testing: "covers/{STI_REAL_NUMBER}.modulus"
--		do
--			Precursor {STST_REAL_NUMBER_TESTS}
--		end

--	test_abs
--			-- Test {STI_REAL_NUMBER}.abs.
--		note
--			testing: "covers/{STI_REAL_NUMBER}.abs"
--		do
--			Precursor {STST_REAL_NUMBER_TESTS}
--		end

--	test_plus
--			-- <Precursor>
--			-- Test {STI_REAL_NUMBER}.plus.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.plus"
--			testing: "covers/{STI_REAL_NUMBER}.plus"
--		do
--			Precursor {STST_REAL_NUMBER_TESTS}
--		end

--	test_minus
--			-- <Precursor>
--			-- Test {STI_REAL_NUMBER}.minus.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.minus"
--			testing: "covers/{STI_REAL_NUMBER}.minus"
--		do
--			Precursor {STST_REAL_NUMBER_TESTS}
--		end

--	test_opposite
--			-- Test {STI_REAL_NUMBER}.opposite.
--		note
--			testing: "covers/{STI_REAL_NUMBER}.opposite"
--		do
--			Precursor {STST_REAL_NUMBER_TESTS}
--		end

--	test_product
--			-- <Precursor>
--			-- Test {STI_REAL_NUMBER}.product.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.product"
--			testing: "covers/{STI_REAL_NUMBER}.product"
--		do
--			Precursor {STST_REAL_NUMBER_TESTS}
--		end

--	test_quotient
--			-- Test {STI_REAL_NUMBER}.quotient.
--		note
--			testing: "covers/{STI_REAL_NUMBER}.quotient"
--		do
--			Precursor {STST_REAL_NUMBER_TESTS}
--		end

--	test_reciprocal
--			-- <Precursor>
--			-- Test {STI_REAL_NUMBER}.reciprocal.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.reciprocal"
--			testing: "covers/{STI_REAL_NUMBER}.reciprocal"
--		do
--			Precursor {STST_REAL_NUMBER_TESTS}
--		end

--	test_inverse
--			-- <Precursor>
--			-- Test {STI_REAL_NUMBER}.inverse.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.inverse"
--			testing: "covers/{STI_REAL_NUMBER}.inverse"
--		do
--			Precursor {STST_REAL_NUMBER_TESTS}
--		end

--feature -- Test routines (Conversion)

--	test_to_integer_number
--			-- <Precursor>
--			-- Test {STI_REAL_NUMBER}.to_integer_number.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.to_integer_number"
--			testing: "covers/{STI_REAL_NUMBER}.to_integer_number"
--		do
--			Precursor {STST_REAL_NUMBER_TESTS}
--		end

--	test_to_natural_number
--			-- <Precursor>
--			-- Test {STI_REAL_NUMBER}.to_natural_number.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.to_natural_number"
--			testing: "covers/{STI_REAL_NUMBER}.to_natural_number"
--		do
--			Precursor {STST_REAL_NUMBER_TESTS}
--		end

--feature -- Test routines (Factory)

--	test_converted_integer
--			-- Test {STI_REAL_NUMBER}.converted_integer.
--		note
--			testing: "covers/{STI_REAL_NUMBER}.converted_integer"
--		do
--			Precursor {STST_REAL_NUMBER_TESTS}
--		end

--feature -- Test routines (Math)

--	test_gcd
--			-- <Precursor>
--			-- Test {STI_REAL_NUMBER}.gcd.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.gcd"
--			testing: "covers/{STI_REAL_NUMBER}.gcd"
--		do
--			Precursor {STST_REAL_NUMBER_TESTS}
--		end

--	test_div
--			-- <Precursor>
--			-- Test {STI_REAL_NUMBER}.div.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.div"
--			testing: "covers/{STI_REAL_NUMBER}.div"
--		do
--			Precursor {STST_REAL_NUMBER_TESTS}
--		end

--	test_rem
--			-- <Precursor>
--			-- Test {STI_REAL_NUMBER}.rem.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.rem"
--			testing: "covers/{STI_REAL_NUMBER}.rem"
--		do
--			Precursor {STST_REAL_NUMBER_TESTS}
--		end

--feature -- Test routines (Predicate)

--	test_integer_product_overflows
--			-- Test {STI_REAL_NUMBER}.integer_product_overflows.
--		note
--			testing: "covers/{STI_REAL_NUMBER}.integer_product_overflows"
--		do
--			Precursor {STST_REAL_NUMBER_TESTS}
--		end

feature -- Test routines (Math)

	test_value_sign_bit
			-- Test {STI_REAL_NUMBER}.value_sign_bit.
		note
			testing: "covers/{STI_REAL_NUMBER}.value_sign_bit"
		local
			v: like some_native_real
		do
			v := Nan
			assert ("unsigned nan", real_number_to_be_tested.value_sign_bit (v) = 0)

			from
				v := some_native_real
			until
				not v.is_nan and v < 0
			loop
				v := some_native_real
			end
			assert ("negative", real_number_to_be_tested.value_sign_bit (v) = 1)

			v := 0.0
			assert ("negative zero", real_number_to_be_tested.value_sign_bit (- v) = 1)
			assert ("positive zero", real_number_to_be_tested.value_sign_bit (v) = 0)

			from
				v := some_native_real
			until
				0 < v
			loop
				v := some_native_real
			end
			assert ("positive", real_number_to_be_tested.value_sign_bit (v) = 0)

			assert ("NaN", attached real_number_to_be_tested.value_sign_bit (Nan))
			assert ("-Infinity", attached real_number_to_be_tested.value_sign_bit (Negative_infinity))
			assert ("Infinity", attached real_number_to_be_tested.value_sign_bit (Positive_infinity))
			assert ("-0", attached real_number_to_be_tested.value_sign_bit (-0.0))
			assert ("0", attached real_number_to_be_tested.value_sign_bit (0))
			assert ("x", attached real_number_to_be_tested.value_sign_bit (some_native_real))
		end

	test_value_logb
			-- Test {STI_REAL_NUMBER}.value_logb.
		note
			testing: "covers/{STI_REAL_NUMBER}.value_logb"
		do
			assert ("-NaN", attached real_number_to_be_tested.value_logb (- Nan.value))
			assert ("NaN", attached real_number_to_be_tested.value_logb (Nan))
			assert ("-Infinity", attached real_number_to_be_tested.value_logb (Negative_infinity))
			assert ("Infinity", attached real_number_to_be_tested.value_logb (Positive_infinity))
			assert ("-0", attached real_number_to_be_tested.value_logb (-0.0))
			assert ("0", attached real_number_to_be_tested.value_logb (0))
			assert ("x", attached real_number_to_be_tested.value_logb (some_native_real))
		end

feature -- Test routines (Implementation)

	test_adjusted_value
			-- Test {STI_REAL_NUMBER}.adjusted_value.
		note
			testing: "covers/{STI_REAL_NUMBER}.adjusted_value"
		do
			Precursor {STST_REAL_NUMBER_TESTS}
			assert ("-NaN", attached real_number_to_be_tested.adjusted_value (- Nan.value))
			assert ("NaN", attached real_number_to_be_tested.adjusted_value (Nan))
			assert ("-Infinity", attached real_number_to_be_tested.adjusted_value (Negative_infinity))
			assert ("Infinity", attached real_number_to_be_tested.adjusted_value (Positive_infinity))
			assert ("-0", attached real_number_to_be_tested.adjusted_value (-0.0))
			assert ("0", attached real_number_to_be_tested.adjusted_value (0))
		end

feature -- Test routines (Implementation)

	test_sign_bit_status
			-- Test {STI_REAL_NUMBER}.sign_bit_status.
		note
			testing: "covers/{STI_REAL_NUMBER}.sign_bit_status"
		local
			x: like exposed_real_number_to_be_tested
		do
			x := - Nan.value
			assert ("signed NaN", x.sign_bit_status = 1)
			assert ("signed NaN ok", sign_bit_status_ok (x))

			x := Nan
			assert ("unsigned NaN", x.sign_bit_status = 0)
			assert ("unsigned NaN ok", sign_bit_status_ok (x))

			x := - Zero.value
			assert ("negative zero", x.sign_bit_status = 1)
			assert ("negative zero ok", sign_bit_status_ok (x))

			x := Zero
			assert ("positive zero", x.sign_bit_status = 0)
			assert ("positive zero ok", sign_bit_status_ok (x))

			x := Negative_infinity
			assert ("- Infinity", x.sign_bit_status = 1)
			assert ("- Infinity ok", sign_bit_status_ok (x))

			x := Positive_infinity
			assert ("Infinity", x.sign_bit_status = 0)
			assert ("Infinity ok", sign_bit_status_ok (x))

			from
				x := exposed_real_number_to_be_tested
			until
				not x.value.is_nan and x.value < 0
			loop
				x := exposed_real_number_to_be_tested
			end
			assert ("negative", x.sign_bit_status = 1)
			assert ("negative ok", sign_bit_status_ok (x))

			from
				x := exposed_real_number_to_be_tested
			until
				0 < x.value
			loop
				x := exposed_real_number_to_be_tested
			end
			assert ("positive", x.sign_bit_status = 0)
			assert ("positive ok", sign_bit_status_ok (x))

			x := exposed_real_number_to_be_tested
			assert ("sign_bit_status", attached x.sign_bit_status)
			assert ("sign_bit_status_ok", sign_bit_status_ok (x))
		end

	test_exponent_bit_pattern
			-- Test {STI_REAL_NUMBER}.exponent_bit_pattern.
		note
			testing: "covers/{STI_REAL_NUMBER}.exponent_bit_pattern"
		local
			x: like exposed_real_number_to_be_tested
		do
			x := - Nan.value
			assert ("-NaN", attached x.exponent_bit_pattern)
			assert ("-NaN ok", exponent_bit_pattern_ok (x))

			x := Nan
			assert ("NaN", attached x.exponent_bit_pattern)
			assert ("NaN ok", exponent_bit_pattern_ok (x))

			x := Negative_infinity
			assert ("-Infinity", attached x.exponent_bit_pattern)
			assert ("-Infinity ok", exponent_bit_pattern_ok (x))

			x := Positive_infinity
			assert ("Infinity", attached x.exponent_bit_pattern)
			assert ("Infinity ok", exponent_bit_pattern_ok (x))

			x := - Zero.value
			assert ("-0", attached x.exponent_bit_pattern)
			assert ("-0 ok", exponent_bit_pattern_ok (x))

			x := Zero
			assert ("0", attached x.exponent_bit_pattern)
			assert ("0 ok", exponent_bit_pattern_ok (Zero))

			x := exposed_real_number_to_be_tested
			assert ("exponent_bit_pattern", attached x.exponent_bit_pattern)
			assert ("exponent_bit_pattern ok", exponent_bit_pattern_ok (x))
		end

feature {NONE} -- Conversion

	real_from_reference (x: STS_REAL_NUMBER): like real_number_to_be_tested
			-- `x' converted to a real number like `real_number_to_be_tested'
		do
			Result := x
		ensure
			value: Result.value = x.value
		end

	real_from_rational_reference (pq: STS_RATIONAL_NUMBER): like real_number_to_be_tested
			-- `pq' converted to a real number like `real_number_to_be_tested'
		do
			Result := pq
		ensure
			value: Result.value = pq.value
		end

	real_from_integer_reference (i: STS_INTEGER_NUMBER): like real_number_to_be_tested
			-- `i' converted to a real number like `real_number_to_be_tested'
		do
			Result := i
		ensure
			value: Result.value = i.real_value
		end

	real_from_natural_reference (n: STS_NATURAL_NUMBER): like real_number_to_be_tested
			-- `n' converted to a real number like `real_number_to_be_tested'
		do
			Result := n
		ensure
			value: Result.value = n.real_value
		end

	real_from_native (v: like some_native_real): like real_number_to_be_tested
			-- `v' converted to a real number like `real_number_to_be_tested'
		do
			Result := v
		ensure
			adjusted_value: Result.value = {like real_number_to_be_tested}.adjusted_value (v)
		end

	native_from_real (x: STI_REAL_NUMBER): like some_native_real
			-- `x' converted to a native real number
		do
			Result := x
		ensure
			value: Result = x.value
		end

	native_ref_from_real (x: STI_REAL_NUMBER): like some_native_real_ref
			-- `x' converted to a native real number reference
		do
			Result := x
		ensure
			value: Result = x.value
		end

	numeric_from_real (x: STI_REAL_NUMBER): NUMERIC
			-- `x' converted to a {NUMERIC} object
		do
			Result := x
		ensure
			value: Result = x.value
		end

	comparable_from_real (x: STI_REAL_NUMBER): COMPARABLE
			-- `x' converted to a {COMPARABLE} object
		do
			Result := x
		ensure
			value: Result = x.value
		end

	hashable_from_real (x: STI_REAL_NUMBER): HASHABLE
			-- `x' converted to a {HASHABLE} object
		do
			Result := x
		ensure
			value: Result = x.value
		end

feature {NONE} -- Factory (element to be tested)

	exposed_real_number_to_be_tested: like some_exposed_real_number
			-- Real number meant to have under tests its features with restricted access
		do
			Result := some_exposed_real_number
		end

feature -- Anchor

	rational_anchor: STI_RATIONAL_NUMBER
			-- <Precursor>
		once
		ensure then
			class
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
