note
	description: "Resources for test classes with a {NATURAL} actual generic parameter"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TESTS_N

inherit
	ELEMENT_TESTS

feature -- Factory (Object)

	some_natural: NATURAL
			-- Randomly-created natural number
		do
			Result := (next_random_item \\ Max_count.as_integer_32).as_natural_32
		ensure
			class
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	source: ""
end
