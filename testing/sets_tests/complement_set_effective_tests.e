note
	description: "Effective test suite for {COMPLEMENT_SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	COMPLEMENT_SET_EFFECTIVE_TESTS

inherit
	COMPLEMENT_SET_TESTS [detachable separate CHARACTER_REF]
		rename
			a as c1,
			b as c2,
			c as c3,
			d as c4
		redefine
			test_all,
			test_make,
			test_reference_set,
			test_out,
			test_debug_output
		end

feature -- Test routines (All)

	test_all
			-- <Precursor>
		note
			testing: "covers/{COMPLEMENT_SET}"
		do
			Precursor {COMPLEMENT_SET_TESTS}
		end

feature -- Test routines (Initialization)

	test_make
			-- <Precursor>
		note
			testing: "covers/{COMPLEMENT_SET}.make"
		do
			Precursor {COMPLEMENT_SET_TESTS}
		end

feature -- Test routines (Primitive)

	test_reference_set
			-- <Precursor>
		note
			testing: "covers/{COMPLEMENT_SET}.reference_set"
		do
			Precursor {COMPLEMENT_SET_TESTS}
		end

feature -- Test routines (Output)

	test_out
			-- <Precursor>
		note
			testing: "covers/{COMPLEMENT_SET}.out"
		do
			Precursor {COMPLEMENT_SET_TESTS}
		end

feature -- Test routines (Status report)

	test_debug_output
			-- <Precursor>
		note
			testing: "covers/{COMPLEMENT_SET}.debug_output"
		do
			Precursor {COMPLEMENT_SET_TESTS}
		end

feature -- Factory (element to be tested)

	set_to_be_tested: COMPLEMENT_SET [detachable separate CHARACTER_REF]
			-- <Precursor>
		do
			create Result.make ({SET_EFFECTIVE_TESTS}.set_to_be_tested)
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
