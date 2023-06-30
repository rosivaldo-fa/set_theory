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
					"no reference",
					(
						agent: BOOLEAN
							local
								n: INTEGER
								xs: ANNOTATED_ARRAYED_SET [G]
							do
								n := some_count.as_integer_32
								check
									valid_number_of_items: n >= 0 -- some_count definition
								end
								create xs.make (n)
								check
									compare_references: not xs.object_comparison -- Default value
								end
								Result := xs.model_set ≍ reference_o
							end
					).item
				)
			assert (
					"discarded references",
					(
						agent: BOOLEAN
							local
								n1, n2: INTEGER
								xs: ANNOTATED_ARRAYED_SET [G]
							do
								n1 := some_count.as_integer_32
								check
									valid_number_of_items_1: n1 >= 0 -- some_count definition
								end
								create xs.make (n1)
								⟳ i: 1 |..| some_count.as_integer_32 ¦
									xs.extend (some_object_a)
								⟲
								n2 := some_count.as_integer_32
								check
									valid_number_of_items_2: n2 >= 0 -- some_count definition
								end
								xs.make (n2)
								check
									compare_references: not xs.object_comparison -- Default value
								end
								Result := xs.model_set ≍ reference_o
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
				valid_number_of_items: n >= 0 -- some_count definition
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
				valid_number_of_items: n >= 0 -- some_count definition
			end
			create s.make (n)
			⟳ i: 1 |..| some_count.as_integer_32 ¦
				s.extend (some_object_a)
			⟲
			assert ("model_set", attached s.model_set)
		end

feature -- Factory (Object)

	same_object_s_a (s: ANNOTATED_ARRAYED_SET [G]; a: G): G
			-- Randomly-fetched object equal to `a'
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
