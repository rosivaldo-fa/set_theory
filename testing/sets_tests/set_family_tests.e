note
	description: "Test suite for {SET_FAMILY}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SET_FAMILY_TESTS [G]

inherit
	SET_TESTS [SET [G]]
		rename
			set_to_be_tested as set_family_to_be_tested,
			a as s1,
			b as s2,
			c as s3,
			d as s4
		end

feature {NONE} -- Factory (element to be tested)

	set_family_to_be_tested: SET_FAMILY [G]
			-- Set family meant to be under tests
		deferred
		end

note
	copyright: "Copyright (c) 2012-2026, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
