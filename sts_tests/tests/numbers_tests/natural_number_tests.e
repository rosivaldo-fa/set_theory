note
	description: "Test suite for {STS_NATURAL_NUMBER}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

deferred class
	NATURAL_NUMBER_TESTS

inherit
	INTEGER_NUMBER_TESTS
		rename
			is_not_in_ok as integer_is_not_in_ok,
			equals_ok as integer_equals_ok,
			unequals_ok as integer_unequals_ok,
			is_less_ok as integer_is_less_ok,
			is_less_equal_ok as integer_is_less_equal_ok,
			is_greater_ok as integer_is_greater_ok,
			is_greater_equal_ok as integer_is_greater_equal_ok,
			min_ok as integer_min_ok,
			max_ok as integer_max_ok,
			divides_ok as integer_divides_ok,
			plus_ok as integer_plus_ok,
			identity_ok as integer_identity_ok,
			minus_ok as integer_minus_ok,
			product_ok as integer_product_ok,
			test_value as test_integer_value,
			test_is_in as test_integer_is_in,
			test_is_not_in as test_integer_is_not_in,
			test_equals as test_integer_equals,
			test_unequals as test_integer_unequals,
			test_is_less as test_integer_is_less,
			test_is_less_equal as test_integer_is_less_equal,
			test_is_greater as test_integer_is_greater,
			test_is_greater_equal as test_integer_is_greater_equal,
			test_min as test_integer_min,
			test_max as test_integer_max,
			test_divides as test_integer_divides,
			test_divisible as test_integer_divisible,
			test_plus as test_integer_plus,
			test_identity as test_integer_identity,
			test_minus as test_integer_minus,
			test_product as test_integer_product,
			test_adjusted_value as test_integer_adjusted_value,
			integer_number_to_be_tested as natural_number_to_be_tested
		redefine
			test_all,
			natural_number_to_be_tested
		end

	NATURAL_NUMBER_PROPERTIES

feature -- Access

	zero: like natural_anchor
			-- The natural number 0
		deferred
		end

	one: like natural_anchor
			-- The natural number 1
		deferred
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {STS_NATURAL_NUMBER}.
		note
			testing: "covers/{STS_NATURAL_NUMBER}"
		do
			Precursor {INTEGER_NUMBER_TESTS}
			test_value
			test_is_in
			test_is_not_in
			test_equals
			test_unequals
			test_is_less
			test_is_less_equal
			test_is_greater
			test_is_greater_equal
			test_min
			test_max
			test_divides
			test_divisible
			test_plus
			test_identity
			test_minus
			test_product
			test_natural_quotient
			test_natural_remainder
			test_adjusted_value
		end

feature -- Test routines (Primitive)

	test_value
			-- Test {STS_NATURAL_NUMBER}.value.
		note
			testing: "covers/{STS_NATURAL_NUMBER}.value"
		do
			assert ("value", attached natural_number_to_be_tested.value)
		end

feature -- Test routines (Membership)

	test_is_in
			-- Test {STS_NATURAL_NUMBER}.is_in.
		note
			testing: "covers/{STS_NATURAL_NUMBER}.is_in"
		local
			n: like natural_number_to_be_tested
			s: like some_set_n
		do
			n := natural_number_to_be_tested
			s := some_set_n.extended (n, some_equality_n)
			assert ("n ∈ s", n ∈ s)

			n := natural_number_to_be_tested
			s := some_set_n.prunned (n)
			assert ("not (n ∈ s)", not (n ∈ s))

			n := natural_number_to_be_tested
			s := some_set_n
			assert ("is_in", n ∈ s ⇒ True)
		end

	test_is_not_in
			-- Test {STS_NATURAL_NUMBER}.is_not_in.
		note
			testing: "covers/{STS_NATURAL_NUMBER}.is_not_in"
		local
			n: like natural_number_to_be_tested
			s: like some_set_n
		do
			n := natural_number_to_be_tested
			s := some_set_n.prunned (n)
			assert ("n ∉ s", n ∉ s)
			assert ("n ∉ s ok", is_not_in_ok (n, s))

			n := natural_number_to_be_tested
			s := some_set_n.extended (n, some_equality_n)
			assert ("not (n ∉ s)", not (n ∉ s))
			assert ("not (n ∉ s) ok", is_not_in_ok (n, s))

			n := natural_number_to_be_tested
			s := some_set_n
			assert ("is_not_in", n ∉ s ⇒ True)
			assert ("is_not_in_ok", is_not_in_ok (n, s))
		end

