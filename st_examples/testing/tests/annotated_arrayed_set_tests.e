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
								Result := xs.reference_set_model ≍ reference_o
							end
					).item
				)
			assert (
					"no object",
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
									changeable_comparison_criterion: xs.changeable_comparison_criterion -- xs.is_empty ⇐ {ANNOTATED_ARRAYED_SET}.make definition
								end
								xs.compare_objects
								check
									compare_objects: xs.object_comparison -- {ANNOTATED_ARRAYED_SET}.compare_objects definition
								end
								Result := xs.object_set_model ≍ object_o
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
								Result := xs.reference_set_model ≍ reference_o
							end
					).item
				)
			assert (
					"discarded objects",
					(
						agent: BOOLEAN
							local
								n1, n2: INTEGER
								xs: ANNOTATED_ARRAYED_SET [G]
							do
								n1 := some_count.as_integer_32
								check
									valid_number_of_items: n1 >= 0 -- some_count definition
								end
								create xs.make (n1)
								⟳ i: 1 |..| some_count.as_integer_32 ¦
									xs.extend (some_object_a)
								⟲
								n2 := some_count.as_integer_32
								check
									valid_number_of_items: n2 >= 0 -- some_count definition
								end
								xs.make (n2)
								check
									changeable_comparison_criterion: xs.changeable_comparison_criterion -- xs.is_empty ⇐ {ANNOTATED_ARRAYED_SET}.make definition
								end
								xs.compare_objects
								check
									compare_objects: xs.object_comparison -- {ANNOTATED_ARRAYED_SET}.compare_objects definition
								end
								Result := xs.object_set_model ≍ object_o
							end
					).item
				)
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
