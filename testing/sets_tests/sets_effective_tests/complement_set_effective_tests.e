note
	description: "Effective test suite for {EFFECTIVE_COMPLEMENT_SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	COMPLEMENT_SET_EFFECTIVE_TESTS

inherit
	EFFECTIVE_COMPLEMENT_SET_TESTS [detachable separate CHARACTER_REF]
		rename
			a as c1,
			b as c2,
			c as c3,
			d as c4
		redefine
			test_all,
			test_make,
			test_reference_set,
			test_has,
			test_extended,
			test_prunned,
			test_u,
			test_universe,
			test_is_universe,
			test_out,
			test_debug_output,
			test_there_exists,
			test_p_holds_outside_reference_set
		end

feature -- Test routines (All)

	test_all
			-- <Precursor>
		note
			testing: "covers/{EFFECTIVE_COMPLEMENT_SET}"
		do
			Precursor {EFFECTIVE_COMPLEMENT_SET_TESTS}
		end

feature -- Test routines (Initialization)

	test_make
			-- <Precursor>
		note
			testing: "covers/{EFFECTIVE_COMPLEMENT_SET}.make"
		do
			Precursor {EFFECTIVE_COMPLEMENT_SET_TESTS}
		end

feature -- Test routines (Primitive)

	test_reference_set
			-- <Precursor>
		note
			testing: "covers/{EFFECTIVE_COMPLEMENT_SET}.reference_set"
		do
			Precursor {EFFECTIVE_COMPLEMENT_SET_TESTS}
		end

feature -- Test routines (Membership)

	test_has
			-- <Precursor>
		note
			testing: "covers/{EFFECTIVE_COMPLEMENT_SET}.has"
		do
			Precursor {EFFECTIVE_COMPLEMENT_SET_TESTS}
		end

feature -- Test routines (Construction)

	test_extended
			-- Test {EFFECTIVE_COMPLEMENT_SET}.extended.
		note
			testing: "covers/{EFFECTIVE_COMPLEMENT_SET}.extended"
		do
			Precursor {EFFECTIVE_COMPLEMENT_SET_TESTS}
		end

	test_prunned
			-- <Precursor>
			-- Test {EFFECTIVE_COMPLEMENT_SET}.prunned.
		note
			testing: "covers/{EFFECTIVE_COMPLEMENT_SET}.prunned"
		do
			Precursor {EFFECTIVE_COMPLEMENT_SET_TESTS}
		end

feature -- Test routines (Access)

	test_u
			-- Test {EFFECTIVE_COMPLEMENT_SET}.u.
		note
			testing: "covers/{EFFECTIVE_COMPLEMENT_SET}.u"
		do
			Precursor {EFFECTIVE_COMPLEMENT_SET_TESTS}
		end

	test_universe
			-- Test {EFFECTIVE_COMPLEMENT_SET}.universe.
		note
			testing: "covers/{EFFECTIVE_COMPLEMENT_SET}.universe"
		do
			Precursor {EFFECTIVE_COMPLEMENT_SET_TESTS}
		end

feature -- Test routines (Quality)

	test_is_universe
			-- Test {EFFECTIVE_COMPLEMENT_SET}.is_universe.
		note
			testing: "covers/{EFFECTIVE_COMPLEMENT_SET}.is_universe"
		do
			Precursor {EFFECTIVE_COMPLEMENT_SET_TESTS}
		end

feature -- Test routines (Output)

	test_out
			-- <Precursor>
		note
			testing: "covers/{EFFECTIVE_COMPLEMENT_SET}.out"
		do
			Precursor {EFFECTIVE_COMPLEMENT_SET_TESTS}
		end

feature -- Test routines (Status report)

	test_debug_output
			-- <Precursor>
		note
			testing: "covers/{EFFECTIVE_COMPLEMENT_SET}.debug_output"
		do
			Precursor {EFFECTIVE_COMPLEMENT_SET_TESTS}
		end

feature -- Test routines (Quantifier)

	test_there_exists
			-- <Precursor>
		note
			testing: "covers/{EFFECTIVE_COMPLEMENT_SET}.there_exists"
		do
			Precursor {EFFECTIVE_COMPLEMENT_SET_TESTS}
		end

	test_p_holds_outside_reference_set
			-- <Precursor>
		note
			testing: "covers/{EFFECTIVE_COMPLEMENT_SET}.p_holds_outside_reference_set"
		do
			Precursor {EFFECTIVE_COMPLEMENT_SET_TESTS}
		end

feature -- Factory (element to be tested)

	set_to_be_tested: EFFECTIVE_COMPLEMENT_SET [detachable separate CHARACTER_REF]
			-- <Precursor>
		do
			create Result.make ({SET_EFFECTIVE_TESTS}.set_to_be_tested)
		end

feature -- Factory

	c1: detachable separate CHARACTER_REF
			-- <Precursor>
		once
			Result := {SET_EFFECTIVE_TESTS}.C1
		ensure then
			class
		end

	c2: detachable separate CHARACTER_REF
			-- <Precursor>
		once
			Result := {SET_EFFECTIVE_TESTS}.C2
		ensure then
			class
		end

	c3: detachable separate CHARACTER_REF
			-- <Precursor>
		once
			Result := {SET_EFFECTIVE_TESTS}.C3
		ensure then
			class
		end

	c4: detachable separate CHARACTER_REF
			-- <Precursor>
		once
			Result := {SET_EFFECTIVE_TESTS}.C4
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
