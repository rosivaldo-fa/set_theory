note
	description: "Test suite for {STI_NATURAL_SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"
	TODO: "AutoTest may confuse {STST_NATURAL_SET_TESTS} with {NATURAL_SET_TESTS}."

class
	NATURAL_SET_EFFECTIVE_TESTS

inherit
	STST_NATURAL_SET_TESTS
		rename
			some_object_g as some_natural_number,
			some_immediate_natural_number as some_expanded_natural_number
		undefine
			default_create,
			some_set_g,
			same_natural_number
		redefine
			test_all,
			test_extended,
			set_to_be_tested
		end

	UNARY_TESTS [STS_NATURAL_NUMBER]
		rename
			is_not_in_ok as element_is_not_in_ok,
			test_is_in as test_element_is_in,
			test_is_not_in as test_element_is_not_in,
			element_to_be_tested as set_to_be_tested,
			some_object_g as some_natural_number
		redefine
			test_all,
			set_to_be_tested
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {STI_NATURAL_SET}.
		note
			testing: "covers/{STI_NATURAL_SET}"
		do
			Precursor {STST_NATURAL_SET_TESTS}
		end

feature -- Test routines (Initialization)

	test_make_extended
			-- Test {STI_NATURAL_SET}.make_extended.
		note
			testing: "covers/{STI_NATURAL_SET}.make_extended"
		do
			assert ("make_extended", attached (create {like natural_set_to_be_tested}.make_extended (some_natural_number, some_natural_set)))
		end

feature -- Test routines (Construction)

	test_extended
			-- Test {STI_NATURAL_SET}.extended.
		note
			testing: "covers/{STI_NATURAL_SET}.extended"
		do
			Precursor {STST_NATURAL_SET_TESTS}
		end

feature {NONE} -- Factory (element to be tested)

	set_to_be_tested: like some_immediate_natural_set
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
