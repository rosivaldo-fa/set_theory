note
	description: "Test suite for {STS_INTEGER_NUMBERS}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

deferred class
	INTEGER_NUMBERS_TESTS

inherit
	INTEGER_SET_TESTS
		rename
			set_to_be_tested as universe_to_be_tested
		undefine
			test_is_universe
		redefine
			test_all,
			universe_to_be_tested
		end

	UNIVERSE_TESTS [STS_INTEGER_NUMBER]
		rename
			test_extended as test_set_extended,
			some_object_g as some_integer_number,
			object_deep_twin_g as object_deep_twin_i,
			object_standard_twin_g as object_standard_twin_i,
			object_twin_g as object_twin_i,
			same_object_g as same_object_i,
			some_equality_g as some_equality_i,
			some_immediate_set_family_g as some_immediate_set_family_i,
			some_immediate_set_g as some_immediate_set_i,
			some_immediate_universe_g as some_immediate_universe_i,
			some_object_deep_equality_g as some_object_deep_equality_i,
			some_object_equality_g as some_object_equality_i,
			some_object_standard_equality_g as some_object_standard_equality_i,
			some_reference_equality_g as some_reference_equality_i,
			some_set_family_g as some_set_family_i,
			some_set_g as some_set_i,
			some_universe_g as some_universe_i,
			some_equality_sg as some_equality_si,
			some_immediate_set_sg as some_immediate_set_si,
			some_object_deep_equality_sg as some_object_deep_equality_si,
			some_object_equality_sg as some_object_equality_si,
			some_object_standard_equality_sg as some_object_standard_equality_si,
			some_reference_equality_sg as some_reference_equality_si,
			some_set_sg as some_set_si
		undefine
			some_set_i,
			some_universe_i,
			some_equality_i,
			some_reference_equality_i,
			some_object_standard_equality_i,
			some_object_equality_i,
			some_object_deep_equality_i
		redefine
			test_all,
			universe_to_be_tested
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {STS_INTEGER_NUMBER}.
		note
			testing: "covers/{STS_INTEGER_NUMBER}"
		do
			Precursor {INTEGER_SET_TESTS}
			Precursor {UNIVERSE_TESTS}
		end

feature {NONE} -- Factory (element to be tested)

	universe_to_be_tested: like some_immediate_integer_universe
			-- Integer universe meant to be under tests
		do
			Result := some_immediate_integer_universe
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
