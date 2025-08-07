note
	description: "Universe of all integer numbers, i.e. ℤ."
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	INTEGER_NUMBERS

inherit
	INTEGER_SET

	UNIVERSE [INTEGER_NUMBER]
		rename
			u as z,
			universe as integer_numbers,
			extended as set_extended
		end

feature -- Quality

	is_universe: BOOLEAN
			-- Is current set a universe, i.e., does it have every integer number?
			--| Current set knows it is a universe!
		deferred
		end

feature -- Anchor

	subset_anchor: INTEGER_SET
			-- <Precursor>
		deferred
		end

	superset_anchor,
	integer_superset_anchor: INTEGER_NUMBERS
			-- <Precursor>
		deferred
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
