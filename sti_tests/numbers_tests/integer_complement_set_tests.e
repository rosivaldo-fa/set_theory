note
	description: "Test suite for {STI_INTEGER_COMPLEMENT_SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	INTEGER_COMPLEMENT_SET_TESTS

inherit
	STST_INTEGER_SET_TESTS
		rename
			u as n,
			some_immediate_natural_number as some_expanded_natural_number,
			some_immediate_integer_number as some_expanded_integer_number
		undefine
			default_create,
			some_set_g,
			same_natural_number,
			some_natural_set,
			same_integer_number,
			some_integer_set
		redefine
			test_all,
			test_extended,
			set_to_be_tested
		end

	UNARY_TESTS [STS_INTEGER_NUMBER]
		rename
			is_not_in_ok as element_is_not_in_ok,
			test_is_in as test_element_is_in,
			test_is_not_in as test_element_is_not_in,
			element_to_be_tested as set_to_be_tested,
			some_object_g as some_integer_number
		redefine
			test_all,
			set_to_be_tested
		end

feature -- Access

	n: STI_INTEGER_NUMBERS
			-- <Precursor>
		once
			create Result
		ensure then
			class
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {STI_INTEGER_COMPLEMENT_SET}.
		note
			testing: "covers/{STI_INTEGER_COMPLEMENT_SET}"
		do
			Precursor {STST_INTEGER_SET_TESTS}
			test_out
		end

feature -- Test routines (Construction)

	test_extended
			-- Test {STI_INTEGER_COMPLEMENT_SET}.extended.
		note
			testing: "covers/{STI_INTEGER_COMPLEMENT_SET}.extended"
		do
			Precursor {STST_INTEGER_SET_TESTS}
		end

feature -- Test routines (Output)

	test_out
			-- Test {STI_INTEGER_COMPLEMENT_SET}.out.
		note
			testing: "covers/{STI_INTEGER_COMPLEMENT_SET}.out"
		do
			assert ("out", attached set_to_be_tested.out)
		end

feature {NONE} -- Factory (element to be tested)

	set_to_be_tested: like some_immediate_integer_complement_set
			-- Integer complement set meant to be under tests
		do
			Result := some_immediate_integer_complement_set
		end

feature -- Anchor

	universe_anchor: STI_INTEGER_NUMBERS
			-- <Precursor>
		once
			Result := n
		ensure then
			class
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
