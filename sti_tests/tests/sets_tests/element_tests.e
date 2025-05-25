note
	description: "Implementation of {STST_ELEMENT_TESTS}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	ELEMENT_TESTS

inherit
	STST_ELEMENT_TESTS
		undefine
			default_create
		redefine
			test_all,
			test_is_in
		end

	EQA_TEST_SET

feature -- Test routines (All)

	test_all
			-- <Precursor>
		note
			testing: "covers/{STS_ELEMENT}"
		do
			Precursor {STST_ELEMENT_TESTS}
		end

feature -- Test routines (Membership)

	test_is_in
			-- <Precursor>
		note
			testing: "covers/{STS_ELEMENT}.is_in"
		do
			Precursor {STST_ELEMENT_TESTS}
		end

feature -- Factory (Separate character reference)

	some_separate_character_ref: detachable separate CHARACTER_REF
			-- Randomly-fetched polymorphic separate character reference
		do
			inspect
				next_random_item \\ 2
			when 0 then
				Result := some_immediate_separate_character_ref
			when 1 then
				Result := some_character_ref
			end
		end

	some_immediate_separate_character_ref: like some_separate_character_ref
			-- Randomly-fetched monomorphic separate character reference
		local
			obj: like some_immediate_instance
		do
--			from
--				obj := some_immediate_instance (new_c)
--			until
--				attached obj -- TODO: System crashes when an agent gets a "separate" Void actual argument.
--			loop
--				obj := some_immediate_instance (new_c)
--			end
			obj := some_immediate_instance (agent new_separate_character_ref)
			if attached obj then
				Result := {like new_separate_character_ref} / obj
				check
						-- `some_immediate_instance' and `new_separate_character_ref' definitions
					right_type: attached Result
					monomorphic: object_is_immediate_instance (Result, {like new_separate_character_ref})
				end
			end
		ensure
--			monomorphic: attached Result implies object_is_immediate_instance (Result, {like some_character_ref}) -- TODO: why not?
			monomorphic: attached Result implies object_is_immediate_instance (Result, {like new_separate_character_ref})
		end

	new_separate_character_ref: like some_immediate_separate_character_ref
			-- Randomly-created monomorphic separate character reference
		local
			c_ref: like new_separate_character_ref
		do
			create c_ref
			separate c_ref as sep_c_ref do
				sep_c_ref.set_item (some_character)
			end
			Result := c_ref
		ensure
			class
			monomorphic: attached Result implies object_is_immediate_instance (Result, {like some_immediate_separate_character_ref})
		end

	some_character_ref: detachable CHARACTER_REF
			-- Randomly-fetched polymorphic character reference
		do
			inspect
				next_random_item \\ 2
			when 0 then
				Result := some_immediate_character_ref
			when 1 then
				Result := some_character
			end
		end

	some_immediate_character_ref: like some_character_ref
			-- Randomly-fetched monomorphic character reference
		local
--			new_c: FUNCTION [like new_character_ref]
			obj: like some_immediate_instance
		do
--			new_c := agent new_character_ref
--			from
			obj := some_immediate_instance (agent new_character_ref)
--			until
--				attached obj -- TODO: System crashes when an agent gets a "separate" Void actual argument.
--			loop
--				obj := some_immediate_instance (new_c)
--			end
			if attached obj then
				Result := {like new_character_ref} / obj
				check
						-- `some_immediate_instance' and `new_character_ref' definitions
					right_type: attached Result
					monomorphic: object_is_immediate_instance (Result, {like new_character_ref})
				end
			end
		ensure
