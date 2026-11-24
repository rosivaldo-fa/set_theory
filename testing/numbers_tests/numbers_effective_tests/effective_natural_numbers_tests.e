note
	description: "Test suite for {EFFECTIVE_NATURAL_NUMBERS}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	EFFECTIVE_NATURAL_NUMBERS_TESTS

inherit
	NATURAL_NUMBERS_TESTS
		redefine
			test_extended,
			test_prunned,
			test_there_exists
		end

feature -- Test routines (Construction)

	test_extended
			-- Test {NATURAL_NUMBERS}.extended.
			-- Test {EFFECTIVE_NATURAL_NUMBERS}.extended.
		note
			testing: "covers/{NATURAL_NUMBERS}.extended"
			testing: "covers/{EFFECTIVE_NATURAL_NUMBERS}.extended"
		do
			Precursor {NATURAL_NUMBERS_TESTS}
		end

	test_prunned
			-- Test {EFFECTIVE_NATURAL_NUMBERS}.prunned.
		note
			testing: "covers/{EFFECTIVE_NATURAL_NUMBERS}.prunned"
		do
			Precursor {NATURAL_NUMBERS_TESTS}
		end

feature -- Test routines (Quantifier)

	test_there_exists
			-- Test {EFFECTIVE_NATURAL_NUMBERS}.there_exists.
		note
			testing: "covers/{EFFECTIVE_NATURAL_NUMBERS}.there_exists"
		do
			Precursor {NATURAL_NUMBERS_TESTS}
		end

feature -- Factory (element to be tested)

	universe_to_be_tested: EFFECTIVE_NATURAL_NUMBERS
			-- Universe meant to be under tests
		once
			create Result
		ensure then
			class
		end

feature -- Factory

	n1: EFFECTIVE_NATURAL_NUMBER
			-- <Precursor>
		once
			Result := {NATURAL} 1
		ensure then
			class
		end

	n2: EFFECTIVE_NATURAL_NUMBER
			-- <Precursor>
		once
			Result := {NATURAL} 2
		ensure then
			class
		end

	n3: EFFECTIVE_NATURAL_NUMBER
			-- <Precursor>
		once
			Result := {NATURAL} 3
		ensure then
			class
		end

	n4: EFFECTIVE_NATURAL_NUMBER
			-- <Precursor>
		once
			Result := {NATURAL} 4
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
