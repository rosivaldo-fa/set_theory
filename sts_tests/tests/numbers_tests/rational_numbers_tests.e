note
	description: "Test suite for {STS_RATIONAL_NUMBERS}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

deferred class
	RATIONAL_NUMBERS_TESTS

inherit
	RATIONAL_SET_TESTS
		rename
			set_to_be_tested as universe_to_be_tested
		undefine
			test_is_universe
		redefine
			test_all,
			universe_to_be_tested
		end

	UNIVERSE_TESTS [STS_RATIONAL_NUMBER]
		rename
			test_extended as test_set_extended,
			some_object_g as some_rational_number,
			object_deep_twin_g as object_deep_twin_pq,
			object_standard_twin_g as object_standard_twin_pq,
			object_twin_g as object_twin_pq,
			same_object_g as same_object_pq,
			some_equality_g as some_equality_pq,
			some_immediate_set_family_g as some_immediate_set_family_pq,
			some_immediate_set_g as some_immediate_set_pq,
			some_immediate_universe_g as some_immediate_universe_pq,
			some_object_deep_equality_g as some_object_deep_equality_pq,
			some_object_equality_g as some_object_equality_pq,
			some_object_standard_equality_g as some_object_standard_equality_pq,
			some_reference_equality_g as some_reference_equality_pq,
			some_set_family_g as some_set_family_pq,
			some_set_g as some_set_pq,
			some_universe_g as some_universe_pq,
			some_equality_sg as some_equality_spq,
			some_immediate_set_sg as some_immediate_set_spq,
			some_object_deep_equality_sg as some_object_deep_equality_spq,
			some_object_equality_sg as some_object_equality_spq,
			some_object_standard_equality_sg as some_object_standard_equality_spq,
			some_reference_equality_sg as some_reference_equality_spq,
			some_set_sg as some_set_spq
		undefine
			some_set_pq,
			some_universe_pq,
			some_equality_pq,
			some_reference_equality_pq,
			some_object_standard_equality_pq,
			some_object_equality_pq,
			some_object_deep_equality_pq
		redefine
			test_all,
			universe_to_be_tested
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {STS_RATIONAL_NUMBER}.
		note
			testing: "covers/{STS_RATIONAL_NUMBER}"
		do
			Precursor {RATIONAL_SET_TESTS}
			Precursor {UNIVERSE_TESTS}
		end

feature {NONE} -- Factory (element to be tested)

	universe_to_be_tested: like some_immediate_rational_universe
			-- Rational universe meant to be under tests
		do
			Result := some_immediate_rational_universe
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
