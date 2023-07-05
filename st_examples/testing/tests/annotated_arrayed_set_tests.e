note
	description: "Test suite for {ANNOTATED_ARRAYED_SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Unnamed", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_examples.html#st_examples_tests"

deferred class
	ANNOTATED_ARRAYED_SET_TESTS [G, EQ -> STS_EQUALITY [G] create default_create end]

inherit
	EQA_TEST_SET
		undefine
			on_prepare
		end

	UNARY_TESTS [G, EQ] -- Ad hoc inheritance. Please see file://$(system_path)/docs/EIS/st_examples.html#st_examples_tests.

feature -- Test routines (Initialization)

	test_make
			-- Test {ANNOTATED_ARRAYED_SET}.make
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.make"
		do
			assert (
					"no element",
					(
						agent: BOOLEAN
							local
								n: INTEGER
								s: ANNOTATED_ARRAYED_SET [G]
							do
								n := some_count.as_integer_32
								check
									valid_number_of_items: n >= 0 -- some_count definition
								end
								create s.make (n)
								if next_random_item \\ 2 = 0 then
									check
										changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
									end
									s.compare_objects
								end
								Result := s.model_set.is_empty
							end
					).item
				)
			assert (
					"discarded elements",
					(
						agent: BOOLEAN
							local
								n1, n2: INTEGER
								s: ANNOTATED_ARRAYED_SET [G]
							do
								n1 := some_count.as_integer_32
								check
									valid_number_of_items_1: n1 >= 0 -- some_count definition
								end
								create s.make (n1)
								⟳ i: 1 |..| some_count.as_integer_32 ¦
									s.extend (some_object_a)
								⟲
								n2 := some_count.as_integer_32
								check
									valid_number_of_items_2: n2 >= 0 -- some_count definition
								end
								s.make (n2)
								if next_random_item \\ 2 = 0 then
									check
										changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
									end
									s.compare_objects
								end
								Result := s.model_set.is_empty
							end
					).item
				)
			assert (
					"make",
					(
						agent: BOOLEAN
							local
								n: INTEGER
								s: ANNOTATED_ARRAYED_SET [G]
							do
								n := some_count.as_integer_32
								check
									valid_number_of_items: n >= 0 -- some_count definition
								end
								create s.make (n)
								Result := attached s
							end
					).item
				)
		end

	test_make_filled
			-- Test {ANNOTATED_ARRAYED_SET}.make_filled
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.make_filled"
		do
			assert (
					"no element",
					(
						agent: BOOLEAN
							local
								s: ANNOTATED_ARRAYED_SET [G]
							do
								if ({G}).has_default then
									create s.make_filled (0)
									if next_random_item \\ 2 = 0 then
										check
											changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
										end
										s.compare_objects
									end
									check
										is_empty: s.model_set.is_empty
									then
									end
								end
								Result := True
							end
					).item
				)
			assert (
					"singleton",
					(
						agent: BOOLEAN
							local
								s: ANNOTATED_ARRAYED_SET [G]
							do
								if ({G}).has_default then
									create s.make_filled (1)
									check
										is_singleton: s.model_set.is_singleton
										default_element: s ∋ ({G}).default
									then
									end
								end
								Result := True
							end
					).item
				)
			assert (
					"discard elements",
					(
						agent: BOOLEAN
							local
								n1, n2: INTEGER
								s: ANNOTATED_ARRAYED_SET [G]
							do
								if ({G}).has_default then
									n1 := some_count.as_integer_32
									check
										valid_number_of_items_1: n1 >= 0 -- some_count definition
									end
									create s.make_filled (n1)
									⟳ i: 1 |..| some_count.as_integer_32 ¦
										s.extend (some_object_a)
									⟲
									n2 := some_count.as_integer_32
									check
										valid_number_of_items_2: n2 >= 0 -- some_count definition
									end
									s.make_filled (n2)
									if next_random_item \\ 2 = 0 and n2 = 0 then
										check
											changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
										end
										s.compare_objects
									end
									check
										is_empty: n2 = 0 ⇒ s.model_set.is_empty
										is_singleton: n2 > 0 ⇒ s.model_set.is_singleton
									then
									end
								end
								Result := True
							end
					).item
				)

			assert (
					"make_filled",
					(
						agent: BOOLEAN
							local
								n: INTEGER
							do
								if ({G}).has_default then
									n := some_count.as_integer_32
									check
										valid_number_of_items: n >= 0 -- some_count definition
									end
									check
										make_filled: attached (create {ANNOTATED_ARRAYED_SET [G]}.make_filled (n))
									then
									end
								end
								Result := True
							end
					).item
				)
		end

	test_make_from_array
			-- Test {ANNOTATED_ARRAYED_SET}.make_from_array
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.make_from_array"
		do
			assert (
					"∅",
					(
						agent: BOOLEAN
							local
								s: ANNOTATED_ARRAYED_SET [G]
							do
								create s.make_from_array (<<>>)
								Result := s.model_set.is_empty
							end
					).item
				)
			assert (
					"{v}",
					(
						agent: BOOLEAN
							local
								v: G
								a: ARRAY [G]
								s: ANNOTATED_ARRAYED_SET [G]
								min_index, max_index: INTEGER
							do
								v := some_object_a
								min_index := some_integer
								max_index := min_index + some_count.as_integer_32
								check
									valid_bounds: min_index <= max_index + 1 -- min_index <= max_index
								end
								create a.make_filled (v, min_index, max_index)
								create s.make_from_array (a)
								Result := s.model_set ≍ singleton (s, v)
							end
					).item
				)
			assert (
					"{v1,v2}",
					(
						agent: BOOLEAN
							local
								v1, v2: G
								s: ANNOTATED_ARRAYED_SET [G]
							do
								v1 := some_object_a
								v2 := some_object_a
								create s.make_from_array (<<v1, v2>>)
								Result := s.model_set ≍ (singleton (s, v1) & v2)
							end
					).item
				)
			assert (
					"{v1,v2,v3}",
					(
						agent: BOOLEAN
							local
								v1, v2, v3: G
								s: ANNOTATED_ARRAYED_SET [G]
							do
								v1 := some_object_a
								v2 := some_object_a
								v3 := some_object_a
								create s.make_from_array (<<v1, v2, v3>>)
								Result := s.model_set ≍ (singleton (s, v1) & v2 & v3)
							end
					).item
				)
			assert (
					"make_from_array",
					(
						agent: BOOLEAN
							local
								a: ARRAY [G]
							do
								create a.make_empty
								⟳ i: 1 |..| some_count.as_integer_32 ¦ a.force (some_object_a, a.count + 1) ⟲
								Result := attached (create {ANNOTATED_ARRAYED_SET [G]}.make_from_array (a))
							end
					).item
				)
		end

	test_make_from_iterable
			-- Test {ANNOTATED_ARRAYED_SET}.make_from_iterable
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.make_from_iterable"
		do
			assert (
					"∅",
					(
						agent: BOOLEAN
							local
								s: ANNOTATED_ARRAYED_SET [G]
							do
								create s.make_from_iterable (<<>>)
								Result := s.model_set.is_empty
							end
					).item
				)
			assert (
					"{v}",
					(
						agent: BOOLEAN
							local
								v: G
								a: ARRAY [G]
								s: ANNOTATED_ARRAYED_SET [G]
								min_index, max_index: INTEGER
							do
								v := some_object_a
								min_index := some_integer
								max_index := min_index + some_count.as_integer_32
								check
									valid_bounds: min_index <= max_index + 1 -- min_index <= max_index
								end
								create a.make_filled (v, min_index, max_index)
								create s.make_from_iterable (a)
								Result := s.model_set ≍ singleton (s, v)
							end
					).item
				)
			assert (
					"{v1,v2}",
					(
						agent: BOOLEAN
							local
								v1, v2: G
								s: ANNOTATED_ARRAYED_SET [G]
							do
								v1 := some_object_a
								v2 := some_object_a
								create s.make_from_iterable (<<v1, v2>>)
								Result := s.model_set ≍ (singleton (s, v1) & v2)
							end
					).item
				)
			assert (
					"{v1,v2,v3}",
					(
						agent: BOOLEAN
							local
								v1, v2, v3: G
								s: ANNOTATED_ARRAYED_SET [G]
							do
								v1 := some_object_a
								v2 := some_object_a
								v3 := some_object_a
								create s.make_from_iterable (<<v1, v2, v3>>)
								Result := s.model_set ≍ (singleton (s, v1) & v2 & v3)
							end
					).item
				)
			assert (
					"make_from_iterable",
					(
						agent: BOOLEAN
							local
								a: ARRAY [G]
							do
								create a.make_empty
								⟳ i: 1 |..| some_count.as_integer_32 ¦ a.force (some_object_a, a.count + 1) ⟲
								Result := attached (create {ANNOTATED_ARRAYED_SET [G]}.make_from_iterable (a))
							end
					).item
				)
		end

