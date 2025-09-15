note
	description: "Universe of all rational numbers, pq.e. ℤ."
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	RATIONAL_NUMBERS

inherit
	RATIONAL_SET

	UNIVERSE [RATIONAL_NUMBER]
		rename
			u as q,
			universe as rational_numbers,
			extended as set_extended
		end

feature -- Quality

	is_universe: BOOLEAN
			-- Is current set a universe, i.e., does it have every rational number?
			--| Current set knows it is a universe!
		deferred
		end

feature -- Anchor

	subset_anchor: RATIONAL_SET
			-- <Precursor>
		deferred
		end

	superset_anchor,
	rational_superset_anchor: RATIONAL_NUMBERS
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
