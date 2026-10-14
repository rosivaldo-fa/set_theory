note
	description: "Test suite for {NATURAL_NUMBER}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

deferred class
	NATURAL_NUMBER_TESTS

inherit
	ELEMENT_TESTS
		rename
			test_is_in as test_element_is_in,
			test_is_not_in as test_element_is_not_in,
			element_to_be_tested as natural_number_to_be_tested,
			is_not_in_ok as element_is_not_in_ok
		undefine
			natural_number_to_be_tested
		redefine
			test_all
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {NATURAL_NUMBER}.
		note
			testing: "covers/{NATURAL_NUMBER}"
		do
			Precursor {ELEMENT_TESTS}
			test_is_in
			test_is_not_in
			test_zero
			test_one
			test_equals
			test_unequals
			test_is_less
			test_is_less_equal
			test_is_greater
		end

feature -- Test routines (Membership)

	test_is_in
			-- Test {NATURAL_NUMBER}.is_in.
		note
			testing: "covers/{NATURAL_NUMBER}.is_in"
		local
			n: like natural_number_to_be_tested
			s: SET [NATURAL_NUMBER]
		do
			n := natural_number_to_be_tested
			create {EFFECTIVE_SET [NATURAL_NUMBER]} s
			s := s.extended (n, create {REFERENCE_EQUALITY [NATURAL_NUMBER]})
			assert ("n ∈ s", n ∈ s)

			s := s.prunned (n)
			assert ("not (n ∈ s)", not (n ∈ s))
		end

	test_is_not_in
			-- Test {NATURAL_NUMBER}.is_not_in.
		note
			testing: "covers/{NATURAL_NUMBER}.is_not_in"
		local
			n: like natural_number_to_be_tested
			s: SET [NATURAL_NUMBER]
		do
			n := natural_number_to_be_tested
			create {EFFECTIVE_SET [NATURAL_NUMBER]} s
			assert ("n ∉ s", n ∉ s)
			assert ("n ∉ s ok", is_not_in_ok (n, s))

			s := s.extended (n, create {REFERENCE_EQUALITY [NATURAL_NUMBER]})
			assert ("not (n ∉ s)", not (n ∉ s))
			assert ("not (n ∉ s) ok", is_not_in_ok (n, s))
		end

feature -- Test routines (Access)

	test_zero
			-- Test {NATURAL_NUMBER}.zero.
		note
			testing: "covers/{NATURAL_NUMBER}.zero"
		do
			assert ("zero", attached natural_number_to_be_tested.Zero)
		end

	test_one
			-- Test {NATURAL_NUMBER}.one.
		note
			testing: "covers/{NATURAL_NUMBER}.one"
		do
			assert ("one", attached natural_number_to_be_tested.One)
		end

feature -- Test routines (Comparison)

	test_equals
			-- Test {NATURAL_NUMBER}.equals.
		note
			testing: "covers/{NATURAL_NUMBER}.equals"
		local
			n: like natural_number_to_be_tested
			m: NATURAL_NUMBER
		do
			n := natural_number_to_be_tested
			assert ("same entity", n ≍ n)
			assert ("same entity ok", equals_ok (n, n, n))

			m := natural_from_native (n.value)
			assert ("same_natural_number", n ≍ m)
			assert ("same_natural_number ok", equals_ok (n, m, natural_from_native (m.value)))

			m := natural_from_native (n.value + 1)
			assert ("not (n ≍ m)", not (n ≍ m))
			assert ("not (n ≍ m) ok", equals_ok (n, m, natural_from_native (3)))
		end

	test_unequals
			-- Test {STS_NATURAL_NUMBER}.unequals.
		note
			testing: "covers/{STS_NATURAL_NUMBER}.unequals"
		local
			n: like natural_number_to_be_tested
			m: NATURAL_NUMBER
		do
			n := natural_number_to_be_tested
			assert ("same entity", not (n ≭ n))
			assert ("same entity ok", unequals_ok (n, n))

			m := natural_from_native (n.value)
			assert ("same_natural_number", not (n ≭ n))
			assert ("same_natural_number ok", unequals_ok (n, m))

			m := natural_from_native (n.value + 1)
			assert ("n ≭ m", n ≭ m)
			assert ("n ≭ m ok", unequals_ok (n, m))
		end

	test_is_less
			-- Test {NATURAL_NUMBER}.is_less.
		note
			testing: "covers/{NATURAL_NUMBER}.is_less"
		local
			n: like natural_number_to_be_tested
			m: NATURAL_NUMBER
		do
			n := natural_number_to_be_tested
			m := natural_from_native (n.value + 1)
			if n.value ≥ m.value then -- An overflow may cause this comparison to succeed
				n := natural_from_native (n.value - 1)
				m := natural_from_native (n.value + 1)
			end
			assert ("n < m", n < m)
			assert ("n < m ok", is_less_ok (n, m, natural_from_native (3)))

			m := natural_from_native (n.value)
			assert ("not (n < m)", not (n < m))
			assert ("not (n < m) ok", is_less_ok (n, m, natural_from_native (3)))

			m := natural_from_native (n.value - 1)
			if n.value < m.value then -- An overflow may cause this comparison to succeed
				n := natural_from_native (n.value + 1)
				m := natural_from_native (n.value - 1)
			end
			assert ("again: not (n < m)", not (n < m))
			assert ("again: not (n < m) ok", is_less_ok (n, m, natural_from_native (3)))
		end

	test_is_less_equal
			-- Test {STS_NATURAL_NUMBER}.is_less_equal.
		note
			testing: "covers/{STS_NATURAL_NUMBER}.is_less_equal"
		local
			n: like natural_number_to_be_tested
			m: NATURAL_NUMBER
		do
			n := natural_number_to_be_tested
			m := natural_from_native (n.value)
			assert ("equal: n ≤ m", n ≤ m)
			assert ("equal: n ≤ m ok", is_less_equal_ok (n, m, natural_from_native (3)))

			m := natural_from_native (n.value + 1)
			if m.value ≤ n.value then -- An overflow may cause this comparison to succeed
				n := natural_from_native (n.value - 1)
				m := natural_from_native (n.value + 1)
			end
			assert ("less: n ≤ m", n ≤ m)
			assert ("less: n ≤ m ok", is_less_equal_ok (n, m, natural_from_native (3)))

			m := natural_from_native (n.value - 1)
			if m.value ≥ n.value then -- An overflow may cause this comparison to succeed
				n := natural_from_native (n.value + 1)
				m := natural_from_native (n.value - 1)
			end
			assert ("not (n ≤ m)", not (n ≤ m))
			assert ("not (n ≤ m) ok", is_less_equal_ok (n, m, natural_from_native (3)))
		end

	test_is_greater
			-- Test {STS_NATURAL_NUMBER}.is_greater.
		note
			testing: "covers/{STS_NATURAL_NUMBER}.is_greater"
		local
			n: like natural_number_to_be_tested
			m: NATURAL_NUMBER
		do
			n := natural_number_to_be_tested
			m := natural_from_native (n.value - 1)
			if n.value ≤ m.value then -- An overflow may cause this comparison to succeed
				n := natural_from_native (n.value + 1)
				m := natural_from_native (n.value - 1)
			end
			assert ("n > m", n > m)
			assert ("n > m ok", is_greater_ok (n, m, natural_from_native (3)))

			m := natural_from_native (n.value)
			assert ("equal: not (n > m)", not (n > m))
			assert ("equal: not (n > m) ok", is_greater_ok (n, m, natural_from_native (3)))

			m := natural_from_native (n.value + 1)
			if n.value ≥ m.value then -- An overflow may cause this comparison to succeed
				n := natural_from_native (n.value - 1)
				m := natural_from_native (n.value + 1)
			end
			assert ("less: not (n > m)", not (n > m))
			assert ("again: not (n > m) ok", is_greater_ok (n, m, natural_from_native (3)))
		end

