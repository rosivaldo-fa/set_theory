note
	description: "Effective test suite for {UNIVERSE}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	UNIVERSE_EFFECTIVE_TESTS

inherit
	UNIVERSE_TESTS [detachable separate CHARACTER_REF]
		rename
			a as c1,
			b as c2,
			c as c3,
			d as c4
		redefine
			test_all,
			test_default_create,
			test_out,
			test_debug_output
		end

feature -- Test routines (All)

	test_all
			-- <Precursor>
		note
			testing: "covers/{UNIVERSE}"
		do
			Precursor {UNIVERSE_TESTS}
		end

feature -- Test routines (Initialization)

	test_default_create
			-- <Precursor>
		note
			testing: "covers/{UNIVERSE}.default_create"
		do
			Precursor {UNIVERSE_TESTS}
		end

feature -- Test routines (Output)

	test_out
			-- <Precursor>
		note
			testing: "covers/{UNIVERSE}.out"
		do
			Precursor {UNIVERSE_TESTS}
		end

feature -- Test routines (Status report)

	test_debug_output
			-- <Precursor>
		note
			testing: "covers/{UNIVERSE}.debug_output"
		do
			Precursor {UNIVERSE_TESTS}
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
