note
	description: "Equality that holds for entities whose object values are the same, i.e. that are equal according to the ~ operator."
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	OBJECT_EQUALITY [A]

inherit
	INSTANCE_FREE_EQUALITY [A]

feature -- Relationship

	holds alias "()" (a, b: A): BOOLEAN
			-- <Precursor>
		do
			Result := a ~ b
		ensure then
			definition: Result = (a ~ b)
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