feature -- Test routines (Comparison)

	test_equals
			-- Test {STS_NATURAL_NUMBER}.equals.
		note
			testing: "covers/{STS_NATURAL_NUMBER}.equals"
		local
			n: like natural_number_to_be_tested
			m: like some_natural_number
		do
			n := natural_number_to_be_tested
			assert ("same entity", n ≍ n)
			assert ("same entity ok", equals_ok (n, n, n))

			n := natural_number_to_be_tested
			m := same_natural_number (n)
			assert ("same_natural_number", n ≍ m)
			assert ("same_natural_number ok", equals_ok (n, m, same_natural_number (m)))

			from
				n := natural_number_to_be_tested
				m := some_natural_number
			until
				m.value /= n.value
			loop
				m := some_natural_number
			end
			assert ("not (n ≍ m)", not (n ≍ m))
			assert ("not (n ≍ m) ok", equals_ok (n, m, some_natural_number))

			n := natural_number_to_be_tested
			m := some_natural_number
			assert ("equals", n ≍ m ⇒ True)
			assert ("equals ok", equals_ok (n, m, some_natural_number))
		end

	test_unequals
			-- Test {STS_NATURAL_NUMBER}.unequals.
		note
			testing: "covers/{STS_NATURAL_NUMBER}.unequals"
		local
			n: like natural_number_to_be_tested
			m: like some_natural_number
		do
			n := natural_number_to_be_tested
			assert ("same entity", not (n ≭ n))
			assert ("same entity ok", unequals_ok (n, n))

			n := natural_number_to_be_tested
			m := same_natural_number (n)
			assert ("same_natural_number", not (n ≭ n))
			assert ("same_natural_number ok", unequals_ok (n, m))

			from
				n := natural_number_to_be_tested
				m := some_natural_number
			until
				m.value /= n.value
			loop
				m := some_natural_number
			end
			assert ("n ≭ m", n ≭ m)
			assert ("n ≭ m ok", unequals_ok (n, m))

			n := natural_number_to_be_tested
			m := some_natural_number
			assert ("unequals", n ≍ m ⇒ True)
			assert ("unequals ok", unequals_ok (n, m))
		end

	test_is_less
			-- Test {STS_NATURAL_NUMBER}.is_less.
		note
			testing: "covers/{STS_NATURAL_NUMBER}.is_less"
		local
			n: like natural_number_to_be_tested
			m: like some_natural_number
		do
			from
				n := natural_number_to_be_tested
				m := some_natural_number
			until
				n.value < m.value
			loop
				n := natural_number_to_be_tested
				m := some_natural_number
			end
			assert ("n < m", n < m)
			assert ("n < m ok", is_less_ok (n, m, some_natural_number))

			from
				n := natural_number_to_be_tested
				m := some_natural_number
			until
				n.value ≥ m.value
			loop
				n := natural_number_to_be_tested
				m := some_natural_number
			end
			assert ("not (n < m)", not (n < m))
			assert ("not (n < m) ok", is_less_ok (n, m, some_natural_number))

			n := natural_number_to_be_tested
			m := some_natural_number
			assert ("is_less", n < m ⇒ True)
			assert ("is_less ok", is_less_ok (n, m, some_natural_number))
		end

	test_is_less_equal
			-- Test {STS_NATURAL_NUMBER}.is_less_equal.
		note
			testing: "covers/{STS_NATURAL_NUMBER}.is_less_equal"
		local
			n: like natural_number_to_be_tested
			m: like some_natural_number
		do
			from
				n := natural_number_to_be_tested
				m := some_natural_number
			until
				n.value ≤ m.value
			loop
				n := natural_number_to_be_tested
				m := some_natural_number
			end
			assert ("n ≤ m", n ≤ m)
			assert ("n ≤ m ok", is_less_equal_ok (n, m, some_natural_number))

			from
				n := natural_number_to_be_tested
				m := some_natural_number
			until
				n.value > m.value
			loop
				n := natural_number_to_be_tested
				m := some_natural_number
			end
			assert ("not (n ≤ m)", not (n ≤ m))
			assert ("not (n ≤ m) ok", is_less_equal_ok (n, m, some_natural_number))

			n := natural_number_to_be_tested
			m := some_natural_number
			assert ("is_less_equal", n ≤ m ⇒ True)
			assert ("is_less_equal_ok", is_less_equal_ok (n, m, some_natural_number))
		end

	test_is_greater
			-- Test {STS_NATURAL_NUMBER}.is_greater.
		note
			testing: "covers/{STS_NATURAL_NUMBER}.is_greater"
		local
			n: like natural_number_to_be_tested
			m: like some_natural_number
		do
			from
				n := natural_number_to_be_tested
				m := some_natural_number
			until
				n.value > m.value
			loop
				n := natural_number_to_be_tested
				m := some_natural_number
			end
			assert ("n > m", n > m)
			assert ("n > m ok", is_greater_ok (n, m, some_natural_number))

			from
				n := natural_number_to_be_tested
				m := some_natural_number
			until
				n.value ≤ m.value
			loop
				n := natural_number_to_be_tested
				m := some_natural_number
			end
			assert ("not (n > m)", not (n > m))
			assert ("not (n > m) ok", is_greater_ok (n, m, some_natural_number))

			n := natural_number_to_be_tested
			m := some_natural_number
			assert ("is_greater", n > m ⇒ True)
			assert ("is_greater ok", is_greater_ok (n, m, some_natural_number))
		end

	test_is_greater_equal
			-- Test {STS_NATURAL_NUMBER}.is_greater_equal.
		note
			testing: "covers/{STS_NATURAL_NUMBER}.is_greater_equal"
		local
			n: like natural_number_to_be_tested
			m: like some_natural_number
		do
			from
				n := natural_number_to_be_tested
				m := some_natural_number
			until
				n.value ≥ m.value
			loop
				n := natural_number_to_be_tested
				m := some_natural_number
			end
			assert ("n ≥ m", n ≥ m)
			assert ("n ≥ m ok", is_greater_equal_ok (n, m, some_natural_number))

			from
				n := natural_number_to_be_tested
				m := some_natural_number
			until
				n.value < m.value
			loop
				n := natural_number_to_be_tested
				m := some_natural_number
			end
			assert ("not (n ≥ m)", not (n ≥ m))
			assert ("not (n ≥ m) ok", is_greater_equal_ok (n, m, some_natural_number))

			n := natural_number_to_be_tested
			m := some_natural_number
			assert ("is_greater_equal", n ≥ m ⇒ True)
			assert ("is_greater_equal_ok", is_less_equal_ok (n, m, some_natural_number))
		end

	test_min
			-- Test {STS_NATURAL_NUMBER}.min.
		note
			testing: "covers/{STS_NATURAL_NUMBER}.min"
		local
			n: like natural_number_to_be_tested
			m: like some_natural_number
		do
			from
				n := natural_number_to_be_tested
				m := some_natural_number
			until
				n ≤ m
			loop
				n := natural_number_to_be_tested
				m := some_natural_number
			end
			assert ("n", (n ∧ m) ≍ n)
			assert ("n ok", min_ok (n, m, some_natural_number))

			from
				n := natural_number_to_be_tested
				m := some_natural_number
			until
				n ≥ m
			loop
				n := natural_number_to_be_tested
				m := some_natural_number
			end
			assert ("m", (n ∧ m) ≍ m)
			assert ("m ok", min_ok (n, m, some_natural_number))

			n := natural_number_to_be_tested
			m := some_natural_number
			assert ("min", attached (n ∧ m))
			assert ("min ok", min_ok (n, m, some_natural_number))
		end

	test_max
			-- Test {STS_NATURAL_NUMBER}.max.
		note
			testing: "covers/{STS_NATURAL_NUMBER}.max"
		local
			n: like natural_number_to_be_tested
			m: like some_natural_number
		do
			from
				n := natural_number_to_be_tested
				m := some_natural_number
			until
				n ≥ m
			loop
				n := natural_number_to_be_tested
				m := some_natural_number
			end
			assert ("n", (n ∨ m) ≍ n)
			assert ("n ok", max_ok (n, m, some_natural_number))

			from
				n := natural_number_to_be_tested
				m := some_natural_number
			until
				n ≤ m
			loop
				n := natural_number_to_be_tested
				m := some_natural_number
			end
			assert ("m", (n ∨ m) ≍ m)
			assert ("m ok", max_ok (n, m, some_natural_number))

			n := natural_number_to_be_tested
			m := some_natural_number
			assert ("max", attached (n ∨ m))
			assert ("max ok", max_ok (n, m, some_natural_number))
		end

