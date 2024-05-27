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
			-- Test {ANNOTATED_ARRAYED_SET}.make.
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
			-- Test {ANNOTATED_ARRAYED_SET}.make_filled.
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
			-- Test {ANNOTATED_ARRAYED_SET}.make_from_array.
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
								create s.make_from_array ({ARRAY [G]} <<>>)
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
			-- Test {ANNOTATED_ARRAYED_SET}.make_from_iterable.
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

feature -- Test routines (Access)

	test_array_at
			-- Test {ANNOTATED_ARRAYED_SET}.array_at.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.array_at"
		local
			s: ANNOTATED_ARRAYED_SET [G]
			i: INTEGER
		do
			create s.make (0)
			if next_random_item \\ 2 = 0 then
				check
					changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
				end
				s.compare_objects
			end
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
			-- Test {ANNOTATED_ARRAYED_SET}.i_th.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.i_th"
		local
			s: ANNOTATED_ARRAYED_SET [G]
			i: INTEGER
		do
			create s.make (0)
			if next_random_item \\ 2 = 0 then
				check
					changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
				end
				s.compare_objects
			end
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
			-- Test {ANNOTATED_ARRAYED_SET}.at.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.at"
		local
			s: ANNOTATED_ARRAYED_SET [G]
			i: INTEGER
		do
			create s.make (0)
			if next_random_item \\ 2 = 0 then
				check
					changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
				end
				s.compare_objects
			end
			⟳ j: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
			if s.count > 0 then
				i := (next_random_item \\ s.count) + 1
				check
					valid_index: s.valid_index (i) -- 1 <= i <= s.count
				end
			end
			assert ("at", s.count > 0 ⇒ attached s.at (i) ⇒ True)
		end

	test_has
			-- Test {ANNOTATED_ARRAYED_SET}.has.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.has"
		local
			s: ANNOTATED_ARRAYED_SET [G]
		do
			create s.make (0)
			if next_random_item \\ 2 = 0 then
				check
					changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
				end
				s.compare_objects
			end
			⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
			assert ("has", s ∋ some_object_a ⇒ True)
		end

	test_index_of
			-- Test {ANNOTATED_ARRAYED_SET}.index_of.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.index_of"
		local
			s: ANNOTATED_ARRAYED_SET [G]
		do
			create s.make (0)
			if next_random_item \\ 2 = 0 then
				check
					changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
				end
				s.compare_objects
			end
			⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
			assert ("index_of", attached s.index_of (some_object_a, 1))
		end

	test_array_item
			-- Test {ANNOTATED_ARRAYED_SET}.array_item.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.array_item"
		local
			s: ANNOTATED_ARRAYED_SET [G]
			j: INTEGER
		do
			create s.make (0)
			if next_random_item \\ 2 = 0 then
				check
					changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
				end
				s.compare_objects
			end
			⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
			if s.count > 0 then
				j := next_random_item \\ s.count
			end
			assert ("array_item", s.array_valid_index (j) ⇒ attached s.array_item (j) ⇒ True)
		end

feature -- Test routines (Measurement)

	test_occurrences
			-- Test {ANNOTATED_ARRAYED_SET}.occurrences.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.occurrences"
		local
			s: ANNOTATED_ARRAYED_SET [G]
		do
			create s.make (0)
			if next_random_item \\ 2 = 0 then
				check
					changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
				end
				s.compare_objects
			end
			⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
			assert ("occurrences", attached s.occurrences (some_object_a))
		end

feature -- Test routines (Comparison)

	test_disjoint
			-- Test {ANNOTATED_ARRAYED_SET}.disjoint.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.disjoint"
			EIS: "name=Error within implementation of {ARRAYED_SET}.disjoint", "protocol=URI", "src=https://support.eiffel.com/report_detail/19894", "tag=Bug, EiffelBase"
		local
			s1, s2: ANNOTATED_ARRAYED_SET [G]
		do
			create s1.make (0)
			if next_random_item \\ 2 = 0 then
				s1.compare_objects
			end
			⟳ i: 1 |..| some_count.as_integer_32 ¦ s1.extend (some_object_a) ⟲
			create s2.make (0)
			if s1.object_comparison then
				s2.compare_objects
			end
			⟳ i: 1 |..| some_count.as_integer_32 ¦ s2.extend (some_object_a) ⟲
			assert ("disjoint", attached s1.disjoint (s2))
		rescue
			if attached {PRECONDITION_VIOLATION} {EXCEPTION_MANAGER}.last_exception as pv then
				if pv.description ~ "item_exists" and pv.recipient_name ~ "subset_strategy" then
						-- https://support.eiffel.com/report_detail/19894
					retry
				end
			end
		end

	test_is_equal
			-- Test {ANNOTATED_ARRAYED_SET}.is_equal.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.is_equal"
		local
			s1, s2: ANNOTATED_ARRAYED_SET [G]
		do
			create s1.make (0)
			if next_random_item \\ 2 = 0 then
				s1.compare_objects
			end
			⟳ i: 1 |..| some_count.as_integer_32 ¦ s1.extend (some_object_a) ⟲
			create s2.make (0)
			if s1.object_comparison then
				s2.compare_objects
			end
			⟳ i: 1 |..| some_count.as_integer_32 ¦ s2.extend (some_object_a) ⟲
			assert ("is_equal", attached s1.is_equal (s2))
		end

	test_is_subset
			-- Test {ANNOTATED_ARRAYED_SET}.is_subset.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.is_subset"
		local
			s1, s2: ANNOTATED_ARRAYED_SET [G]
		do
			create s1.make (0)
			if next_random_item \\ 2 = 0 then
				s1.compare_objects
			end
			⟳ i: 1 |..| some_count.as_integer_32 ¦ s1.extend (some_object_a) ⟲
			create s2.make (0)
			if s1.object_comparison then
				s2.compare_objects
			end
			⟳ i: 1 |..| some_count.as_integer_32 ¦ s2.extend (some_object_a) ⟲
			assert ("is_subset", attached (s1 ⊆ s2))
		end

	test_is_superset
			-- Test {ANNOTATED_ARRAYED_SET}.is_superset.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.is_superset"
		local
			s1, s2: ANNOTATED_ARRAYED_SET [G]
		do
			create s1.make (0)
			if next_random_item \\ 2 = 0 then
				s1.compare_objects
			end
			⟳ i: 1 |..| some_count.as_integer_32 ¦ s1.extend (some_object_a) ⟲
			create s2.make (0)
			if s1.object_comparison then
				s2.compare_objects
			end
			⟳ i: 1 |..| some_count.as_integer_32 ¦ s2.extend (some_object_a) ⟲
			assert ("is_superset", attached (s1 ⊇ s2))
		end

