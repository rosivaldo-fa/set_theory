note
	description: "Test suite for {STS_NATURAL_SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

deferred class
	NATURAL_SET_TESTS

inherit
	SET_TESTS [STS_NATURAL_NUMBER]
		redefine
			test_all
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {STS_NATURAL_SET}.
		note
			testing: "covers/{STS_NATURAL_SET}"
		do
			Precursor {SET_TESTS}
		end

feature {NONE} -- Factory (element to be tested)

	natural_set_to_be_tested: like some_immediate_natural_set
			-- Natural set meant to be under tests
		do
			Result := some_immediate_natural_set
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
