note
	description: "Set that has every element of a given type"
	author: "Rosivaldo Fernandes Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	UNIVERSE [G]

--inherit
--	SET [G]
--		redefine
--			is_universe,
--			superset_anchor
--		end

--feature -- Quality

--	is_universe: BOOLEAN = True
--			-- <Precursor>
--			--| Current set knows it is a universe!

--feature -- Anchor

--	superset_anchor: UNIVERSE [G]
--			-- <Precursor>
--		do
--			Result := Current
--		end

--invariant
--	is_universe: is_universe

note
	copyright: "Copyright (c) 2012-2026, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
