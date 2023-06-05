note
	description: "Test suite for {STS_OBJECT_DEEP_EQUALITY [detachable INTEGER_REF]}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	OBJECT_DEEP_EQUALITY_TESTS_DIR

inherit
	OBJECT_DEEP_EQUALITY_TESTS [detachable INTEGER_REF, STS_OBJECT_DEEP_EQUALITY [detachable INTEGER_REF]]
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

	properties: STP_OBJECT_DEEP_EQUALITY_PROPERTIES [detachable INTEGER_REF, STS_OBJECT_DEEP_EQUALITY [detachable INTEGER_REF]];
	-- <Precursor>

feature -- Test routines (All)

	test_all
			-- Test every routine of {STS_OBJECT_DEEP_EQUALITY}.
		note
			testing: "covers/{STS_OBJECT_DEEP_EQUALITY}"
		do
			Precursor {OBJECT_DEEP_EQUALITY_TESTS}
			test_holds
			test_holds_successively
		end

feature -- Test routines (Relationship)

	test_holds
			-- <Precursor>
		note
			testing: "covers/{STS_OBJECT_DEEP_EQUALITY}.holds"
		do
			Precursor {OBJECT_DEEP_EQUALITY_TESTS}
		end

	test_holds_successively
			-- <Precursor>
		note
			testing: "covers/{STS_INSTANCE_FREE_EQUALITY}.holds_successively"
			testing: "covers/{STS_OBJECT_DEEP_EQUALITY}.holds_successively"
		do
			Precursor {OBJECT_DEEP_EQUALITY_TESTS}
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	source: ""

end