feature -- Test routines (Status report)

	test_is_inserted
			-- Test {ANNOTATED_ARRAYED_SET}.is_inserted.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.is_inserted"
		local
			s: ANNOTATED_ARRAYED_SET [G]
		do
			create s.make (0)
			if next_random_item \\ 2 = 0 then
				check
					changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
				end
				s.compare_objects
			end
			⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
			assert ("is_inserted", s.is_inserted (some_object_a) ⇒ True)
		end

	test_valid_cursor
			-- Test {ANNOTATED_ARRAYED_SET}.valid_cursor.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.valid_cursor"
		local
			s: ANNOTATED_ARRAYED_SET [G]
			p: CURSOR
		do
			create s.make (0)
			if next_random_item \\ 2 = 0 then
				check
					changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
				end
				s.compare_objects
			end
			⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
			check
				good_divisor: s.count + 2 /= 0 -- 0 ≤ s
			end
			⟳ i: 1 |..| (next_random_item \\ (s.count + 2)) ¦
				check
					not_after: not s.after -- 0 ≤ s.index < s.count
				end
				s.forth
			⟲
			p := s.cursor
			⟳ i: 1 |..| some_count.as_integer_32 ¦ s.prune (some_object_a) ⟲
			assert ("valid_cursor", s.valid_cursor (p) ⇒ True)
		end

	test_valid_cursor_index
			-- Test {ANNOTATED_ARRAYED_SET}.valid_cursor_index.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.valid_cursor_index"
		local
			s: ANNOTATED_ARRAYED_SET [G]
		do
			create s.make (0)
			if next_random_item \\ 2 = 0 then
				check
					changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
				end
				s.compare_objects
			end
			⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
			assert ("valid_cursor_index", s.valid_cursor_index (some_integer + some_integer) ⇒ True)
		end

	test_valid_index
			-- Test {ANNOTATED_ARRAYED_SET}.valid_index.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.valid_index"
			EIS: "name=Wrong post-condition of {ARRAYED_SET}.valid_index", "protocol=URI", "src=https://support.eiffel.com/report_detail/19895", "tag=Bug, EiffelBase"
		local
			s: ANNOTATED_ARRAYED_SET [G]
		do
			create s.make (0)
			if next_random_item \\ 2 = 0 then
				check
					changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
				end
				s.compare_objects
			end
			⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
			assert ("valid_index", s.valid_index (some_integer + some_integer) ⇒ True)
		rescue
			if
				{EXCEPTIONS}.original_exception = {EXCEPTIONS}.postcondition and
				{EXCEPTIONS}.original_class_name ~ "ANNOTATED_ARRAYED_SET" and
				{EXCEPTIONS}.original_recipient_name ~ "valid_index" and
				{EXCEPTIONS}.original_tag_name ~ "index_valid"
			then
				retry
			end
		end

	test_array_valid_index
			-- Test {ANNOTATED_ARRAYED_SET}.array_valid_index.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.array_valid_index"
		local
			s: ANNOTATED_ARRAYED_SET [G]
		do
			create s.make (0)
			if next_random_item \\ 2 = 0 then
				check
					changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
				end
				s.compare_objects
			end
			⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
			assert ("array_valid_index", s.array_valid_index (some_integer + some_integer) ⇒ True)
		end

feature -- Test routines (Status setting)

	test_compare_objects
			-- Test {ANNOTATED_ARRAYED_SET}.compare_objects.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.compare_objects"
		do
			assert (
					"compare_objects", (
						agent: BOOLEAN
							do
								(create {ANNOTATED_ARRAYED_SET [G]}.make (0)).compare_objects
								Result := True
							end
					).item
				)
		end

	test_compare_references
			-- Test {ANNOTATED_ARRAYED_SET}.compare_references.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.compare_references"
		do
			assert (
					"compare_references", (
						agent: BOOLEAN
							do
								(create {ANNOTATED_ARRAYED_SET [G]}.make (0)).compare_references
								Result := True
							end
					).item
				)
		end

