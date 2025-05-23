﻿note
	description: "Test suite for {SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SET_TESTS [G]

inherit
	UNARY_TESTS [G]
		rename
			element_to_be_tested as set_to_be_tested
		redefine
			set_to_be_tested
		end

feature -- Test routines (Membership)

	test_has
			-- Test {SET}.has.
		note
			testing: "covers/{SET}.has"
		local
			a: G
			s: like set_to_be_tested
		do
			a := some_object_g
			s := set_to_be_tested
			assert ("has", s ∋ a ⇒ True)
		end

feature {NONE} -- Factory (element to be tested)

	set_to_be_tested: like some_immediate_set_g
			-- Set meant to be under tests
		do
			Result := some_immediate_set_g
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
