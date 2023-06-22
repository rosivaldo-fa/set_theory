note
	description: "Test suite for {STS_ELEMENT}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	ELEMENT_TESTS

inherit
	STS_ELEMENT
		undefine
			default_create
		end

	EQA_TEST_SET
		redefine
			on_prepare
		end

feature -- Access

	properties: STP_ELEMENT_PROPERTIES

feature {NONE} -- Events

	on_prepare
			-- <Precursor>
		do
			Precursor {EQA_TEST_SET}
			create properties
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {STS_ELEMENT}.
		note
			testing: "covers/{STS_ELEMENT}"
		do
			test_is_in
			test_is_not_in
		end

feature -- Test routines (Membership)

	test_is_in
			-- Test {STS_ELEMENT}.is_in.
		note
			testing: "covers/{STS_ELEMENT}.is_in"
		local
			a: like element_to_be_tested
			s: like some_elements
		do
			a := element_to_be_tested
			s := new_element_references & a
			assert ("a ∈ s", a ∈ s)
			assert ("a ∈ s ok", properties.is_in_ok (a, s))

			s := s / a
			assert ("not (a ∈ s)", not (a ∈ s))
			assert ("not (a ∈ s) ok", properties.is_in_ok (a, s))

			s := new_element_standard_objects & a.standard_twin
			assert ("a.standard_twin ∈ s", a ∈ s)
			assert ("a.standard_twin ∈ s ok", properties.is_in_ok (a, s))

			s := s / a.standard_twin
			assert ("not (a.standard_twin ∈ s)", not (a ∈ s))
			assert ("not (a.standard_twin ∈ s) ok", properties.is_in_ok (a, s))

			s := new_element_objects & a.twin
			assert ("a.twin ∈ s", a ∈ s)
			assert ("a.twin ∈ s ok", properties.is_in_ok (a, s))

			s := s / a.twin
			assert ("not (a.twin ∈ s)", not (a ∈ s))
			assert ("not (a.twin ∈ s) ok", properties.is_in_ok (a, s))

			s := new_element_deep_objects & a.deep_twin
			assert ("a.deep_twin ∈ s", a ∈ s)
			assert ("a.deep_twin ∈ s ok", properties.is_in_ok (a, s))

			s := s / a.deep_twin
			assert ("not (a.deep_twin ∈ s)", not (a ∈ s))
			assert ("not (a.deep_twin ∈ s) ok", properties.is_in_ok (a, s))

			s := some_elements
			assert ("is_in", a ∈ s ⇒ True)
			assert ("is_in_ok", properties.is_in_ok (a, s))
		end

	test_is_not_in
			-- Test {STS_ELEMENT}.is_not_in.
		note
			testing: "covers/{STS_ELEMENT}.is_not_in"
		local
			a: like element_to_be_tested
			s: like some_elements
		do
			a := element_to_be_tested
			s := new_element_references / a
			assert ("a ∉ s", a ∉ s)
			assert ("a ∉ s ok", properties.is_not_in_ok (a, s))

			s := s & a
			assert ("not (a ∉ s)", not (a ∉ s))
			assert ("not (a ∉ s) ok", properties.is_not_in_ok (a, s))

			s := new_element_standard_objects / a.standard_twin
			assert ("a.standard_twin ∉ s", a ∉ s)
			assert ("a.standard_twin ∉ s ok", properties.is_not_in_ok (a, s))

			s := s & a.standard_twin
			assert ("not (a.standard_twin ∉ s)", not (a ∉ s))
			assert ("not (a.standard_twin ∉ s) ok", properties.is_not_in_ok (a, s))

			s := new_element_objects / a.twin
			assert ("a.twin ∉ s", a ∉ s)
			assert ("a.twin ∉ s ok", properties.is_not_in_ok (a, s))

			s := s & a.twin
			assert ("not (a.twin ∉ s)", not (a ∉ s))
			assert ("not (a.twin ∉ s) ok", properties.is_not_in_ok (a, s))

			s := new_element_deep_objects / a.deep_twin
			assert ("a.deep_twin ∉ s", a ∉ s)
			assert ("a.deep_twin ∉ s ok", properties.is_not_in_ok (a, s))

			s := s & a.deep_twin
			assert ("not (a.deep_twin ∉ s)", not (a ∉ s))
			assert ("not (a.deep_twin ∉ s) ok", properties.is_not_in_ok (a, s))

			s := some_elements
			assert ("is_not_in", a ∉ s ⇒ True)
			assert ("is_not_in_ok", properties.is_not_in_ok (a, s))
		end

feature {NONE} -- Factory (Element to be tested)

	element_to_be_tested: like some_immediate_element
			-- Element meant to be under tests
		do
			Result := some_immediate_element
		ensure
			monomorphic: Result.generating_type ~ {detachable like element_to_be_tested}
		end

feature -- Factory (Integer reference)

	some_integer_ref: detachable INTEGER_REF
			-- Randomly-fetched polymorphic integer-number reference
		do
			inspect next_random_item \\ 2
			when 0 then
				Result := some_immediate_integer_ref
			when 1 then
				Result := some_integer
			end
		end

	some_immediate_integer_ref: like some_integer_ref
			-- Randomly-fetched monomorphic integer-number reference
		local
			obj: like some_immediate_instance
			new_i: FUNCTION [like new_integer_ref]
		do
			new_i := agent new_integer_ref
			obj := some_immediate_instance (new_i)
			if attached obj then
				Result := {like new_integer_ref} / obj
				check
						-- `some_immediate_instance' and `new_integer_ref' definitions
					right_type: attached Result
					monomorphic: Result.generating_type ~ {like new_integer_ref}
				end
			end
		ensure
			monomorphic: attached Result implies Result.generating_type ~ {like some_integer_ref}
		end

	new_integer_ref: like some_immediate_integer_ref
			-- Randomly-created monomorphic integer-number reference
		do
			Result := some_integer.to_reference
		ensure
			class
			monomorphic: attached Result implies Result.generating_type ~ {like some_immediate_integer_ref}
		end

	some_integer: INTEGER
			-- Randomly-created integer number
		do
			Result := next_random_item \\ Max_count.as_integer_32 - Max_count.as_integer_32 // 2
		ensure
			class
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

