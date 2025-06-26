note
	description: "Object that checks whether the properties verified within set theory hold for an implementation of {STS_NATURAL_NUMBER}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NATURAL_NUMBER_PROPERTIES

feature -- Properties (Membership)

	is_not_in_ok (i: STS_NATURAL_NUMBER; s: STS_SET [STS_NATURAL_NUMBER]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_NATURAL_NUMBER}.is_not_in?
		do
			check
				another_definition: i ∉ s = s ∌ i
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
