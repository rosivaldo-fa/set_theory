note
	description: "Test suite for {SET_FAMILY}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SET_FAMILY_TESTS [G]

inherit
	SET_TESTS [SET [G]]
		rename
			test_make_extended as test_set_make_extended,
			set_to_be_tested as set_family_to_be_tested,
			exposed_set_to_be_tested as exposed_set_family_to_be_tested,
			a as s1,
			b as s2,
			c as s3,
			d as s4
		redefine
			test_set_make_extended,
			test_has,
			test_does_not_have,
			set_family_to_be_tested,
			exposed_set_family_to_be_tested
		end

feature -- Test routines (Initialization)

	test_set_make_extended
			-- Do nothing
		note
			testing: "covers/{SET_FAMILY}.set_make_extended"
		do
		end

feature -- Test routines (Membership)

	test_has
			-- <Precursor>
			-- Test {SET_FAMILY}.has.
		note
			testing: "covers/{SET}.has"
			testing: "covers/{SET_FAMILY}.has"
		local
			sf: like set_family_to_be_tested
		do
			create sf.make_extended (s1, create {REFERENCE_EQUALITY [SET [G]]}, set_family_to_be_tested)
			assert ("sf ∋ s1", sf ∋ s1)

			create sf
			assert ("not (sf ∋ s1)", not (sf ∋ s1))

			sf := set_family_to_be_tested
			assert ("has", sf ∋ s1 ⇒ True)
		end

	test_does_not_have
			-- <Precursor>
			-- Test {SET_FAMILY}.does_not_have.
		note
			testing: "covers/{SET_FAMILY}.does_not_have"
			testing: "covers/{SET_FAMILY}.does_not_have"
		local
			sf: like set_family_to_be_tested
		do
			create sf
			assert ("sf ∌ c1", sf ∌ s1)

			create sf.make_extended (s1, create {REFERENCE_EQUALITY [SET [G]]}, set_family_to_be_tested)
			assert ("not (sf ∌ c1)", not (sf ∌ s1))

			sf := set_family_to_be_tested
			assert ("does_not_have", sf ∌ s1 ⇒ True)
		end

feature {NONE} -- Factory (element to be tested)

	set_family_to_be_tested: SET_FAMILY [G]
			-- Set family meant to be under tests
		do
			create Result
		end

	exposed_set_family_to_be_tested: EXPOSED_SET_FAMILY [G]
			-- Exposed set family meant to be under tests
		do
			create Result
		end

note
	copyright: "Copyright (c) 2012-2026, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
