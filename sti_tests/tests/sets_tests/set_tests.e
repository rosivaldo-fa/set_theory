note
	description: "Test suite for {STI_SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SET_TESTS [G]

inherit
	STST_SET_TESTS [G]
		undefine
			default_create
		end

	ELEMENT_TESTS
		rename
			element_to_be_tested as set_to_be_tested
		undefine
			test_all,
			test_is_in,
			set_to_be_tested,
			some_element
		end

feature -- Test routines (Output)

	test_element_out
			-- Test {STI_SET}.element_out.
		note
			testing: "covers/{STI_SET}.element_out"
		local
			a: G
			s: like set_to_be_tested
		do
			a := some_object_g
			s := set_to_be_tested
			assert ("element_out", attached s.element_out (a))
		end

feature -- Factory (Set)

	some_immediate_set_g: STI_SET [G]
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
