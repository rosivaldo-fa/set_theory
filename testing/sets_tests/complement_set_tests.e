note
	description: "Test suite for {COMPLEMENT_SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	COMPLEMENT_SET_TESTS [G]

inherit
	SET_TESTS [G]
		redefine
			test_all,
			test_has,
			test_does_not_have
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {COMPLEMENT_SET}.
		note
			testing: "covers/{COMPLEMENT_SET}"
		do
			Precursor {SET_TESTS}
--			test_make
		end

feature -- Test routines (Initialization)

	test_make
			-- Test {COMPLEMENT_SET}.make.
		note
			testing: "covers/{COMPLEMENT_SET}.make"
		do
			assert (
					"make",
					attached (
						create {like set_to_be_tested}.make (create {EFFECTIVE_SET [G]})
					)
				)
		end

feature -- Test routines (Membership)

	test_has
			-- Test {COMPLEMENT_SET}.has.
		note
			testing: "covers/{COMPLEMENT_SET}.has"
		local
			s: like set_to_be_tested
		do
			s := set_to_be_tested
			assert ("s ∋ a", s ∋ a)
			s := s.prunned (a)
			assert ("not (s ∋ a)", not (s ∋ a))
			s := set_to_be_tested
			assert ("has", s ∋ a ⇒ True)
		end

	test_does_not_have
			-- Test {COMPLEMENT_SET}.does_not_have.
		note
			testing: "covers/{COMPLEMENT_SET}.does_not_have"
		local
			s: like set_to_be_tested
		do
			s := set_to_be_tested.prunned (a)
			assert ("s ∌ a", s ∌ a)
			create s.make (create {EFFECTIVE_SET [G]})
			assert ("not (s ∌ a)", not (s ∌ a))
			s := set_to_be_tested
			assert ("does_not_have", s ∌ a ⇒ True)
		end

feature -- Factory (element to be tested)

	set_to_be_tested: COMPLEMENT_SET [G]
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