feature -- Test routines (Model)

	test_model_set
			-- Test {ANNOTATED_ARRAYED_SET}.model_set
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.model_set"
		local
			n: INTEGER
			s: ANNOTATED_ARRAYED_SET [G]
			a, b, c: G
		do
			n := some_count.as_integer_32
			check
				valid_number_of_items_1: n >= 0 -- some_count definition
			end
			create s.make (n)
			assert ("∅", s.model_set.is_empty)

			if next_random_item \\ 2 = 0 then
				check
					changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
				end
				s.compare_objects
			end
			a := some_object_a
			s.extend (same_object_s_a (s, a))
			assert ("{a}", s.model_set ≍ singleton (s, a))

			b := some_object_a
			s.extend (same_object_s_a (s, b))
			assert ("{a,b}", s.model_set ≍ (singleton (s, a) & b))

			c := some_object_a
			s.extend (same_object_s_a (s, c))
			assert ("{a,b,c}", s.model_set ≍ (singleton (s, a) & b & c))

			n := some_count.as_integer_32
			check
				valid_number_of_items_2: n >= 0 -- some_count definition
			end
			create s.make (n)
			⟳ i: 1 |..| some_count.as_integer_32 ¦
				s.extend (some_object_a)
			⟲
			assert ("model_set", attached s.model_set)
		end

	test_model_indices
			-- Test {ANNOTATED_ARRAYED_SET}.model_indices
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.model_indices"
		local
			s: ANNOTATED_ARRAYED_SET [G]
		do
			create s.make (0)
			⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
			assert ("model_indices", attached s.model_indices)
		end

	test_cursor
			-- Test {ANNOTATED_ARRAYED_SET}.cursor
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.cursor"
		local
			s: ANNOTATED_ARRAYED_SET [G]
		do
			create s.make (0)
			⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
			s.start
			if s.count > 0 then
				⟳ i: 1 |..| (next_random_item \\ (s.count + 1)) ¦ s.forth ⟲
			end
			assert ("cursor", attached s.cursor)
		end

	test_first
			-- Test {ANNOTATED_ARRAYED_SET}.first
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.first"
		local
			s: ANNOTATED_ARRAYED_SET [G]
		do
			create s.make (0)
			⟳ i: 1 |..| (1 + some_count.as_integer_32) ¦ s.extend (some_object_a) ⟲
			check
				not_empty: not s.is_empty -- Iteration above
			end
			assert ("first", attached s.first ⇒ True)
		end

	test_has
			-- Test {ANNOTATED_ARRAYED_SET}.has
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.has"
		local
			s: ANNOTATED_ARRAYED_SET [G]
		do
			create s.make (0)
			⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
			assert ("has", s ∋ some_object_a ⇒ True)
		end

	test_index_of
			-- Test {ANNOTATED_ARRAYED_SET}.index_of
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.index_of"
		local
			s: ANNOTATED_ARRAYED_SET [G]
		do
			create s.make (0)
			⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
			assert ("index_of", attached s.index_of (some_object_a, 1))
		end

	test_item
			-- Test {ANNOTATED_ARRAYED_SET}.item
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.item"
		local
			s: ANNOTATED_ARRAYED_SET [G]
		do
			create s.make (0)
			⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
			s.start
			if s.count > 0 then
				⟳ i: 1 |..| (next_random_item \\ (s.count + 1)) ¦ s.forth ⟲
			end
			assert ("item", not s.off ⇒ attached s.item ⇒ True)
		end

	test_array_item
			-- Test {ANNOTATED_ARRAYED_SET}.array_item
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.array_item"
		local
			s: ANNOTATED_ARRAYED_SET [G]
			j: INTEGER
		do
			create s.make (0)
			⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
			if s.count > 0 then
				j := next_random_item \\ s.count
			end
			assert ("array_item", s.array_valid_index (j) ⇒ attached s.array_item (j) ⇒ True)
		end

	test_item_for_iteration
			-- Test {ANNOTATED_ARRAYED_SET}.item_for_iteration
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.item_for_iteration"
		local
			s: ANNOTATED_ARRAYED_SET [G]
		do
			create s.make (0)
			⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
			s.start
			if s.count > 0 then
				⟳ i: 1 |..| (next_random_item \\ (s.count + 1)) ¦ s.forth ⟲
			end
			assert ("item_for_iteration", not s.off ⇒ attached s.item_for_iteration ⇒ True)
		end

	test_last
			-- Test {ANNOTATED_ARRAYED_SET}.last
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.last"
		local
			s: ANNOTATED_ARRAYED_SET [G]
		do
			create s.make (0)
			⟳ i: 1 |..| (1 + some_count.as_integer_32) ¦ s.extend (some_object_a) ⟲
			check
				not_empty: not s.is_empty -- Iteration above
			end
			assert ("last", attached s.last ⇒ True)
		end

	test_new_cursor
			-- Test {ANNOTATED_ARRAYED_SET}.new_cursor
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.new_cursor"
		local
			s: ANNOTATED_ARRAYED_SET [G]
		do
			create s.make (0)
			⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
			assert ("new_cursor", attached s.new_cursor)
		end

