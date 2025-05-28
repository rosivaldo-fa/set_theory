note
	description: "Test suite for {STI_SET [detachable separate CHARACTER_REF]}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	SET_TESTS_DSCR

inherit
	STST_SET_TESTS [detachable separate CHARACTER_REF]
		rename
			some_object_g as some_separate_character_ref,
--			some_set_g as some_set_dscr,
			some_immediate_set_g as some_immediate_set_dscr
		undefine
			default_create
		redefine
			test_all,
			test_has,
			test_extended
		end

	ELEMENT_TESTS
		rename
			element_to_be_tested as set_to_be_tested
		undefine
			test_is_in,
			set_to_be_tested,
			some_element
		redefine
			test_all
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {STI_SET}.
		note
			testing: "covers/{STI_SET}"
		do
			Precursor {STST_SET_TESTS}
		end

feature -- Test routines (Membership)

	test_has
			-- Test {STI_SET}.has.
		note
			testing: "covers/{STI_SET}.has"
		do
			Precursor {STST_SET_TESTS}
		end

feature -- Test routines (Construction)

	test_extended
			-- Test {STI_SET}.extended.
		note
			testing: "covers/{STI_SET}.extended"
		do
			Precursor {STST_SET_TESTS}
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
