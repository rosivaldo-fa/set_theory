note
	description: "Test suite for {STI_COMPLEMENT_SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	COMPLEMENT_SET_TESTS [G]

inherit
	STST_SET_TESTS [G]
		undefine
			default_create
		redefine
			test_all
		end

	ELEMENT_TESTS
		rename
			is_not_in_ok as element_is_not_in_ok,
			test_is_in as test_element_is_in,
			test_is_not_in as test_element_is_not_in,
			element_to_be_tested as set_to_be_tested
		undefine
			test_element_is_in,
			test_element_is_not_in,
			set_to_be_tested,
			some_element
		redefine
			test_all
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {STI_COMPLEMENT_SET}.
		note
			testing: "covers/{STI_COMPLEMENT_SET}"
		do
			Precursor {STST_SET_TESTS}
		end

feature -- Factory (Set)

	some_immediate_complement_set_g: STI_COMPLEMENT_SET [G]
			-- <Precursor>
		deferred
		end

	some_immediate_set_sg: STI_SET [STS_SET [G]]
			-- <Precursor>
		deferred
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