feature -- Test routines (Cursor movement)

	test_start
			-- Test {ANNOTATED_ARRAYED_SET}.start.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.start"
		do
			assert (
					"start", (
						agent: BOOLEAN
							local
								s: ANNOTATED_ARRAYED_SET [G]
							do
								create s.make (0)
								if next_random_item \\ 2 = 0 then
									check
										changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
									end
									s.compare_objects
								end
								⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
								s.start
								Result := True
							end
					).item
				)
		end

	test_back
			-- Test {ANNOTATED_ARRAYED_SET}.back.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.back"
		do
			assert (
					"back", (
						agent: BOOLEAN
							local
								s: ANNOTATED_ARRAYED_SET [G]
							do
								create s.make (0)
								if next_random_item \\ 2 = 0 then
									check
										changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
									end
									s.compare_objects
								end
								⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
								check
									valid_index: s.valid_cursor_index (s.count + 1) -- By definition
								end
								s.go_i_th (s.count + 1)
								⟳ i: 1 |..| (s.count + 1) ¦
									check not_before: not s.before end -- 1 ≤ s.index ≤ s.count + 1
									s.back
								⟲
								Result := True
							end
					).item
				)
		end

	test_forth
			-- Test {ANNOTATED_ARRAYED_SET}.forth.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.forth"
		do
			assert (
					"forth", (
						agent: BOOLEAN
							local
								s: ANNOTATED_ARRAYED_SET [G]
							do
								create s.make (0)
								if next_random_item \\ 2 = 0 then
									check
										changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
									end
									s.compare_objects
								end
								⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
								⟳
 i: 1 |..| (s.count + 1) ¦
									check not_after: not s.after end -- 0 ≤ s.index ≤ s.count
									s.forth
								⟲
								Result := True
							end
					).item
				)
		end

	test_finish
			-- Test {ANNOTATED_ARRAYED_SET}.finish.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.finish"
		do
			assert (
					"finish", (
						agent: BOOLEAN
							local
								s: ANNOTATED_ARRAYED_SET [G]
							do
								create s.make (0)
								if next_random_item \\ 2 = 0 then
									check
										changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
									end
									s.compare_objects
								end
								⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
								s.finish
								Result := True
							end
					).item
				)
		end

	test_go_i_th
			-- Test {ANNOTATED_ARRAYED_SET}.go_i_th.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.go_i_th"
		do
			assert (
					"go_i_th", (
						agent: BOOLEAN
							local
								s: ANNOTATED_ARRAYED_SET [G]
								i: INTEGER
							do
								create s.make (0)
								if next_random_item \\ 2 = 0 then
									check
										changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
									end
									s.compare_objects
								end
								⟳ j: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
								check
									good_divisor: s.count + 2 /= 0 -- 0 ≤ s.count
								end
								i := next_random_item \\ (s.count + 2)
								check
									valid_cursor_index: s.valid_cursor_index (i) -- 0 ≤ i ≤ s.count + 1
								end
								s.go_i_th (i)
								Result := True
							end
					).item
				)
		end

	test_go_to
			-- Test {ANNOTATED_ARRAYED_SET}.go_to.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.go_to"
		do
			assert (
					"go_to", (
						agent: BOOLEAN
							local
								s: ANNOTATED_ARRAYED_SET [G]
								p: CURSOR
							do
								create s.make (0)
								if next_random_item \\ 2 = 0 then
									check
										changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
									end
									s.compare_objects
								end
								⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
								⟳ i: 1 |..| (next_random_item \\ (s.count + 1)) ¦
									check
										not_after: not s.after -- 0 ≤ s.index < (s.count + 1)
									end
									s.forth
								⟲
								p := s.cursor
								check
									cursor_position_valid: s.valid_cursor (p) -- 0 ≤ p.index < (s.count + 1)
								end
								s.go_to (p)
								Result := True
							end
					).item
				)
		end

	test_move
			-- Test {ANNOTATED_ARRAYED_SET}.move.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.move"
		do
			assert (
					"move", (
						agent: BOOLEAN
							local
								s: ANNOTATED_ARRAYED_SET [G]
							do
								create s.make (0)
								if next_random_item \\ 2 = 0 then
									check
										changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
									end
									s.compare_objects
								end
								⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
								⟳ i: 1 |..| (next_random_item \\ (s.count + 1)) ¦
									check
										not_after: not s.after -- 0 ≤ s.index < (s.count + 1)
									end
									s.forth
								⟲
								s.move (some_integer)
								Result := True
							end
					).item
				)
		end

	test_search
			-- Test {ANNOTATED_ARRAYED_SET}.search.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.search"
		do
			assert (
					"search", (
						agent: BOOLEAN
							local
								s: ANNOTATED_ARRAYED_SET [G]
							do
								create s.make (0)
								if next_random_item \\ 2 = 0 then
									check
										changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
									end
									s.compare_objects
								end
								⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
								⟳ i: 1 |..| (next_random_item \\ (s.count + 1)) ¦
									check
										not_after: not s.after -- 0 ≤ s.index < (s.count + 1)
									end
									s.forth
								⟲
								s.search (some_object_a)
								Result := True
							end
					).item
				)
		end

