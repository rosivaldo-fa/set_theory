note
	description: "Test suite for {STS_REFERENCE_EQUALITY [detachable separate CHARACTER_REF]}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	REFERENCE_EQUALITY_TESTS_DSCR

inherit
	STST_REFERENCE_EQUALITY_TESTS [detachable separate CHARACTER_REF]
		rename
			some_object_g as some_separate_character_ref,
			same_object_g as same_object_dscr,
			object_standard_twin_g as object_standard_twin_dscr,
			object_twin_g as object_twin_dscr,
			object_deep_twin_g as object_deep_twin_dscr,

			some_equality_g as some_equality_dscr,
			some_immediate_equality_g as some_reference_equality_dscr,
			some_reference_equality_g as some_reference_equality_dscr,
			some_object_standard_equality_g as some_object_standard_equality_dscr,
			some_object_equality_g as some_object_equality_dscr,
			some_object_deep_equality_g as some_object_deep_equality_dscr,
			some_equality_sg as some_equality_sdscr,
			some_reference_equality_sg as some_reference_equality_sdscr,
			some_object_standard_equality_sg as some_object_standard_equality_sdscr,
			some_object_equality_sg as some_object_equality_sdscr,
			some_object_deep_equality_sg as some_object_deep_equality_sdscr,

			some_set_g as some_set_dscr,
			some_immediate_set_g as some_immediate_set_dscr,
			some_set_sg as some_set_sdscr,
			some_immediate_set_sg as some_immediate_set_sdscr,
			some_set_family_g as some_set_family_dscr,
			some_immediate_set_family_g as some_immediate_set_family_dscr
		undefine
			default_create,
			test_is_in,
			some_set_dscr
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
			-- Test every routine of {STS_REFERENCE_EQUALITY}.
		note
			testing: "covers/{STS_REFERENCE_EQUALITY}"
		do
			Precursor {STST_REFERENCE_EQUALITY_TESTS}
		end

feature -- Test routines (Relationship)

	test_holds
			-- <Precursor>
		note
			testing: "covers/{STS_REFERENCE_EQUALITY}.holds"
		do
			Precursor {STST_REFERENCE_EQUALITY_TESTS}
		end

	test_holds_successively
			-- <Precursor>
		note
			testing: "covers/{STS_INSTANCE_FREE_EQUALITY}.holds_successively"
			testing: "covers/{STS_REFERENCE_EQUALITY}.holds_successively"
		do
			Precursor {STST_REFERENCE_EQUALITY_TESTS}
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
