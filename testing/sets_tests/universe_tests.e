note
	description: "Test suite for {UNIVERSE}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	UNIVERSE_TESTS [G]

inherit
	SET_TESTS [G]
		rename
			set_to_be_tested as universe_to_be_tested
		redefine
			test_all,
			test_has,
			test_does_not_have
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {UNIVERSE}.
		note
			testing: "covers/{UNIVERSE}"
		do
			Precursor {SET_TESTS}
		end

feature -- Test routines (Initialization)

	test_default_create
			-- Test {UNIVERSE}.default_create.
		note
			testing: "covers/{UNIVERSE}.default_create"
		do
			assert ("default_create", attached (create {like universe_to_be_tested}))
		end

feature -- Test routines (Membership)

	test_has
			-- Test {UNIVERSE}.has.
		note
			testing: "covers/{UNIVERSE}.has"
		local
			u: like universe_to_be_tested
		do
			u := universe_to_be_tested
			assert ("u ∋ a", u ∋ a)
			assert ("u ∋ b", u ∋ b)
			assert ("u ∋ c", u ∋ c)
			assert ("u ∋ d", u ∋ d)
		end

	test_does_not_have
			-- Test {UNIVERSE}.does_not_have.
		note
			testing: "covers/{UNIVERSE}.does_not_have"
		local
			u: like universe_to_be_tested
		do
			u := universe_to_be_tested
			assert ("not (u ∌ a)", not (u ∌ a))
			assert ("not (u ∌ b)", not (u ∌ b))
			assert ("not (u ∌ c)", not (u ∌ c))
			assert ("not (u ∌ d)", not (u ∌ d))
		end

feature -- Factory (element to be tested)

	universe_to_be_tested: UNIVERSE [G]
			-- Universe meant to be under tests
		do
			create Result
		ensure then
			class
		end

note
	copyright: "Copyright (c) 2012-2026, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
