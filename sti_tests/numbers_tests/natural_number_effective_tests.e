note
	description: "Test suite for {STI_NATURAL_NUMBER}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"
	TODO: "AutoTest may confuse {STST_NATURAL_NUMBER_TESTS} with {NATURAL_NUMBER_TESTS}."

class
	NATURAL_NUMBER_EFFECTIVE_TESTS

inherit
	STST_NATURAL_NUMBER_TESTS
		rename
			some_immediate_natural_number as some_expanded_natural_number
		undefine
			default_create,
			test_is_in,
			test_is_not_in
		redefine
			test_all,
			test_value
		end

	ELEMENT_TESTS
		rename
			element_to_be_tested as natural_number_to_be_tested
		undefine
			test_all,
			natural_number_to_be_tested
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {STI_NATURAL_NUMBER}.
		note
			testing: "covers/{STI_NATURAL_NUMBER}"
		do
			Precursor {STST_NATURAL_NUMBER_TESTS}
		end

feature -- Test routines (Initialization)

	test_default_create
			-- Test {STI_NATURAL_NUMBER}.default_create.
		note
			testing: "covers/{STI_NATURAL_NUMBER}.default_create"
		do
			assert ("default_create", attached (create {like natural_number_to_be_tested}))
		end

feature -- Test routines (Primitive)

	test_value
			-- Test {STI_NATURAL_NUMBER}.value.
		note
			testing: "covers/{STI_NATURAL_NUMBER}.value"
		do
			Precursor {STST_NATURAL_NUMBER_TESTS}
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