feature -- Factory (Object)

	some_natural: NATURAL
			-- Randomly-created natural number
		do
			Result := (next_random_item \\ Max_count.as_integer_32).as_natural_32
		ensure
			class
		end

feature -- Factory (Element)

	some_element: STS_ELEMENT
			-- Randomly-fetched polymorphic element
		do
			inspect
				next_random_item \\ 3
			when 0 then
				Result := some_immediate_element
			when 1 then
				Result := some_equality
			when 2 then
				Result := some_set
			end
		end

	some_immediate_element: like some_element
			-- Randomly-fetched monomorphic element
		do
			check
					-- `some_immediate_instance' and `new_element' definitions
				a: attached {like new_element} some_immediate_instance (agent new_element) as a
				monomorphic: a.generating_type ~ {detachable like new_element}
			then
				Result := a
			end
		ensure
			monomorphic: Result.generating_type ~ {detachable like some_element}
		end

	new_element: like some_immediate_element
			-- Randomly-created monomorphic element
		do
			create Result
		ensure
			class
			monomorphic: Result.generating_type ~ {detachable like some_immediate_element}
		end

	some_elements: STS_SET [STS_ELEMENT, STS_EQUALITY [STS_ELEMENT]]
			-- Randomly-fetched polymorphic set of elements
		do
			inspect
				next_random_item \\ 4
			when 0 then
				Result := new_element_references
			when 1 then
				Result := new_element_standard_objects
			when 2 then
				Result := new_element_objects
			when 3 then
				Result := new_element_deep_objects
			end
		end

	new_element_references: MUTABLE_SET [STS_ELEMENT, STS_REFERENCE_EQUALITY [STS_ELEMENT]]
			-- Randomly-created set of elements compared by referece equality
		do
			across
				1 |..| some_count.as_integer_32 as i
			from
				create Result.make_empty
			loop
				Result := Result & some_element
			end
		end

	new_element_standard_objects: MUTABLE_SET [STS_ELEMENT, STS_OBJECT_STANDARD_EQUALITY [STS_ELEMENT]]
			-- Randomly-created set of elements compared by object standard equality
		do
			across
				1 |..| some_count.as_integer_32 as i
			from
				create Result.make_empty
			loop
				Result := Result & some_element
			end
		end

	new_element_objects: MUTABLE_SET [STS_ELEMENT, STS_OBJECT_EQUALITY [STS_ELEMENT]]
			-- Randomly-created set of elements compared by object equality
		do
			across
				1 |..| some_count.as_integer_32 as i
			from
				create Result.make_empty
			loop
				Result := Result & some_element
			end
		end

	new_element_deep_objects: MUTABLE_SET [STS_ELEMENT, STS_OBJECT_DEEP_EQUALITY [STS_ELEMENT]]
			-- Randomly-created set of elements compared by object deep equality
		do
			across
				1 |..| some_count.as_integer_32 as i
			from
				create Result.make_empty
			loop
				Result := Result & some_element
			end
		end

