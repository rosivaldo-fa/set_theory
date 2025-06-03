note
	description: "Set that has every element of a given type"
	author: "Rosivaldo Fernandes Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	UNIVERSE [G]

inherit
	SET [G]
		redefine
			is_universe
		end

feature -- Quality

	is_universe: BOOLEAN = True
			-- <Precursor>

feature -- Anchor

	superset_anchor: UNIVERSE [G]
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
