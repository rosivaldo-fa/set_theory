note
	description: "Implementation of {STS_UNIVERSE}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	UNIVERSE [G]

inherit
	STS_UNIVERSE [G]
		redefine
			does_not_have
		end

feature -- Membership

	has alias "∋" (a: G): BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

	does_not_have alias "∌" (a: G): BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

feature -- Construction

	extended (a: G; eq: STS_EQUALITY [G]): like superset_anchor
			-- <Precursor>
		do
			Result := Current
		end

	prunned (a: G): like subset_anchor
			-- <Precursor>
		local
			ref: SET [G]
		do
			create ref
			create Result.make (ref.extended (a, create {STS_REFERENCE_EQUALITY}))
		end

feature -- Quality

	is_universe: BOOLEAN = True

feature -- Anchor

	subset_anchor: SET [G]
			-- <Precursor>
		do
			create Result
		end

	superset_anchor: UNIVERSE [G]
			-- <Precursor>
		do
			Result := Current
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