feature -- Factory (Equality)

	some_equality: STS_EQUALITY [detachable separate ANY]
			-- Randomly-fetched polymorphic equality
		do
			inspect
				next_random_item \\ 4
			when 0 then
				Result := some_reference_equality
			when 1 then
				Result := some_object_standard_equality
			when 2 then
				Result := some_object_equality
			when 3 then
				Result := some_object_deep_equality
			end
		end

	some_reference_equality: STS_REFERENCE_EQUALITY [detachable separate ANY]
			-- Randomly-fetched polymorphic reference equality
		do
			inspect
				next_random_item \\ 3
			when 0 then
				Result := some_reference_equality_dir
			when 1 then
				Result := some_reference_equality_dscr
			when 2 then
				Result := some_reference_equality_n
			end
		end

	some_reference_equality_dir: STS_REFERENCE_EQUALITY [detachable INTEGER_REF]
			-- Randomly-fetched instance of {STS_REFERENCE_EQUALITY [detachable INTEGER_REF]}
		do
			check
				eq: attached {STS_REFERENCE_EQUALITY [detachable INTEGER_REF]} some_immediate_instance
						(agent: STS_REFERENCE_EQUALITY [detachable INTEGER_REF] do create Result end) as eq -- `some_immediate_instance' definition
				monomorphic: eq.generating_type ~ {detachable STS_REFERENCE_EQUALITY [detachable INTEGER_REF]}
			then
				Result := eq
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

	some_reference_equality_n: STS_REFERENCE_EQUALITY [NATURAL]
			-- Randomly-fetched instance of {STS_REFERENCE_EQUALITY [NATURAL]}
		do
			check
				eq: attached {STS_REFERENCE_EQUALITY [NATURAL]} some_immediate_instance
						(agent: STS_REFERENCE_EQUALITY [NATURAL] do create Result end) as eq -- `some_immediate_instance' definition
				monomorphic: eq.generating_type ~ {detachable STS_REFERENCE_EQUALITY [NATURAL]}
			then
				Result := eq
			end
		end

	some_object_standard_equality: STS_OBJECT_STANDARD_EQUALITY [detachable separate ANY]
			-- Randomly-fetched polymorphic reference equality
		do
			inspect
				next_random_item \\ 3
			when 0 then
				Result := some_object_standard_equality_dir
			when 1 then
				Result := some_object_standard_equality_dscr
			when 2 then
				Result := some_object_standard_equality_n
			end
		end

	some_object_standard_equality_dir: STS_OBJECT_STANDARD_EQUALITY [detachable INTEGER_REF]
			-- Randomly-fetched instance of {STS_OBJECT_STANDARD_EQUALITY [detachable INTEGER_REF]}
		do
			check
				eq: attached {STS_OBJECT_STANDARD_EQUALITY [detachable INTEGER_REF]} some_immediate_instance
						(agent: STS_OBJECT_STANDARD_EQUALITY [detachable INTEGER_REF] do create Result end) as eq -- `some_immediate_instance' definition
				monomorphic: eq.generating_type ~ {detachable STS_OBJECT_STANDARD_EQUALITY [detachable INTEGER_REF]}
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

	some_object_standard_equality_n: STS_OBJECT_STANDARD_EQUALITY [NATURAL]
			-- Randomly-fetched instance of {STS_OBJECT_STANDARD_EQUALITY [NATURAL]}
		do
			check
				eq: attached {STS_OBJECT_STANDARD_EQUALITY [NATURAL]} some_immediate_instance
						(agent: STS_OBJECT_STANDARD_EQUALITY [NATURAL] do create Result end) as eq -- `some_immediate_instance' definition
				monomorphic: eq.generating_type ~ {detachable STS_OBJECT_STANDARD_EQUALITY [NATURAL]}
			then
				Result := eq
			end
		end

	some_object_equality: STS_OBJECT_EQUALITY [detachable separate ANY]
			-- Randomly-fetched polymorphic reference equality
		do
			inspect
				next_random_item \\ 3
			when 0 then
				Result := some_object_equality_dir
			when 1 then
				Result := some_object_equality_dscr
			when 2 then
				Result := some_object_equality_n
			end
		end

	some_object_equality_dir: STS_OBJECT_EQUALITY [detachable INTEGER_REF]
			-- Randomly-fetched instance of {STS_OBJECT_EQUALITY [detachable INTEGER_REF]}
		do
			check
				eq: attached {STS_OBJECT_EQUALITY [detachable INTEGER_REF]} some_immediate_instance
						(agent: STS_OBJECT_EQUALITY [detachable INTEGER_REF] do create Result end) as eq -- `some_immediate_instance' definition
				monomorphic: eq.generating_type ~ {detachable STS_OBJECT_EQUALITY [detachable INTEGER_REF]}
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

	some_object_equality_n: STS_OBJECT_EQUALITY [NATURAL]
			-- Randomly-fetched instance of {STS_OBJECT_EQUALITY [NATURAL]}
		do
			check
				eq: attached {STS_OBJECT_EQUALITY [NATURAL]} some_immediate_instance
						(agent: STS_OBJECT_EQUALITY [NATURAL] do create Result end) as eq -- `some_immediate_instance' definition
				monomorphic: eq.generating_type ~ {detachable STS_OBJECT_EQUALITY [NATURAL]}
			then
				Result := eq
			end
		end

	some_object_deep_equality: STS_OBJECT_DEEP_EQUALITY [detachable separate ANY]
			-- Randomly-fetched polymorphic reference equality
		do
			inspect
				next_random_item \\ 3
			when 0 then
				Result := some_object_deep_equality_dir
			when 1 then
				Result := some_object_deep_equality_dscr
			when 2 then
				Result := some_object_deep_equality_n
			end
		end

	some_object_deep_equality_dir: STS_OBJECT_DEEP_EQUALITY [detachable INTEGER_REF]
			-- Randomly-fetched instance of {STS_OBJECT_DEEP_EQUALITY [detachable INTEGER_REF]}
		do
			check
				eq: attached {STS_OBJECT_DEEP_EQUALITY [detachable INTEGER_REF]} some_immediate_instance
						(agent: STS_OBJECT_DEEP_EQUALITY [detachable INTEGER_REF] do create Result end) as eq -- `some_immediate_instance' definition
				monomorphic: eq.generating_type ~ {detachable STS_OBJECT_DEEP_EQUALITY [detachable INTEGER_REF]}
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

	some_object_deep_equality_n: STS_OBJECT_DEEP_EQUALITY [NATURAL]
			-- Randomly-fetched instance of {STS_OBJECT_DEEP_EQUALITY [NATURAL]}
		do
			check
				eq: attached {STS_OBJECT_DEEP_EQUALITY [NATURAL]} some_immediate_instance
						(agent: STS_OBJECT_DEEP_EQUALITY [NATURAL] do create Result end) as eq -- `some_immediate_instance' definition
				monomorphic: eq.generating_type ~ {detachable STS_OBJECT_DEEP_EQUALITY [NATURAL]}
			then
				Result := eq
			end
		end

