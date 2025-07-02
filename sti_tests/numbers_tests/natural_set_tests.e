note
	description: "Test suite for {STI_NATURAL_SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	NATURAL_SET_TESTS

inherit
	SET_TESTS [STS_NATURAL_NUMBER]
		rename
			some_object_g as some_natural_number
		redefine
			test_all
		end

feature -- Test routines (All)

	test_all
			-- <Precursor>
		note
			testing: "covers/{STI_NATURAL_SET}"
		do
			Precursor {SET_TESTS}
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
