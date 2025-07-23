note
	description: "Test suite for {STS_NATURAL_NUMBERS}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

deferred class
	NATURAL_NUMBERS_TESTS

inherit
	NATURAL_SET_TESTS
		rename
			set_to_be_tested as universe_to_be_tested
		undefine
			test_is_universe
		redefine
			test_all,
			universe_to_be_tested
		end

	UNIVERSE_TESTS [STS_NATURAL_NUMBER]
		rename
			test_extended as test_set_extended,
			some_object_g as some_natural_number
		redefine
			test_all,
			universe_to_be_tested
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {STS_NATURAL_NUMBER}.
		note
			testing: "covers/{STS_NATURAL_NUMBER}"
		do
			Precursor {NATURAL_SET_TESTS}
			Precursor {UNIVERSE_TESTS}
		end

feature {NONE} -- Factory (element to be tested)

	universe_to_be_tested: like some_immediate_natural_universe
			-- Natural universe meant to be under tests
		do
			Result := some_immediate_natural_universe
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