feature -- Factory (Set)

	some_set: STS_SET [detachable separate ANY, STS_EQUALITY [detachable separate ANY]]
			-- Randomly-fetched polymorphic set
		do
			inspect
				next_random_item \\ 4
			when 0 then
				Result := some_set_of_references
			when 1 then
				Result := some_set_of_standard_objects
			when 2 then
				Result := some_set_of_objects
			when 3 then
				Result := some_set_of_deep_objects
			end
		end

	some_set_of_references: STS_SET [detachable separate ANY, STS_REFERENCE_EQUALITY [detachable separate ANY]]
			-- Randomly-fetched polymorphic set of objects compared by reference equality
		do
			inspect
				next_random_item \\ 3
			when 0 then
				Result := some_set_of_references_dir
			when 1 then
				Result := some_set_of_references_dscr
			when 2 then
				Result := some_set_of_references_n
			end
		end

	some_set_of_references_dir: STS_SET [detachable INTEGER_REF, STS_REFERENCE_EQUALITY [detachable INTEGER_REF]]
			-- Randomly-fetched polymorphic set of integer references compared by reference equality
		do
			inspect
				next_random_item \\ 2
			when 0 then
				Result := some_immediate_set_of_references_dir
			when 1 then
				Result := some_immediate_set_of_references_dir
			end
		end

	some_immediate_set_of_references_dir: MUTABLE_SET [detachable INTEGER_REF, STS_REFERENCE_EQUALITY [detachable INTEGER_REF]]
			-- Randomly-fetched monomorphic set of integer references compared by reference equality
		do
			check
				s: attached {MUTABLE_SET [detachable INTEGER_REF, STS_REFERENCE_EQUALITY [detachable INTEGER_REF]]} some_immediate_instance (
							agent: MUTABLE_SET [detachable INTEGER_REF, STS_REFERENCE_EQUALITY [detachable INTEGER_REF]]
								do
									across
										1 |..| some_count.as_integer_32 as i
									from
										create Result.make_empty
									loop
										Result := Result & some_integer_ref
									end
								end
						) as s -- `some_immediate_instance' definition
				monomorphic: s.generating_type ~ {detachable MUTABLE_SET [detachable INTEGER_REF, STS_REFERENCE_EQUALITY [detachable INTEGER_REF]]}
			then
				Result := cropped_set (s)
			end
		ensure
			monomorphic: Result.generating_type ~ {detachable MUTABLE_SET [detachable INTEGER_REF, STS_REFERENCE_EQUALITY [detachable INTEGER_REF]]}
		end

	some_set_of_references_dscr: STS_SET [detachable separate CHARACTER_REF, STS_REFERENCE_EQUALITY [detachable separate CHARACTER_REF]]
			-- Randomly-fetched polymorphic set of separate character references compared by reference equality
		do
			inspect
				next_random_item \\ 2
			when 0 then
				Result := some_immediate_set_of_references_dscr
			when 1 then
				Result := some_immediate_set_of_references_dscr
			end
		end

	some_immediate_set_of_references_dscr: MUTABLE_SET [detachable separate CHARACTER_REF, STS_REFERENCE_EQUALITY [detachable separate CHARACTER_REF]]
			-- Randomly-fetched monomorphic set of separate character references compared by reference equality
		do
			check
				s: attached {MUTABLE_SET [detachable separate CHARACTER_REF, STS_REFERENCE_EQUALITY [detachable separate CHARACTER_REF]]} some_immediate_instance (
							agent: MUTABLE_SET [detachable separate CHARACTER_REF, STS_REFERENCE_EQUALITY [detachable separate CHARACTER_REF]]
								do
									across
										1 |..| some_count.as_integer_32 as i
									from
										create Result.make_empty
									loop
										Result := Result & some_separate_character_ref
									end
								end
						) as s -- `some_immediate_instance' definition
				monomorphic: s.generating_type ~ {detachable MUTABLE_SET [detachable separate CHARACTER_REF, STS_REFERENCE_EQUALITY [detachable separate CHARACTER_REF]]}
			then
				Result := cropped_set (s)
			end
		ensure
			monomorphic: Result.generating_type ~ {detachable MUTABLE_SET [detachable separate CHARACTER_REF, STS_REFERENCE_EQUALITY [detachable separate CHARACTER_REF]]}
		end

	some_set_of_references_n: STS_SET [NATURAL, STS_REFERENCE_EQUALITY [NATURAL]]
			-- Randomly-fetched polymorphic set of natural numbers compared by reference equality
		do
			inspect
				next_random_item \\ 2
			when 0 then
				Result := some_immediate_set_of_references_n
			when 1 then
				Result := some_immediate_set_of_references_n
			end
		end

	some_immediate_set_of_references_n: MUTABLE_SET [NATURAL, STS_REFERENCE_EQUALITY [NATURAL]]
			-- Randomly-fetched monomorphic set of natural numbers compared by reference equality
		do
			check
				s: attached {MUTABLE_SET [NATURAL, STS_REFERENCE_EQUALITY [NATURAL]]} some_immediate_instance (
							agent: MUTABLE_SET [NATURAL, STS_REFERENCE_EQUALITY [NATURAL]]
								do
									across
										1 |..| some_count.as_integer_32 as i
									from
										create Result.make_empty
									loop
										Result := Result & some_natural
									end
								end
						) as s -- `some_immediate_instance' definition
				monomorphic: s.generating_type ~ {detachable MUTABLE_SET [NATURAL, STS_REFERENCE_EQUALITY [NATURAL]]}
			then
				Result := cropped_set (s)
			end
		ensure
			monomorphic: Result.generating_type ~ {detachable MUTABLE_SET [NATURAL, STS_REFERENCE_EQUALITY [NATURAL]]}
		end

	some_set_of_standard_objects: STS_SET [detachable separate ANY, STS_OBJECT_STANDARD_EQUALITY [detachable separate ANY]]
			-- Randomly-fetched polymorphic set of objects compared by standard object equality
		do
			inspect
				next_random_item \\ 3
			when 0 then
				Result := some_set_of_standard_objects_dir
			when 1 then
				Result := some_set_of_standard_objects_dscr
			when 2 then
				Result := some_set_of_standard_objects_n
			end
		end

	some_set_of_standard_objects_dir: STS_SET [detachable INTEGER_REF, STS_OBJECT_STANDARD_EQUALITY [detachable INTEGER_REF]]
			-- Randomly-fetched polymorphic set of integer references compared by standard object equality
		do
			inspect
				next_random_item \\ 2
			when 0 then
				Result := some_immediate_set_of_standard_objects_dir
			when 1 then
				Result := some_immediate_set_of_standard_objects_dir
			end
		end

	some_immediate_set_of_standard_objects_dir: MUTABLE_SET [detachable INTEGER_REF, STS_OBJECT_STANDARD_EQUALITY [detachable INTEGER_REF]]
			-- Randomly-fetched monomorphic set of integer references compared by standard object equality
		do
			check
				s: attached {MUTABLE_SET [detachable INTEGER_REF, STS_OBJECT_STANDARD_EQUALITY [detachable INTEGER_REF]]} some_immediate_instance (
							agent: MUTABLE_SET [detachable INTEGER_REF, STS_OBJECT_STANDARD_EQUALITY [detachable INTEGER_REF]]
								do
									across
										1 |..| some_count.as_integer_32 as i
									from
										create Result.make_empty
									loop
										Result := Result & some_integer_ref
									end
								end
						) as s -- `some_immediate_instance' definition
				monomorphic: s.generating_type ~ {detachable MUTABLE_SET [detachable INTEGER_REF, STS_OBJECT_STANDARD_EQUALITY [detachable INTEGER_REF]]}
			then
				Result := cropped_set (s)
			end
		ensure
			monomorphic: Result.generating_type ~ {detachable MUTABLE_SET [detachable INTEGER_REF, STS_OBJECT_STANDARD_EQUALITY [detachable INTEGER_REF]]}
		end

	some_set_of_standard_objects_dscr: STS_SET [detachable separate CHARACTER_REF, STS_OBJECT_STANDARD_EQUALITY [detachable separate CHARACTER_REF]]
			-- Randomly-fetched polymorphic set of separate character references compared by standard object equality
		do
			inspect
				next_random_item \\ 2
			when 0 then
				Result := some_immediate_set_of_standard_objects_dscr
			when 1 then
				Result := some_immediate_set_of_standard_objects_dscr
			end
		end

	some_immediate_set_of_standard_objects_dscr: MUTABLE_SET [detachable separate CHARACTER_REF, STS_OBJECT_STANDARD_EQUALITY [detachable separate CHARACTER_REF]]
			-- Randomly-fetched monomorphic set of separate character references compared by standard object equality
		do
			check
				s: attached {MUTABLE_SET [detachable separate CHARACTER_REF, STS_OBJECT_STANDARD_EQUALITY [detachable separate CHARACTER_REF]]} some_immediate_instance (
							agent: MUTABLE_SET [detachable separate CHARACTER_REF, STS_OBJECT_STANDARD_EQUALITY [detachable separate CHARACTER_REF]]
								do
									across
										1 |..| some_count.as_integer_32 as i
									from
										create Result.make_empty
									loop
										Result := Result & some_separate_character_ref
									end
								end
						) as s -- `some_immediate_instance' definition
				monomorphic: s.generating_type ~ {detachable MUTABLE_SET [detachable separate CHARACTER_REF, STS_OBJECT_STANDARD_EQUALITY [detachable separate CHARACTER_REF]]}
			then
				Result := cropped_set (s)
			end
		ensure
			monomorphic: Result.generating_type ~ {detachable MUTABLE_SET [detachable separate CHARACTER_REF, STS_OBJECT_STANDARD_EQUALITY [detachable separate CHARACTER_REF]]}
		end

	some_set_of_standard_objects_n: STS_SET [NATURAL, STS_OBJECT_STANDARD_EQUALITY [NATURAL]]
			-- Randomly-fetched polymorphic set of natural numbers compared by standard object equality
		do
			inspect
				next_random_item \\ 2
			when 0 then
				Result := some_immediate_set_of_standard_objects_n
			when 1 then
				Result := some_immediate_set_of_standard_objects_n
			end
		end

	some_immediate_set_of_standard_objects_n: MUTABLE_SET [NATURAL, STS_OBJECT_STANDARD_EQUALITY [NATURAL]]
			-- Randomly-fetched monomorphic set of natural numbers compared by standard object equality
		do
			check
				s: attached {MUTABLE_SET [NATURAL, STS_OBJECT_STANDARD_EQUALITY [NATURAL]]} some_immediate_instance (
							agent: MUTABLE_SET [NATURAL, STS_OBJECT_STANDARD_EQUALITY [NATURAL]]
								do
									across
										1 |..| some_count.as_integer_32 as i
									from
										create Result.make_empty
									loop
										Result := Result & some_natural
									end
								end
						) as s -- `some_immediate_instance' definition
				monomorphic: s.generating_type ~ {detachable MUTABLE_SET [NATURAL, STS_OBJECT_STANDARD_EQUALITY [NATURAL]]}
			then
				Result := cropped_set (s)
			end
		ensure
			monomorphic: Result.generating_type ~ {detachable MUTABLE_SET [NATURAL, STS_OBJECT_STANDARD_EQUALITY [NATURAL]]}
		end

	some_set_of_objects: STS_SET [detachable separate ANY, STS_OBJECT_EQUALITY [detachable separate ANY]]
			-- Randomly-fetched polymorphic set of objects compared by object equality
		do
			inspect
				next_random_item \\ 3
			when 0 then
				Result := some_set_of_objects_dir
			when 1 then
				Result := some_set_of_objects_dscr
			when 2 then
				Result := some_set_of_objects_n
			end
		end

	some_set_of_objects_dir: STS_SET [detachable INTEGER_REF, STS_OBJECT_EQUALITY [detachable INTEGER_REF]]
			-- Randomly-fetched polymorphic set of integer references compared by object equality
		do
			inspect
				next_random_item \\ 2
			when 0 then
				Result := some_immediate_set_of_objects_dir
			when 1 then
				Result := some_immediate_set_of_objects_dir
			end
		end

	some_immediate_set_of_objects_dir: MUTABLE_SET [detachable INTEGER_REF, STS_OBJECT_EQUALITY [detachable INTEGER_REF]]
			-- Randomly-fetched monomorphic set of integer references compared by object equality
		do
			check
				s: attached {MUTABLE_SET [detachable INTEGER_REF, STS_OBJECT_EQUALITY [detachable INTEGER_REF]]} some_immediate_instance (
							agent: MUTABLE_SET [detachable INTEGER_REF, STS_OBJECT_EQUALITY [detachable INTEGER_REF]]
								do
									across
										1 |..| some_count.as_integer_32 as i
									from
										create Result.make_empty
									loop
										Result := Result & some_integer_ref
									end
								end
						) as s -- `some_immediate_instance' definition
				monomorphic: s.generating_type ~ {detachable MUTABLE_SET [detachable INTEGER_REF, STS_OBJECT_EQUALITY [detachable INTEGER_REF]]}
			then
				Result := cropped_set (s)
			end
		ensure
			monomorphic: Result.generating_type ~ {detachable MUTABLE_SET [detachable INTEGER_REF, STS_OBJECT_EQUALITY [detachable INTEGER_REF]]}
		end

	some_set_of_objects_dscr: STS_SET [detachable separate CHARACTER_REF, STS_OBJECT_EQUALITY [detachable separate CHARACTER_REF]]
			-- Randomly-fetched polymorphic set of separate character references compared by object equality
		do
			inspect
				next_random_item \\ 2
			when 0 then
				Result := some_immediate_set_of_objects_dscr
			when 1 then
				Result := some_immediate_set_of_objects_dscr
			end
		end

	some_immediate_set_of_objects_dscr: MUTABLE_SET [detachable separate CHARACTER_REF, STS_OBJECT_EQUALITY [detachable separate CHARACTER_REF]]
			-- Randomly-fetched monomorphic set of separate character references compared by object equality
		do
			check
				s: attached {MUTABLE_SET [detachable separate CHARACTER_REF, STS_OBJECT_EQUALITY [detachable separate CHARACTER_REF]]} some_immediate_instance (
							agent: MUTABLE_SET [detachable separate CHARACTER_REF, STS_OBJECT_EQUALITY [detachable separate CHARACTER_REF]]
								do
									across
										1 |..| some_count.as_integer_32 as i
									from
										create Result.make_empty
									loop
										Result := Result & some_separate_character_ref
									end
								end
						) as s -- `some_immediate_instance' definition
				monomorphic: s.generating_type ~ {detachable MUTABLE_SET [detachable separate CHARACTER_REF, STS_OBJECT_EQUALITY [detachable separate CHARACTER_REF]]}
			then
				Result := cropped_set (s)
			end
		ensure
			monomorphic: Result.generating_type ~ {detachable MUTABLE_SET [detachable separate CHARACTER_REF, STS_OBJECT_EQUALITY [detachable separate CHARACTER_REF]]}
		end

	some_set_of_objects_n: STS_SET [NATURAL, STS_OBJECT_EQUALITY [NATURAL]]
			-- Randomly-fetched polymorphic set of natural numbers compared by object equality
		do
			inspect
				next_random_item \\ 2
			when 0 then
				Result := some_immediate_set_of_objects_n
			when 1 then
				Result := some_immediate_set_of_objects_n
			end
		end

	some_immediate_set_of_objects_n: MUTABLE_SET [NATURAL, STS_OBJECT_EQUALITY [NATURAL]]
			-- Randomly-fetched monomorphic set of natural numbers compared by object equality
		do
			check
				s: attached {MUTABLE_SET [NATURAL, STS_OBJECT_EQUALITY [NATURAL]]} some_immediate_instance (
							agent: MUTABLE_SET [NATURAL, STS_OBJECT_EQUALITY [NATURAL]]
								do
									across
										1 |..| some_count.as_integer_32 as i
									from
										create Result.make_empty
									loop
										Result := Result & some_natural
									end
								end
						) as s -- `some_immediate_instance' definition
				monomorphic: s.generating_type ~ {detachable MUTABLE_SET [NATURAL, STS_OBJECT_EQUALITY [NATURAL]]}
			then
				Result := cropped_set (s)
			end
		ensure
			monomorphic: Result.generating_type ~ {detachable MUTABLE_SET [NATURAL, STS_OBJECT_EQUALITY [NATURAL]]}
		end

	some_set_of_deep_objects: STS_SET [detachable separate ANY, STS_OBJECT_DEEP_EQUALITY [detachable separate ANY]]
			-- Randomly-fetched polymorphic set of objects compared by deep object equality
		do
			inspect
				next_random_item \\ 3
			when 0 then
				Result := some_set_of_deep_objects_dir
			when 1 then
				Result := some_set_of_deep_objects_dscr
			when 2 then
				Result := some_set_of_deep_objects_n
			end
		end

	some_set_of_deep_objects_dir: STS_SET [detachable INTEGER_REF, STS_OBJECT_DEEP_EQUALITY [detachable INTEGER_REF]]
			-- Randomly-fetched polymorphic set of integer references compared by deep object equality
		do
			inspect
				next_random_item \\ 2
			when 0 then
				Result := some_immediate_set_of_deep_objects_dir
			when 1 then
				Result := some_immediate_set_of_deep_objects_dir
			end
		end

	some_immediate_set_of_deep_objects_dir: MUTABLE_SET [detachable INTEGER_REF, STS_OBJECT_DEEP_EQUALITY [detachable INTEGER_REF]]
			-- Randomly-fetched monomorphic set of integer references compared by deep object equality
		do
			check
				s: attached {MUTABLE_SET [detachable INTEGER_REF, STS_OBJECT_DEEP_EQUALITY [detachable INTEGER_REF]]} some_immediate_instance (
							agent: MUTABLE_SET [detachable INTEGER_REF, STS_OBJECT_DEEP_EQUALITY [detachable INTEGER_REF]]
								do
									across
										1 |..| some_count.as_integer_32 as i
									from
										create Result.make_empty
									loop
										Result := Result & some_integer_ref
									end
								end
						) as s -- `some_immediate_instance' definition
				monomorphic: s.generating_type ~ {detachable MUTABLE_SET [detachable INTEGER_REF, STS_OBJECT_DEEP_EQUALITY [detachable INTEGER_REF]]}
			then
				Result := cropped_set (s)
			end
		ensure
			monomorphic: Result.generating_type ~ {detachable MUTABLE_SET [detachable INTEGER_REF, STS_OBJECT_DEEP_EQUALITY [detachable INTEGER_REF]]}
		end

	some_set_of_deep_objects_dscr: STS_SET [detachable separate CHARACTER_REF, STS_OBJECT_DEEP_EQUALITY [detachable separate CHARACTER_REF]]
			-- Randomly-fetched polymorphic set of separate character references compared by deep object equality
		do
			inspect
				next_random_item \\ 2
			when 0 then
				Result := some_immediate_set_of_deep_objects_dscr
			when 1 then
				Result := some_immediate_set_of_deep_objects_dscr
			end
		end

	some_immediate_set_of_deep_objects_dscr: MUTABLE_SET [detachable separate CHARACTER_REF, STS_OBJECT_DEEP_EQUALITY [detachable separate CHARACTER_REF]]
			-- Randomly-fetched monomorphic set of separate character references compared by deep object equality
		do
			check
				s: attached {MUTABLE_SET [detachable separate CHARACTER_REF, STS_OBJECT_DEEP_EQUALITY [detachable separate CHARACTER_REF]]} some_immediate_instance (
							agent: MUTABLE_SET [detachable separate CHARACTER_REF, STS_OBJECT_DEEP_EQUALITY [detachable separate CHARACTER_REF]]
								do
									across
										1 |..| some_count.as_integer_32 as i
									from
										create Result.make_empty
									loop
										Result := Result & some_separate_character_ref
									end
								end
						) as s -- `some_immediate_instance' definition
				monomorphic: s.generating_type ~ {detachable MUTABLE_SET [detachable separate CHARACTER_REF, STS_OBJECT_DEEP_EQUALITY [detachable separate CHARACTER_REF]]}
			then
				Result := cropped_set (s)
			end
		ensure
			monomorphic: Result.generating_type ~ {detachable MUTABLE_SET [detachable separate CHARACTER_REF, STS_OBJECT_DEEP_EQUALITY [detachable separate CHARACTER_REF]]}
		end

	some_set_of_deep_objects_n: STS_SET [NATURAL, STS_OBJECT_DEEP_EQUALITY [NATURAL]]
			-- Randomly-fetched polymorphic set of natural numbers compared by deep object equality
		do
			inspect
				next_random_item \\ 2
			when 0 then
				Result := some_immediate_set_of_deep_objects_n
			when 1 then
				Result := some_immediate_set_of_deep_objects_n
			end
		end

	some_immediate_set_of_deep_objects_n: MUTABLE_SET [NATURAL, STS_OBJECT_DEEP_EQUALITY [NATURAL]]
			-- Randomly-fetched monomorphic set of natural numbers compared by deep object equality
		do
			check
				s: attached {MUTABLE_SET [NATURAL, STS_OBJECT_DEEP_EQUALITY [NATURAL]]} some_immediate_instance (
							agent: MUTABLE_SET [NATURAL, STS_OBJECT_DEEP_EQUALITY [NATURAL]]
								do
									across
										1 |..| some_count.as_integer_32 as i
									from
										create Result.make_empty
									loop
										Result := Result & some_natural
									end
								end
						) as s -- `some_immediate_instance' definition
				monomorphic: s.generating_type ~ {detachable MUTABLE_SET [NATURAL, STS_OBJECT_DEEP_EQUALITY [NATURAL]]}
			then
				Result := cropped_set (s)
			end
		ensure
			monomorphic: Result.generating_type ~ {detachable MUTABLE_SET [NATURAL, STS_OBJECT_DEEP_EQUALITY [NATURAL]]}
		end

	cropped_set (s: STS_SET [detachable separate ANY, STS_EQUALITY [detachable separate ANY]]): like s
			-- `s' striped from as many elements as necessary to keep its cardinality at most `Max_count'
		local
