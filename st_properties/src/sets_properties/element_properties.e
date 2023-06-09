note
	description: "Object that checks whether the properties verified within set theory hold for an implementation of {STS_ELEMENT}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	ELEMENT_PROPERTIES

inherit
	STS_ELEMENT

feature -- Properties (Membership)

	is_in_ok (a: STS_ELEMENT; s: STS_SET [STS_ELEMENT, STS_EQUALITY [STS_ELEMENT]]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_ELEMENT}.is_in?
		note
			EIS: "name=Clickable view does not work for renamed classes.", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_properties.html#bug19884", "tag=bug, EiffelStudio"
		do
			check
				require_non_emptiness: a ∈ s ⇒ not s.is_empty
			then
				Result := True
			end
		end

	is_not_in_ok (a: STS_ELEMENT; s: STS_SET [STS_ELEMENT, STS_EQUALITY [STS_ELEMENT]]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_ELEMENT}.is_not_in?
		do
			check
				definition: a ∉ s = s ∌ a
				sufficient_emptiness: s.is_empty implies a ∉ s
			then
				Result := True
			end
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	source: ""
end
