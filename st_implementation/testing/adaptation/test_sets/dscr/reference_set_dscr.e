note
	description: "SET derived for {detachable separate CHARACTER_REF}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	REFERENCE_SET_DSCR

inherit
	SET [detachable separate CHARACTER_REF, STS_REFERENCE_EQUALITY [detachable separate CHARACTER_REF]]

create
	make_empty,
	make_singleton

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	source: ""
end
