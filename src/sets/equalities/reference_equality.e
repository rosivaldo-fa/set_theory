note
	description: "Equality that holds for entities that reference the same object, i.e. that are equal according to the = operator."
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	REFERENCE_EQUALITY [G]

inherit
	INSTANCE_FREE_EQUALITY [G]

feature -- Relationship

	holds alias "()" (a, b: G): BOOLEAN
			-- <Precursor>
		do
			Result := a = b
		ensure then
			definition: Result = (a = b)
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
