note
	description: "test application root class"
	date: "$Date: 2019-09-11 18:27:54 +0000 (Wed, 11 Sep 2019) $"
	revision: "$Revision: 103504 $"

class
	APPLICATION

create
	test_all

feature  -- Initialization

	test_all
			-- Run every available test.
		local
			element_tests: ELEMENT_TESTS
			reference_equality_dscr_tests: REFERENCE_EQUALITY_DSCR_TESTS
		do
			create element_tests
			element_tests.test_all
			create reference_equality_dscr_tests
			reference_equality_dscr_tests.test_all
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	source: ""
end
