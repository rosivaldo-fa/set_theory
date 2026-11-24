note
	description: "Test suite for {NATURAL_SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

deferred class
	NATURAL_SET_TESTS

inherit
	SET_TESTS [NATURAL_NUMBER]
		rename
			test_extended as test_set_extended,
			test_u as test_n,
			test_universe as test_natural_numbers,
			a as n1,
			b as n2,
			c as n3,
			d as n4
		redefine
			test_all,
			test_has,
			test_does_not_have,
			test_there_exists
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {NATURAL_SET}.
		note
			testing: "covers/{NATURAL_SET}"
		do
			Precursor {SET_TESTS}
			test_extended
		end

feature -- Test routines (Construction)

	test_extended
			-- Test {NATURAL_SET}.extended.
		note
			testing: "covers/{SET}.extended"
		local
			s: like set_to_be_tested
		do
			s := set_to_be_tested & n1
			assert ("{n1, ...}", s ∋ n1)
		end

feature -- Test routines (Membership)

	test_has
			-- <Precursor>
			-- Test {NATURAL_SET}.has.
		note
			testing: "covers/{SET}.has"
			testing: "covers/{NATURAL_SET}.has"
		local
			s: like set_to_be_tested
		do
			s := set_to_be_tested & n1
			assert ("s ∋ n1", s ∋ n1)

			s := set_to_be_tested
			assert ("has", s ∋ n1 ⇒ True)
		end

	test_does_not_have
			-- <Precursor>
			-- Test {NATURAL_SET}.does_not_have.
		note
			testing: "covers/{SET}.does_not_have"
			testing: "covers/{NATURAL_SET}.does_not_have"
		local
			s: like set_to_be_tested
		do
			s := set_to_be_tested & n1
			assert ("not (s ∌ n1)", not (s ∌ n1))

			s := set_to_be_tested
			assert ("does_not_have", s ∌ n1 ⇒ True)
		end

feature -- Test routines (Quantifier)

	test_there_exists
			-- <Precursor>
			-- Test {NATURAL_SET}.there_exists.
		note
			testing: "covers/{SET}.there_exists"
			testing: "covers/{NATURAL_SET}.there_exists"
		local
			s: like set_to_be_tested
			l_n1: NATURAL_NUMBER
		do
			l_n1 := n1
			s := set_to_be_tested & l_n1
			assert (
				"exists",
				s |∃ agent (m, ia_n1: NATURAL_NUMBER): BOOLEAN
					do
						Result := m = ia_n1
					end (?, l_n1) = True
				)
		end

feature -- Factory (element to be tested)

	set_to_be_tested: NATURAL_SET
			-- Set meant to be under tests
		deferred
		end

feature -- Factory

	n1, n2, n3, n4: NATURAL_NUMBER
			-- <Precursor>
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
