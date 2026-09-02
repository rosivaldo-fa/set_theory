note
	description: "Equality that defines `holds' as a class feature."
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	INSTANCE_FREE_EQUALITY [G]

inherit
	EQUALITY [G]
		redefine
			holds_successively
		end

feature -- Relationship

	holds alias "()" (a, b: G): BOOLEAN
			-- <Precursor>
			--| Equalities whose `holds' can be a class feature may inherit from current one; {EQUALITY}.holds is kept open for descendants that need a non-class
			--| `holds' feature.
		deferred
		ensure then
			class
		end

	holds_successively (a, b, c: G): BOOLEAN
			-- <Precursor>
		do
			Result := holds (a, b) and holds (b, c)
		ensure then
			class
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