--			cropped_s: STS_SET [detachable separate ANY, STS_EQUALITY [detachable separate ANY]]
			n: like natural_anchor
		do
			n := # s
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
			no_change: # s ≤ Max_count implies Result ≍ s
			cropped: Result ⊆ s
		end

feature -- Anchor

	natural_anchor: NATURAL
			-- Anchor for natural numbers
			--| TODO: Pull it up to a target-dependant class.
		do
		ensure
			class
		end

feature {NONE} -- Implementation

	some_immediate_instance (a_new_instance: FUNCTION [detachable separate ANY]): detachable separate ANY
			-- Randomly-fetched object whose type equals the result type of `a_new_instance'
		local
			rt: like result_type
			immediate_instances: SPECIAL [ANY]
			i: INTEGER
			tries: NATURAL
			chk_ops: BOOLEAN
		do
			if next_random_item \\ 2 = 0 then
				Result := new_immediate_instance (a_new_instance)
			else
				rt := result_type (a_new_instance)

					-- TODO: Does {MEMORY}.objects_instance_of_type (rt.type_id) return objects partially garbage-collected?
				immediate_instances := {MEMORY}.objects_instance_of_type (rt.type_id) -- TODO: It crahses frequently when gathering, e.g. sets of sets...
				if immediate_instances.count = 0 then
					if rt.is_attached or next_random_item \\ 2 = 0 then
						Result := new_immediate_instance (a_new_instance)
					else
						Result := Void
					end
				else
					check
						positive: 0 < immediate_instances.count -- immediate_instances.count /= 0
					end
					if rt.is_attached then
						i := some_integer_up_to (immediate_instances.count) - 1
					else
						i := some_integer_up_to (immediate_instances.count + 1) - 1
					end
					if i < immediate_instances.count then
						check
							valid_index: immediate_instances.valid_index (i) -- 0 ≤ i < immediate_instances.count
						end
						Result := immediate_instances [i]
						separate Result as sep_res do
							chk_ops := {ISE_RUNTIME}.check_assert (True)
							sep_res.do_nothing -- Cause an invariant violation if Result is ill formed.
							chk_ops := {ISE_RUNTIME}.check_assert (chk_ops)
						end
					else
						Result := Void
					end
				end
			end
		ensure
			immediate_instance_fetched: object_is_immediate_instance (Result, result_type (a_new_instance))
		rescue
			if attached {EXCEPTIONS}.exception_trace as et and then et.has_substring (" _invariant ") then
					-- Assume that immediate_instances has fetched an ill-formed object. Just retry.
				tries := tries + 1
				if tries < 20 then
					retry
				end
			end
		end

	new_immediate_instance (a_new_instance: FUNCTION [detachable separate ANY]): detachable separate ANY
			-- Randomly-created object whose type equals the result type of `a_new_instance'
		do
			Result := a_new_instance.item
		ensure
			immediate_instance_created: object_is_immediate_instance (Result, result_type (a_new_instance))
		end

	object_is_immediate_instance (x: detachable separate ANY; t: TYPE [detachable separate ANY]): BOOLEAN
			-- Is `x' a immediate instance of `t', i.e. does `x' conform to `t' and is it not a proper descendant of `t'?
		do
			if x = Void then
				Result := not t.is_attached
			elseif t.is_attached then
				Result := t ~ {attached like x} or t ~ {attached separate like x}
			else
				Result := t ~ {like x} or t ~ {separate like x}
			end
		ensure
			class
			when_void: x = Void implies Result = not t.is_attached
			when_attached: x /= Void and t.is_attached implies Result = (t ~ {attached like x} or t ~ {attached separate like x})
			when_detachable: x /= Void and not t.is_attached implies Result = (t ~ {like x} or t ~ {separate like x})
		end

	result_type (a_new_instance: FUNCTION [detachable separate ANY]): TYPE [detachable ANY]
			-- Result type of the function accessed via `a_new_instance' agent
		local
			l_new_instance_type: TYPE [detachable ANY]
		do
			l_new_instance_type := a_new_instance.generating_type
			check
				large_enough: l_new_instance_type.generic_parameter_count ≥ 1 -- FUNCTION [detachable separate ANY] has generic parameters.
				small_enough: l_new_instance_type.generic_parameter_count ≤ l_new_instance_type.generic_parameter_count -- By definition
			end
			Result := l_new_instance_type.generic_parameter_type (l_new_instance_type.generic_parameter_count)
		ensure
			class
			el_new_instance_type: attached a_new_instance.generating_type as el_new_instance_type
			large_enough: el_new_instance_type.generic_parameter_count ≥ 1 -- FUNCTION [detachable separate ANY] has generic parameters.
			small_enough: el_new_instance_type.generic_parameter_count ≤ el_new_instance_type.generic_parameter_count -- By definition
			definition: Result ~ el_new_instance_type.generic_parameter_type (el_new_instance_type.generic_parameter_count)
		end

	some_index_up_to (n: NATURAL): NATURAL
			-- Randomly-created index in the range {1..`n'}
		require
			positive: 0 < n
		do
			Result := next_random_item.as_natural_32 \\ n + 1
		ensure
			class
			positive: 0 < Result
			small_enough: Result <= n
		end

	some_integer_up_to (i: INTEGER): INTEGER
			-- Randomly-created integer in the range {1..`i'}
		require
			positive: 0 < i
		do
			Result := next_random_item \\ i + 1
		ensure
			class
			positive: 0 < Result
			small_enough: Result <= i
		end

	some_count: NATURAL
			-- Randomly-created natural number to be used for counting
		do
			Result := next_random_item.as_natural_32 \\ (Max_count + 1)
		ensure
			class
			upper_bound: Result ≤ Max_count
		end

feature {SET_PROPERTIES} -- Implementation

	Max_count: NATURAL = 5
			-- Maximum value for `some_count'
			-- Why so few? Believe me: you don't want to deal with all subsets of all subsets of a set with 6 elements!

feature {NONE} -- Implementation

	next_random_item: like random_sequence.item
			-- Item at next position of `random_sequence'
		do
			check
				not_after: not random_sequence.After -- {RANDOM}.After = `False'
			end
			random_sequence.forth
			check
				readable: random_sequence.Readable -- {RANDOM}.Readable = `True'
				not_off: not random_sequence.off -- {RANDOM}.is_empty = `False' and {RANDOM}.After = `False'
			end
			Result := random_sequence.item
		ensure
			class
		end

	random_sequence: RANDOM
			-- Sequence of random numbers
		local
			time: TIME
		once
			from
				create time.make_now
			until
				time.compact_time >= 0
			loop
				create time.make_now
			end
			create Result.set_seed (time.compact_time)
		ensure
			class
		end

	Min_character: CHARACTER = 'a'
			-- Minimum value for `some_character'

	some_index: NATURAL
			-- Randomly-created index
		do
			check
				positive: 0 < Max_count -- `Max_count' definition
			end
			Result := some_index_up_to (Max_count)
		ensure
			class
			positive: 0 < Result
			upper_bound: Result <= Max_count
		end

invariant
	valid_characters: (Min_character.natural_32_code + Max_count - 1).is_valid_character_8_code

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/Set-Theory"

end

