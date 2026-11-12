note
	description: "Effective test suite for {UNIVERSE}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

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
			test_has,
			test_does_not_have,
			test_extended,
			test_prunned,
			test_u,
			test_universe,
			test_is_universe,
			test_out,
			test_debug_output,
			test_there_exists,
			test_there_exists_character_8,
			test_there_exists_character_32,
			test_there_exists_native_natural_8,
			test_there_exists_native_natural_16,
			test_there_exists_native_natural_32,
			test_there_exists_native_natural_64,
			test_there_exists_native_integer_8,
			test_there_exists_native_integer_16,
			test_there_exists_native_integer_32,
			test_there_exists_native_integer_64,
			test_there_exists_native_real_32,
			test_there_exists_native_real_64,
			test_there_exists_g_instance
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

feature -- Test routines (Membership)

	test_has
			-- <Precursor>
		note
			testing: "covers/{UNIVERSE}.has"
		do
			Precursor {UNIVERSE_TESTS}
		end

	test_does_not_have
			-- <Precursor>
		note
			testing: "covers/{UNIVERSE}.does_not_have"
		do
			Precursor {UNIVERSE_TESTS}
		end

feature -- Test routines (Construction)

	test_extended
			-- Test {UNIVERSE}.extended.
		note
			testing: "covers/{UNIVERSE}.extended"
		do
			Precursor {UNIVERSE_TESTS}
		end

	test_prunned
			-- Test {UNIVERSE}.prunned.
		note
			testing: "covers/{UNIVERSE}.prunned"
		do
			Precursor {UNIVERSE_TESTS}
		end

feature -- Test routines (Access)

	test_u
			-- Test {UNIVERSE}.u.
		note
			testing: "covers/{UNIVERSE}.u"
		do
			Precursor {UNIVERSE_TESTS}
		end

	test_universe
			-- Test {UNIVERSE}.universe.
		note
			testing: "covers/{UNIVERSE}.universe"
		do
			Precursor {UNIVERSE_TESTS}
		end

feature -- Test routines (Quality)

	test_is_universe
			-- Test {UNIVERSE}.is_universe.
		note
			testing: "covers/{UNIVERSE}.is_universe"
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

feature -- Test routines (Quantifier)

	test_there_exists
			-- <Precursor>
		note
			testing: "covers/{UNIVERSE}.there_exists"
		do
			Precursor {UNIVERSE_TESTS}
		end

	test_there_exists_character_8
			-- <Precursor>
		note
			testing: "covers/{UNIVERSE}.there_exists_character_8"
		do
			Precursor {UNIVERSE_TESTS}
		end

	test_there_exists_character_32
			-- <Precursor>
		note
			testing: "covers/{UNIVERSE}.there_exists_character_32"
		do
			Precursor {UNIVERSE_TESTS}
		end

	test_there_exists_native_natural_8
			-- <Precursor>
		note
			testing: "covers/{UNIVERSE}.there_exists_native_natural_8"
		do
			Precursor {UNIVERSE_TESTS}
		end

	test_there_exists_native_natural_16
			-- <Precursor>
		note
			testing: "covers/{UNIVERSE}.there_exists_native_natural_16"
		do
			Precursor {UNIVERSE_TESTS}
		end

	test_there_exists_native_natural_32
			-- <Precursor>
		note
			testing: "covers/{UNIVERSE}.there_exists_native_natural_32"
		do
			Precursor {UNIVERSE_TESTS}
		end

	test_there_exists_native_natural_64
			-- <Precursor>
		note
			testing: "covers/{UNIVERSE}.there_exists_native_natural_64"
		do
			Precursor {UNIVERSE_TESTS}
		end

	test_there_exists_native_integer_8
			-- <Precursor>
		note
			testing: "covers/{UNIVERSE}.there_exists_native_integer_8"
		do
			Precursor {UNIVERSE_TESTS}
		end

	test_there_exists_native_integer_16
			-- <Precursor>
		note
			testing: "covers/{UNIVERSE}.there_exists_native_integer_16"
		do
			Precursor {UNIVERSE_TESTS}
		end

	test_there_exists_native_integer_32
			-- <Precursor>
		note
			testing: "covers/{UNIVERSE}.there_exists_native_integer_32"
		do
			Precursor {UNIVERSE_TESTS}
		end

	test_there_exists_native_integer_64
			-- <Precursor>
		note
			testing: "covers/{UNIVERSE}.there_exists_native_integer_64"
		do
			Precursor {UNIVERSE_TESTS}
		end

	test_there_exists_native_real_32
			-- <Precursor>
		note
			testing: "covers/{UNIVERSE}.there_exists_native_real_32"
		do
			Precursor {UNIVERSE_TESTS}
		end

	test_there_exists_native_real_64
			-- <Precursor>
		note
			testing: "covers/{UNIVERSE}.there_exists_native_real_64"
		do
			Precursor {UNIVERSE_TESTS}
		end

	test_there_exists_g_instance
			-- <Precursor>
		note
			testing: "covers/{UNIVERSE}.there_exists_g_instance"
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
