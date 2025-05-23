note
	description: "Equality that holds for entities that are both void or that are equal according to the ≡≡≡ operator, i.e. `is_deep_equal' comparison."
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	OBJECT_DEEP_EQUALITY [G]

inherit
	INSTANCE_FREE_EQUALITY [G]

feature -- Relationship

	holds alias "()" (a, b: G): BOOLEAN
			-- <Precursor>
		do
			if attached a then
				Result := attached b and then a ≡≡≡ b
			else
				Result := not attached b
			end
		ensure then
			attached_a: attached a ⇒ Result = (attached b and then a ≡≡≡ b)
			detached_a: not attached a ⇒ Result = not attached b
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
