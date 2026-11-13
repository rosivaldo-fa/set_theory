note
	description: "Effective test suite for {EFFECTIVE_NATURAL_SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	NATURAL_SET_EFFECTIVE_TESTS

inherit
	EFFECTIVE_NATURAL_SET_TESTS
		redefine
			test_all,
			test_default_create,
			test_make_extended,
			test_given_element,
			test_subset,
			test_has,
			test_set_extended,
			test_extended
		end

feature -- Test routines (All)

	test_all
			-- <Precursor>
		note
			testing: "covers/{EFFECTIVE_NATURAL_SET}"
		do
			Precursor {EFFECTIVE_NATURAL_SET_TESTS}
		end

feature -- Test routines (Initialization)

	test_default_create
			-- <Precursor>
		note
			testing: "covers/{EFFECTIVE_NATURAL_SET}.default_create"
		do
			Precursor {EFFECTIVE_NATURAL_SET_TESTS}
		end

	test_make_extended
			-- <Precursor>
		note
			testing: "covers/{EFFECTIVE_NATURAL_SET}.make_extended"
		do
			Precursor {EFFECTIVE_NATURAL_SET_TESTS}
		end

feature -- Test routines (Primitive)

	test_given_element
			-- <Precursor>
		note
			testing: "covers/{EFFECTIVE_NATURAL_SET}.given_element"
		do
			Precursor {EFFECTIVE_NATURAL_SET_TESTS}
		end

	test_subset
			-- <Precursor>
		note
			testing: "covers/{EFFECTIVE_NATURAL_SET}.subset"
		do
			Precursor {EFFECTIVE_NATURAL_SET_TESTS}
		end

feature -- Test routines (Membership)

	test_has
			-- Test {EFFECTIVE_NATURAL_SET}.has.
		note
			testing: "covers/{EFFECTIVE_NATURAL_SET}.has"
		do
			Precursor {EFFECTIVE_NATURAL_SET_TESTS}
		end

feature -- Test routines (Construction)

	test_set_extended
			-- Test {EFFECTIVE_NATURAL_SET}.set_extended.
		note
			testing: "covers/{EFFECTIVE_NATURAL_SET}.set_extended"
		do
			Precursor {EFFECTIVE_NATURAL_SET_TESTS}
		end

	test_extended
			-- Test {EFFECTIVE_NATURAL_SET}.extended.
		note
			testing: "covers/{EFFECTIVE_NATURAL_SET}.extended"
		do
			Precursor {EFFECTIVE_NATURAL_SET_TESTS}
		end

note
	copyright: "Copyright (c) 2012-2026, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
