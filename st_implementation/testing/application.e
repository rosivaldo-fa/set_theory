note
	description: "test application root class"
	date: "$Date: 2019-09-11 18:27:54 +0000 (Wed, 11 Sep 2019) $"
	revision: "$Revision: 103504 $"

class
	APPLICATION

create
	test_all

feature {NONE} -- Initialization

	test_all
			-- Run every available test.
		do
			(create {ELEMENT_TESTS}).test_all;
			(create {REFERENCE_EQUALITY_DSCR_TESTS}).test_all;
			(create {OBJECT_EQUALITY_DSCR_TESTS}).test_all;
			(create {OBJECT_STANDARD_EQUALITY_DSCR_TESTS}).test_all;
			(create {OBJECT_DEEP_EQUALITY_DSCR_TESTS}).test_all;
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	source: ""
end
