note
	description: "Test suite for {STS_REAL_NUMBER}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

deferred class
	REAL_NUMBER_TESTS

inherit
	ELEMENT_TESTS
		rename
			is_not_in_ok as element_is_not_in_ok,
			test_is_in as test_element_is_in,
			test_is_not_in as test_element_is_not_in,
			element_to_be_tested as real_number_to_be_tested
		redefine
			test_all,
			real_number_to_be_tested
		end

	REAL_NUMBER_PROPERTIES

feature -- Access

	two: like real_anchor
			-- The real number 2
		deferred
		ensure
			definition: Result.value = 2
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {STS_REAL_NUMBER}.
		note
			testing: "covers/{STS_REAL_NUMBER}"
		do
			Precursor {ELEMENT_TESTS}
			test_value
			test_is_in
			test_is_not_in
			test_sign
			test_zero
			test_one
			test_two
			test_is_nan
			test_is_negative_infinity
			test_is_positive_infinity
			test_is_infinite
			test_is_finite
			test_is_rational
			test_is_integer
			test_is_natural
			test_is_invertible
			test_equals
			test_unequals
			test_is_less
			test_is_less_equal
			test_is_greater
			test_is_greater_equal
			test_three_way_comparison
--			test_multipliable
--			test_divisible
			test_min
			test_max
--			test_modulus
--			test_abs
--			test_plus
--			test_minus
--			test_opposite
--			test_product
--			test_quotient
--			test_reciprocal
--			test_inverse
--			test_to_integer_number
--			test_to_natural_number
--			test_converted_integer
--			test_gcd
--			test_div
--			test_rem
--			test_integer_product_overflows
			test_adjusted_value
		end

feature -- Test routines (Primitive)

	test_value
			-- Test {STS_REAL_NUMBER}.value.
		note
			testing: "covers/{STS_REAL_NUMBER}.value"
		local
			x: like real_number_to_be_tested
		do
			x := real_number_to_be_tested
			assert ("value", attached x.value)
		end

feature -- Test routines (Membership)

	test_is_in
			-- Test {STS_REAL_NUMBER}.is_in.
		note
			testing: "covers/{STS_REAL_NUMBER}.is_in"
		local
			x: like real_number_to_be_tested
			s: like some_set_r
		do
			x := real_number_to_be_tested
			s := some_set_r.extended (x, some_equality_r)
			assert ("x ∈ s", x ∈ s)

			x := real_number_to_be_tested
			s := some_set_r.prunned (x)
			assert ("not (x ∈ s)", not (x ∈ s))

			x := real_number_to_be_tested
			s := some_set_r
			assert ("is_in", x ∈ s ⇒ True)
		end

	test_is_not_in
			-- Test {STS_REAL_NUMBER}.is_not_in.
		note
			testing: "covers/{STS_REAL_NUMBER}.is_not_in"
		local
			x: like real_number_to_be_tested
			s: like some_set_r
		do
			x := real_number_to_be_tested
			s := some_set_r.prunned (x)
			assert ("x ∉ s", x ∉ s)
			assert ("x ∉ s ok", is_not_in_ok (x, s))

			x := real_number_to_be_tested
			s := some_set_r.extended (x, some_equality_r)
			assert ("not (x ∉ s)", not (x ∉ s))
			assert ("not (x ∉ s) ok", is_not_in_ok (x, s))

			x := real_number_to_be_tested
			s := some_set_r
			assert ("is_not_in", x ∉ s ⇒ True)
			assert ("is_not_in_ok", is_not_in_ok (x, s))
		end

feature -- Test routines (Access)

	test_sign
			-- Test {STS_REAL_NUMBER}.sign.
		note
			testing: "covers/{STS_REAL_NUMBER}.sign"
		local
			x: like real_number_to_be_tested
		do
			x := real_number_to_be_tested
			assert ("x.sign", attached x.sign)

			from
				x := real_number_to_be_tested
			until
				x < Zero
			loop
				x := real_number_to_be_tested
			end
			assert ("negative", x.sign.real_value = - One.value)

			from
				x := real_number_to_be_tested
			until
				x > Zero
			loop
				x := real_number_to_be_tested
			end
			assert ("positive", x.sign.real_value = One.value)
		end

	test_zero
			-- Test {STS_REAL_NUMBER}.zero.
		note
			testing: "covers/{STS_REAL_NUMBER}.zero"
		local
			x: like real_number_to_be_tested
		do
			x := real_number_to_be_tested
			assert ("zero", attached x.Zero)
		end

	test_one
			-- Test {STS_REAL_NUMBER}.one.
		note
			testing: "covers/{STS_REAL_NUMBER}.one"
		local
			x: like real_number_to_be_tested
		do
			x := real_number_to_be_tested
			assert ("one", attached x.One)
			assert ("One ok", one_ok (x, some_real_number))

			assert ("0", one_ok (Zero, some_real_number))
		end

	test_two
			-- Test {STS_REAL_NUMBER}.two.
		note
			testing: "covers/{STS_REAL_NUMBER}.two"
		do
			assert ("two", attached real_number_to_be_tested.two)
		end

