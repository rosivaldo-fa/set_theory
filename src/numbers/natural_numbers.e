note
	description: "Set of all natural numbers, i.e. the set ℕ."
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NATURAL_NUMBERS

inherit
	NATURAL_SET
		rename
			set_superset_anchor as universe_anchor,
			superset_anchor as universe_anchor
		undefine
			does_not_have
		end

	UNIVERSE [NATURAL_NUMBER]
		rename
			extended as set_extended,
			u as n,
			universe as natural_numbers
		end

feature -- Construction

	extended alias "&" (m: NATURAL_NUMBER): like Current
			-- Current universe itself
		do
			Result := Current
		end

	prunned alias "/" (m: NATURAL_NUMBER): COMPLEMENT_SET [NATURAL_NUMBER]
			-- <Precursor>
		deferred
		end

feature -- Anchor

	universe_anchor: like Current
			-- Anchor for the universe of natural numbers
		do
			Result := Current
		end

note
	copyright: "Copyright (c) 2012-2026, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