feature -- Test routines (Access)

	test_area
			-- Test {ANNOTATED_ARRAYED_SET}.area
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.area"
		local
			s: ANNOTATED_ARRAYED_SET [G]
		do
			create s.make (0)
			⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
			assert ("area", attached s.area)
		end

	test_array_at
			-- Test {ANNOTATED_ARRAYED_SET}.array_at
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.array_at"
		local
			s: ANNOTATED_ARRAYED_SET [G]
			i: INTEGER
		do
			create s.make (0)
			⟳ j: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
			if s.count > 0 then
				i := next_random_item \\ s.count
				check
					valid_index: s.array_valid_index (i) -- 0 <= i < s.count
				end
			end
			assert ("array_at", s.count > 0 ⇒ attached s.array_at (i) ⇒ True)
		end

	test_i_th
			-- Test {ANNOTATED_ARRAYED_SET}.i_th
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.i_th"
		local
			s: ANNOTATED_ARRAYED_SET [G]
			i: INTEGER
		do
			create s.make (0)
			⟳ j: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
			if s.count > 0 then
				i := (next_random_item \\ s.count) + 1
				check
					valid_index: s.valid_index (i) -- 1 <= i <= s.count
				end
			end
			assert ("i_th", s.count > 0 ⇒ attached (s [i]) ⇒ True)
		end

	test_at
			-- Test {ANNOTATED_ARRAYED_SET}.at
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.at"
		local
			s: ANNOTATED_ARRAYED_SET [G]
			i: INTEGER
		do
			create s.make (0)
			⟳ j: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
			if s.count > 0 then
				i := (next_random_item \\ s.count) + 1
				check
					valid_index: s.valid_index (i) -- 1 <= i <= s.count
				end
			end
			assert ("at", s.count > 0 ⇒ attached s.at (i) ⇒ True)
		end

