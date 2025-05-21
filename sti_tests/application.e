note
	description: "sti_tests application root class"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

create
	test_all

feature {NONE} -- Initialization

	test_all
			-- Run every available test.
		do
			(create {ELEMENT_TESTS}).test_all;
			(create {REFERENCE_EQUALITY_TESTS_DSCR}).test_all;
			(create {OBJECT_STANDARD_EQUALITY_TESTS_DSCR}).test_all;
--			(create {SET_TESTS_DSCR}).test_all;
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
