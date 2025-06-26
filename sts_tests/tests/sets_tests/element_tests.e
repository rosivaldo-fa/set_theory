note
	description: "Test suite for {ELEMENT}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ELEMENT_TESTS

inherit
	ELEMENT_PROPERTIES

feature -- Basic operations

	assert (a_tag: READABLE_STRING_GENERAL; a_condition: BOOLEAN)
			-- Assert `a_condition'. To be implemented by {EQA_TEST_SET}
		require
			a_tag_not_void: a_tag /= Void
		deferred
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
			-- Test {ELEMENT}.is_in.
		note
			testing: "covers/{ELEMENT}.is_in"
		local
			a: like element_to_be_tested
			s: like some_elements
		do
			a := element_to_be_tested
			s := some_elements
			assert ("is_in", a ∈ s ⇒ True)
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
			s := some_elements
			assert ("is_not_in", a ∉ s ⇒ True)
			assert ("is_not_in_ok", is_not_in_ok (a, s))
		end

feature {NONE} -- Factory (Element to be tested)

	element_to_be_tested: like some_immediate_element
			-- Element meant to be under tests
		do
			Result := some_immediate_element
		ensure
			monomorphic: Result.generating_type ~ {detachable like element_to_be_tested}
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
				Result := some_element_equality
			when 2 then
				Result := some_natural_number
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

	some_elements: STS_SET [STS_ELEMENT]
			-- Randomly-fetched polymorphic set of elements
		deferred
		end

feature -- Factory (Equality)

	some_element_equality: STS_EQUALITY [STS_ELEMENT]
			-- Randomly-fetched polymorphic equality for comparing {STS_ELEMENT} instances
		do
			inspect
				next_random_item \\ 4
			when 0 then
				Result := some_element_reference_equality
			when 1 then
				Result := some_element_object_standard_equality
			when 2 then
				Result := some_element_object_equality
			when 3 then
				Result := some_element_object_deep_equality
			end
		end

	some_element_reference_equality: STS_REFERENCE_EQUALITY [STS_ELEMENT]
			-- Randomly-fetched polymorphic reference equality for comparing {STS_ELEMENT} object references
		do
			check
				eq: attached {STS_REFERENCE_EQUALITY [STS_ELEMENT]} some_immediate_instance
						(agent: STS_REFERENCE_EQUALITY [STS_ELEMENT] do create Result end) as eq -- `some_immediate_instance' definition
				monomorphic: eq.generating_type ~ {detachable STS_REFERENCE_EQUALITY [STS_ELEMENT]}
			then
				Result := eq
			end
		end

	some_element_object_standard_equality: STS_OBJECT_STANDARD_EQUALITY [STS_ELEMENT]
			-- Randomly-fetched polymorphic reference equality for comparing {STS_ELEMENT} object standard value
		do
			check
				eq: attached {STS_OBJECT_STANDARD_EQUALITY [STS_ELEMENT]} some_immediate_instance
						(agent: STS_OBJECT_STANDARD_EQUALITY [STS_ELEMENT] do create Result end) as eq -- `some_immediate_instance' definition
				monomorphic: eq.generating_type ~ {detachable STS_OBJECT_STANDARD_EQUALITY [STS_ELEMENT]}
			then
				Result := eq
			end
		end

	some_element_object_equality: STS_OBJECT_EQUALITY [STS_ELEMENT]
			-- Randomly-fetched polymorphic reference equality for comparing {STS_ELEMENT} object value
		do
			check
				eq: attached {STS_OBJECT_EQUALITY [STS_ELEMENT]} some_immediate_instance
						(agent: STS_OBJECT_EQUALITY [STS_ELEMENT] do create Result end) as eq -- `some_immediate_instance' definition
				monomorphic: eq.generating_type ~ {detachable STS_OBJECT_EQUALITY [STS_ELEMENT]}
			then
				Result := eq
			end
		end

	some_element_object_deep_equality: STS_OBJECT_DEEP_EQUALITY [STS_ELEMENT]
			-- Randomly-fetched polymorphic reference equality for comparing {STS_ELEMENT} object deep value
		do
			check
				eq: attached {STS_OBJECT_DEEP_EQUALITY [STS_ELEMENT]} some_immediate_instance
						(agent: STS_OBJECT_DEEP_EQUALITY [STS_ELEMENT] do create Result end) as eq -- `some_immediate_instance' definition
				monomorphic: eq.generating_type ~ {detachable STS_OBJECT_DEEP_EQUALITY [STS_ELEMENT]}
			then
				Result := eq
			end
		end

feature -- Factory (natural number)

	some_natural_number: STS_NATURAL_NUMBER
			-- Randomly-fetched polymorphic natural number
		do
			Result := some_immediate_natural_number
		end

	some_immediate_natural_number: STS_NATURAL_NUMBER
			-- Randomly-fetched monomorphic natural number
		deferred
		ensure
			monomorphic: Result.generating_type ~ {detachable like some_immediate_natural_number}
		end

	some_set_of_natural_numbers: STS_SET [STS_NATURAL_NUMBER]
			-- Randomly-fetched polymorphic set of natural numbers
		do
			inspect
				next_random_item \\ 2
			when 0 then
				Result := some_immediate_set_of_natural_numbers
			when 1 then
				Result := some_universe_of_natural_numbers
			end
		end

	some_immediate_set_of_natural_numbers: like some_set_of_natural_numbers
			-- Randomly-fetched monomorphic set of natural numbers
		deferred
		ensure
			monomorphic: Result.generating_type ~ {detachable like some_immediate_set_of_natural_numbers}
		end

	some_universe_of_natural_numbers: STS_UNIVERSE [STS_NATURAL_NUMBER]
			-- Randomly-fetched polymorphic universe of natural numbers
		do
			Result := some_immediate_universe_of_natural_numbers
		end

	some_immediate_universe_of_natural_numbers: like some_universe_of_natural_numbers
			-- Randomly-fetched monomorphic universe of natural numbers
		deferred
		ensure
			monomorphic: Result.generating_type ~ {detachable like some_immediate_universe_of_natural_numbers}
		end

	some_natural_number_equality: STS_EQUALITY [STS_NATURAL_NUMBER]
			-- Randomly-fetched polymorphic equality for comparing {STS_NATURAL_NUMBER} instances
		do
			inspect
				next_random_item \\ 4
			when 0 then
				Result := some_natural_number_reference_equality
			when 1 then
				Result := some_natural_number_object_standard_equality
			when 2 then
				Result := some_natural_number_object_equality
			when 3 then
				Result := some_natural_number_object_deep_equality
			end
		end

	some_natural_number_reference_equality: STS_REFERENCE_EQUALITY [STS_NATURAL_NUMBER]
			-- Randomly-fetched polymorphic reference equality for comparing {STS_NATURAL_NUMBER} object references
		do
			check
				eq: attached {STS_REFERENCE_EQUALITY [STS_NATURAL_NUMBER]} some_immediate_instance
						(agent: STS_REFERENCE_EQUALITY [STS_NATURAL_NUMBER] do create Result end) as eq -- `some_immediate_instance' definition
				monomorphic: eq.generating_type ~ {detachable STS_REFERENCE_EQUALITY [STS_NATURAL_NUMBER]}
			then
				Result := eq
			end
		end

	some_natural_number_object_standard_equality: STS_OBJECT_STANDARD_EQUALITY [STS_NATURAL_NUMBER]
			-- Randomly-fetched polymorphic reference equality for comparing {STS_NATURAL_NUMBER} object standard value
		do
			check
				eq: attached {STS_OBJECT_STANDARD_EQUALITY [STS_NATURAL_NUMBER]} some_immediate_instance
						(agent: STS_OBJECT_STANDARD_EQUALITY [STS_NATURAL_NUMBER] do create Result end) as eq -- `some_immediate_instance' definition
				monomorphic: eq.generating_type ~ {detachable STS_OBJECT_STANDARD_EQUALITY [STS_NATURAL_NUMBER]}
			then
				Result := eq
			end
		end

	some_natural_number_object_equality: STS_OBJECT_EQUALITY [STS_NATURAL_NUMBER]
			-- Randomly-fetched polymorphic reference equality for comparing {STS_NATURAL_NUMBER} object value
		do
			check
				eq: attached {STS_OBJECT_EQUALITY [STS_NATURAL_NUMBER]} some_immediate_instance
						(agent: STS_OBJECT_EQUALITY [STS_NATURAL_NUMBER] do create Result end) as eq -- `some_immediate_instance' definition
				monomorphic: eq.generating_type ~ {detachable STS_OBJECT_EQUALITY [STS_NATURAL_NUMBER]}
			then
				Result := eq
			end
		end

	some_natural_number_object_deep_equality: STS_OBJECT_DEEP_EQUALITY [STS_NATURAL_NUMBER]
			-- Randomly-fetched polymorphic reference equality for comparing {STS_NATURAL_NUMBER} object deep value
		do
			check
				eq: attached {STS_OBJECT_DEEP_EQUALITY [STS_NATURAL_NUMBER]} some_immediate_instance
						(agent: STS_OBJECT_DEEP_EQUALITY [STS_NATURAL_NUMBER] do create Result end) as eq -- `some_immediate_instance' definition
				monomorphic: eq.generating_type ~ {detachable STS_OBJECT_DEEP_EQUALITY [STS_NATURAL_NUMBER]}
			then
				Result := eq
			end
		end

feature {NONE} -- Implementation

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

	Min_character: CHARACTER = 'a'
			-- Minimum value for `some_character'

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
