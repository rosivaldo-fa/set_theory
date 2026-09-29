note
	description: "Effective test suite for {SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	EFFECTIVE_SET_TESTS

inherit
	SET_TESTS [detachable separate CHARACTER_REF]
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
			testing: "covers/{SET}"
		do
			Precursor {SET_TESTS}
		end

feature -- Test routines (Initialization)

	test_default_create
			-- <Precursor>
		note
			testing: "covers/{SET}.default_create"
		do
			Precursor {SET_TESTS}
		end

	test_make_extended
			-- <Precursor>
		note
			testing: "covers/{SET}.make_extended"
		do
			Precursor {SET_TESTS}
		end

feature -- Test routines (Membership)

	test_has
			-- <Precursor>
		note
			testing: "covers/{SET}.has"
		do
			Precursor {SET_TESTS}
		end

	test_does_not_have
			-- <Precursor>
		note
			testing: "covers/{SET}.does_not_have"
		do
			Precursor {SET_TESTS}
		end

	test_is_in
			-- <Precursor>
		note
			testing: "covers/{SET}.is_in"
		do
			Precursor {SET_TESTS}
		end

	test_is_not_in
			-- <Precursor>
		note
			testing: "covers/{SET}.is_not_in"
		do
			Precursor {SET_TESTS}
		end

feature -- Test routines (Construction)

	test_extended
			-- <Precursor>
		note
			testing: "covers/{SET}.extended"
		do
			Precursor {SET_TESTS}
		end

	test_prunned
			-- <Precursor>
		note
			testing: "covers/{SET}.prunned"
		do
			Precursor {SET_TESTS}
		end

feature -- Test routines (Quality)

	test_is_universe
			-- <Precursor>
		note
			testing: "covers/{SET}.is_universe"
		do
			Precursor {SET_TESTS}
		end

feature -- Test routines (Output)

	test_element_out
			-- <Precursor>
		note
			testing: "covers/{SET}.element_out"
		do
			Precursor {SET_TESTS}
		end

	test_out
			-- <Precursor>
		note
			testing: "covers/{SET}.out"
		do
			Precursor {SET_TESTS}
		end

feature -- Test routines (Status report)

	test_debug_output
			-- <Precursor>
		do
			Precursor {SET_TESTS}
		end

feature -- Test routines (Implementation)

	test_given_element
			-- <Precursor>
		note
			testing: "covers/{SET}.given_element"
		do
			Precursor {SET_TESTS}
		end

	test_eq
			-- <Precursor>
		note
			testing: "covers/{SET}.eq"
		do
			Precursor {SET_TESTS}
		end

	test_subset
			-- <Precursor>
		note
			testing: "covers/{SET}.subset"
		do
			Precursor {SET_TESTS}
		end

	test_given_element_storage
			-- <Precursor>
		note
			testing: "covers/{SET}.given_element_storage"
		do
			Precursor {SET_TESTS}
		end

feature {NONE} -- Factory

	c1: detachable separate CHARACTER_REF
			-- <Precursor>
		once
		end

	c2: detachable separate CHARACTER_REF
			-- <Precursor>
		do
			create Result
		end

	c3: detachable separate CHARACTER_REF
			-- <Precursor>
		do
			create Result
			separate Result as sep_result do
				sep_result.set_item ('a')
			end
		end

	c4: detachable separate CHARACTER_REF
			-- <Precursor>
		do
			create Result
			separate Result as sep_result do
				sep_result.set_item ('b')
			end
		end

note
	copyright: "Copyright (c) 2012-2026, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