feature -- Factory (element to be tested)

	natural_number_to_be_tested: NATURAL_NUMBER
			-- Natural number meant to be under tests
		deferred
		end

feature -- Factory

	natural_from_native (v: like native_natural_anchor): NATURAL_NUMBER
			-- Natural number whose value is adjusted from `v'
		deferred
		ensure
			adjusted_value: Result.value = natural_number_to_be_tested.adjusted_value (v)
		end

feature -- Properties (Membership)

	is_not_in_ok (n: NATURAL_NUMBER; s: SET [NATURAL_NUMBER]): BOOLEAN
			-- Do the properties verified within number theory hold for {NATURAL_NUMBER}.is_not_in?
		do
			check
				another_definition: n ∉ s = s ∌ n
			then
				Result := True
			end
		end

feature -- Properties (Comparison)

	equals_ok (n, m, l: NATURAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {NATURAL_NUMBER}.equals?
		do
			check
				reflexive: n ≍ n
				symmetric: n ≍ m ⇒ m ≍ n
				transitive: n ≍ m and m ≍ l ⇒ n ≍ l
				euclidian: n ≍ m and n ≍ l ⇒ m ≍ l
			then
				Result := True
			end
		end

	unequals_ok (n, m: NATURAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {NATURAL_NUMBER}.unequals?
		do
			check
				alternate_definition: n ≭ m = (n.value /= m.value)
				irreflexive: not (n ≭ n)
			then
				Result := True
			end
		end

	is_less_ok (n, m, l: NATURAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {NATURAL_NUMBER}.is_less?
		do
			check
				irreflexive: not (n < n)
				asymmetric: n < m ⇒ not (m < n)
				transitive: n < m and m < l ⇒ n < l
			then
				Result := True
			end
		end

	is_less_equal_ok (n, m, l: NATURAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {NATURAL_NUMBER}.is_less_equal?
		do
			check
				alternate_definition: n ≤ m = (n.value ≤ m.value)
				reflexive: n ≤ n
				transitive: n ≤ m and m ≤ l ⇒ n ≤ l
				antisymmetric: n ≤ m and m ≤ n ⇒ n ≍ m
			then
				Result := True
			end
		end

	is_greater_ok (n, m, l: NATURAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {NATURAL_NUMBER}.is_greater?
		do
			check
				alternate_definition: n > m = (n.value > m.value)
				yet_another_definition: n > m = not (n ≤ m)
				irreflexive: not (n > n)
				asymmetric: n > m implies not (m > n)
				transitive: n > m and m > l implies n > l
			then
				Result := True
			end
		end

feature -- Anchor

	native_natural_anchor: NATURAL
			-- Anchor for the native representation of the value of current natural number
			--| TODO: Make it target dependant.
		deferred
		end

note
	copyright: "Copyright (c) 2012-2026, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
