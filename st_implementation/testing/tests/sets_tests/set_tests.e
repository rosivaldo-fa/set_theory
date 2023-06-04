note
	description: "Test suite for {SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SET_TESTS [A, EQ -> STS_EQUALITY [A] create default_create end]

inherit
	UNARY_TESTS [A, EQ]
		rename
			element_to_be_tested as set_to_be_tested
		redefine
			properties,
			set_to_be_tested
		end

feature -- Access

	properties: SET_PROPERTIES [A, EQ]
			-- Object that checks the set-theory properties of {SET}

feature {NONE} -- Factory (element to be tested)

	set_to_be_tested: like new_set_a
			-- Set meant to be under tests
		do
			check
				new_s: attached {FUNCTION [like new_set_a]} (agent new_set_a) as new_s

					-- `some_immediate_instance' and `new_set_a' definitions
				s: attached {like new_set_a} some_immediate_instance (new_s) as s
				monomorphic: s.generating_type ~ {detachable like new_set_a}
			then
				Result := cropped_set (s)
			end
		end

feature -- Factory (Set)

	new_set_a: SET [A, EQ]
			-- Randomly-created monomorphic set of elements like {A}, whose equality is checked by {EQ}.
		do
			across
				1 |..| some_count.as_integer_32 as i
			from
				create Result.make_empty
			loop
--				Result := Result & some_object_a
			end
		ensure
			monomorphic: Result.generating_type ~ {detachable like new_set_a}
		end

	cropped_set (s: STS_SET [detachable separate ANY, STS_EQUALITY [detachable separate ANY]]): like s
			-- `s' striped from as many elements as necessary to keep its cardinality at most `Max_count'
		local
			cropped_s: STS_SET [detachable separate ANY, STS_EQUALITY [detachable separate ANY]]
--			n: like new_set_a.cardinality
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
--		ensure
--			small_enough: # Result ≤ Max_count
--			no_change: # s ≤ Max_count implies Result ≍ s
--			cropped: Result ⊆ s
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	source: ""
end
