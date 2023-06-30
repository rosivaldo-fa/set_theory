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

			a := some_object_a
			s.extend (same_object_a (a)) -- TODO: Consider s.model_set.eq.
			assert ("{a}", s.model_set ≍ s.model_set.singleton (a)) -- TODO: Make an {ANNOTATED_ARRAYED_SET}.singleton.

			b := some_object_a
			s.extend (b)
			assert ("{a,b}", s.model_set ≍ (s.model_set.singleton (a) & b)) -- TODO: Make an {ANNOTATED_ARRAYED_SET}.singleton.

			c := some_object_a
			s.extend (c)
			assert ("{a,b,c}", s.model_set ≍ (s.model_set.singleton (a) & b & c)) -- TODO: Make an {ANNOTATED_ARRAYED_SET}.singleton.

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

feature {NONE} -- Factory (Set)

	reference_o: STI_SET [G, STS_REFERENCE_EQUALITY [G]]
			-- The empty set, i.e. {} or ∅, with elements compared by object references
			--| TODO: Make it once? An attribute?
		do
			create Result.make_empty
		end

	object_o: STI_SET [G, STS_OBJECT_EQUALITY [G]]
			-- The empty set, i.e. {} or ∅, with elements compared by object values
			--| TODO: Make it once? An attribute?
		do
			create Result.make_empty
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
