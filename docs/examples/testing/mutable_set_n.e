note
	description: "Summary description for {MUTABLE_SET_N}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MUTABLE_SET_N

inherit
	MUTABLE_SET [NATURAL, STS_OBJECT_EQUALITY [NATURAL]]

create
	make_empty,
	make_singleton

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/Set-Theory"
end