feature -- Test routines (Quality)

	test_is_nan
			-- Test {STS_REAL_NUMBER}.is_nan.
		note
			testing: "covers/{STS_REAL_NUMBER}.is_nan"
		local
			x: like real_number_to_be_tested
		do
			x := real_number_to_be_tested
			assert ("is_nan", x.is_nan ⇒ True)
			assert ("is_nan ok", is_nan_ok (x, some_real_number))

			from
				x := real_number_to_be_tested
			until
				x < Zero
			loop
				x := real_number_to_be_tested
			end
			x := x.real_from_value ({like real_math_anchor}.log (x.value))
			assert ("log (x).is_nan", x.is_nan)
			assert ("log (x).is_nan ok", is_nan_ok (x, some_real_number))

			from
				x := real_number_to_be_tested
			until
				x < Zero
			loop
				x := real_number_to_be_tested
			end
			x := x.real_from_value ({like real_math_anchor}.log10 (x.value))
			assert ("log10 (x).is_nan", x.is_nan)
			assert ("log10 (x).is_nan ok", is_nan_ok (x, some_real_number))

			from
				x := real_number_to_be_tested
			until
				x < Zero
			loop
				x := real_number_to_be_tested
			end
			x := x.real_from_value ({like real_math_anchor}.log_2 (x.value))
			assert ("log_2 (x).is_nan", x.is_nan)
			assert ("log_2 (x).is_nan ok", is_nan_ok (x, some_real_number))

			assert ("not zero.is_nan", not zero.is_nan)
			assert ("not zero.is_nan ok", is_nan_ok (Zero, some_real_number))

			assert ("not one.is_nan", not one.is_nan)
			assert ("not one.is_nan ok", is_nan_ok (one, some_real_number))
		end

	test_is_negative_infinity
			-- Test {STS_REAL_NUMBER}.is_negative_infinity.
		note
			testing: "covers/{STS_REAL_NUMBER}.is_negative_infinity"
		local
			x: like real_number_to_be_tested
		do
			x := real_number_to_be_tested
			assert ("is_negative_infinity", x.is_negative_infinity ⇒ True)
			assert ("is_negative_infinity ok", is_negative_infinity_ok (x, some_real_number))

			assert ("not zero.is_negative_infinity", not zero.is_negative_infinity)
			assert ("not zero.is_negative_infinity ok", is_negative_infinity_ok (Zero, some_real_number))

			assert ("not one.is_negative_infinity", not one.is_negative_infinity)
			assert ("not one.is_negative_infinity ok", is_negative_infinity_ok (one, some_real_number))
		end

	test_is_positive_infinity
			-- Test {STS_REAL_NUMBER}.is_positive_infinity.
		note
			testing: "covers/{STS_REAL_NUMBER}.is_positive_infinity"
		local
			x: like real_number_to_be_tested
		do
			x := real_number_to_be_tested
			assert ("is_positive_infinity", x.is_positive_infinity ⇒ True)
			assert ("is_positive_infinity ok", is_positive_infinity_ok (x, some_real_number))

			assert ("not zero.is_positive_infinity", not zero.is_positive_infinity)
			assert ("not zero.is_positive_infinity ok", is_positive_infinity_ok (Zero, some_real_number))

			assert ("not one.is_positive_infinity", not one.is_positive_infinity)
			assert ("not one.is_positive_infinity ok", is_positive_infinity_ok (one, some_real_number))
		end

	test_is_infinite
			-- Test {STS_REAL_NUMBER}.is_infinite.
		note
			testing: "covers/{STS_REAL_NUMBER}.is_infinite"
		local
			x: like real_number_to_be_tested
		do
			x := real_number_to_be_tested
			assert ("is_infinite", x.is_infinite ⇒ True)
			assert ("not zero.is_infinite", not zero.is_infinite)
			assert ("not one.is_infinite", not one.is_infinite)
		end

	test_is_finite
			-- Test {STS_REAL_NUMBER}.is_finite.
		note
			testing: "covers/{STS_REAL_NUMBER}.is_finite"
		local
			x: like real_number_to_be_tested
		do
			x := real_number_to_be_tested
			assert ("is_finite", x.is_finite ⇒ True)
			assert ("zero.is_finite", zero.is_finite)
			assert ("one.is_finite", one.is_finite)
		end

	test_is_rational
			-- Test {STS_REAL_NUMBER}.is_rational.
		note
			testing: "covers/{STS_REAL_NUMBER}.is_rational"
		local
			x: like real_number_to_be_tested
		do
			x := real_number_to_be_tested
			assert ("is_rational", x.is_rational ⇒ True)
			assert ("is_rational ok", is_rational_ok (x))

			assert ("zero.is_rational", zero.is_rational)
			assert ("zero.is_rational ok", is_rational_ok (zero))

			assert ("one.is_rational", one.is_rational)
			assert ("one.is_rational ok", is_rational_ok (one))

			assert ("two.is_rational", two.is_rational)
			assert ("two.is_rational ok", is_rational_ok (two))
		end

	test_is_integer
			-- Test {STS_REAL_NUMBER}.is_integer.
		note
			testing: "covers/{STS_REAL_NUMBER}.is_integer"
		local
			x: like real_number_to_be_tested
		do
			x := real_number_to_be_tested
			assert ("is_integer", x.is_integer ⇒ True)
			assert ("is_integer ok", is_integer_ok (x))

			assert ("zero.is_integer", zero.is_integer)
			assert ("zero.is_integer ok", is_integer_ok (zero))

			assert ("one.is_integer", one.is_integer)
			assert ("one.is_integer ok", is_integer_ok (one))

			assert ("two.is_integer", two.is_integer)
			assert ("two.is_integer ok", is_integer_ok (two))
		end

	test_is_natural
			-- Test {STS_REAL_NUMBER}.is_natural.
		note
			testing: "covers/{STS_REAL_NUMBER}.is_natural"
		local
			x: like real_number_to_be_tested
		do
			x := real_number_to_be_tested
			assert ("is_natural", x.is_natural ⇒ True)
			assert ("is_natural ok", is_natural_ok (x))

			assert ("zero.is_natural", zero.is_natural)
			assert ("zero.is_natural ok", is_natural_ok (zero))

			assert ("one.is_natural", one.is_natural)
			assert ("one.is_natural ok", is_natural_ok (one))

			assert ("two.is_natural", two.is_natural)
			assert ("two.is_natural ok", is_natural_ok (two))
		end

	test_is_invertible
			-- Test {STS_REAL_NUMBER}.is_invertible.
		note
			testing: "covers/{STS_REAL_NUMBER}.is_invertible"
		local
			x: like real_number_to_be_tested
		do
			from
				x := real_number_to_be_tested
			until
				x ≭ zero
			loop
				x := real_number_to_be_tested
			end
			assert ("x.is_invertible", x.is_invertible)

			x := real_number_to_be_tested
			assert ("is_invertible", x.is_invertible ⇒ True)
			assert ("zero.is_invertible ⇒ True", zero.is_invertible ⇒ True)
			assert ("one.is_invertible", one.is_invertible)
			assert ("two.is_invertible", two.is_invertible)
		end

