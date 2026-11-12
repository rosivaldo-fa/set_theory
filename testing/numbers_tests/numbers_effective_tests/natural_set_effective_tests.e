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
			test_make_extended
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

note
	copyright: "Copyright (c) 2012-2026, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
