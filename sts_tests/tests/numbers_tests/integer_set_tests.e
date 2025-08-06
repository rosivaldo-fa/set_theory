note
	description: "Test suite for {STS_INTEGER_SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

deferred class
	INTEGER_SET_TESTS

inherit
	SET_TESTS [STS_INTEGER_NUMBER]
		rename
			test_extended as test_set_extended,
			some_object_g as some_integer_number
		redefine
			test_all
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {STS_INTEGER_SET}.
		note
			testing: "covers/{STS_INTEGER_SET}"
		do
			Precursor {SET_TESTS}
			test_extended
		end

feature -- Test routines (Construction)

	test_extended
			-- Test {STS_INTEGER_SET}.extended.
		note
			testing: "covers/{STS_INTEGER_SET}.extended"
		local
			s: like integer_set_to_be_tested
			i: like some_integer_number
		do
			s := integer_set_to_be_tested
			i := some_integer_number
			assert ("{i, ...}", s.extended (same_integer_number (i)) ∋ i)
		end

feature {NONE} -- Factory (element to be tested)

	integer_set_to_be_tested: like some_immediate_integer_set
			-- Integer set meant to be under tests
		do
			Result := some_immediate_integer_set
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