feature -- Test routines (Element change)

	test_append
			-- Test {ANNOTATED_ARRAYED_SET}.append.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.append"
		do
			assert (
					"append", (
						agent: BOOLEAN
							local
								s: ANNOTATED_ARRAYED_SET [G]
								seq: SEQUENCE [G]
							do
								create s.make (0)
								if next_random_item \\ 2 = 0 then
									check
										changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
									end
									s.compare_objects
								end
								⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
								inspect
									next_random_item \\ 5
								when 0 then
									create {LINKED_LIST [G]} seq.make
								when 1 then
									create {ARRAYED_LIST [G]} seq.make (0)
								when 2 then
									create {ARRAYED_STACK [G]} seq.make (0)
								when 3 then
									create {ARRAYED_SET [G]} seq.make (0)
								when 4 then
									create {ANNOTATED_ARRAYED_SET [G]} seq.make (0)
								end
								⟳ i: 1 |..| some_count.as_integer_32 ¦ seq.extend (some_object_a) ⟲
								s.append (seq)
								Result := True
							end
					).item
				)
		end

	test_extend
			-- Test {ANNOTATED_ARRAYED_SET}.extend.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.extend"
		do
			assert (
					"extend", (
						agent: BOOLEAN
							local
								s: ANNOTATED_ARRAYED_SET [G]
							do
								create s.make (0)
								if next_random_item \\ 2 = 0 then
									check
										changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
									end
									s.compare_objects
								end
								⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
								s.extend (some_object_a)
								Result := True
							end
					).item
				)
		end

	test_al_extend
			-- Test {ANNOTATED_ARRAYED_SET}.al_extend.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.al_extend"
		do
			assert (
					"al_extend", (
						agent: BOOLEAN
							local
								s: ANNOTATED_ARRAYED_SET [G]
							do
								create s.make (0)
								if next_random_item \\ 2 = 0 then
									check
										changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
									end
									s.compare_objects
								end
								⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
								s.al_extend (some_object_a)
								Result := True
							end
					).item
				)
		end

	test_fill
			-- Test {ANNOTATED_ARRAYED_SET}.fill.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.fill"
		do
			assert (
					"fill", (
						agent: BOOLEAN
							local
								s: ANNOTATED_ARRAYED_SET [G]
								ll: LINKED_LIST [G]
								ls: LINKED_SET [G]
								al: ARRAYED_LIST [G]
								arrayed_stack: ARRAYED_STACK [G]
								arrayed_set: ARRAYED_SET [G]
								aas: ANNOTATED_ARRAYED_SET [G]
								a: ARRAY [G]
								aq: ARRAYED_QUEUE [G]
								ht: HASH_TABLE [G, INTEGER]
								st: STRING_TABLE [G]
								msr: MUTABLE_SET [G, STS_REFERENCE_EQUALITY [G]]
								msos: MUTABLE_SET [G, STS_OBJECT_STANDARD_EQUALITY [G]]
								mso: MUTABLE_SET [G, STS_OBJECT_EQUALITY [G]]
								msod: MUTABLE_SET [G, STS_OBJECT_DEEP_EQUALITY [G]]
								cont: CONTAINER [G]
							do
								create s.make (0)
								if next_random_item \\ 2 = 0 then
									check
										changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
									end
									s.compare_objects
								end
								⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
								inspect
									next_random_item \\ 14
								when 0 then
									create ll.make
									⟳ i: 1 |..| some_count.as_integer_32 ¦ ll.extend (some_object_a) ⟲
									cont := ll
								when 1 then
									create ls.make
									⟳ i: 1 |..| some_count.as_integer_32 ¦ ls.extend (some_object_a) ⟲
									cont := ls
								when 2 then
									create al.make (0)
									⟳ i: 1 |..| some_count.as_integer_32 ¦ al.extend (some_object_a) ⟲
									cont := al
								when 3 then
									create arrayed_stack.make (0)
									⟳ i: 1 |..| some_count.as_integer_32 ¦ arrayed_stack.extend (some_object_a) ⟲
									cont := arrayed_stack
								when 4 then
									create arrayed_set.make (0)
									⟳ i: 1 |..| some_count.as_integer_32 ¦ arrayed_set.extend (some_object_a) ⟲
									cont := arrayed_set
								when 5 then
									create aas.make (0)
									⟳ i: 1 |..| some_count.as_integer_32 ¦ aas.extend (some_object_a) ⟲
									cont := aas
								when 6 then
									create a.make_empty
									⟳ i: 1 |..| some_count.as_integer_32 ¦ a.force (some_object_a, a.upper + 1) ⟲
									cont := a
								when 7 then
									create aq.make (0)
									⟳ i: 1 |..| some_count.as_integer_32 ¦ aq.extend (some_object_a) ⟲
									cont := aq
								when 8 then
									create ht.make (0)
									⟳ i: 1 |..| some_count.as_integer_32 ¦ ht.extend (some_object_a, i) ⟲
									cont := ht
								when 9 then
									create st.make (0)
									⟳ i: 1 |..| some_count.as_integer_32 ¦ st.extend (some_object_a, i.out) ⟲
									cont := st
								when 10 then
									create msr.make_empty
									⟳ i: 1 |..| some_count.as_integer_32 ¦ msr.extend (some_object_a) ⟲
									cont := msr
								when 11 then
									create msos.make_empty
									⟳ i: 1 |..| some_count.as_integer_32 ¦ msos.extend (some_object_a) ⟲
									cont := msos
								when 12 then
									create mso.make_empty
									⟳ i: 1 |..| some_count.as_integer_32 ¦ mso.extend (some_object_a) ⟲
									cont := mso
								when 13 then
									create msod.make_empty
									⟳ i: 1 |..| some_count.as_integer_32 ¦ msod.extend (some_object_a) ⟲
									cont := msod
								end
								s.fill (cont)
								Result := True
							end
					).item
				)
		end

	test_force
			-- Test {ANNOTATED_ARRAYED_SET}.force.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.force"
		do
			assert (
					"force", (
						agent: BOOLEAN
							local
								s: ANNOTATED_ARRAYED_SET [G]
							do
								create s.make (0)
								if next_random_item \\ 2 = 0 then
									check
										changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
									end
									s.compare_objects
								end
								⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
								s.force (some_object_a)
								Result := True
							end
					).item
				)
		end

	test_merge
			-- Test {ANNOTATED_ARRAYED_SET}.merge.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.merge"
		do
			assert (
					"merge", (
						agent: BOOLEAN
							local
								s: ANNOTATED_ARRAYED_SET [G]
								ll: LINKED_LIST [G]
								ls: LINKED_SET [G]
								al: ARRAYED_LIST [G]
								arrayed_stack: ARRAYED_STACK [G]
								arrayed_set: ARRAYED_SET [G]
								aas: ANNOTATED_ARRAYED_SET [G]
								a: ARRAY [G]
								aq: ARRAYED_QUEUE [G]
								ht: HASH_TABLE [G, INTEGER]
								st: STRING_TABLE [G]
								msr: MUTABLE_SET [G, STS_REFERENCE_EQUALITY [G]]
								msos: MUTABLE_SET [G, STS_OBJECT_STANDARD_EQUALITY [G]]
								mso: MUTABLE_SET [G, STS_OBJECT_EQUALITY [G]]
								msod: MUTABLE_SET [G, STS_OBJECT_DEEP_EQUALITY [G]]
								cont: CONTAINER [G]
							do
								create s.make (0)
								if next_random_item \\ 2 = 0 then
									check
										changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
									end
									s.compare_objects
								end
								⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
								inspect
									next_random_item \\ 14
								when 0 then
									create ll.make
									if s.object_comparison then
										ll.compare_objects
									end
									⟳ i: 1 |..| some_count.as_integer_32 ¦ ll.extend (some_object_a) ⟲
									cont := ll
								when 1 then
									create ls.make
									if s.object_comparison then
										ls.compare_objects
									end
									⟳ i: 1 |..| some_count.as_integer_32 ¦ ls.extend (some_object_a) ⟲
									cont := ls
								when 2 then
									create al.make (0)
									if s.object_comparison then
										al.compare_objects
									end
									⟳ i: 1 |..| some_count.as_integer_32 ¦ al.extend (some_object_a) ⟲
									cont := al
								when 3 then
									create arrayed_stack.make (0)
									if s.object_comparison then
										arrayed_stack.compare_objects
									end
									⟳ i: 1 |..| some_count.as_integer_32 ¦ arrayed_stack.extend (some_object_a) ⟲
									cont := arrayed_stack
								when 4 then
									create arrayed_set.make (0)
									if s.object_comparison then
										arrayed_set.compare_objects
									end
									⟳ i: 1 |..| some_count.as_integer_32 ¦ arrayed_set.extend (some_object_a) ⟲
									cont := arrayed_set
								when 5 then
									create aas.make (0)
									if s.object_comparison then
										aas.compare_objects
									end
									⟳ i: 1 |..| some_count.as_integer_32 ¦ aas.extend (some_object_a) ⟲
									cont := aas
								when 6 then
									create a.make_empty
									if s.object_comparison then
										a.compare_objects
									end
									⟳ i: 1 |..| some_count.as_integer_32 ¦ a.force (some_object_a, a.upper + 1) ⟲
									cont := a
								when 7 then
									create aq.make (0)
									if s.object_comparison then
										aq.compare_objects
									end
									⟳ i: 1 |..| some_count.as_integer_32 ¦ aq.extend (some_object_a) ⟲
									cont := aq
								when 8 then
									create ht.make (0)
									if s.object_comparison then
										ht.compare_objects
									end
									⟳ i: 1 |..| some_count.as_integer_32 ¦ ht.extend (some_object_a, i) ⟲
									cont := ht
								when 9 then
									create st.make (0)
									if s.object_comparison then
										st.compare_objects
									end
									⟳ i: 1 |..| some_count.as_integer_32 ¦ st.extend (some_object_a, i.out) ⟲
									cont := st
								when 10 then
									create msr.make_empty
									if msr.object_comparison then
										msr.compare_objects
									end
									⟳ i: 1 |..| some_count.as_integer_32 ¦ msr.extend (some_object_a) ⟲
									cont := msr
								when 11 then
									create msos.make_empty
									if s.object_comparison then
										msos.compare_objects
									end
									⟳ i: 1 |..| some_count.as_integer_32 ¦ msos.extend (some_object_a) ⟲
									cont := msos
								when 12 then
									create mso.make_empty
									if s.object_comparison then
										mso.compare_objects
									end
									⟳ i: 1 |..| some_count.as_integer_32 ¦ mso.extend (some_object_a) ⟲
									cont := mso
								when 13 then
									create msod.make_empty
									if s.object_comparison then
										msod.compare_objects
									end
									⟳ i: 1 |..| some_count.as_integer_32 ¦ msod.extend (some_object_a) ⟲
									cont := msod
								end
								s.merge (cont)
								Result := True
							end
					).item
				)
		end

	test_merge_left
			-- Test {ANNOTATED_ARRAYED_SET}.merge_left.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.merge_left"
		do
			assert (
					"merge_left", (
						agent: BOOLEAN
							local
								s: ANNOTATED_ARRAYED_SET [G]
								al: ARRAYED_LIST [G]
							do
								create s.make (0)
								if next_random_item \\ 2 = 0 then
									check
										changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
									end
									s.compare_objects
								end
								⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
								inspect
									next_random_item \\ 4
								when 0 then
									create al.make (0)
								when 1 then
									create {ARRAYED_STACK [G]} al.make (0)
								when 2 then
									create {ARRAYED_SET [G]} al.make (0)
								when 3 then
									create {ANNOTATED_ARRAYED_SET [G]} al.make (0)
								end
								if s.object_comparison then
									al.compare_objects
								end
								⟳ i: 1 |..| some_count.as_integer_32 ¦ al.extend (some_object_a) ⟲
								s.start
								⟳ i: 1 |..| (next_random_item \\ (s.count + 1)) ¦
									check not_after: not s.after end -- 1 ≤ s.index ≤ s.count
									s.forth
								⟲
								check
									not_before: not s.before -- 1 ≤ s.index ≤ s.count + 1
								end
								s.merge_left (al)
								Result := True
							end
					).item
				)
		end

	test_merge_right
			-- Test {ANNOTATED_ARRAYED_SET}.merge_right.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.merge_right"
		do
			assert (
					"merge_right", (
						agent: BOOLEAN
							local
								s: ANNOTATED_ARRAYED_SET [G]
								al: ARRAYED_LIST [G]
							do
								create s.make (0)
								if next_random_item \\ 2 = 0 then
									check
										changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
									end
									s.compare_objects
								end
								⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
								inspect
									next_random_item \\ 4
								when 0 then
									create al.make (0)
								when 1 then
									create {ARRAYED_STACK [G]} al.make (0)
								when 2 then
									create {ARRAYED_SET [G]} al.make (0)
								when 3 then
									create {ANNOTATED_ARRAYED_SET [G]} al.make (0)
								end
								if s.object_comparison then
									al.compare_objects
								end
								⟳ i: 1 |..| some_count.as_integer_32 ¦ al.extend (some_object_a) ⟲
								s.finish
								⟳ i: 1 |..| (next_random_item \\ (s.count + 1)) ¦
									check not_before: not s.before end -- 1 ≤ s.index ≤ s.count
									s.back
								⟲
								check
									not_after: not s.after -- 0 ≤ s.index ≤ s.count
								end
								s.merge_right (al)
								Result := True
							end
					).item
				)
		end

	test_move_item
			-- Test {ANNOTATED_ARRAYED_SET}.move_item.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.move_item"
			EIS: "name={ARRAYED_SET}.move_item does not fulfill {ARRAYED_SET}.put_left precondition.", "protocol=URI", "src=https://support.eiffel.com/report_detail/19896", "tag=Bug, EiffelBase"
			EIS: "name={ARRAYED_SET}.move_item does not fulfill {ARRAYED_SET}.go_i_th precondition.", "protocol=URI", "src=https://support.eiffel.com/report_detail/19897", "tag=Bug, EiffelBase"
			EIS: "name=Possibly unnecessary precondition in {ARRAYED_SET}.move_item: item_exists", "protocol=URI", "src=https://support.eiffel.com/report_detail/19898", "tag=Bug, EiffelBase"
		do
			assert (
					"move_item", (
						agent: BOOLEAN
							local
								v: G
								s: ANNOTATED_ARRAYED_SET [G]
							do
								create s.make (0)
								if next_random_item \\ 2 = 0 then
									check
										changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
									end
									s.compare_objects
								end
								⟳ i: 1 |..| some_count.as_integer_32 ¦
									from
										v := some_object_a
									until
										v /= Void
									loop
										v := some_object_a
									end
									s.extend (v)
								⟲
								from
									v := some_object_a
								until
									v /= Void
								loop
									v := some_object_a
								end
								s.extend (v)
								⟳ i: 1 |..| (next_random_item \\ (s.count + 1)) ¦
									check not_after: not s.after end -- 0 ≤ s.index ≤ s.count
									s.forth
								⟲
								check
									item_exists: v /= Void -- Loops above
									item_in_set: s.has (v) -- Above: s.extend (v)
								end
								s.move_item (v)
								Result := True
							rescue
								if
									attached {PRECONDITION_VIOLATION} {EXCEPTION_MANAGER}.last_exception as pv and then
									(pv.recipient_name ~ "move_item" and (pv.description ~ "valid_index" or pv.description ~ "not_before"))
								then
									retry
								end
							end
					).item
				)
		end

	test_put
			-- Test {ANNOTATED_ARRAYED_SET}.put.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.put"
		do
			assert (
					"put", (
						agent: BOOLEAN
							local
								s: ANNOTATED_ARRAYED_SET [G]
							do
								create s.make (0)
								if next_random_item \\ 2 = 0 then
									check
										changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
									end
									s.compare_objects
								end
								⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
								s.put (some_object_a)
								Result := True
							end
					).item
				)
		end

	test_array_put
			-- Test {ANNOTATED_ARRAYED_SET}.array_put.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.array_put"
		do
			assert (
					"array_put", (
						agent: BOOLEAN
							local
								s: ANNOTATED_ARRAYED_SET [G]
								i: INTEGER
							do
								create s.make (0)
								if next_random_item \\ 2 = 0 then
									check
										changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
									end
									s.compare_objects
								end
								⟳ j: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
								s.extend (some_object_a)
								check good_divisor: s.count > 0 end
								i := next_random_item \\ s.count
								check valid_index: s.array_valid_index (i) end -- 0 ≤ i < s.count
								s.array_put (some_object_a, i)
								Result := True
							end
					).item
				)
		end

	test_al_put
			-- Test {ANNOTATED_ARRAYED_SET}.al_put.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.al_put"
		do
			assert (
					"al_put", (
						agent: BOOLEAN
							local
								s: ANNOTATED_ARRAYED_SET [G]
							do
								create s.make (0)
								if next_random_item \\ 2 = 0 then
									check
										changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
									end
									s.compare_objects
								end
								⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
								s.extend (some_object_a)
								s.start
								check good_divisor: s.count > 0 end
								⟳ i: 1 |..| (next_random_item \\ s.count) ¦
									check not_after: not s.after end -- 1 ≤ s.index < s.count
									s.forth
								⟲
								check writeable: s.writable end -- 1 ≤ s.index ≤ s.count
								s.al_put (some_object_a)
								Result := True
							end
					).item
				)
		end

	test_sequence_put
			-- Test {ANNOTATED_ARRAYED_SET}.sequence_put.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.sequence_put"
		do
			assert (
					"sequence_put", (
						agent: BOOLEAN
							local
								s: ANNOTATED_ARRAYED_SET [G]
							do
								create s.make (0)
								if next_random_item \\ 2 = 0 then
									check
										changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
									end
									s.compare_objects
								end
								⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
								s.sequence_put (some_object_a)
								Result := True
							end
					).item
				)
		end

	test_put_front
			-- Test {ANNOTATED_ARRAYED_SET}.put_front.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.put_front"
		do
			assert (
					"put_front", (
						agent: BOOLEAN
							local
								s: ANNOTATED_ARRAYED_SET [G]
							do
								create s.make (0)
								if next_random_item \\ 2 = 0 then
									check
										changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
									end
									s.compare_objects
								end
								⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
								s.put_front (some_object_a)
								Result := True
							end
					).item
				)
		end

	test_put_i_th
			-- Test {ANNOTATED_ARRAYED_SET}.put_i_th.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.put_i_th"
		do
			assert (
					"put_i_th", (
						agent: BOOLEAN
							local
								s: ANNOTATED_ARRAYED_SET [G]
								i: INTEGER
							do
								create s.make (0)
								if next_random_item \\ 2 = 0 then
									check
										changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
									end
									s.compare_objects
								end
								⟳ j: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
								s.extend (some_object_a)
								check
									good_divisor: s.count /= 0 -- s.count > 0
								end
								i := 1 + next_random_item \\ s.count
								check
									valid_key: s.valid_index (i) -- 1 ≤ i ≤ s.count
								end
								s.put_i_th (some_object_a, i)
								Result := True
							end
					).item
				)
		end

	test_put_left
			-- Test {ANNOTATED_ARRAYED_SET}.put_left.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.put_left"
		do
			assert (
					"put_left", (
						agent: BOOLEAN
							local
								s: ANNOTATED_ARRAYED_SET [G]
							do
								create s.make (0)
								if next_random_item \\ 2 = 0 then
									check
										changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
									end
									s.compare_objects
								end
								⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
								check not_after: not s.after end -- s.index = 0
								s.forth
								check not_before: not s.before end -- Above: s.forth
								s.put_left (some_object_a)
								Result := True
							end
					).item
				)
		end

	test_put_right
			-- Test {ANNOTATED_ARRAYED_SET}.put_right.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.put_right"
		do
			assert (
					"put_right", (
						agent: BOOLEAN
							local
								s: ANNOTATED_ARRAYED_SET [G]
							do
								create s.make (0)
								if next_random_item \\ 2 = 0 then
									check
										changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
									end
									s.compare_objects
								end
								⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
								check not_after: not s.after end -- No cursor movement above.
								s.put_right (some_object_a)
								Result := True
							end
					).item
				)
		end

	test_replace
			-- Test {ANNOTATED_ARRAYED_SET}.replace.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.replace"
		do
			assert (
					"replace", (
						agent: BOOLEAN
							local
								s: ANNOTATED_ARRAYED_SET [G]
							do
								create s.make (0)
								if next_random_item \\ 2 = 0 then
									check
										changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
									end
									s.compare_objects
								end
								⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
								s.extend (some_object_a)
								s.start
								check good_divisor: s.count > 0 end
								⟳ i: 1 |..| (next_random_item \\ s.count) ¦
									check not_after: not s.after end -- 1 ≤ s.index < s.count
									s.forth
								⟲
								check writeable: s.writable end -- 1 ≤ s.index ≤ s.count
								s.replace (some_object_a)
								Result := True
							end
					).item
				)
		end

