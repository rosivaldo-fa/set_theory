note
	description: "Equality that holds for entities that reference the same object, i.e. that are equal according to the = operator."
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	REFERENCE_EQUALITY [A]

inherit
	INSTANCE_FREE_EQUALITY [A]

feature -- Relationship

	holds alias "()" (a, b: A): BOOLEAN
			-- <Precursor>
		do
			Result := a = b
		ensure then
			definition: Result = (a = b)
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo Fernandes Alves"
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	source: ""
end
