note
	description: "Test suite for {STS_NATURAL_SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

deferred class
	NATURAL_SET_TESTS

inherit
	SET_TESTS [STS_NATURAL_NUMBER]
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
		redefine
			test_all,
			some_set_n,
			some_universe_n,
			some_equality_n,
			some_reference_equality_n,
			some_object_standard_equality_n,
			some_object_equality_n,
			some_object_deep_equality_n
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {STS_NATURAL_SET}.
		note
			testing: "covers/{STS_NATURAL_SET}"
		do
			Precursor {SET_TESTS}
			test_extended
		end

feature -- Test routines (Construction)

	test_extended
			-- Test {STS_NATURAL_SET}.extended.
		note
			testing: "covers/{STS_NATURAL_SET}.extended"
		local
			s: like natural_set_to_be_tested
			n: like some_natural_number
		do
			s := natural_set_to_be_tested
			n := some_natural_number
			assert ("{n, ...}", s.extended (same_natural_number (n)) ∋ n)
		end

feature {NONE} -- Factory (element to be tested)

	natural_set_to_be_tested: like some_immediate_natural_set
			-- Natural set meant to be under tests
		do
			Result := some_immediate_natural_set
		end

feature -- Factory (natural number)

	some_set_n: STS_SET [STS_NATURAL_NUMBER]
			-- <Precursor>
		do
			inspect
				next_random_item \\ 4
			when 0 then
				Result := some_immediate_set_n
			when 1 then
				Result := some_universe_n
			when 2 then
				Result := some_natural_set
			end
		end

	some_universe_n: STS_UNIVERSE [STS_NATURAL_NUMBER]
			-- <Precursor>
		do
			inspect
				next_random_item \\ 2
			when 0 then
				Result := some_immediate_universe_n
			when 1 then
				Result := some_natural_universe
			end
		end

	some_equality_n: STS_EQUALITY [STS_NATURAL_NUMBER]
			-- <Precursor>
		do
			inspect
				next_random_item \\ 4
			when 0 then
				Result := some_reference_equality_n
			when 1 then
				Result := some_object_standard_equality_n
			when 2 then
				Result := some_object_equality_n
			when 3 then
				Result := some_object_deep_equality_n
			end
		end

	some_reference_equality_n: STS_REFERENCE_EQUALITY [STS_NATURAL_NUMBER]
			-- <Precursor>
		do
			check
				eq: attached {STS_REFERENCE_EQUALITY [STS_NATURAL_NUMBER]} some_immediate_instance
						(agent: STS_REFERENCE_EQUALITY [STS_NATURAL_NUMBER] do create Result end) as eq -- `some_immediate_instance' definition
				monomorphic: eq.generating_type ~ {detachable STS_REFERENCE_EQUALITY [STS_NATURAL_NUMBER]}
			then
				Result := eq
			end
		end

	some_object_standard_equality_n: STS_OBJECT_STANDARD_EQUALITY [STS_NATURAL_NUMBER]
			-- <Precursor>
		do
			check
				eq: attached {STS_OBJECT_STANDARD_EQUALITY [STS_NATURAL_NUMBER]} some_immediate_instance
						(agent: STS_OBJECT_STANDARD_EQUALITY [STS_NATURAL_NUMBER] do create Result end) as eq -- `some_immediate_instance' definition
				monomorphic: eq.generating_type ~ {detachable STS_OBJECT_STANDARD_EQUALITY [STS_NATURAL_NUMBER]}
			then
				Result := eq
			end
		end

	some_object_equality_n: STS_OBJECT_EQUALITY [STS_NATURAL_NUMBER]
			-- <Precursor>
		do
			check
				eq: attached {STS_OBJECT_EQUALITY [STS_NATURAL_NUMBER]} some_immediate_instance
						(agent: STS_OBJECT_EQUALITY [STS_NATURAL_NUMBER] do create Result end) as eq -- `some_immediate_instance' definition
				monomorphic: eq.generating_type ~ {detachable STS_OBJECT_EQUALITY [STS_NATURAL_NUMBER]}
			then
				Result := eq
			end
		end

	some_object_deep_equality_n: STS_OBJECT_DEEP_EQUALITY [STS_NATURAL_NUMBER]
			-- <Precursor>
		do
			check
				eq: attached {STS_OBJECT_DEEP_EQUALITY [STS_NATURAL_NUMBER]} some_immediate_instance
						(agent: STS_OBJECT_DEEP_EQUALITY [STS_NATURAL_NUMBER] do create Result end) as eq -- `some_immediate_instance' definition
				monomorphic: eq.generating_type ~ {detachable STS_OBJECT_DEEP_EQUALITY [STS_NATURAL_NUMBER]}
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