feature -- Test routines (Removal)

	test_prune
			-- Test {ANNOTATED_ARRAYED_SET}.prune.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.prune"
		do
			assert (
					"prune", (
						agent: BOOLEAN
							local
								s: ANNOTATED_ARRAYED_SET [G]
							do
								create s.make (0)
								if next_random_item \\ 2 = 0 then
									check
										changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
									end
									s.compare_objects
								end
								⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
								s.prune (some_object_a)
								Result := True
							end
					).item
				)
		end

	test_al_prune
			-- Test {ANNOTATED_ARRAYED_SET}.al_prune.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.al_prune"
		do
			assert (
					"al_prune", (
						agent: BOOLEAN
							local
								s: ANNOTATED_ARRAYED_SET [G]
							do
								create s.make (0)
								if next_random_item \\ 2 = 0 then
									check
										changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
									end
									s.compare_objects
								end
								⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
								⟳ i: 1 |..| (next_random_item \\ (s.count + 1)) ¦
									check
										not_after: not s.after -- 0 ≤ s.index < (s.count + 1)
									end
									s.forth
								⟲
								s.al_prune (some_object_a)
								Result := True
							end
					).item
				)
		end

	test_prune_all
			-- Test {ANNOTATED_ARRAYED_SET}.prune_all.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.prune_all"
		do
			assert (
					"prune_all", (
						agent: BOOLEAN
							local
								s: ANNOTATED_ARRAYED_SET [G]
							do
								create s.make (0)
								if next_random_item \\ 2 = 0 then
									check
										changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
									end
									s.compare_objects
								end
								⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
								⟳ i: 1 |..| (next_random_item \\ (s.count + 1)) ¦
									check
										not_after: not s.after -- 0 ≤ s.index < (s.count + 1)
									end
									s.forth
								⟲
								s.prune_all (some_object_a)
								Result := True
							end
					).item
				)
		end

	test_remove
			-- Test {ANNOTATED_ARRAYED_SET}.remove.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.remove"
		do
			assert (
					"remove", (
						agent: BOOLEAN
							local
								s: ANNOTATED_ARRAYED_SET [G]
							do
								create s.make (0)
								if next_random_item \\ 2 = 0 then
									check
										changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
									end
									s.compare_objects
								end
								s.extend (some_object_a)
								⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
								s.start
								check good_divisor: s.count /= 0 end -- 0 < s.count
								⟳ i: 1 |..| (next_random_item \\ s.count) ¦
									check
										not_after: not s.after -- 0 < s.index ≤ s.count
									end
									s.forth
								⟲
								s.remove
								Result := True
							end
					).item
				)
		end

	test_remove_i_th
			-- Test {ANNOTATED_ARRAYED_SET}.remove_i_th.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.remove_i_th"
		do
			assert (
					"remove_i_th", (
						agent: BOOLEAN
							local
								s: ANNOTATED_ARRAYED_SET [G]
								i: INTEGER
							do
								create s.make (0)
								if next_random_item \\ 2 = 0 then
									check
										changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
									end
									s.compare_objects
								end
								⟳ j: 1 |..| some_index.as_integer_32 ¦ s.extend (some_object_a) ⟲
								i := (next_random_item \\ s.count) + 1
								check
									valid_index: s.valid_index (i) -- 1 <= i <= s.count
								end
								s.remove_i_th (i)
								Result := True
							end
					).item
				)
		end

	test_remove_left
			-- Test {ANNOTATED_ARRAYED_SET}.remove_left.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.remove_left"
		do
			assert (
					"remove_left", (
						agent: BOOLEAN
							local
								s: ANNOTATED_ARRAYED_SET [G]
							do
								create s.make (0)
								if next_random_item \\ 2 = 0 then
									check
										changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
									end
									s.compare_objects
								end
								⟳ i: 1 |..| some_index.as_integer_32 ¦ s.extend (some_object_a) ⟲
								s.start
								⟳ i: 1 |..| ((next_random_item \\ s.count) + 1) ¦
									check
										not_after: not s.after -- 0 < s.index ≤ s.count
									end
									s.forth
								⟲
								check
									left_exists: s.index > 1 -- 1 < s.index ≤ s.count + 1
								end
								s.remove_left
								Result := True
							end
					).item
				)
		end

	test_remove_right
			-- Test {ANNOTATED_ARRAYED_SET}.remove_right.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.remove_right"
		do
			assert (
					"remove_right", (
						agent: BOOLEAN
							local
								s: ANNOTATED_ARRAYED_SET [G]
							do
								create s.make (0)
								if next_random_item \\ 2 = 0 then
									check
										changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
									end
									s.compare_objects
								end
								⟳ i: 1 |..| some_index.as_integer_32 ¦ s.extend (some_object_a) ⟲
								s.finish
								⟳ i: 1 |..| ((next_random_item \\ s.count) + 1) ¦
									check
										not_before: not s.before -- 0 < s.index ≤ s.count
									end
									s.back
								⟲
								check
									right_exists: s.index < s.count -- 0 ≤ s.index < s.count
								end
								s.remove_right
								Result := True
							end
					).item
				)
		end

	test_wipe_out
			-- Test {ANNOTATED_ARRAYED_SET}.wipe_out.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.wipe_out"
		do
			assert (
					"wipe_out", (
						agent: BOOLEAN
							local
								s: ANNOTATED_ARRAYED_SET [G]
							do
								create s.make (0)
								if next_random_item \\ 2 = 0 then
									check
										changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
									end
									s.compare_objects
								end
								⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
								check
									good_divisor: s.count + 2 /= 0 -- 0 ≤ s.count
								end
								⟳ i: 1 |..| (next_random_item \\ (s.count + 2)) ¦
									check
										not_after: not s.after -- 0 < s.index ≤ s.count
									end
									s.forth
								⟲
								s.wipe_out
								Result := True
							end
					).item
				)
		end

