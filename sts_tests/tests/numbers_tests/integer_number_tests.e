note
	description: "Test suite for {STS_INTEGER_NUMBER}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

deferred class
	INTEGER_NUMBER_TESTS

inherit
	ELEMENT_TESTS
		rename
			is_not_in_ok as element_is_not_in_ok,
			test_is_in as test_element_is_in,
			test_is_not_in as test_element_is_not_in,
			element_to_be_tested as integer_number_to_be_tested
		redefine
			test_all,
			integer_number_to_be_tested
		end

	INTEGER_NUMBER_PROPERTIES

feature -- Test routines (All)

	test_all
			-- Test every routine of {STS_INTEGER_NUMBER}.
		note
			testing: "covers/{STS_INTEGER_NUMBER}"
		do
			Precursor {ELEMENT_TESTS}
			test_value
			test_is_in
			test_is_not_in
			test_zero
			test_one
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
			test_integer_quotient
			test_integer_remainder
			test_adjusted_value
		end

feature -- Test routines (Primitive)

	test_value
			-- Test {STS_INTEGER_NUMBER}.value.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.value"
		do
			assert ("value", attached integer_number_to_be_tested.value)
		end

feature -- Test routines (Membership)

	test_is_in
			-- Test {STS_INTEGER_NUMBER}.is_in.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.is_in"
		local
			n: like integer_number_to_be_tested
			s: like some_set_of_integer_numbers
		do
			n := integer_number_to_be_tested
			s := some_set_of_integer_numbers.extended (n, some_integer_number_equality)
			assert ("n ∈ s", n ∈ s)

			n := integer_number_to_be_tested
			s := some_set_of_integer_numbers.prunned (n)
			assert ("not (n ∈ s)", not (n ∈ s))

			n := integer_number_to_be_tested
			s := some_set_of_integer_numbers
			assert ("is_in", n ∈ s ⇒ True)
		end

	test_is_not_in
			-- Test {STS_INTEGER_NUMBER}.is_not_in.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.is_not_in"
		local
			n: like integer_number_to_be_tested
			s: like some_set_of_integer_numbers
		do
			n := integer_number_to_be_tested
			s := some_set_of_integer_numbers.prunned (n)
			assert ("n ∉ s", n ∉ s)
			assert ("n ∉ s ok", is_not_in_ok (n, s))

			n := integer_number_to_be_tested
			s := some_set_of_integer_numbers.extended (n, some_integer_number_equality)
			assert ("not (n ∉ s)", not (n ∉ s))
			assert ("not (n ∉ s) ok", is_not_in_ok (n, s))

			n := integer_number_to_be_tested
			s := some_set_of_integer_numbers
			assert ("is_not_in", n ∉ s ⇒ True)
			assert ("is_not_in_ok", is_not_in_ok (n, s))
		end

feature -- Test routines (Access)

	test_zero
			-- Test {STI_INTEGER_NUMBER}.zero.
		note
			testing: "covers/{STI_INTEGER_NUMBER}.zero"
		local
			n: like integer_number_to_be_tested
		do
			n := integer_number_to_be_tested
			assert ("zero", attached n.Zero)
		end

	test_one
			-- Test {STI_INTEGER_NUMBER}.one.
		note
			testing: "covers/{STI_INTEGER_NUMBER}.one"
		local
			n: like integer_number_to_be_tested
		do
			n := integer_number_to_be_tested
			assert ("one", attached n.One)
		end

