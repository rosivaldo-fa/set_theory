note
	description: "Test suite for {EFFECTIVE_NATURAL_NUMBER}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	EFFECTIVE_NATURAL_NUMBER_TESTS

inherit
	NATURAL_NUMBER_TESTS
		redefine
			test_all
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {EFFECTIVE_NATURAL_NUMBER}.
		note
			testing: "covers/{EFFECTIVE_NATURAL_NUMBER}"
		do
			Precursor {NATURAL_NUMBER_TESTS}
			test_default_create
			test_make
			test_make_from_reference
		end

feature -- Test routines (Initialization)

	test_default_create
			-- Test {EFFECTIVE_NATURAL_NUMBER}.default_create.
		note
			testing: "covers/{EFFECTIVE_NATURAL_NUMBER}.default_create"
		do
			assert ("default_create", attached (create {like natural_number_to_be_tested}))
		end

	test_make
			-- Test {EFFECTIVE_NATURAL_NUMBER}.make.
		note
			testing: "covers/{EFFECTIVE_NATURAL_NUMBER}.make"
		do
			assert ("make", attached (create {like natural_number_to_be_tested}.make (1)))
			assert ("natural_number_from_native", attached natural_number_from_native (1))
		end

	test_make_from_reference
			-- Test {EFFECTIVE_NATURAL_NUMBER}.make_from_reference.
		note
			testing: "covers/{EFFECTIVE_NATURAL_NUMBER}.make_from_reference"
		do
			assert ("make_from_reference", attached (create {like natural_number_to_be_tested}.make_from_reference (create {EFFECTIVE_NATURAL_NUMBER}.make (1))))
			assert ("natural_number_from_reference", attached natural_number_from_reference (create {EFFECTIVE_NATURAL_NUMBER}.make (1)))
		end

feature -- Factory (element to be tested)

	natural_number_to_be_tested: EFFECTIVE_NATURAL_NUMBER
			-- Natural number meant to be under tests
		once
			create Result
		ensure then
			class
		end

feature -- Conversion

	natural_number_from_native (v: like native_natural_anchor): like natural_number_to_be_tested
			-- `v' converted to a natural number like `natural_number_to_be_tested'
		do
			Result := v
		ensure
			class
			adjusted_value: Result.value = {like natural_number_to_be_tested}.adjusted_value (v)
		end

	natural_number_from_reference (n: NATURAL_NUMBER): like natural_number_to_be_tested
			-- `n' converted to a natural number like `natural_number_to_be_tested'
		do
			Result := n
		ensure
			class
--			same_natural_number: Result ≍ n
		end

feature -- Anchor

	native_natural_anchor: NATURAL
			-- <Precursor>
		do
		ensure then
			class
		end

note
	copyright: "Copyright (c) 2012-2026, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
