note
	description: "Test suite for {EFFECTIVE_INTEGER_NUMBER}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	EFFECTIVE_INTEGER_NUMBER_TESTS

inherit
	INTEGER_NUMBER_TESTS
		redefine
			test_all
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {EFFECTIVE_INTEGER_NUMBER}.
		note
			testing: "covers/{EFFECTIVE_INTEGER_NUMBER}"
		do
			Precursor {INTEGER_NUMBER_TESTS}
			test_default_create
			test_make
			test_make_from_reference
		end

feature -- Test routines (Initialization)

	test_default_create
			-- Test {EFFECTIVE_INTEGER_NUMBER}.default_create.
		note
			testing: "covers/{EFFECTIVE_INTEGER_NUMBER}.default_create"
		do
			assert ("default_create", attached (create {like integer_number_to_be_tested}))
		end

	test_make
			-- Test {EFFECTIVE_INTEGER_NUMBER}.make.
		note
			testing: "covers/{EFFECTIVE_INTEGER_NUMBER}.make"
		do
			assert ("make", attached (create {like integer_number_to_be_tested}.make (1)))
			assert ("integer_number_from_native", attached integer_number_from_native (1))
		end

	test_make_from_reference
			-- Test {EFFECTIVE_INTEGER_NUMBER}.make_from_reference.
		note
			testing: "covers/{EFFECTIVE_INTEGER_NUMBER}.make_from_reference"
		do
			assert ("make_from_reference", attached (create {like integer_number_to_be_tested}.make_from_reference (create {EFFECTIVE_INTEGER_NUMBER}.make (1))))
			assert ("integer_number_from_reference", attached integer_number_from_reference (create {EFFECTIVE_INTEGER_NUMBER}.make (1)))
		end

feature -- Factory (element to be tested)

	integer_number_to_be_tested: EFFECTIVE_INTEGER_NUMBER
			-- Integer number meant to be under tests
		once
			create Result
		ensure then
			class
		end

	integer_number_from_reference (i: INTEGER_NUMBER): like integer_number_to_be_tested
			-- `i' converted to an integer number like `integer_number_to_be_tested'
		do
			Result := i
		ensure
			class
--			same_integer_number: Result ≍ i -- TODO: Uncomment.
		end

feature -- Conversion

	integer_number_from_native (v: like native_integer_anchor): like integer_number_to_be_tested
			-- `v' converted to an integer number like `integer_number_to_be_tested'
		do
			Result := v
		ensure then
			class
			adjusted_value: Result.value = {like integer_number_to_be_tested}.adjusted_value (v)
		end

feature -- Anchor

	native_integer_anchor: INTEGER
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
