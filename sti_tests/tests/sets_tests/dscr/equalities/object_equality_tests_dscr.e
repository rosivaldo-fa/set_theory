note
	description: "Test suite for {STS_OBJECT_EQUALITY [detachable separate CHARACTER_REF]}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	OBJECT_EQUALITY_TESTS_DSCR

inherit
	STST_OBJECT_EQUALITY_TESTS [detachable separate CHARACTER_REF]
		rename
			some_object_g as some_separate_character_ref,
			some_immediate_equality_g as some_object_equality_dscr,
			some_immediate_set_g as some_immediate_set_dscr
		undefine
			default_create,
			test_is_in
		redefine
			test_all,
			test_holds,
			test_holds_successively
		end

	UNARY_TESTS_DSCR
		rename
			element_to_be_tested as equality_to_be_tested
		undefine
			equality_to_be_tested
		redefine
			test_all
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {STS_OBJECT_EQUALITY}.
		note
			testing: "covers/{STS_OBJECT_EQUALITY}"
		do
			Precursor {STST_OBJECT_EQUALITY_TESTS}
		end

feature -- Test routines (Relationship)

	test_holds
			-- <Precursor>
		note
			testing: "covers/{STS_OBJECT_EQUALITY}.holds"
		do
			Precursor {STST_OBJECT_EQUALITY_TESTS}
		end

	test_holds_successively
			-- <Precursor>
		note
			testing: "covers/{STS_INSTANCE_FREE_EQUALITY}.holds_successively"
			testing: "covers/{STS_OBJECT_EQUALITY}.holds_successively"
		do
			Precursor {STST_OBJECT_EQUALITY_TESTS}
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