feature -- Test routines (Relationship)

	test_divides
			-- Test {STS_NATURAL_NUMBER}.divides.
		note
			testing: "covers/{STS_NATURAL_NUMBER}.divides"
		local
			n: like natural_number_to_be_tested
			m: like some_natural_number
		do
			from
				n := natural_number_to_be_tested
			until
				n ≭ One
			loop
				n := natural_number_to_be_tested
			end
			m := (some_natural_number ⋅ n) + One
			assert ("not (n | m)", not (n | m))
			assert ("not (n | m) ok", divides_ok (n, m, some_natural_number))

			n := natural_number_to_be_tested
			m := some_natural_number
			assert ("divides", (n | m) ⇒ True)
			assert ("divides_ok", divides_ok (n, m, some_natural_number))
		end

	test_divisible
			-- Test {STS_NATURAL_NUMBER}.divisible.
		note
			testing: "covers/{STS_NATURAL_NUMBER}.divisible"
		local
			n: like natural_number_to_be_tested
			m: like some_natural_number
		do
			from
				n := natural_number_to_be_tested
				m := some_natural_number
			until
				m ≭ zero
			loop
				m := some_natural_number
			end
			assert ("n.divisible (m)", n.divisible (m))

			n := natural_number_to_be_tested
			m := some_natural_number.zero
			assert ("not n.divisible (m)", not n.divisible (m))

			n := natural_number_to_be_tested
			m := some_natural_number
			assert ("divisible", n.divisible (m) ⇒ True)
		end

