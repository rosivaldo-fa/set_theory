note
	description: "Test suite for {STS_INTEGER_SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

deferred class
	INTEGER_SET_TESTS

inherit
	SET_TESTS [STS_INTEGER_NUMBER]
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
		redefine
			test_all,
			some_set_i,
			some_universe_i,
			some_equality_i,
			some_reference_equality_i,
			some_object_standard_equality_i,
			some_object_equality_i,
			some_object_deep_equality_i
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {STS_INTEGER_SET}.
		note
			testing: "covers/{STS_INTEGER_SET}"
		do
			Precursor {SET_TESTS}
			test_extended
		end

feature -- Test routines (Construction)

	test_extended
			-- Test {STS_INTEGER_SET}.extended.
		note
			testing: "covers/{STS_INTEGER_SET}.extended"
		local
			s: like integer_set_to_be_tested
			i: like some_integer_number
		do
			s := integer_set_to_be_tested
			i := some_integer_number
			assert ("{i, ...}", s.extended (same_integer_number (i)) ∋ i)
		end

feature {NONE} -- Factory (element to be tested)

	integer_set_to_be_tested: like some_immediate_integer_set
			-- Integer set meant to be under tests
		do
			Result := some_immediate_integer_set
		end

feature -- Factory (integer number)

	some_set_i: STS_SET [STS_INTEGER_NUMBER]
			-- <Precursor>
		do
			inspect
				next_random_item \\ 3
			when 0 then
				Result := some_immediate_set_i
			when 1 then
				Result := some_universe_i
			when 2 then
				Result := some_integer_set
			end
		end

	some_universe_i: STS_UNIVERSE [STS_INTEGER_NUMBER]
			-- <Precursor>
		do
			inspect
				next_random_item \\ 2
			when 0 then
				Result := some_immediate_universe_i
			when 1 then
				Result := some_integer_universe
			end
		end

	some_equality_i: STS_EQUALITY [STS_INTEGER_NUMBER]
			-- <Precursor>
		do
			inspect
				next_random_item \\ 4
			when 0 then
				Result := some_reference_equality_i
			when 1 then
				Result := some_object_standard_equality_i
			when 2 then
				Result := some_object_equality_i
			when 3 then
				Result := some_object_deep_equality_i
			end
		end

	some_reference_equality_i: STS_REFERENCE_EQUALITY [STS_INTEGER_NUMBER]
			-- <Precursor>
		do
			check
				eq: attached {STS_REFERENCE_EQUALITY [STS_INTEGER_NUMBER]} some_immediate_instance
						(agent: STS_REFERENCE_EQUALITY [STS_INTEGER_NUMBER] do create Result end) as eq -- `some_immediate_instance' definition
				monomorphic: eq.generating_type ~ {detachable STS_REFERENCE_EQUALITY [STS_INTEGER_NUMBER]}
			then
				Result := eq
			end
		end

	some_object_standard_equality_i: STS_OBJECT_STANDARD_EQUALITY [STS_INTEGER_NUMBER]
			-- <Precursor>
		do
			check
				eq: attached {STS_OBJECT_STANDARD_EQUALITY [STS_INTEGER_NUMBER]} some_immediate_instance
						(agent: STS_OBJECT_STANDARD_EQUALITY [STS_INTEGER_NUMBER] do create Result end) as eq -- `some_immediate_instance' definition
				monomorphic: eq.generating_type ~ {detachable STS_OBJECT_STANDARD_EQUALITY [STS_INTEGER_NUMBER]}
			then
				Result := eq
			end
		end

	some_object_equality_i: STS_OBJECT_EQUALITY [STS_INTEGER_NUMBER]
			-- <Precursor>
		do
			check
				eq: attached {STS_OBJECT_EQUALITY [STS_INTEGER_NUMBER]} some_immediate_instance
						(agent: STS_OBJECT_EQUALITY [STS_INTEGER_NUMBER] do create Result end) as eq -- `some_immediate_instance' definition
				monomorphic: eq.generating_type ~ {detachable STS_OBJECT_EQUALITY [STS_INTEGER_NUMBER]}
			then
				Result := eq
			end
		end

	some_object_deep_equality_i: STS_OBJECT_DEEP_EQUALITY [STS_INTEGER_NUMBER]
			-- <Precursor>
		do
			check
				eq: attached {STS_OBJECT_DEEP_EQUALITY [STS_INTEGER_NUMBER]} some_immediate_instance
						(agent: STS_OBJECT_DEEP_EQUALITY [STS_INTEGER_NUMBER] do create Result end) as eq -- `some_immediate_instance' definition
				monomorphic: eq.generating_type ~ {detachable STS_OBJECT_DEEP_EQUALITY [STS_INTEGER_NUMBER]}
			then
				Result := eq
			end
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
