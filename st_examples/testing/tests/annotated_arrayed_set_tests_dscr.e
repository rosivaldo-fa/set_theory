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
			test_model_set
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

feature -- Test routines (Model)

	test_model_set
			-- <Precursor>
		note
			testing: "covers/{ANNOTATED_ARRAYED_SET}.model_set"
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