feature -- Test routines (Operation)

	test_plus
			-- Test {STS_NATURAL_NUMBER}.plus.
		note
			testing: "covers/{STS_NATURAL_NUMBER}.plus"
		local
			n: like natural_number_to_be_tested
			m: like some_natural_number
		do
			n := natural_number_to_be_tested
			m := some_natural_number
			assert ("plus", attached (n + m))
			assert ("plus_ok", plus_ok (n, m, some_natural_number))
		end

	test_identity
			-- Test {STS_NATURAL_NUMBER}.identity.
		note
			testing: "covers/{STS_NATURAL_NUMBER}.identity"
		local
			n: like natural_number_to_be_tested
		do
			n := natural_number_to_be_tested
			assert ("identity", attached (+ n))
			assert ("identity_ok", identity_ok (n))
		end

	test_minus
			-- Test {STS_NATURAL_NUMBER}.minus.
		note
			testing: "covers/{STS_NATURAL_NUMBER}.minus"
		local
			n: like natural_number_to_be_tested
			m: like some_natural_number
		do
			from
				n := natural_number_to_be_tested
				m := some_natural_number
			until
				m ≤ n
			loop
				n := natural_number_to_be_tested
				m := some_natural_number
			end
			assert ("minus", attached (n - m))
			assert ("minus ok", minus_ok (n, m, some_natural_number))
		end

	test_product
			-- Test {STS_NATURAL_NUMBER}.product.
		note
			testing: "covers/{STS_NATURAL_NUMBER}.product"
		local
			n: like natural_number_to_be_tested
			m: like some_natural_number
		do
			n := natural_number_to_be_tested
			m := some_natural_number
			assert ("product", attached (n ⋅ m))
			assert ("product ok", product_ok (n, m, some_natural_number))
		end

	test_natural_quotient
			-- Test {STS_NATURAL_NUMBER}.natural_quotient.
		note
			testing: "covers/{STS_NATURAL_NUMBER}.natural_quotient"
		local
			n: like natural_number_to_be_tested
			m: like some_natural_number
		do
			from
				n := natural_number_to_be_tested
				m := some_natural_number
			until
				n.divisible (m)
			loop
				m := some_natural_number
			end
			assert ("natural_quotient", attached (n // m))
			assert ("natural_quotient ok", natural_quotient_ok (n, m))
		end

	test_natural_remainder
			-- Test {STS_NATURAL_NUMBER}.natural_remainder.
		note
			testing: "covers/{STS_NATURAL_NUMBER}.natural_remainder"
		local
			n: like natural_number_to_be_tested
			m: like some_natural_number
		do
			from
				n := natural_number_to_be_tested
				m := some_natural_number
			until
				n.divisible (m)
			loop
				m := some_natural_number
			end
			assert ("natural_remainder", attached (n \\ m))
			assert ("natural_remainder ok", natural_remainder_ok (n, m))
		end

feature -- Test routines (Implementation)

	test_adjusted_value
			-- Test {STS_NATURAL_NUMBER}.adjusted_value.
		note
			testing: "covers/{STS_NATURAL_NUMBER}.adjusted_value"
		do
			assert ("adjusted_value", attached natural_number_to_be_tested.adjusted_value (next_random_item.as_natural_32))
		end

feature {NONE} -- Factory (element to be tested)

	natural_number_to_be_tested: like some_immediate_natural_number
			-- Natural number meant to be under tests
		do
			Result := some_immediate_natural_number
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