feature -- Test routines (Comparison)

	test_equals
			-- Test {STS_INTEGER_NUMBER}.equals.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.equals"
		local
			n: like integer_number_to_be_tested
			m: like some_integer_number
		do
			n := integer_number_to_be_tested
			assert ("same entity", n ≍ n)
			assert ("same entity ok", equals_ok (n, n, n))

			n := integer_number_to_be_tested
			m := same_integer_number (n)
			assert ("same_integer_number", n ≍ m)
			assert ("same_integer_number ok", equals_ok (n, m, same_integer_number (m)))

			from
				n := integer_number_to_be_tested
				m := some_integer_number
			until
				m.value /= n.value
			loop
				m := some_integer_number
			end
			assert ("not (n ≍ m)", not (n ≍ m))
			assert ("not (n ≍ m) ok", equals_ok (n, m, some_integer_number))

			n := integer_number_to_be_tested
			m := some_integer_number
			assert ("equals", n ≍ m ⇒ True)
			assert ("equals ok", equals_ok (n, m, some_integer_number))
		end

	test_unequals
			-- Test {STS_INTEGER_NUMBER}.unequals.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.unequals"
		local
			n: like integer_number_to_be_tested
			m: like some_integer_number
		do
			n := integer_number_to_be_tested
			assert ("same entity", not (n ≭ n))
			assert ("same entity ok", unequals_ok (n, n))

			n := integer_number_to_be_tested
			m := same_integer_number (n)
			assert ("same_integer_number", not (n ≭ n))
			assert ("same_integer_number ok", unequals_ok (n, m))

			from
				n := integer_number_to_be_tested
				m := some_integer_number
			until
				m.value /= n.value
			loop
				m := some_integer_number
			end
			assert ("n ≭ m", n ≭ m)
			assert ("n ≭ m ok", unequals_ok (n, m))

			n := integer_number_to_be_tested
			m := some_integer_number
			assert ("unequals", n ≍ m ⇒ True)
			assert ("unequals ok", unequals_ok (n, m))
		end

	test_is_less
			-- Test {STS_INTEGER_NUMBER}.is_less.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.is_less"
		local
			n: like integer_number_to_be_tested
			m: like some_integer_number
		do
			from
				n := integer_number_to_be_tested
				m := some_integer_number
			until
				n.value < m.value
			loop
				n := integer_number_to_be_tested
				m := some_integer_number
			end
			assert ("n < m", n < m)
			assert ("n < m ok", is_less_ok (n, m, some_integer_number))

			from
				n := integer_number_to_be_tested
				m := some_integer_number
			until
				n.value ≥ m.value
			loop
				n := integer_number_to_be_tested
				m := some_integer_number
			end
			assert ("not (n < m)", not (n < m))
			assert ("not (n < m) ok", is_less_ok (n, m, some_integer_number))

			n := integer_number_to_be_tested
			m := some_integer_number
			assert ("is_less", n < m ⇒ True)
			assert ("is_less ok", is_less_ok (n, m, some_integer_number))
		end

	test_is_less_equal
			-- Test {STS_INTEGER_NUMBER}.is_less_equal.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.is_less_equal"
		local
			n: like integer_number_to_be_tested
			m: like some_integer_number
		do
			from
				n := integer_number_to_be_tested
				m := some_integer_number
			until
				n.value ≤ m.value
			loop
				n := integer_number_to_be_tested
				m := some_integer_number
			end
			assert ("n ≤ m", n ≤ m)
			assert ("n ≤ m ok", is_less_equal_ok (n, m, some_integer_number))

			from
				n := integer_number_to_be_tested
				m := some_integer_number
			until
				n.value > m.value
			loop
				n := integer_number_to_be_tested
				m := some_integer_number
			end
			assert ("not (n ≤ m)", not (n ≤ m))
			assert ("not (n ≤ m) ok", is_less_equal_ok (n, m, some_integer_number))

			n := integer_number_to_be_tested
			m := some_integer_number
			assert ("is_less_equal", n ≤ m ⇒ True)
			assert ("is_less_equal_ok", is_less_equal_ok (n, m, some_integer_number))
		end

	test_is_greater
			-- Test {STS_INTEGER_NUMBER}.is_greater.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.is_greater"
		local
			n: like integer_number_to_be_tested
			m: like some_integer_number
		do
			from
				n := integer_number_to_be_tested
				m := some_integer_number
			until
				n.value > m.value
			loop
				n := integer_number_to_be_tested
				m := some_integer_number
			end
			assert ("n > m", n > m)
			assert ("n > m ok", is_greater_ok (n, m, some_integer_number))

			from
				n := integer_number_to_be_tested
				m := some_integer_number
			until
				n.value ≤ m.value
			loop
				n := integer_number_to_be_tested
				m := some_integer_number
			end
			assert ("not (n > m)", not (n > m))
			assert ("not (n > m) ok", is_greater_ok (n, m, some_integer_number))

			n := integer_number_to_be_tested
			m := some_integer_number
			assert ("is_greater", n > m ⇒ True)
			assert ("is_greater ok", is_greater_ok (n, m, some_integer_number))
		end

	test_is_greater_equal
			-- Test {STS_INTEGER_NUMBER}.is_greater_equal.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.is_greater_equal"
		local
			n: like integer_number_to_be_tested
			m: like some_integer_number
		do
			from
				n := integer_number_to_be_tested
				m := some_integer_number
			until
				n.value ≥ m.value
			loop
				n := integer_number_to_be_tested
				m := some_integer_number
			end
			assert ("n ≥ m", n ≥ m)
			assert ("n ≥ m ok", is_greater_equal_ok (n, m, some_integer_number))

			from
				n := integer_number_to_be_tested
				m := some_integer_number
			until
				n.value < m.value
			loop
				n := integer_number_to_be_tested
				m := some_integer_number
			end
			assert ("not (n ≥ m)", not (n ≥ m))
			assert ("not (n ≥ m) ok", is_greater_equal_ok (n, m, some_integer_number))

			n := integer_number_to_be_tested
			m := some_integer_number
			assert ("is_greater_equal", n ≥ m ⇒ True)
			assert ("is_greater_equal_ok", is_less_equal_ok (n, m, some_integer_number))
		end

	test_min
			-- Test {STS_INTEGER_NUMBER}.min.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.min"
		local
			n: like integer_number_to_be_tested
			m: like some_integer_number
		do
			from
				n := integer_number_to_be_tested
				m := some_integer_number
			until
				n ≤ m
			loop
				n := integer_number_to_be_tested
				m := some_integer_number
			end
			assert ("n", (n ∧ m) ≍ n)
			assert ("n ok", min_ok (n, m, some_integer_number))

			from
				n := integer_number_to_be_tested
				m := some_integer_number
			until
				n ≥ m
			loop
				n := integer_number_to_be_tested
				m := some_integer_number
			end
			assert ("m", (n ∧ m) ≍ m)
			assert ("m ok", min_ok (n, m, some_integer_number))

			n := integer_number_to_be_tested
			m := some_integer_number
			assert ("min", attached (n ∧ m))
			assert ("min ok", min_ok (n, m, some_integer_number))
		end

	test_max
			-- Test {STS_INTEGER_NUMBER}.max.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.max"
		local
			n: like integer_number_to_be_tested
			m: like some_integer_number
		do
			from
				n := integer_number_to_be_tested
				m := some_integer_number
			until
				n ≥ m
			loop
				n := integer_number_to_be_tested
				m := some_integer_number
			end
			assert ("n", (n ∨ m) ≍ n)
			assert ("n ok", max_ok (n, m, some_integer_number))

			from
				n := integer_number_to_be_tested
				m := some_integer_number
			until
				n ≤ m
			loop
				n := integer_number_to_be_tested
				m := some_integer_number
			end
			assert ("m", (n ∨ m) ≍ m)
			assert ("m ok", max_ok (n, m, some_integer_number))

			n := integer_number_to_be_tested
			m := some_integer_number
			assert ("max", attached (n ∨ m))
			assert ("max ok", max_ok (n, m, some_integer_number))
		end

