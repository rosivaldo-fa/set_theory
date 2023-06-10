note
	description: "Implementation of {STP_EQUALITY_PROPERTIES}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	EQUALITY_PROPERTIES [A, EQ -> STS_EQUALITY [A] create default_create end]

inherit
	STP_EQUALITY_PROPERTIES [A, EQ]
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			-- <Precursor>
		do
			create set_properties
		end

feature -- Access

	current_universe: like set_properties.universe_anchor
			-- <Precursor>
		do
			Result := set_properties.current_universe
		end

	set_properties: SET_PROPERTIES [A, EQ]
			-- Object that checks whether the properties verified within set theory hold for an implementation of {STS_SET [A, EQ]}
;
note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	source: ""
end
