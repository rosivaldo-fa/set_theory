note
	description: "Test suite for {STS_OBJECT_DEEP_EQUALITY [detachable separate CHARACTER_REF]}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	OBJECT_DEEP_EQUALITY_TESTS_DSCR

inherit
	ELEMENT_TESTS
		rename
			element_to_be_tested as equality_to_be_tested
		undefine
			equality_to_be_tested
		redefine
			test_all
		end
	STST_OBJECT_DEEP_EQUALITY_TESTS [detachable separate CHARACTER_REF]
		rename
			some_object_g as some_separate_character_ref,
			some_immediate_equality_g as some_object_deep_equality_dscr
		undefine
			default_create,
			test_is_in
		redefine
			test_all
--			test_holds
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {STS_OBJECT_DEEP_EQUALITY}.
		note
			testing: "covers/{STS_OBJECT_DEEP_EQUALITY}"
		do
			Precursor {STST_OBJECT_DEEP_EQUALITY_TESTS}
		end

--feature -- Test routines (Relationship)

--	test_holds
--			-- <Precursor>
--		note
--			testing: "covers/{STS_OBJECT_DEEP_EQUALITY}.holds"
--		do
--			Precursor {STST_OBJECT_DEEP_EQUALITY_TESTS}
--		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
