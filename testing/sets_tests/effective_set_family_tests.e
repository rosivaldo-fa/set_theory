note
	description: "Test suite for {EFFECTIVE_SET_FAMILY}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EFFECTIVE_SET_FAMILY_TESTS [G]

inherit
	SET_FAMILY_TESTS [G]
		redefine
			test_all
		end

	EFFECTIVE_SET_TESTS [SET [G]]
		rename
			test_make_extended as test_set_make_extended,
			set_to_be_tested as set_family_to_be_tested,
			exposed_set_to_be_tested as exposed_set_family_to_be_tested,
			a as s1,
			b as s2,
			c as s3,
			d as s4
		redefine
			test_all,
			test_set_make_extended,
			set_family_to_be_tested,
			exposed_set_family_to_be_tested
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {EFFECTIVE_SET_FAMILY}.
		note
			testing: "covers/{EFFECTIVE_SET_FAMILY}"
		do
			Precursor {SET_FAMILY_TESTS}
			Precursor {EFFECTIVE_SET_TESTS}
			test_make_extended
		end

feature -- Test routines (Initialization)

	test_set_make_extended
			-- Do nothing
		note
			testing: "covers/{EFFECTIVE_SET_FAMILY}.set_make_extended"
		do
		end

	test_make_extended
			-- Test {EFFECTIVE_SET_FAMILY}.make_extended.
		note
			testing: "covers/{EFFECTIVE_SET_FAMILY}.make_extended"
		do
			assert (
					"make_extended",
					attached (
						create {like set_family_to_be_tested}.make_extended (s1, create {REFERENCE_EQUALITY [SET [G]]}, set_family_to_be_tested)
					)
				)
		end

feature {NONE} -- Factory (element to be tested)

	set_family_to_be_tested: EFFECTIVE_SET_FAMILY [G]
			-- <Precursor>
		do
			create Result
		end

	exposed_set_family_to_be_tested: EXPOSED_SET_FAMILY [G]
			-- Exposed set family meant to be under tests
		do
			create Result
		end

note
	copyright: "Copyright (c) 2012-2026, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
