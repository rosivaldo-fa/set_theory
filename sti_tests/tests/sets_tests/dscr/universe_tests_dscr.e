note
	description: "Test suite for {STI_UNIVERSE [detachable separate CHARACTER_REF]}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	UNIVERSE_TESTS_DSCR

inherit
	UNIVERSE_TESTS [detachable separate CHARACTER_REF]
		rename
			some_object_g as some_separate_character_ref,
			same_object_g as same_object_dscr,
			object_standard_twin_g as object_standard_twin_dscr,
			object_twin_g as object_twin_dscr,
			object_deep_twin_g as object_deep_twin_dscr,

			some_equality_g as some_equality_dscr,
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
		redefine
			test_all,
			test_has,
			test_does_not_have,
			test_extended,
			test_prunned,
			test_out,
			test_debug_output
		end

	UNARY_TESTS_DSCR
		rename
			is_not_in_ok as element_is_not_in_ok,
			test_is_in as test_element_is_in,
			test_is_not_in as test_element_is_not_in,
			element_to_be_tested as universe_to_be_tested
		undefine
			universe_to_be_tested
		redefine
			test_all
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {STI_UNIVERSE}.
		note
			testing: "covers/{STI_UNIVERSE}"
		do
			Precursor {UNIVERSE_TESTS}
		end

feature -- Test routines (Membership)

	test_has
			-- <Precursor>
		note
			testing: "covers/{STI_UNIVERSE}.has"
		do
			Precursor {UNIVERSE_TESTS}
		end

	test_does_not_have
			-- <Precursor>
		note
			testing: "covers/{STI_UNIVERSE}.does_not_have"
		do
			Precursor {UNIVERSE_TESTS}
		end

feature -- Test routines (Construction)

	test_extended
			-- <Precursor>
		note
			testing: "covers/{STI_UNIVERSE}.extended"
		do
			Precursor {UNIVERSE_TESTS}
		end

	test_prunned
			-- Test {STI_UNIVERSE}.prunned.
		note
			testing: "covers/{STI_UNIVERSE}.prunned"
		do
			Precursor {UNIVERSE_TESTS}
		end

feature -- Test routines (Output)

	test_out
			-- <Precursor>
		note
			testing: "covers/{STI_UNIVERSE}.out"
		do
			Precursor {UNIVERSE_TESTS}
		end

feature -- Test routines (Status report)

	test_debug_output
			-- <Precursor>
		note
			testing: "covers/{STI_UNIVERSE}.debug_output"
		do
			Precursor {UNIVERSE_TESTS}
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