feature -- Test routines (Relationship)

	test_divides
			-- Test {STS_INTEGER_NUMBER}.divides.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.divides"
		local
			n: like integer_number_to_be_tested
			m: like some_integer_number
		do
			from
				n := integer_number_to_be_tested
			until
				n ≭ One
			loop
				n := integer_number_to_be_tested
			end
			m := (some_integer_number ⋅ n) + One
			assert ("not (n | m)", not (n | m))
			assert ("not (n | m) ok", divides_ok (n, m, some_integer_number))

			n := integer_number_to_be_tested
			m := some_integer_number
			assert ("divides", (n | m) ⇒ True)
			assert ("divides_ok", divides_ok (n, m, some_integer_number))
		end

	test_divisible
			-- Test {STS_INTEGER_NUMBER}.divisible.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.divisible"
		local
			n: like integer_number_to_be_tested
			m: like some_integer_number
		do
			from
				n := integer_number_to_be_tested
				m := some_integer_number
			until
				m ≭ zero
			loop
				m := some_integer_number
			end
			assert ("n.divisible (m)", n.divisible (m))

			n := integer_number_to_be_tested
			m := some_integer_number.zero
			assert ("not n.divisible (m)", not n.divisible (m))

			n := integer_number_to_be_tested
			m := some_integer_number
			assert ("divisible", n.divisible (m) ⇒ True)
		end

