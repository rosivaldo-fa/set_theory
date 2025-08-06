note
	description: "Test suite for {STI_INTEGER_NUMBERS}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"
	TODO: "AutoTest may confuse {STST_INTEGER_NUMBERS_TESTS} with {INTEGER_NUMBERS_TESTS}."

class
	INTEGER_NUMBERS_EFFECTIVE_TESTS

inherit
	STST_INTEGER_NUMBERS_TESTS
		rename
			u as z,
			some_immediate_natural_number as some_expanded_natural_number,
			some_immediate_integer_number as some_expanded_integer_number
		undefine
			default_create,
			same_natural_number,
			some_natural_set,
			same_integer_number,
			some_integer_set,
			some_set_g
		redefine
			test_all
		end

	UNARY_TESTS [STS_INTEGER_NUMBER]
		rename
			is_not_in_ok as element_is_not_in_ok,
			test_is_in as test_element_is_in,
			test_is_not_in as test_element_is_not_in,
			element_to_be_tested as universe_to_be_tested,
			some_object_g as some_integer_number
		undefine
			universe_to_be_tested
		redefine
			test_all
		end

feature -- Access

	z: STI_INTEGER_NUMBERS
			-- <Precursor>
		once
			create Result
		ensure then
			class
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {STI_INTEGER_NUMBERS}.
		note
			testing: "covers/{STI_INTEGER_NUMBERS}"
		do
			Precursor {STST_INTEGER_NUMBERS_TESTS}
			test_default_create
			test_out
			test_debug_output
		end

feature -- Test routines (Initialization)

	test_default_create
			-- Test {STI_INTEGER_NUMBERS}.default_create.
		note
			testing: "covers/{STI_INTEGER_NUMBERS}.default_create"
		do
			assert ("default_create", attached (create {like universe_to_be_tested}))
		end

feature -- Test routines (Output)

	test_out
			-- Test {STI_INTEGER_NUMBERS}.out.
		note
			testing: "covers/{STI_INTEGER_NUMBERS}.out"
		do
			assert ("out", attached universe_to_be_tested.out)
		end

feature -- Test routines (Status report)

	test_debug_output
			-- Test {STI_INTEGER_NUMBERS}.debug_output.
		note
			testing: "covers/{STI_INTEGER_NUMBERS}.debug_output"
		do
			assert ("debug_output", attached universe_to_be_tested.debug_output)
		end

feature -- Anchor

	universe_anchor: STI_INTEGER_NUMBERS
			-- <Precursor>
		once
			Result := z
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
