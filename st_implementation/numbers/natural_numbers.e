note
	description: "Implementation of {STS_NATURAL_NUMBERS}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	NATURAL_NUMBERS

--inherit
--	STS_NATURAL_NUMBERS
--		undefine
--			does_not_have,
--			out
--		end

--	UNIVERSE [STS_NATURAL_NUMBER]
--		rename
--			extended as set_extended,
--			u as n,
--			universe as natural_numbers
--		redefine
--			subset_anchor,
--			superset_anchor
--		end

--feature -- Construction

--	extended (a_n: NATURAL_NUMBER): like natural_superset_anchor
--			-- <Precursor>
--		do
--			Result := Current
--		end

--feature -- Anchor

--	subset_anchor: NATURAL_SET
--			-- <Precursor>
--		do
--			Result := Current
--		end

--	superset_anchor: NATURAL_NUMBERS
--			-- <Precursor>
--		do
--			Result := Current
--		end

--	natural_superset_anchor: NATURAL_NUMBERS
--			-- <Precursor>
--		do
--			Result := Current
--		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
