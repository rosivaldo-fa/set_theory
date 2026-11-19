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
			does_not_have
		end

feature -- Quality

	is_universe: BOOLEAN = True
			-- <Precursor>
			--| Current set knows it is a universe!

feature -- Membership

	has alias "∋" (a: G): BOOLEAN
			-- <Precursor>
			--| Notice that a universe has every thing, but it does not need to know anything about its elements, and indeed probably does not know. It has
			--| an important impact upon `there_exists'.
		do
			Result := True
		end;

	does_not_have alias "∌" (a: G): BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

feature -- Construction

	extended (a: G; eq: EQUALITY [G]): like Current
			-- Current universe itself
		do
			Result := Current
		end

	prunned alias "/" (a: G): COMPLEMENT_SET [G]
			-- <Precursor>
		deferred
		ensure then
			reference_set: Result.reference_set ∋ a -- TODO: Make it a singleton.
		end

feature -- Access

	u,
	universe: like Current
			-- <Precursor>
		deferred
		end

feature -- Anchor

	universe_anchor: like Current
			-- <Precursor>
		deferred
		end

invariant
	is_universe: is_universe

note
	copyright: "Copyright (c) 2012-2026, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
