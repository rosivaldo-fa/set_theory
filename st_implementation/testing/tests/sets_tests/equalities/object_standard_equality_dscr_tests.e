note
	description: "Test suite for {OBJECT_STANDARD_EQUALITY_DSCR}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	OBJECT_STANDARD_EQUALITY_DSCR_TESTS

inherit
	OBJECT_STANDARD_EQUALITY_TESTS [detachable separate CHARACTER_REF, OBJECT_STANDARD_EQUALITY_DSCR]
		rename
			some_object_a as some_separate_character_ref
		redefine
			properties,
			test_all
		end

	DSCR_TESTS
		rename
			element_to_be_tested as equality_to_be_tested
		undefine
			equality_to_be_tested
		redefine
			properties,
			test_all
		end

feature -- Access

	properties: EQUALITY_PROPERTIES [detachable separate CHARACTER_REF, OBJECT_STANDARD_EQUALITY_DSCR];
			-- <Precursor>

feature -- Test routines (All)

	test_all
			-- Test every routine of {STS_OBJECT_STANDARD_EQUALITY}.
		note
			testing: "covers/{STS_OBJECT_STANDARD_EQUALITY}"
		do
			Precursor {OBJECT_STANDARD_EQUALITY_TESTS}
			test_holds
			test_holds_successively
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	source: ""
end