feature -- Factory (Object)

	same_object_s_a (s: CONTAINER [G]; a: G): G
			-- Randomly-fetched object equal to `a', compared according to `s'.`object_comparison'
		do
			Result := a
			if s.object_comparison then
				if next_random_item \\ 2 = 0 then
					separate a as sep_a do -- BEWARE: Not void-safe!
						if attached sep_a then
							Result := sep_a.twin
						end
					end
				end
			end
		ensure
			same_value: Result ~ a
			possibly_same_reference: not s.object_comparison ⇒ Result = a
		end

feature {NONE} -- Factory (Set)

	reference_o: STI_SET [G, STS_REFERENCE_EQUALITY [G]]
			-- The empty set, i.e. {} or ∅, with elements compared by object references
			--| TODO: Make it once? An attribute?
		do
			create Result.make_empty
		end

	singleton (s: ANNOTATED_ARRAYED_SET [G]; a: G): STS_SET [G, STS_EQUALITY [G]]
			-- Singleton in the form {`a'}
			--| TODO: DRY.
		do
			if not s.object_comparison then
				create {STI_SET [G, STS_REFERENCE_EQUALITY [G]]} Result.make_singleton (a)
			else
				create {STI_SET [G, STS_OBJECT_EQUALITY [G]]} Result.make_singleton (a)
			end
		ensure
			reference_equality: not s.object_comparison ⇒ Result.eq.generating_type <= {detachable STS_REFERENCE_EQUALITY [G]}
			object_equality: s.object_comparison ⇒ Result.eq.generating_type <= {detachable STS_OBJECT_EQUALITY [G]}
			singleton: Result.is_singleton
			sole_element: Result ∋ a
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
