note
	description: "Test suite for {INTEGER_NUMBER}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

deferred class
	INTEGER_NUMBER_TESTS

inherit
	ELEMENT_TESTS
		rename
			test_is_in as test_element_is_in,
			test_is_not_in as test_element_is_not_in,
			element_to_be_tested as integer_number_to_be_tested,
			is_not_in_ok as element_is_not_in_ok
		undefine
			integer_number_to_be_tested
		end

note
	copyright: "Copyright (c) 2012-2026, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