feature -- Test routines (Transformation)

	test_swap
			-- Test {ANNOTATED_ARRAYED_SET}.swap.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.swap"
		do
			assert (
					"swap", (
						agent: BOOLEAN
							local
								s: ANNOTATED_ARRAYED_SET [G]
								i: INTEGER
							do
								create s.make (0)
								if next_random_item \\ 2 = 0 then
									check
										changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
									end
									s.compare_objects
								end
								⟳ j: 1 |..| some_index.as_integer_32 ¦ s.extend (some_object_a) ⟲
								check
									good_divisor: s.count /= 0 -- 0 < s.count
								end
								⟳ j: 1 |..| (next_random_item \\ s.count + 1) ¦
									check
										not_after: not s.after -- 0 ≤ s.index < s.count
									end
									s.forth
								⟲
								i := (next_random_item \\ s.count) + 1
								check
									valid_index: s.valid_index (i) -- 1 ≤ i ≤ s.count
								end
								s.swap (i)
								Result := True
							end
					).item
				)
		end

feature -- Test routines (Basic operations)

	test_intersect
			-- Test {ANNOTATED_ARRAYED_SET}.intersect.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.intersect"
		do
			assert (
					"intersect", (
						agent: BOOLEAN
							local
								s1: ANNOTATED_ARRAYED_SET [G]
								s2: ARRAYED_SET [G]
							do
								create s1.make (0)
								create s2.make (0)
								if next_random_item \\ 2 = 0 then
									check
										changeable_comparison_criterion_1: s1.changeable_comparison_criterion -- s1.is_empty
										changeable_comparison_criterion_2: s2.changeable_comparison_criterion -- s2.is_empty
									end
									s1.compare_objects
									s2.compare_objects
								end
								⟳ i: 1 |..| some_index.as_integer_32 ¦ s1.extend (some_object_a) ⟲
								⟳ i: 1 |..| some_index.as_integer_32 ¦ s2.extend (some_object_a) ⟲
								check
									good_divisor_1: s1.count + 2 /= 0 -- 0 ≤ s1.count
									valid_cursor_index_1: -- By definition
										((next_random_item \\ (s1.count + 2) >= 0) and (next_random_item \\ (s1.count + 2) <= s1.count + 1))
									good_divisor_2: s2.count + 2 /= 0 -- 0 ≤ s2.count
									valid_cursor_index_2: -- By definition
										((next_random_item \\ (s2.count + 2) >= 0) and (next_random_item \\ (s2.count + 2) <= s2.count + 1))
								end
								s1.go_i_th (next_random_item \\ (s1.count + 2))
								s2.go_i_th (next_random_item \\ (s2.count + 2))
								s1.intersect (s2)
								Result := True
							end
					).item
				)
		end

	test_subtract
			-- Test {ANNOTATED_ARRAYED_SET}.subtract.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.subtract"
		do
			assert (
					"subtract", (
						agent: BOOLEAN
							local
								s1: ANNOTATED_ARRAYED_SET [G]
								s2: ARRAYED_SET [G]
							do
								create s1.make (0)
								create s2.make (0)
								if next_random_item \\ 2 = 0 then
									check
										changeable_comparison_criterion_1: s1.changeable_comparison_criterion -- s1.is_empty
										changeable_comparison_criterion_2: s2.changeable_comparison_criterion -- s2.is_empty
									end
									s1.compare_objects
									s2.compare_objects
								end
								⟳ i: 1 |..| some_index.as_integer_32 ¦ s1.extend (some_object_a) ⟲
								⟳ i: 1 |..| some_index.as_integer_32 ¦ s2.extend (some_object_a) ⟲
								check
									good_divisor_1: s1.count + 2 /= 0 -- 0 ≤ s1.count
									valid_cursor_index_1: -- By definition
										((next_random_item \\ (s1.count + 2) >= 0) and (next_random_item \\ (s1.count + 2) <= s1.count + 1))
									good_divisor_2: s2.count + 2 /= 0 -- 0 ≤ s2.count
									valid_cursor_index_2: -- By definition
										((next_random_item \\ (s2.count + 2) >= 0) and (next_random_item \\ (s2.count + 2) <= s2.count + 1))
								end
								s1.go_i_th (next_random_item \\ (s1.count + 2))
								s2.go_i_th (next_random_item \\ (s2.count + 2))
								s1.subtract (s2)
								Result := True
							end
					).item
				)
		end

	test_symdif
			-- Test {ANNOTATED_ARRAYED_SET}.symdif.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.symdif"
			EIS: "name=Bug: wrong implementation of {ARRAYED_SET}.symdif", "protocol=URI", "src=https://support.eiffel.com/report_detail/19921", "tag=bug, library, EiffelBase"
			EIS: "name=Bug: Unexpected exception from {ARRAYED_SET} set operations", "protocol=URI", "src=https://support.eiffel.com/report_detail/19922", "tag=bug, library, EiffelBase"
		do
			assert (
					"symdif", (
						agent: BOOLEAN
							local
								s1: ANNOTATED_ARRAYED_SET [G]
								s2: ARRAYED_SET [G]
							do
								create s1.make (0)
								create s2.make (0)
								if next_random_item \\ 2 = 0 then
									check
										changeable_comparison_criterion_1: s1.changeable_comparison_criterion -- s1.is_empty
										changeable_comparison_criterion_2: s2.changeable_comparison_criterion -- s2.is_empty
									end
									s1.compare_objects
									s2.compare_objects
								end
								⟳ i: 1 |..| some_index.as_integer_32 ¦ s1.extend (some_object_a) ⟲
								⟳ i: 1 |..| some_index.as_integer_32 ¦ s2.extend (some_object_a) ⟲
								check
									good_divisor_1: s1.count + 2 /= 0 -- 0 ≤ s1.count
									valid_cursor_index_1: -- By definition
										((next_random_item \\ (s1.count + 2) >= 0) and (next_random_item \\ (s1.count + 2) <= s1.count + 1))
									good_divisor_2: s2.count + 2 /= 0 -- 0 ≤ s2.count
									valid_cursor_index_2: -- By definition
										((next_random_item \\ (s2.count + 2) >= 0) and (next_random_item \\ (s2.count + 2) <= s2.count + 1))
								end
								s1.go_i_th (next_random_item \\ (s1.count + 2))
								s2.go_i_th (next_random_item \\ (s2.count + 2))
								s1.symdif (s2)
								Result := True
							end
					).item
				)
		end

