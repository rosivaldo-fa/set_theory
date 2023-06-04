note
	description: "Implementation of {REFERENCE_SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	REFERENCE_SET [A]

inherit
	STS_REFERENCE_SET [A]
		redefine
			subset_anchor
		end

	SET [A, STS_REFERENCE_EQUALITY [A]]
		redefine
			subset_anchor
		end

create
	make_empty,
	make_singleton

feature -- Anchor

	subset_anchor: REFERENCE_SET [A]
			-- <Precursor>
		do
			Result := Current
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	source: ""
end
