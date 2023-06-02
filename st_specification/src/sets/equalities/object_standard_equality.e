note
	description: "Equality that holds for entities that are both void or that are equal according to the ≜ operator, i.e. `standard_is_equal' comparison."
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	OBJECT_STANDARD_EQUALITY [A]

inherit
	INSTANCE_FREE_EQUALITY [A]

feature -- Relationship

	holds alias "()" (a, b: A): BOOLEAN
			-- <Precursor>
		do
			if attached a then
				Result := attached {like a} b as l_b and then a ≜ l_b
			else
				Result := not attached b
			end
		ensure then
			attached_a: attached a implies Result = (attached {like a} b as l_b and then a ≜ l_b)
			detached_a: not attached a implies Result = not attached b
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	source: ""
end
