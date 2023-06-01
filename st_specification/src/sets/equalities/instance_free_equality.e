note
	description: "Equality that defines `holds' as a class feature."
	author: "Rosivaldo Fernandes Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	INSTANCE_FREE_EQUALITY [A]

inherit
	EQUALITY [A]
		redefine
			holds_successively
		end

feature -- Relationship

	holds alias "()" (a, b: A): BOOLEAN
			-- <Precursor>
			--| Equalities whose `holds' can be a class feature may inherit from current one; {EQUALITY}.holds is kept open for descendants that need a non-class
			--| `holds' feature.
		deferred
		ensure then
			class
		end

	holds_successively (a, b, c: A): BOOLEAN
			-- <Precursor>
		do
			Result := holds (a, b) and holds (b, c)
		ensure then
			class
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo Fernandes Alves"
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	source: ""
end