--			monomorphic: attached Result implies object_is_immediate_instance (Result, {like some_character_ref}) -- TODO: why not?
			monomorphic: attached Result implies object_is_immediate_instance (Result, {like new_character_ref})
		end

	new_character_ref: like some_immediate_character_ref
			-- Randomly-created monomorphic character reference
		do
			create Result
			Result.set_item (some_character)
		ensure
			class
			monomorphic: attached Result implies object_is_immediate_instance (Result, {like some_immediate_character_ref})
		end

	some_character: CHARACTER
			-- Randomly-created character
		local
			n: NATURAL
		do
			n := some_index
			check
				valid_character:
						-- 0 < n ≤ Max_count ⇐ `some_index' definition
						-- class invariant: (Min_character.natural_32_code + Max_count - 1).is_valid_character_8_code
					(Min_character.natural_32_code + n - 1).is_valid_character_8_code
			end
			Result := (Min_character.natural_32_code + n - 1).to_character_8
		ensure
			class
		end

feature -- Factory (Element)

	some_elements: STI_SET [STS_ELEMENT]
			-- <Precursor>
		do
			across
				1 |..| some_count.as_integer_32 as i
			from
				create Result
			loop
				Result := Result.extended (some_element, some_element_equality)
			end
		end

feature -- Factory (Equality)

	some_equality_dscr: STS_EQUALITY [detachable separate CHARACTER_REF]
			-- Randomly-fetched polymorphic equality for comparing {detachable separate CHARACTER_REF} instances
		do
			inspect
				next_random_item \\ 1
			when 0 then
				Result := some_reference_equality_dscr
			end
		end

	some_reference_equality_dscr: STS_REFERENCE_EQUALITY [detachable separate CHARACTER_REF]
			-- Randomly-fetched instance of {STS_REFERENCE_EQUALITY [detachable separate CHARACTER_REF]}
		do
			check
				eq: attached {STS_REFERENCE_EQUALITY [detachable separate CHARACTER_REF]} some_immediate_instance
						(agent: STS_REFERENCE_EQUALITY [detachable separate CHARACTER_REF] do create Result end) as eq -- `some_immediate_instance' definition
				monomorphic: eq.generating_type ~ {detachable STS_REFERENCE_EQUALITY [detachable separate CHARACTER_REF]}
			then
				Result := eq
			end
		end

	some_object_standard_equality_dscr: STS_OBJECT_STANDARD_EQUALITY [detachable separate CHARACTER_REF]
			-- Randomly-fetched instance of {STS_OBJECT_STANDARD_EQUALITY [detachable separate CHARACTER_REF]}
		do
			check
				eq: attached {STS_OBJECT_STANDARD_EQUALITY [detachable separate CHARACTER_REF]} some_immediate_instance
						(agent: STS_OBJECT_STANDARD_EQUALITY [detachable separate CHARACTER_REF] do create Result end) as eq -- `some_immediate_instance' definition
				monomorphic: eq.generating_type ~ {detachable STS_OBJECT_STANDARD_EQUALITY [detachable separate CHARACTER_REF]}
			then
				Result := eq
			end
		end

	some_object_equality_dscr: STS_OBJECT_EQUALITY [detachable separate CHARACTER_REF]
			-- Randomly-fetched instance of {STS_OBJECT_EQUALITY [detachable separate CHARACTER_REF]}
		do
			check
				eq: attached {STS_OBJECT_EQUALITY [detachable separate CHARACTER_REF]} some_immediate_instance
						(agent: STS_OBJECT_EQUALITY [detachable separate CHARACTER_REF] do create Result end) as eq -- `some_immediate_instance' definition
				monomorphic: eq.generating_type ~ {detachable STS_OBJECT_EQUALITY [detachable separate CHARACTER_REF]}
			then
				Result := eq
			end
		end

	some_object_deep_equality_dscr: STS_OBJECT_DEEP_EQUALITY [detachable separate CHARACTER_REF]
			-- Randomly-fetched instance of {STS_OBJECT_DEEP_EQUALITY [detachable separate CHARACTER_REF]}
		do
			check
				eq: attached {STS_OBJECT_DEEP_EQUALITY [detachable separate CHARACTER_REF]} some_immediate_instance
						(agent: STS_OBJECT_DEEP_EQUALITY [detachable separate CHARACTER_REF] do create Result end) as eq -- `some_immediate_instance' definition
				monomorphic: eq.generating_type ~ {detachable STS_OBJECT_DEEP_EQUALITY [detachable separate CHARACTER_REF]}
			then
				Result := eq
			end
		end

feature -- Factory (Set)

	some_set_dscr: STS_SET [detachable separate CHARACTER_REF]
			-- Randomly-fetched polymorphic set of separate character references
		do
			inspect
				next_random_item \\ 1
			when 0 then
				Result := some_immediate_set_dscr
			end
		end

	some_immediate_set_dscr: STI_SET [detachable separate CHARACTER_REF]
			-- Randomly-fetched monomorphic set of separate character references
		do
			check
				s: attached {STI_SET [detachable separate CHARACTER_REF]} some_immediate_instance (
							agent: STI_SET [detachable separate CHARACTER_REF]
								do
									across
										1 |..| some_count.as_integer_32 as i
									from
										create Result
									loop
										Result := Result.extended (some_separate_character_ref, some_equality_dscr)
									end
								end
						) as s -- `some_immediate_instance' definition
				monomorphic: s.generating_type ~ {detachable STI_SET [detachable separate CHARACTER_REF]}
			then
				Result := cropped_set (s)
			end
		ensure
			monomorphic: Result.generating_type ~ {detachable STI_SET [detachable separate CHARACTER_REF]}
		end

	cropped_set (s: STS_SET [detachable separate ANY]): like s
			-- `s' striped from as many elements as necessary to keep its cardinality at most `Max_count'
		local
