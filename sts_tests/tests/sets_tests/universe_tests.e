note
	description: "Test suite for {STS_UNIVERSE}"
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
			test_is_universe,
			universe_to_be_tested
		end

feature -- Test routines (Quality)

	test_is_universe
			-- Test {STS_UNIVERSE}.is_universe.
		note
			testing: "covers/{STS_UNIVERSE}.is_universe"
		do
			assert ("is_universe", universe_to_be_tested.is_universe)
		end

feature {NONE} -- Factory (element to be tested)

	universe_to_be_tested: like some_immediate_universe_g
			-- Universe meant to be under tests
		do
			Result := some_immediate_universe_g
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
