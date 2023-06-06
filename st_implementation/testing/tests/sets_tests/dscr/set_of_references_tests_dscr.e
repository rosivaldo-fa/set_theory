note
	description: "Test suite for {SET [detachable separate CHARACTER_REF, STS_REFERENCE_EQUALITY [detachable separate CHARACTER_REF]]}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	SET_OF_REFERENCES_TESTS_DSCR

inherit
	SET_TESTS [detachable separate CHARACTER_REF, STS_REFERENCE_EQUALITY [detachable separate CHARACTER_REF]]
		rename
			some_object_a as some_separate_character_ref,
			some_immediate_set_a as some_immediate_set_of_references_dscr
		redefine
			properties,
			test_all,
			test_is_empty
		end

	TESTS_DSCR
		rename
			element_to_be_tested as set_to_be_tested
		undefine
			set_to_be_tested
		redefine
			properties,
			test_all
		end

feature -- Access

	properties: SET_PROPERTIES [detachable separate CHARACTER_REF, STS_REFERENCE_EQUALITY [detachable separate CHARACTER_REF]]
			-- <Precursor>

feature -- Test routines (All)

	test_all
			-- Test every routine of {SET}.
		note
			testing: "covers/{SET}"
		do
			Precursor {SET_TESTS}
			test_is_empty
		end

feature -- Test routines (Primitive)

	test_is_empty
			-- <Precursor>
		note
			testing: "covers/{SET}.is_empty"
		do
			Precursor {SET_TESTS}
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	source: ""

end
