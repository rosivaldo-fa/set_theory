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
			test_all
--			test_is_in
		end

	ELEMENT_TESTS
		rename
			element_to_be_tested as set_to_be_tested
		undefine
			test_is_in,
			set_to_be_tested
		redefine
			test_all
--			test_is_in
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {STI_SET}.
		note
			testing: "covers/{STI_SET}"
		do
			Precursor {STST_SET_TESTS}
		end

--feature -- Test routines (Membership)

--	test_is_in
--			-- <Precursor>
--		note
--			testing: "covers/{STS_ELEMENT}.is_in"
--			testing: "covers/{STS_SET}.is_in"
--			testing: "covers/{SET}.is_in"
--		do
--			Precursor {STST_SET_TESTS}
--		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
