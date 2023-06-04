note
	description: "Pool of features available for test classes that need one generic parameter and its respective equality type"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	UNARY_TESTS [A, EQ -> STS_EQUALITY [A] create default_create end]

inherit
	ELEMENT_TESTS

feature -- Factory (Object)

	some_object_a: A
			-- Randomly-fetched object like {A}
		deferred
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	source: ""
end
