note
	description: "Test suite for {STS_NATURAL_NUMBER}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

deferred class
	NATURAL_NUMBER_TESTS

inherit
	ELEMENT_TESTS
		rename
			is_not_in_ok as element_is_not_in_ok,
			test_is_in as test_element_is_in,
			test_is_not_in as test_element_is_not_in,
			element_to_be_tested as natural_number_to_be_tested
		redefine
			test_all,
			natural_number_to_be_tested
		end

	NATURAL_NUMBER_PROPERTIES

feature -- Test routines (All)

	test_all
			-- Test every routine of {STS_NATURAL_NUMBER}.
		note
			testing: "covers/{STS_NATURAL_NUMBER}"
		do
			Precursor {ELEMENT_TESTS}
			test_value
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
			s: like some_set_of_natural_numbers
		do
			n := natural_number_to_be_tested
			s := some_set_of_natural_numbers.extended (n, some_natural_number_equality)
			assert ("n ∈ s", n ∈ s)

			n := natural_number_to_be_tested
			s := some_set_of_natural_numbers.prunned (n)
			assert ("not (n ∈ s)", not (n ∈ s))

			n := natural_number_to_be_tested
			s := some_set_of_natural_numbers
			assert ("is_in", n ∈ s ⇒ True)
		end

	test_is_not_in
			-- Test {STS_NATURAL_NUMBER}.is_not_in.
		note
			testing: "covers/{STS_NATURAL_NUMBER}.is_not_in"
		local
			n: like natural_number_to_be_tested
			s: like some_set_of_natural_numbers
		do
			n := natural_number_to_be_tested
			s := some_set_of_natural_numbers.prunned (n)
			assert ("n ∉ s", n ∉ s)
			assert ("n ∉ s ok", is_not_in_ok (n, s))

			n := natural_number_to_be_tested
			s := some_set_of_natural_numbers.extended (n, some_natural_number_equality)
			assert ("not (n ∉ s)", not (n ∉ s))
			assert ("not (n ∉ s) ok", is_not_in_ok (n, s))

			n := natural_number_to_be_tested
			s := some_set_of_natural_numbers
			assert ("is_not_in", n ∉ s ⇒ True)
			assert ("is_not_in_ok", is_not_in_ok (n, s))
		end

feature -- Test routines (Access)

	test_zero
			-- Test {STI_NATURAL_NUMBER}.zero.
		note
			testing: "covers/{STI_NATURAL_NUMBER}.zero"
		local
			n: like natural_number_to_be_tested
		do
			n := natural_number_to_be_tested
			assert ("zero", attached n.Zero)
		end

	test_one
			-- Test {STI_NATURAL_NUMBER}.one.
		note
			testing: "covers/{STI_NATURAL_NUMBER}.one"
		local
			n: like natural_number_to_be_tested
		do
			n := natural_number_to_be_tested
			assert ("one", attached n.One)
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
			m, l: like some_natural_number
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
			m, l: like some_natural_number
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