feature -- Test routines (Operation)

	test_plus
			-- Test {STS_INTEGER_NUMBER}.plus.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.plus"
		local
			n: like integer_number_to_be_tested
			m: like some_integer_number
		do
			n := integer_number_to_be_tested
			m := some_integer_number
			assert ("plus", attached (n + m))
			assert ("plus_ok", plus_ok (n, m, some_integer_number))
		end

	test_identity
			-- Test {STS_INTEGER_NUMBER}.identity.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.identity"
		local
			n: like integer_number_to_be_tested
		do
			n := integer_number_to_be_tested
			assert ("identity", attached (+ n))
			assert ("identity_ok", identity_ok (n))
		end

	test_minus
			-- Test {STS_INTEGER_NUMBER}.minus.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.minus"
		local
			n: like integer_number_to_be_tested
			m: like some_integer_number
		do
			from
				n := integer_number_to_be_tested
				m := some_integer_number
			until
				m ≤ n
			loop
				n := integer_number_to_be_tested
				m := some_integer_number
			end
			assert ("minus", attached (n + m))
			assert ("minus ok", minus_ok (n, m, some_integer_number))
		end

	test_product
			-- Test {STS_INTEGER_NUMBER}.product.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.product"
		local
			n: like integer_number_to_be_tested
			m: like some_integer_number
		do
			n := integer_number_to_be_tested
			m := some_integer_number
			assert ("product", attached (n ⋅ m))
			assert ("product ok", product_ok (n, m, some_integer_number))
		end

	test_integer_quotient
			-- Test {STS_INTEGER_NUMBER}.integer_quotient.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.integer_quotient"
		local
			n: like integer_number_to_be_tested
			m: like some_integer_number
		do
			from
				n := integer_number_to_be_tested
				m := some_integer_number
			until
				n.divisible (m)
			loop
				m := some_integer_number
			end
			assert ("integer_quotient", attached (n // m))
			assert ("integer_quotient ok", integer_quotient_ok (n, m))
		end

	test_integer_remainder
			-- Test {STS_INTEGER_NUMBER}.integer_remainder.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.integer_remainder"
		local
			n: like integer_number_to_be_tested
			m: like some_integer_number
		do
			from
				n := integer_number_to_be_tested
				m := some_integer_number
			until
				n.divisible (m)
			loop
				m := some_integer_number
			end
			assert ("integer_remainder", attached (n \\ m))
			assert ("integer_remainder ok", integer_remainder_ok (n, m))
		end

feature -- Test routines (Implementation)

	test_adjusted_value
			-- Test {STS_INTEGER_NUMBER}.adjusted_value.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.adjusted_value"
		do
			assert ("adjusted_value", attached integer_number_to_be_tested.adjusted_value (next_random_item.as_integer_32))
		end

feature {NONE} -- Factory (element to be tested)

	integer_number_to_be_tested: like some_immediate_integer_number
			-- Integer number meant to be under tests
		do
			Result := some_immediate_integer_number
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
