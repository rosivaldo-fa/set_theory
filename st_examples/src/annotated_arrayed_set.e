note
	description: "A model-contracted version of the EiffelBase ARRAYED_SET."
	author: "Rosivaldo F Alves, based on ARRAYED_SET of EiffelBase"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Unnamed", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_examples.html#ANNOTATED_ARRAYED_SET"

class ANNOTATED_ARRAYED_SET [G]

inherit
	ARRAYED_SET [G]
		redefine
			make,
			make_filled,
			make_from_array,
			make_from_iterable,
			i_th, at
		end

create
	make,
	make_filled,
	make_from_array,
	make_from_iterable

convert
	make_from_iterable ({ARRAY [G]})

feature -- Initialization

	make (n: INTEGER)
			-- <Precursor>
		do
			Precursor {ARRAYED_SET} (n)
		ensure then
			empty_set: model_set.is_empty
		end

	make_filled (n: INTEGER)
			-- <Precursor>
		do
			Precursor {ARRAYED_SET} (n)
		ensure then
			empty_reference_set: n = 0 and not object_comparison ⇒ model_set.is_empty
			singleton_reference: n > 0 and not object_comparison ⇒ model_set ≍ model_set.singleton (({G}).default)
		end

feature {NONE} -- Initialization

	make_from_array (a: ARRAY [G])
			-- <Precursor>
		do
			Precursor {ARRAYED_SET} (a)
		ensure then
			compare_references: not object_comparison -- Default value
			nothing_lost: ∀ x: a ¦ model_set ∋ x -- TODO: Repeated creation?
			nothing_else: model_set |∀ agent a.has
		end

	make_from_iterable (other: ITERABLE [G])
			-- <Precursor>
		do
			Precursor {ARRAYED_SET} (other)
		ensure then
			compare_references: not object_comparison -- Default value
			nothing_lost: ∀ x: other ¦ model_set ∋ x -- TODO: Repeated creation?
			nothing_else: model_set |∀ agent (ia_other: ITERABLE [G]; y: G): BOOLEAN do Result := ∃ x: ia_other ¦ x = y end (other, ?) -- TODO: Don't use an inline agent?
		end

feature -- Model

	model_set: STS_SET [G, STS_EQUALITY [G]]
			-- Representation of current arrayed set as a mathematical set
		do
			if not object_comparison then
				create {STI_SET [G, STS_REFERENCE_EQUALITY [G]]} Result.make_empty
			else
				create {STI_SET [G, STS_OBJECT_EQUALITY [G]]} Result.make_empty
			end
			⟳ x: Current ¦ Result := Result & x ⟲
		ensure
			nothing_lost: ∀ x: Current ¦ Result ∋ x
			nothing_else: Result |∀ agent has
		end

feature -- Access

	i_th alias "[]", at alias "@" (i: INTEGER): like item assign put_i_th
			-- <Precursor>
		do
			Result := area_v2.item (i - 1)
		ensure then
			valid_element: model_set ∋ Result
		end

invariant
	reference_equality: not object_comparison ⇒ model_set.eq.generating_type <= {detachable STS_REFERENCE_EQUALITY [G]}
	object_equality: object_comparison ⇒ model_set.eq.generating_type <= {detachable STS_OBJECT_EQUALITY [G]}

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
