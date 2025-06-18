note
	description: "Test suite for {STI_NATURAL_NUMBER}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	NATURAL_NUMBER_TESTS

inherit
	ELEMENT_TESTS

feature -- Test routines (Initialization)

	test_default_create
			-- Test {STI_NATURAL_NUMBER}.default_create.
		note
			testing: "covers/{STI_NATURAL_NUMBER}.default_create"
		do
			assert ("default_create", attached (create {like natural_to_be_tested}))
		end

feature {NONE} -- Factory (element to be tested)

	natural_to_be_tested: like some_expanded_natural
			-- Natural number meant to be under tests
		do
			Result := some_expanded_natural
		end

feature -- Factory (natural)

	some_expanded_natural: STI_NATURAL_NUMBER
			-- Randomly-fetched expanded natural number.
		do
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
