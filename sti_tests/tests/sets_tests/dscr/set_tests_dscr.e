note
	description: "Test suite for {STI_SET [detachable separate CHARACTER_REF]}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	SET_TESTS_DSCR

inherit
	SET_TESTS [detachable separate CHARACTER_REF]
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
			test_make_extended,
			test_has,
			test_does_not_have,
			test_is_in,
			test_is_not_in,
			test_extended,
			test_prunned,
			test_out,
			test_element_out,
			test_is_universe
--			test_converted
		end

	UNARY_TESTS_DSCR
		rename
			is_not_in_ok as element_is_not_in_ok,
			test_is_in as test_element_is_in,
			test_is_not_in as test_element_is_not_in,
			element_to_be_tested as set_to_be_tested
		undefine
			test_all,
			set_to_be_tested
		end

feature -- Test routines (All)

	test_all
			-- <Precursor>
		note
			testing: "covers/{STI_SET}"
		do
			Precursor {SET_TESTS}
		end

feature -- Test routines (Initialization)

	test_make_extended
			-- <Precursor>
		note
			testing: "covers/{STI_SET}.make_extended"
		do
			Precursor {SET_TESTS}
		end

feature -- Test routines (Membership)

	test_has
			-- Test {STI_SET}.has.
		note
			testing: "covers/{STI_SET}.has"
		do
			Precursor {SET_TESTS}
		end

	test_does_not_have
			-- <Precursor>
			-- Test {STI_SET}.does_not_have.
		note
			testing: "covers/{STS_SET}.does_not_have"
			testing: "covers/{STI_SET}.does_not_have"
		do
			Precursor {SET_TESTS}
		end

	test_is_in
			-- <Precursor>
			-- Test {STI_SET}.is_in.
		note
			testing: "covers/{STS_SET}.is_in"
			testing: "covers/{STI_SET}.is_in"
		do
			Precursor {SET_TESTS}
		end

	test_is_not_in
			-- <Precursor>
			-- Test {STI_SET}.is_in.
		note
			testing: "covers/{STS_SET}.is_not_in"
			testing: "covers/{STI_SET}.is_not_in"
		do
			Precursor {SET_TESTS}
		end

feature -- Test routines (Construction)

	test_extended
			-- Test {STI_SET}.extended.
		note
			testing: "covers/{STI_SET}.extended"
		local
			a: detachable separate CHARACTER_REF
			s: STI_SET [detachable separate CHARACTER_REF]
			ref_eq: like some_reference_equality_dscr
		do
			Precursor {SET_TESTS}
			if next_random_item \\ 2 = 0 then
				a := some_immediate_separate_character_ref
			else
				a := some_immediate_character_ref
			end
			create s
			ref_eq := some_reference_equality_dscr
			s := s.extended (object_standard_twin_dscr (a), ref_eq)
			s := s.extended (object_twin_dscr (a), ref_eq)
			s := s.extended (object_deep_twin_dscr (a), ref_eq)
			assert ("Beware equalities!", attached a ⇒ s ∌ a)
		end

	test_prunned
			-- Test {STI_SET}.prunned.
		note
			testing: "covers/{STI_SET}.prunned"
		do
			Precursor {SET_TESTS}
		end

feature -- Test routines (Output)

	test_out
			-- <Precursor>
		note
			testing: "covers/{STI_SET}.out"
		do
			Precursor {SET_TESTS}
		end

	test_element_out
			-- <Precursor>
		note
			testing: "covers/{STI_SET}.element_out"
		do
			Precursor {SET_TESTS}
		end

feature -- Test routines (Quality)

	test_is_universe
			-- Test {STI_SET}.is_universe.
		note
			testing: "covers/{STI_SET}.is_universe"
		do
			Precursor {SET_TESTS}
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
