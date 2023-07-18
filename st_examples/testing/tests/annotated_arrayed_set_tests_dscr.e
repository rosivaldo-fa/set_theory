note
	description: "Test suite for {ANNOTATED_ARRAYED_SET [detachable separate CHARACTER_REF]}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"
	EIS: "name=Unnamed", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_examples.html#st_examples_tests"

class
	ANNOTATED_ARRAYED_SET_TESTS_DSCR

inherit
	ANNOTATED_ARRAYED_SET_TESTS [
	detachable separate CHARACTER_REF,
	STS_REFERENCE_EQUALITY [detachable separate CHARACTER_REF] -- Ad hoc equality. Please see file://$(system_path)/docs/EIS/st_examples.html#st_examples_tests.
	]
		rename
			some_object_a as some_separate_character_ref,
			some_immediate_set_a as some_immediate_set_of_references_dscr,
			some_set_a as some_set_of_references_dscr
		redefine
			test_make,
			test_make_filled,
			test_make_from_array,
			test_make_from_iterable,
			test_array_at,
			test_i_th,
			test_at,
			test_has,
			test_index_of,
			test_array_item,
			test_occurrences,
			test_disjoint,
			test_is_equal,
			test_is_subset,
			test_is_superset,
			test_is_inserted,
			test_valid_cursor,
			test_valid_cursor_index,
			test_valid_index,
			test_array_valid_index,
			test_compare_objects,
			test_compare_references,
			test_start,
			test_back,
			test_forth,
			test_finish,
			test_go_i_th,
			test_go_to,
			test_move,
			test_search,
			test_append,
			test_extend,
			test_al_extend,
			test_fill,
			test_force,
			test_merge,
			test_merge_left
		end

feature -- Test routines (Initialization)

	test_make
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.make"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_make_filled
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.make_filled"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_make_from_array
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.make_from_array"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_make_from_iterable
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.make_from_iterable"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

feature -- Test routines (Access)

	test_array_at
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.array_at"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_i_th
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.i_th"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_at
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.at"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_has
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.has"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_index_of
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.index_of"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_array_item
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.array_item"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

feature -- Test routines (Measurement)

	test_occurrences
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.occurrences"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

feature -- Test routines (Comparison)

	test_disjoint
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.disjoint"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_is_equal
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.is_equal"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_is_subset
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.is_subset"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_is_superset
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.is_superset"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

feature -- Test routines (Status report)

	test_is_inserted
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.is_inserted"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_valid_cursor
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.valid_cursor"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_valid_cursor_index
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.valid_cursor_index"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_valid_index
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.valid_index"
			EIS: "name=Wrong post-condition of {ARRAYED_SET}.valid_index", "protocol=URI", "src=https://support.eiffel.com/report_detail/19895", "tag=Bug, EiffelBase"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_array_valid_index
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.array_valid_index"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

feature -- Test routines (Status setting)

	test_compare_objects
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.compare_objects"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_compare_references
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.compare_references"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

feature -- Test routines (Cursor movement)

	test_start
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.start"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_back
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.back"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_forth
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.forth"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_finish
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.finish"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_go_i_th
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.go_i_th"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_go_to
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.go_to"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_move
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.move"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_search
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.search"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

feature -- Test routines (Element change)

	test_append
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.append"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_extend
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.extend"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_al_extend
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.al_extend"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_fill
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.fill"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_force
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.force"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_merge
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.merge"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_merge_left
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.merge_left"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

feature -- Mapping

	f_x (x: detachable separate CHARACTER_REF): detachable separate CHARACTER_REF
			-- <Precursor>
		do
			if attached x then
				check
						-- class invariant: (Min_character.natural_32_code + Max_count - 1).is_valid_character_code
					valid_character: ((x |-| Min_character + 2) \\ Max_count.as_integer_32 + Min_character.code).is_valid_character_8_code
				end
				Result := ((x |-| Min_character + 2) \\ Max_count.as_integer_32 + Min_character.code).to_character_8
			end
		end

feature -- Reduction

	f_acc_x (acc, x: detachable separate CHARACTER_REF): detachable separate CHARACTER_REF
			-- <Precursor>
		do
			if attached acc and attached x then
				check
						-- class invariant: (Min_character.natural_32_code + Max_count - 1).is_valid_character_code
					valid_character: ((acc |-| x.item).abs \\ Max_count.as_integer_32 + Min_character.code).is_valid_character_8_code
				end
				Result := ((acc |-| x.item).abs \\ Max_count.as_integer_32 + Min_character.code).to_character_8
			end
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
