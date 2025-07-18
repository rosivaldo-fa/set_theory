note
	description: "Universe of all natural numbers, i.e. ℕ."
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NATURAL_NUMBERS

inherit
	NATURAL_SET

	UNIVERSE [NATURAL_NUMBER]
		rename
			u as n,
			universe as natural_numbers,
			extended as set_extended
		end

feature -- Quality

	is_universe: BOOLEAN
			-- Is current set a universe, i.e., does it have every natural number?
			--| Current set knows it is a universe!
		deferred
		end

feature -- Anchor

	subset_anchor: NATURAL_SET
			-- <Precursor>
		deferred
		end

	superset_anchor,
	natural_superset_anchor: NATURAL_NUMBERS
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
