note
	description: "Test suite for {STS_NATURAL_NUMBERS}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

deferred class
	NATURAL_NUMBERS_TESTS

inherit
	NATURAL_SET_TESTS
		rename
			set_to_be_tested as universe_to_be_tested
		undefine
			test_is_universe
		redefine
			test_all,
			universe_to_be_tested
		end

	UNIVERSE_TESTS [STS_NATURAL_NUMBER]
		rename
			test_extended as test_set_extended,
			some_object_g as some_natural_number,
			object_deep_twin_g as object_deep_twin_n,
			object_standard_twin_g as object_standard_twin_n,
			object_twin_g as object_twin_n,
			same_object_g as same_object_n,
			some_equality_g as some_equality_n,
			some_immediate_set_family_g as some_immediate_set_family_n,
			some_immediate_set_g as some_immediate_set_n,
			some_immediate_universe_g as some_immediate_universe_n,
			some_object_deep_equality_g as some_object_deep_equality_n,
			some_object_equality_g as some_object_equality_n,
			some_object_standard_equality_g as some_object_standard_equality_n,
			some_reference_equality_g as some_reference_equality_n,
			some_set_family_g as some_set_family_n,
			some_set_g as some_set_n,
			some_universe_g as some_universe_n,
			some_equality_sg as some_equality_sn,
			some_immediate_set_sg as some_immediate_set_sn,
			some_object_deep_equality_sg as some_object_deep_equality_sn,
			some_object_equality_sg as some_object_equality_sn,
			some_object_standard_equality_sg as some_object_standard_equality_sn,
			some_reference_equality_sg as some_reference_equality_sn,
			some_set_sg as some_set_sn
		undefine
			some_set_n,
			some_universe_n,
			some_equality_n,
			some_reference_equality_n,
			some_object_standard_equality_n,
			some_object_equality_n,
			some_object_deep_equality_n
		redefine
			test_all,
			universe_to_be_tested
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {STS_NATURAL_NUMBER}.
		note
			testing: "covers/{STS_NATURAL_NUMBER}"
		do
			Precursor {NATURAL_SET_TESTS}
			Precursor {UNIVERSE_TESTS}
		end

feature {NONE} -- Factory (element to be tested)

	universe_to_be_tested: like some_immediate_natural_universe
			-- Natural universe meant to be under tests
		do
			Result := some_immediate_natural_universe
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