feature -- Test routines (Comparison)

	test_equals
			-- Test {STS_REAL_NUMBER}.equals.
		note
			testing: "covers/{STS_REAL_NUMBER}.equals"
		local
			x: like real_number_to_be_tested
			y: like some_real_number
		do
			x := real_number_to_be_tested
			assert ("same_entity", x ≍ x)
			assert ("same_entity ok", equals_ok (x, x, x))

			x := real_number_to_be_tested
			y := same_real_number (x)
			assert ("same_real_number", x ≍ y)
			assert ("same_real ok", equals_ok (x, y, same_real_number (y)))

			x := real_number_to_be_tested
			y := some_real_number
			assert ("some_real_number", x ≍ y ⇒ True)
			assert ("some_real_number ok", equals_ok (x, y, some_real_number))

			assert ("0 ok", equals_ok (Zero, some_real_number, some_real_number))
			assert ("1 ok", equals_ok (one, some_real_number, some_real_number))
			assert ("2 ok", equals_ok (two, some_real_number, some_real_number))
		end

	test_unequals
			-- Test {STS_REAL_NUMBER}.unequals.
		note
			testing: "covers/{STS_REAL_NUMBER}.unequals"
		local
			x: like real_number_to_be_tested
			y: like some_real_number
		do
			x := real_number_to_be_tested
			assert ("same_entity", not (x ≭ x))
			assert ("same_entity ok", unequals_ok (x, x))

			x := real_number_to_be_tested
			y := same_real_number (x)
			assert ("same_real_number", not (x ≭ y))
			assert ("same_real ok", unequals_ok (x, y))

			x := real_number_to_be_tested
			y := some_real_number
			assert ("some_real_number", x ≭ y ⇒ True)
			assert ("some_real_number ok", unequals_ok (x, y))

			assert ("0 ok", unequals_ok (Zero, some_real_number))
			assert ("1 ok", unequals_ok (one, some_real_number))
			assert ("2 ok", unequals_ok (two, some_real_number))
		end

	test_is_less
			-- Test {STI_REAL_NUMBER}.is_less.
		note
			testing: "covers/{STI_REAL_NUMBER}.is_less"
		local
			x: like real_number_to_be_tested
			y: like some_real_number
		do
			x := real_number_to_be_tested
			y := some_real_number
			assert ("is_less", x < y ⇒ True)
			assert ("is_less_ok", is_less_ok (x, y, some_real_number))

			from
				y := some_real_number
			until
				y > y.zero
			loop
				y := some_real_number
			end
			assert ("0 < y", zero < y)
			assert ("0 < y ok", is_less_ok (zero, y, some_real_number))

			from
				y := some_real_number
			until
				y.zero ≍ y or y.zero > y
			loop
				y := some_real_number
			end
			assert ("not (0 < y)", not (zero < y))
			assert ("not (0 < y) ok", is_less_ok (Zero, y, some_real_number))
		end

	test_is_less_equal
			-- Test {STS_REAL_NUMBER}.is_less_equal.
		note
			testing: "covers/{STS_REAL_NUMBER}.is_less_equal"
		local
			x: like real_number_to_be_tested
			y: like some_real_number
		do
			x := real_number_to_be_tested
			y := some_real_number
			assert ("is_less_equal", x ≤ y ⇒ True)
			assert ("is_less_equal_ok", is_less_equal_ok (x, y, some_real_number))

			from
				y := some_real_number
			until
				y > y.zero or y ≍ zero
			loop
				y := some_real_number
			end
			assert ("0 ≤ y", zero ≤ y)
			assert ("0 ≤ y ok", is_less_equal_ok (zero, y, some_real_number))

			from
				y := some_real_number
			until
				y < y.zero
			loop
				y := some_real_number
			end
			assert ("not (0 ≤ y)", not (zero ≤ y))
			assert ("not (0 ≤ y) ok", is_less_equal_ok (Zero, y, some_real_number))
		end

	test_is_greater
			-- Test {STS_REAL_NUMBER}.is_greater.
		note
			testing: "covers/{STS_REAL_NUMBER}.is_greater"
		local
			x: like real_number_to_be_tested
			y: like some_real_number
		do
			x := real_number_to_be_tested
			y := some_real_number
			assert ("is_greater", x > y ⇒ True)
			assert ("is_greater_ok", is_greater_ok (x, y, some_real_number))

			from
				y := some_real_number
			until
				y < y.zero
			loop
				y := some_real_number
			end
			assert ("0 > y", zero > y)
			assert ("0 > y ok", is_greater_ok (zero, y, some_real_number))

			from
				y := some_real_number
			until
				y.zero ≤ y
			loop
				y := some_real_number
			end
			assert ("not (0 > y)", not (zero > y))
			assert ("not (0 > y) ok", is_greater_ok (Zero, y, some_real_number))
		end

	test_is_greater_equal
			-- Test {STS_REAL_NUMBER}.is_greater_equal.
		note
			testing: "covers/{STS_REAL_NUMBER}.is_greater_equal"
		local
			x: like real_number_to_be_tested
			y: like some_real_number
		do
			x := real_number_to_be_tested
			y := some_real_number
			assert ("is_greater_equal", x ≥ y ⇒ True)
			assert ("is_greater_equal_ok", is_greater_equal_ok (x, y, some_real_number))

			from
				y := some_real_number
			until
				y ≤ y.zero
			loop
				y := some_real_number
			end
			assert ("0 ≥ y", zero ≥ y)
			assert ("0 ≥ y ok", is_greater_equal_ok (zero, y, some_real_number))

			from
				y := some_real_number
			until
				y > y.zero
			loop
				y := some_real_number
			end
			assert ("not (0 ≥ y)", not (zero ≥ y))
			assert ("not (0 ≥ y) ok", is_greater_equal_ok (Zero, y, some_real_number))
		end

	test_three_way_comparison
			-- Test {STS_REAL_NUMBER}.three_way_comparison.
		note
			testing: "covers/{STS_REAL_NUMBER}.three_way_comparison"
		local
			x: like real_number_to_be_tested
			y: like some_real_number
		do
			x := real_number_to_be_tested
			y := some_real_number
			assert ("three_way_comparison", attached (x ⋚ y))
			assert ("three_way_comparison ok", three_way_comparison_ok (x, y, some_real_number))

			from
				x := real_number_to_be_tested
				y := some_real_number
			until
				x < y
			loop
				x := real_number_to_be_tested
				y := some_real_number
			end
			assert ("negative", x ⋚ y ≍ - (x ⋚ y).one)
			assert ("negative ok", three_way_comparison_ok (x, y, some_real_number))

			x := real_number_to_be_tested
			y := same_real_number (x)
			assert ("zero", x.zero ≍ (x ⋚ y))
			assert ("zero ok", three_way_comparison_ok (x, y, some_real_number))

			from
				x := real_number_to_be_tested
				y := some_real_number
			until
				x > y
			loop
				x := real_number_to_be_tested
				y := some_real_number
			end
			assert ("positive", x.one ≍ (x ⋚ y))
			assert ("positive ok", three_way_comparison_ok (x, y, some_real_number))

			from
				y := some_real_number
			until
				y > y.zero
			loop
				y := some_real_number
			end
			assert ("0 < y", zero ⋚ y ≍ - (zero ⋚ y).one)
			assert ("0 < y ok", three_way_comparison_ok (zero, y, some_real_number))

			y := y.zero
			assert ("0 = y", zero ≍ (zero ⋚ y))
			assert ("0 = y ok", three_way_comparison_ok (zero, y, some_real_number))

			from
				y := some_real_number
			until
				y < y.zero
			loop
				y := some_real_number
			end
			assert ("0 > y", one ≍ (zero ⋚ y))
			assert ("0 > y ok", three_way_comparison_ok (zero, y, some_real_number))
		end

	test_min
			-- Test {STS_REAL_NUMBER}.min.
		note
			testing: "covers/{STS_REAL_NUMBER}.min"
		local
			x: like real_number_to_be_tested
			y: like some_real_number
		do
			x := real_number_to_be_tested
			y := some_real_number
			assert ("min", attached (x ∧ y))
			assert ("min ok", min_ok (x, y, some_real_number))

			from
				x := real_number_to_be_tested
				y := some_real_number
			until
				x ≤ y
			loop
				x := real_number_to_be_tested
				y := some_real_number
			end
			assert ("x", (x ∧ y) ≍ x)
			assert ("x ok", min_ok (x, y, some_real_number))

			from
				x := real_number_to_be_tested
				y := some_real_number
			until
				x ≥ y
			loop
				x := real_number_to_be_tested
				y := some_real_number
			end
			assert ("y", (x ∧ y) ≍ y)
			assert ("y ok", min_ok (x, y, some_real_number))

			from
				y := some_real_number
			until
				y ≥ y.zero
			loop
				y := some_real_number
			end
			assert ("0 ≤ y", (zero ∧ y) ≍ zero)
			assert ("0 ≤ y ok", min_ok (zero, y, some_real_number))

			from
				y := some_real_number
			until
				y ≤ y.zero
			loop
				y := some_real_number
			end
			assert ("0 ≥ y", (zero ∧ y) ≍ y)
			assert ("0 ≥ y ok", min_ok (zero, y, some_real_number))
		end

	test_max
			-- Test {STS_REAL_NUMBER}.max.
		note
			testing: "covers/{STS_REAL_NUMBER}.max"
		local
			x: like real_number_to_be_tested
			y: like some_real_number
		do
			x := real_number_to_be_tested
			y := some_real_number
			assert ("max", attached (x ∨ y))
			assert ("max ok", max_ok (x, y, some_real_number))

			from
				x := real_number_to_be_tested
				y := some_real_number
			until
				x ≥ y
			loop
				x := real_number_to_be_tested
				y := some_real_number
			end
			assert ("x", (x ∨ y) ≍ x)
			assert ("x ok", max_ok (x, y, some_real_number))

			from
				x := real_number_to_be_tested
				y := some_real_number
			until
				x ≤ y
			loop
				x := real_number_to_be_tested
				y := some_real_number
			end
			assert ("y", (x ∨ y) ≍ y)
			assert ("y ok", max_ok (x, y, some_real_number))

			from
				y := some_real_number
			until
				y ≤ y.zero
			loop
				y := some_real_number
			end
			assert ("0 ≥ y", (zero ∨ y) ≍ zero)
			assert ("0 ≥ y ok", max_ok (zero, y, some_real_number))

			from
				y := some_real_number
			until
				y ≥ y.zero
			loop
				y := some_real_number
			end
			assert ("0 ≤ y", (zero ∨ y) ≍ y)
			assert ("0 ≤ y ok", max_ok (zero, y, some_real_number))
		end

