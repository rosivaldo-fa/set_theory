note
	description: "Test suite for {STS_ELEMENT}"
	author: "Rosivaldo Fernandes Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	ELEMENT_TESTS

inherit
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
--			s := new_element_references-- & a
			create {SET [STS_ELEMENT, STS_REFERENCE_EQUALITY [STS_ELEMENT]]} s.make_singleton (a)
			assert ("a ∈ s", a ∈ s)
			assert ("a ∈ s ok", properties.is_in_ok (a, s))

			s := new_element_references--/ a
			assert ("not (a ∈ s)", not (a ∈ s))
			assert ("not (a ∈ s) ok", properties.is_in_ok (a, s))

--			s := new_element_objects--& a
			create {SET [STS_ELEMENT, STS_OBJECT_EQUALITY [STS_ELEMENT]]} s.make_singleton (a.twin)
			assert ("a.twin ∈ s", a ∈ s)
			assert ("a.twin ∈ s ok", properties.is_in_ok (a, s))

			s := new_element_objects--/ a
			assert ("not (a.twin ∈ s)", not (a ∈ s))
			assert ("not (a.twin ∈ s) ok", properties.is_in_ok (a, s))

			a := element_to_be_tested
			s := some_elements
			assert ("is_in", a ∈ s ⇒ True)
			assert ("is_in_ok", properties.is_in_ok (a, s))
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
				next_random_item \\ 1
			when 0 then
				Result := some_immediate_element
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
				next_random_item \\ 2
			when 0 then
				Result := new_element_references
			when 1 then
				Result := new_element_objects
			end
		end

	new_element_references: SET [STS_ELEMENT, STS_REFERENCE_EQUALITY [STS_ELEMENT]]
			-- Randomly-created set of elements compared by references
		do
			across
				1 |..| some_count.as_integer_32 as i
			from
				create Result.make_empty
			loop
--				Result := Result & some_element
			end
		end

	new_element_objects: SET [STS_ELEMENT, STS_OBJECT_EQUALITY [STS_ELEMENT]]
			-- Randomly-created set of elements compared by object values
		do
			across
				1 |..| some_count.as_integer_32 as i
			from
				create Result.make_empty
			loop
--				Result := Result & some_element
			end
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
						i := some_index_up_to (immediate_instances.count.as_natural_32).as_integer_32 - 1 -- TODO: Create an integer some_index_up_to.
					else
						i := some_index_up_to (immediate_instances.count.as_natural_32 + 1).as_integer_32 - 1
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

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo Fernandes Alves"
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	source: ""
end


