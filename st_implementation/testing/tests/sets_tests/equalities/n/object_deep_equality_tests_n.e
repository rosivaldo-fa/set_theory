note
	description: "Test suite for {STS_OBJECT_DEEP_EQUALITY [NATURAL]}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	OBJECT_DEEP_EQUALITY_TESTS_N

inherit
	OBJECT_DEEP_EQUALITY_TESTS [NATURAL, STS_OBJECT_DEEP_EQUALITY [NATURAL]]
		rename
			some_object_a as some_natural,
			some_immediate_equality_a as some_object_deep_equality_n,
			some_set_a as some_set_of_deep_objects_n,
			some_immediate_set_a as some_immediate_set_of_deep_objects_n
		redefine
			properties,
			test_all,
			test_holds,
			test_holds_successively
		end

	TESTS_N
		rename
			element_to_be_tested as equality_to_be_tested
		undefine
			on_prepare,
			equality_to_be_tested
		redefine
			properties,
			test_all
		end

feature -- Access

	properties: STP_OBJECT_DEEP_EQUALITY_PROPERTIES [NATURAL, STS_OBJECT_DEEP_EQUALITY [NATURAL]];
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
