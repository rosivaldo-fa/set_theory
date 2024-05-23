﻿note
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
			test_merge_left,
			test_merge_right,
			test_move_item,
			test_put,
			test_array_put,
			test_al_put,
			test_sequence_put,
			test_put_front,
			test_put_i_th,
			test_put_left,
			test_put_right,
			test_replace,
			test_prune,
			test_al_prune,
			test_prune_all,
			test_remove,
			test_remove_i_th,
			test_remove_left,
			test_remove_right,
			test_wipe_out,
			test_swap,
			test_intersect,
			test_subtract,
			test_symdif
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

	test_merge_right
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.merge_right"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_move_item
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.move_item"
			EIS: "name={ARRAYED_SET}.move_item does not fulfill {ARRAYED_SET}.put_left precondition.", "protocol=URI", "src=https://support.eiffel.com/report_detail/19896", "tag=Bug, EiffelBase"
			EIS: "name={ARRAYED_SET}.move_item does not fulfill {ARRAYED_SET}.go_i_th precondition.", "protocol=URI", "src=https://support.eiffel.com/report_detail/19897", "tag=Bug, EiffelBase"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_put
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.put"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_array_put
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.array_put"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_al_put
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.al_put"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_sequence_put
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.sequence_put"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_put_front
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.put_front"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_put_i_th
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.put_i_th"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_put_left
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.put_left"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_put_right
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.put_right"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_replace
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.replace"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

feature -- Test routines (Removal)

	test_prune
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.prune"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_al_prune
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.al_prune"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_prune_all
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.prune_all"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_remove
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.remove"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_remove_i_th
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.remove_i_th"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_remove_left
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.remove_left"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_remove_right
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.remove_right"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_wipe_out
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.wipe_out"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

feature -- Test routines (Transformation)

	test_swap
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.swap"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

feature -- Test routines (Basic operations)

	test_intersect
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.intersect"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_subtract
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.subtract"
		do
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}
		end

	test_symdif
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.symdif"
			EIS: "name=Bug: wrong implementation of {ARRAYED_SET}.symdif", "protocol=URI", "src=https://support.eiffel.com/report_detail/19921", "tag=bug, library, EiffelBase"
		do
			from

			until
				false
			loop
			assert (
					"symdif", (
						agent: BOOLEAN
							local
								s1: ANNOTATED_ARRAYED_SET [detachable separate CHARACTER_REF]
								s2: ANNOTATED_ARRAYED_SET [detachable separate CHARACTER_REF]
							do
								create s1.make (0)
								create s2.make (0)
								s1.extend ('a')
								s2.extend (('a').to_reference)
								s1.symdif (s2)
								Result := True
							end
					).item
				)
			Precursor {ANNOTATED_ARRAYED_SET_TESTS}

			end
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
	copyright: "Copyright (c) 2012-2024, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
