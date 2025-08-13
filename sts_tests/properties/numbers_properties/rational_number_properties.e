note
	description: "Object that checks whether the properties verified within set and number theory hold for an implementation of {STS_RATIONAL_NUMBER}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	RATIONAL_NUMBER_PROPERTIES

inherit
	ELEMENT_PROPERTIES
		rename
			is_not_in_ok as element_is_not_in_ok
		end

feature -- Properties (Membership)

	is_not_in_ok (pq: STS_RATIONAL_NUMBER; s: STS_SET [STS_RATIONAL_NUMBER]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_RATIONAL_NUMBER}.is_not_in?
		do
			check
				definition: pq ∉ s = s ∌ pq
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
