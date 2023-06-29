note
	description: "{MUTABLE_SET} adapted to allow testing of restricted-access features"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	EXPOSED_MUTABLE_SET [A, EQ -> STS_EQUALITY [A] create default_create end]

inherit
	MUTABLE_SET [A, EQ]
		export {MUTABLE_SET_TESTS}
			elements
		end

create
	make_empty,
	make_singleton

create {MUTABLE_SET, MUTABLE_SET_TESTS}
	make_from_special

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/Set-Theory"
end
