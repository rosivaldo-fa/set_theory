note
	description: "Test suite for {SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SET_TESTS [G]

inherit
	ELEMENT_TESTS
		rename
			test_is_in as test_element_is_in,
			test_is_not_in as test_element_is_not_in,
			element_to_be_tested as set_to_be_tested
		undefine
			set_to_be_tested
		redefine
			test_all
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {SET}.
		note
			testing: "covers/{SET}"
		do
			Precursor {ELEMENT_TESTS}
			test_has
			test_does_not_have
			test_is_in
			test_is_not_in
			test_extended
			test_prunned
			test_is_universe
		end

feature -- Test routines (Membership)

	test_has
			-- Test {SET}.has.
		note
			testing: "covers/{SET}.has"
		local
			s: like set_to_be_tested
		do
			s := set_to_be_tested
			assert ("not (s ∋ a)", not (s ∋ a))

			s := s.extended (a, create {REFERENCE_EQUALITY [G]})
			assert ("s ∋ a", s ∋ a)

			s := set_to_be_tested
			assert ("has", s ∋ a ⇒ True)
		end

	test_does_not_have
			-- Test {SET}.does_not_have.
		note
			testing: "covers/{SET}.does_not_have"
		local
			s: like set_to_be_tested
		do
			s := set_to_be_tested
			assert ("s ∌ a", s ∌ a)

			s := s.extended (a, create {REFERENCE_EQUALITY [G]})
			assert ("not (s ∌ a)", not (s ∌ a))

			s := set_to_be_tested
			assert ("does_not_have", s ∌ a ⇒ True)
		end

	test_is_in
			-- Test {SET}.is_in.
		note
			testing: "covers/{SET}.is_in"
		local
			s: like set_to_be_tested
			ss: EFFECTIVE_SET [SET [G]]
		do
			s := set_to_be_tested
			create ss.make_extended (
					s, create {REFERENCE_EQUALITY [SET [G]]}, create {EFFECTIVE_SET [SET [G]]}
				)
			assert ("s ∈ ss", s ∈ ss)

			create ss
			assert ("not (s ∈ ss)", not (s ∈ ss))
		end

	test_is_not_in
			-- Test {SET}.is_not_in.
		note
			testing: "covers/{SET}.is_not_in"
		local
			s: like set_to_be_tested
			ss: EFFECTIVE_SET [SET [G]]
		do
			s := set_to_be_tested
			create ss
			assert ("s ∉ ss", s ∉ ss)

			create ss.make_extended (
					s, create {REFERENCE_EQUALITY [SET [G]]}, create {EFFECTIVE_SET [SET [G]]}
				)
			assert ("not (s ∉ ss)", not (s ∉ ss))
		end

feature -- Test routines (Construction)

	test_extended
			-- Test {SET}.extended.
		note
			testing: "covers/{SET}.extended"
		local
			s: like set_to_be_tested
		do
			s := set_to_be_tested
			assert ("{a, ...}", s.extended (a, create {REFERENCE_EQUALITY [G]}) ∋ a)
		end

	test_prunned
			-- Test {SET}.prunned.
		note
			testing: "covers/{SET}.prunned"
		local
			s: like set_to_be_tested
		do
			s := set_to_be_tested
			assert ("s ∖ {a}", s.prunned (a) ∌ a)
		end

feature -- Test routines (Quality)

	test_is_universe
			-- Test {SET}.is_universe.
		note
			testing: "covers/{SET}.is_universe"
		do
			assert ("is_universe", attached set_to_be_tested.is_universe ⇒ True)
		end

feature -- Factory (element to be tested)

	set_to_be_tested: SET [G]
			-- Set meant to be under tests
		deferred
		end

feature -- Factory

	a, b, c, d: G
			-- Auxiliary data
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