feature -- Test routines (Relationship)

--	test_multipliable
--			-- Test {STS_REAL_NUMBER}.multipliable.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.multipliable"
--		local
--			x: like real_number_to_be_tested
--			y: like some_real_number
--		do
--			x := real_number_to_be_tested
--			y := some_real_number
--			check
--				good_divisor_1: x.q.divisible (gcd (y.p, x.q)) -- x.q /= 0
--				good_divisor_2: y.q.divisible (gcd (x.p, y.q)) -- y.q /= 0
--			end
--			assert (
--					"when does not overflow",
--					not x.integer_product_overflows (x.q // gcd (y.p, x.q), y.q // gcd (x.p, y.q)) ⇒ x.multipliable (y)
--				)
--			assert (
--					"when is not multipliable",
--					not x.multipliable (y) ⇒ x.integer_product_overflows (x.q // gcd (y.p, x.q), y.q // gcd (x.p, y.q))
--				)
--			assert ("multipliable ok", multipliable_ok (x, y))
--		end

	test_divisible
			-- Test {STS_REAL_NUMBER}.divisible.
		note
			testing: "covers/{STS_REAL_NUMBER}.divisible"
		local
			x: like real_number_to_be_tested
			y: like some_real_number
		do
			x := real_number_to_be_tested
			y := some_real_number
			assert ("divisible", x.divisible (y) ⇒ True)

			x := real_number_to_be_tested
			from
				y := some_real_number
			until
				y ≭ zero
			loop
				y := some_real_number
			end
			assert ("x.divisible (y)", x.divisible (y))
		end

--feature -- Test routines (Operation)

--	test_modulus
--			-- Test {STS_REAL_NUMBER}.modulus.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.modulus"
--		do
--			assert ("modulus", attached real_number_to_be_tested.modulus)
--		end

--	test_abs
--			-- Test {STS_REAL_NUMBER}.abs.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.abs"
--		do
--			assert ("abs", attached real_number_to_be_tested.abs)
--		end

--	test_plus
--			-- Test {STS_REAL_NUMBER}.plus.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.plus"
--		local
--			x: like real_number_to_be_tested
--			y: like some_real_number
--		do
--			x := real_number_to_be_tested
--			y := some_real_number
--			assert ("plus", attached (x + y))
--			assert ("plus_ok", plus_ok (x, y))
--		end

--	test_minus
--			-- Test {STS_REAL_NUMBER}.minus.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.minus"
--		local
--			x: like real_number_to_be_tested
--			y: like some_real_number
--		do
--			x := real_number_to_be_tested
--			y := some_real_number
--			assert ("minus", attached (x - y))
--			assert ("minus_ok", minus_ok (x, y))
--		end

--	test_opposite
--			-- Test {STS_REAL_NUMBER}.opposite.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.opposite"
--		local
--			x: like real_number_to_be_tested
--		do
--			x := real_number_to_be_tested
--			assert ("opposite", attached (- x))
--			assert ("opposite_ok", opposite_ok (x))
--		end

--	test_product
--			-- Test {STS_REAL_NUMBER}.product.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.product"
--		local
--			x: like real_number_to_be_tested
--			y: like some_real_number
--		do
--			from
--				x := real_number_to_be_tested
--				y := some_real_number
--			until
--				x.multipliable (y)
--			loop
--				x := real_number_to_be_tested
--				y := some_real_number
--			end
--			assert ("product", attached (x * y))
--			assert ("product_ok", product_ok (x, y))
--		end

--	test_quotient
--			-- Test {STS_REAL_NUMBER}.quotient.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.quotient"
--		local
--			x: like real_number_to_be_tested
--			y: like some_real_number
--		do
--			from
--				x := real_number_to_be_tested
--				y := some_real_number
--			until
--				x.divisible (y)
--			loop
--				x := real_number_to_be_tested
--				y := some_real_number
--			end
--			assert ("quotient", attached (x / y))
--			assert ("quotient_ok", quotient_ok (x))
--		end

--	test_reciprocal
--			-- Test {STS_REAL_NUMBER}.reciprocal.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.reciprocal"
--		local
--			x: like real_number_to_be_tested
--		do
--			x := real_number_to_be_tested
--			assert ("reciprocal", x.is_invertible ⇒ attached x.reciprocal)
--		end

--	test_inverse
--			-- Test {STS_REAL_NUMBER}.inverse.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.inverse"
--		local
--			x: like real_number_to_be_tested
--		do
--			x := real_number_to_be_tested
--			assert ("inverse", x.is_invertible ⇒ attached x.inverse)
--		end

--feature -- Test routines (Conversion)

--	test_to_integer_number
--			-- Test {STS_REAL_NUMBER}.to_integer_number.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.to_integer_number"
--		local
--			x: like real_number_to_be_tested
--		do
--			x := real_number_to_be_tested
--			assert ("to_integer_number", x.is_integer ⇒ attached x.to_integer_number)
--		end

--	test_to_natural_number
--			-- Test {STS_REAL_NUMBER}.to_natural_number.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.to_natural_number"
--		local
--			x: like real_number_to_be_tested
--		do
--			x := real_number_to_be_tested
--			assert ("to_natural_number", x.is_natural ⇒ attached x.to_natural_number)
--		end

--feature -- Test routines (Factory)

--	test_converted_integer
--			-- Test {STS_REAL_NUMBER}.converted_integer.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.converted_integer"
--		do
--			assert ("converted_integer", attached real_number_to_be_tested.converted_integer (some_integer_number_number))
--		end

feature -- Test routines (Math)

	test_splitted
			-- Test {STS_REAL_NUMBER}.splitted.
		note
			testing: "covers/{STS_REAL_NUMBER}.splitted"
		local
			x: like real_number_to_be_tested
			i: like some_integer_number
		do
			x := real_number_to_be_tested
			i := some_integer_number
			assert ("splitted", attached x.splitted (i))
			assert ("splitted ok", splitted_ok (x, i))

			assert ("zero.splitted (i)", attached zero.splitted (i))
			assert ("zero.splitted (i) ok", splitted_ok (zero, i))

			assert ("one.splitted (i)", attached one.splitted (i))
			assert ("one.is_rational ok", splitted_ok (one, i))

			assert ("two.splitted (i)", attached two.is_rational)
			assert ("two.splitted (i) ok", splitted_ok (two, i))
		end

--	test_gcd
--			-- Test gcd.
--		note
--			testing: "covers/gcd"
--		local
--			x: like real_number_to_be_tested
--			i, j: like some_integer_number_number
--		do
--			i := some_integer_number_number
--			j := some_integer_number_number
--			x := real_number_to_be_tested
--			assert ("gcd", attached x.gcd (i, j))
--			assert ("gcd_ok", gcd_ok (x, i, j, some_integer_number_number))
--		end

--	test_div
--			-- Test {STS_REAL_NUMBER}.div.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.div"
--		local
--			i, j: like some_integer_number_number
--		do
--			i := some_integer_number_number
--			from
--				j := some_integer_number_number
--			until
--				i.divisible (j)
--			loop
--				j := some_integer_number_number
--			end
--			assert ("div", attached real_number_to_be_tested.div (i, j))
--		end

--	test_rem
--			-- Test {STS_REAL_NUMBER}.rem.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.rem"
--		local
--			x: like real_number_to_be_tested
--			i, j: like some_integer_number_number
--		do
--			x := real_number_to_be_tested
--			i := some_integer_number_number
--			from
--				j := some_integer_number_number
--			until
--				i.divisible (j)
--			loop
--				j := some_integer_number_number
--			end
--			assert ("rem", attached x.rem (i, j))
--			assert ("rem ok", rem_ok (x, i, j))
--		end

--feature -- Test routines (Predicate)

--	test_integer_product_overflows
--			-- Test {STS_REAL_NUMBER}.integer_product_overflows.
--		note
--			testing: "covers/{STS_REAL_NUMBER}.integer_product_overflows"
--		local
--			x: like real_number_to_be_tested
--			i, j: like some_integer_number_number
--		do
--			x := real_number_to_be_tested
--			i := - some_integer_number_number.abs
--			i := i ∧ - i.one
--			j := - some_integer_number_number.abs ∧ - i.one
--			if i.max_value_exists then
--				check
--					good_divisor_1: i.max_value.divisible (j) -- j < 0
--				end
--				i := i ∧ i.max_value // j - i.one
--				assert ("i, j < 0; overflow", x.integer_product_overflows (i, j))
--				assert ("i, j < 0; overflow ok", integer_product_overflows_ok (x, i, j))
--			end

--			j := some_integer_number_number.abs ∨ j.one
--			if i.min_value_exists then
--				check
--					good_divisor_2: i.min_value.divisible (j) -- j > 0
--				end
--				i := i ∧ i.min_value // j - i.one
--				assert ("i < 0 < j; overflow", x.integer_product_overflows (i, j))
--				assert ("i < 0 < j; overflow ok", integer_product_overflows_ok (x, i, j))
--			end

--			i := some_integer_number_number.abs ∨ i.one
--			j := - some_integer_number_number.abs ∧ - i.one - i.one
--			if i.min_value_exists then
--				check
--					good_divisor_3: i.min_value.divisible (j) -- j < 0
--				end
--				i := i ∨ i.min_value // j + i.one
--				assert ("j < - 1 < 0 < i; overflow", x.integer_product_overflows (i, j))
--				assert ("j < - 1 < 0 < i; overflow ok", integer_product_overflows_ok (x, i, j))
--			end

--			j := some_integer_number_number.abs ∨ j.one
--			if i.max_value_exists then
--				check
--					good_divisor_4: i.max_value.divisible (j) -- j > 0
--				end
--				i := i ∨ i.max_value // j + i.one
--				assert ("0 < i, j; overflow", x.integer_product_overflows (i, j))
--				assert ("0 < i, j; overflow ok", integer_product_overflows_ok (x, i, j))
--			end

--			i := - some_integer_number_number.abs ∧ - i.one
--			j := - some_integer_number_number.abs ∧ - i.one
--			if i.max_value_exists then
--				check
--					good_divisor_5: i.max_value.divisible (j) -- j < 0
--				end
--				i := i ∨ i.max_value // j
--				assert ("i, j < 0; no overflow", not x.integer_product_overflows (i, j))
--				assert ("i, j < 0; no overflow ok", integer_product_overflows_ok (x, i, j))
--			end

--			j := j.zero
--			assert ("i < 0 = j; no overflow", not x.integer_product_overflows (i, j))
--			assert ("i < 0 = j; no overflow ok", integer_product_overflows_ok (x, i, j))

--			j := some_integer_number_number.abs ∨ j.one
--			if i.min_value_exists then
--				check
--					good_divisor_6: i.min_value.divisible (j) -- j > 0
--				end
--				i := i ∨ i.min_value // j
--				assert ("i < 0 < j; no overflow", not x.integer_product_overflows (i, j))
--				assert ("i < 0 < j; no overflow ok", integer_product_overflows_ok (x, i, j))
--			end

--			i := i.zero
--			j := some_integer_number_number
--			assert ("i = 0; no overflow", not x.integer_product_overflows (i, j))
--			assert ("i = 0; no overflow ok", integer_product_overflows_ok (x, i, j))

--			i := some_integer_number_number.abs ∨ i.one
--			j := - some_integer_number_number.abs ∧ - i.one - i.one
--			if i.min_value_exists then
--				check
--					good_divisor_7: i.min_value.divisible (j) -- j < 0
--				end
--				i := i ∧ i.min_value // j
--				assert ("j < - 1 < 0 < i; no overflow", not x.integer_product_overflows (i, j))
--				assert ("j < - 1 < 0 < i; no overflow ok", integer_product_overflows_ok (x, i, j))
--			end

--			j := - j.one
--			assert ("- 1 = j < 0 < i; no overflow", not x.integer_product_overflows (i, j))
--			assert ("- 1 = j < 0 < i; no overflow ok", integer_product_overflows_ok (x, i, j))

--			j := j.zero
--			assert ("j = 0 < i; no overflow", not x.integer_product_overflows (i, j))
--			assert ("j = 0 < i; no overflow ok", integer_product_overflows_ok (x, i, j))

--			j := some_integer_number_number.abs ∨ j.one
--			if i.max_value_exists then
--				check
--					good_divisor_8: i.max_value.divisible (j) -- j > 0
--				end
--				i := i ∧ i.max_value // j
--				assert ("0 < i, j; no overflow", not x.integer_product_overflows (i, j))
--				assert ("0 < i, j; no overflow ok", integer_product_overflows_ok (x, i, j))
--			end

--			i := some_integer_number_number
--			j := some_integer_number_number
--			x := real_number_to_be_tested
--			assert ("product_overflows", x.integer_product_overflows (i, j) ⇒ True)
--			assert ("integer_product_overflows_ok", integer_product_overflows_ok (x, i, j))
--		end

feature -- Test routines (Implementation)

	test_adjusted_value
			-- Test {STS_REAL_NUMBER}.adjusted_value.
		note
			testing: "covers/{STS_REAL_NUMBER}.adjusted_value"
		do
			assert ("adjusted_value", attached real_number_to_be_tested.adjusted_value (some_native_real))
		end

feature {NONE} -- Factory (element to be tested)

	real_number_to_be_tested: like some_immediate_real_number
			-- Real number meant to be under tests
		do
			Result := some_immediate_real_number
		end

feature -- Anchor

	real_anchor: STS_REAL_NUMBER
			-- Anchor for real numbers
		deferred
		end

	real_math_anchor: like real_number_to_be_tested.real_math_anchor
			-- Anchor for accessing basic mathematical operations on native real numbers
		do
			Result := real_number_to_be_tested.real_math_anchor
		end

note
	copyright: "Copyright (c) 2012-2026, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