feature -- Factory (Iteration)

	test_for_all
			-- Test {ANNOTATED_ARRAYED_SET}.for_all.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.for_all"
		do
			assert (
					"for_all", (
						agent: BOOLEAN
							local
								s: ANNOTATED_ARRAYED_SET [G]
							do
								create s.make (0)
								if next_random_item \\ 2 = 0 then
									check
										changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
									end
									s.compare_objects
								end
								⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
								check
									good_divisor: s.count + 2 /= 0 -- 0 ≤ s.count
									valid_cursor_index: -- By definition
										((next_random_item \\ (s.count + 2) >= 0) and (next_random_item \\ (s.count + 2) <= s.count + 1))
								end
								s.go_i_th (next_random_item \\ (s.count + 2))
								Result := s.for_all (agent (x: G): BOOLEAN do Result := x ~ x end)
							end
					).item
				)
		end

	test_there_exists
			-- Test {ANNOTATED_ARRAYED_SET}.there_exists.
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.there_exists"
		do
			assert (
					"there_exists", (
						agent: BOOLEAN
							local
								s: ANNOTATED_ARRAYED_SET [G]
							do
								create s.make (0)
								if next_random_item \\ 2 = 0 then
									check
										changeable_comparison_criterion: s.changeable_comparison_criterion -- s.is_empty
									end
									s.compare_objects
								end
								⟳ i: 1 |..| some_count.as_integer_32 ¦ s.extend (some_object_a) ⟲
								check
									good_divisor: s.count + 2 /= 0 -- 0 ≤ s.count
									valid_cursor_index: -- By definition
										((next_random_item \\ (s.count + 2) >= 0) and (next_random_item \\ (s.count + 2) <= s.count + 1))
								end
								s.go_i_th (next_random_item \\ (s.count + 2))
								Result := s.there_exists (agent (x: G): BOOLEAN do Result := x ~ x end) ⇒ True
							end
					).item
				)
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
	copyright: "Copyright (c) 2012-2024, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
