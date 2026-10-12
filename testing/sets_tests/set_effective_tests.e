note
	description: "Effective test suite for {EFFECTIVE_SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	SET_EFFECTIVE_TESTS

inherit
	EFFECTIVE_SET_TESTS [detachable separate CHARACTER_REF]
		rename
			a as c1,
			b as c2,
			c as c3,
			d as c4
		redefine
			test_all,
			test_default_create,
			test_make_extended,
			test_has,
			test_does_not_have,
			test_is_in,
			test_is_not_in,
			test_extended,
			test_prunned,
			test_u,
			test_universe,
			test_element_out,
			test_out,
			test_debug_output,
			test_is_universe,
			test_given_element,
			test_eq,
			test_subset,
			test_given_element_storage
		end

feature -- Test routines (All)

	test_all
			-- <Precursor>
		note
			testing: "covers/{EFFECTIVE_SET}"
		do
			Precursor {EFFECTIVE_SET_TESTS}
		end

feature -- Test routines (Initialization)

	test_default_create
			-- <Precursor>
		note
			testing: "covers/{EFFECTIVE_SET}.default_create"
		do
			Precursor {EFFECTIVE_SET_TESTS}
		end

	test_make_extended
			-- <Precursor>
		note
			testing: "covers/{EFFECTIVE_SET}.make_extended"
		do
			Precursor {EFFECTIVE_SET_TESTS}
		end

feature -- Test routines (Membership)

	test_has
			-- <Precursor>
			-- Test {EFFECTIVE_SET}.has.
		note
			testing: "covers/{SET}.has"
			testing: "covers/{EFFECTIVE_SET}.has"
		do
			Precursor {EFFECTIVE_SET_TESTS}
		end

	test_does_not_have
			-- <Precursor>
			-- Test {EFFECTIVE_SET}.does_not_have.
		note
			testing: "covers/{SET}.does_not_have"
			testing: "covers/{EFFECTIVE_SET}.does_not_have"
		do
			Precursor {EFFECTIVE_SET_TESTS}
		end

	test_is_in
			-- <Precursor>
			-- Test {EFFECTIVE_SET}.is_in.
		note
			testing: "covers/{SET}.is_in"
			testing: "covers/{EFFECTIVE_SET}.is_in"
		do
			Precursor {EFFECTIVE_SET_TESTS}
		end

	test_is_not_in
			-- <Precursor>
			-- Test {EFFECTIVE_SET}.is_not_in.
		note
			testing: "covers/{SET}.is_not_in"
			testing: "covers/{EFFECTIVE_SET}.is_not_in"
		do
			Precursor {EFFECTIVE_SET_TESTS}
		end

feature -- Test routines (Construction)

	test_extended
			-- <Precursor>
			-- Test {EFFECTIVE_SET}.extended.
		note
			testing: "covers/{SET}.extended"
			testing: "covers/{EFFECTIVE_SET}.extended"
		do
			Precursor {EFFECTIVE_SET_TESTS}
		end

	test_prunned
			-- <Precursor>
			-- Test {EFFECTIVE_SET}.prunned.
		note
			testing: "covers/{SET}.prunned"
			testing: "covers/{EFFECTIVE_SET}.prunned"
		do
			Precursor {EFFECTIVE_SET_TESTS}
		end

feature -- Test routines (Access)

	test_u
			-- Test {EFFECTIVE_SET}.u.
		note
			testing: "covers/{EFFECTIVE_SET}.u"
		do
			Precursor {EFFECTIVE_SET_TESTS}
		end

	test_universe
			-- Test {EFFECTIVE_SET}.universe.
		note
			testing: "covers/{EFFECTIVE_SET}.universe"
		do
			Precursor {EFFECTIVE_SET_TESTS}
		end

feature -- Test routines (Quality)

	test_is_universe
			-- <Precursor>
			-- Test {EFFECTIVE_SET}.is_universe.
		note
			testing: "covers/{SET}.is_universe"
			testing: "covers/{EFFECTIVE_SET}.is_universe"
		do
			Precursor {EFFECTIVE_SET_TESTS}
		end

feature -- Test routines (Output)

	test_element_out
			-- <Precursor>
		note
			testing: "covers/{EFFECTIVE_SET}.element_out"
		do
			Precursor {EFFECTIVE_SET_TESTS}
		end

	test_out
			-- <Precursor>
		note
			testing: "covers/{EFFECTIVE_SET}.out"
		do
			Precursor {EFFECTIVE_SET_TESTS}
		end

feature -- Test routines (Status report)

	test_debug_output
			-- <Precursor>
		note
			testing: "covers/{EFFECTIVE_SET}.out"
		do
			Precursor {EFFECTIVE_SET_TESTS}
		end

feature -- Test routines (Implementation)

	test_given_element
			-- <Precursor>
		note
			testing: "covers/{EFFECTIVE_SET}.given_element"
		do
			Precursor {EFFECTIVE_SET_TESTS}
		end

	test_eq
			-- <Precursor>
		note
			testing: "covers/{EFFECTIVE_SET}.eq"
		do
			Precursor {EFFECTIVE_SET_TESTS}
		end

	test_subset
			-- <Precursor>
		note
			testing: "covers/{EFFECTIVE_SET}.subset"
		do
			Precursor {EFFECTIVE_SET_TESTS}
		end

	test_given_element_storage
			-- <Precursor>
		note
			testing: "covers/{EFFECTIVE_SET}.given_element_storage"
		do
			Precursor {EFFECTIVE_SET_TESTS}
		end

feature -- Factory

	c1: detachable separate CHARACTER_REF
			-- <Precursor>
		once
		ensure then
			class
		end

	c2: detachable separate CHARACTER_REF
			-- <Precursor>
		once
			create Result
		ensure then
			class
		end

	c3: detachable separate CHARACTER_REF
			-- <Precursor>
		once
			create Result
			separate Result as sep_result do
				sep_result.set_item ('a')
			end
		ensure then
			class
		end

	c4: detachable separate CHARACTER_REF
			-- <Precursor>
		once
			create Result
			separate Result as sep_result do
				sep_result.set_item ('b')
			end
		ensure then
			class
		end

note
	copyright: "Copyright (c) 2012-2026, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