--			cropped_s: STS_SET [detachable separate ANY, STS_EQUALITY [detachable separate ANY]]
--			n: NATURAL
		do
--			n := # s
--			if n ≤ Max_count then
			Result := s
--			else
--				if n > max_asserted_elements then
--					chk_cropp := {ISE_RUNTIME}.check_assert (False)
--				end
--					cropped_s := trimmed_n_tuple (s.as_tuple).terms
--					Result := s.o ∪ cropped_s
--				if chk_cropp then
--					chk_cropp := {ISE_RUNTIME}.check_assert (True)
--				end
--			end
		ensure
--			small_enough: # Result ≤ Max_count
--			no_change: # s ≤ Max_count implies Result ≍ s
--			cropped: Result ⊆ s
		end

--	some_set_of_standard_objects_dscr: STS_SET [detachable separate CHARACTER_REF]
--			-- Randomly-fetched polymorphic set of separate character references
--		do
--			inspect
--				next_random_item \\ 1
--			when 0 then
--				Result := some_immediate_set_of_standard_objects_dscr
--			end
--		end

	some_immediate_set_of_standard_objects_dscr: STI_SET [detachable separate CHARACTER_REF]
			-- Randomly-fetched monomorphic set of separate character references
		do
			check
				s: attached {STI_SET [detachable separate CHARACTER_REF]} some_immediate_instance (
							agent: STI_SET [detachable separate CHARACTER_REF]
								do
									across
										1 |..| some_count.as_integer_32 as i
									from
										create Result
									loop
										Result := Result.extended (some_separate_character_ref, some_equality_dscr)
									end
								end
						) as s -- `some_immediate_instance' definition
				monomorphic: s.generating_type ~ {detachable STI_SET [detachable separate CHARACTER_REF]}
			then
				Result := cropped_set (s)
			end
		ensure
			monomorphic: Result.generating_type ~ {detachable STI_SET [detachable separate CHARACTER_REF]}
		end

	some_set_of_objects_dscr: STS_SET [detachable separate CHARACTER_REF]
			-- Randomly-fetched polymorphic set of separate character references
		do
			inspect
				next_random_item \\ 2
			when 0 then
				Result := some_immediate_set_of_standard_objects_dscr
			when 1 then
				Result := some_immediate_set_of_standard_objects_dscr
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
