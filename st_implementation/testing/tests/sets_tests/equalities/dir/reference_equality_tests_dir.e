note
	description: "Test suite for {REFERENCE_EQUALITY_DIR}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	REFERENCE_EQUALITY_TESTS_DIR

inherit
	REFERENCE_EQUALITY_TESTS [detachable INTEGER_REF, REFERENCE_EQUALITY_DIR]
		rename
			some_object_a as some_integer_ref
		redefine
			properties,
			test_all,
			test_holds,
			test_holds_successively
		end

	TESTS_DIR
		rename
			element_to_be_tested as equality_to_be_tested
		undefine
			equality_to_be_tested
		redefine
			properties,
			test_all
		end

feature -- Access

	properties: EQUALITY_PROPERTIES [detachable INTEGER_REF, REFERENCE_EQUALITY_DIR]
			-- <Precursor>

feature -- Test routines (All)

	test_all
			-- Test every routine of {STS_REFERENCE_EQUALITY}.
		note
			testing: "covers/{STS_REFERENCE_EQUALITY}"
		do
			Precursor {REFERENCE_EQUALITY_TESTS}
			test_holds
			test_holds_successively
		end

feature -- Test routines (Relationship)

	test_holds
			-- <Precursor>
		note
			testing: "covers/{STS_REFERENCE_EQUALITY}.holds"
		do
			Precursor {REFERENCE_EQUALITY_TESTS}
		end

	test_holds_successively
			-- <Precursor>
		note
			testing: "covers/{STS_INSTANCE_FREE_EQUALITY}.holds_successively"
			testing: "covers/{STS_REFERENCE_EQUALITY}.holds_successively"
		do
			Precursor {REFERENCE_EQUALITY_TESTS}
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	source: ""

end
