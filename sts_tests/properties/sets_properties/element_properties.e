note
	description: "Object that checks whether the properties verified within set theory hold for an implementation of {STS_ELEMENT}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ELEMENT_PROPERTIES

feature -- Properties (Membership)

	is_not_in_ok (a: STS_ELEMENT; s: STS_SET [STS_ELEMENT]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_ELEMENT}.is_not_in?
		do
			check
				another_definition: a ∉ s = s ∌ a
			then
				Result := True
			end
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
