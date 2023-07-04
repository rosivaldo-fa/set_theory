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
			area,
			array_at,
			i_th, at,
			cursor,
			first,
			has,
			index_of
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
			s: attached model_set as s
			empty_set: n = 0 ⇒ s.is_empty
			singleton: n > 0 ⇒ s ≍ s.singleton (({G}).default)
		end

feature {NONE} -- Initialization

	make_from_array (a: ARRAY [G])
			-- <Precursor>
		do
			Precursor {ARRAYED_SET} (a)
		ensure then
			s: attached model_set as s
			nothing_lost: ∀ x: a ¦ s ∋ x
			nothing_else: s |∀ agent a.has
		end

	make_from_iterable (other: ITERABLE [G])
			-- <Precursor>
		do
			Precursor {ARRAYED_SET} (other)
		ensure then
			s: attached model_set as s
			nothing_lost: ∀ x: other ¦ s ∋ x
			nothing_else: s |∀ agent iterable_has_element_reference (other, ?)
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
			reference_equality: not object_comparison ⇒ Result.eq.generating_type <= {detachable STS_REFERENCE_EQUALITY [G]}
			object_equality: object_comparison ⇒ Result.eq.generating_type <= {detachable STS_OBJECT_EQUALITY [G]}
			nothing_lost: ∀ x: Current ¦ Result ∋ x
			nothing_else: Result |∀ agent has
		end

	model_indices: STI_SET [INTEGER, STS_OBJECT_EQUALITY [INTEGER]]
			-- Representation of current arrayed set's indices as a mathematical set
		do
			create Result.make_empty
			⟳ i: 0 |..| (count + 1) ¦ Result := Result.extended (i) ⟲
		ensure
			nothing_lost: ∀ i: 0 |..| (count + 1) ¦ Result ∋ i
			nothing_else: Result |∀ agent (0 |..| (count + 1)).has
		end

feature -- Access

	area: SPECIAL [G]
			-- <Precursor>
		do
			Result := Precursor {ARRAYED_SET}
		ensure then
			s: attached model_set as s
			nothing_lost: ∀ x: Result ¦ s ∋ x
			nothing_else: s |∀ agent iterable_has_element (Result, s.eq, ?)
		end

	array_at (i: INTEGER): G assign array_put
			-- <Precursor>
		do
			Result := Precursor {ARRAYED_SET} (i)
		ensure then
			valid_element: model_set ∋ Result
		end

	i_th alias "[]", at alias "@" (i: INTEGER): like item assign put_i_th
			-- <Precursor>
		do
			Result := area_v2.item (i - 1)
		ensure then
			valid_element: model_set ∋ Result
		end

	cursor: ARRAYED_LIST_CURSOR
			-- <Precursor>
		do
			Result := Precursor {ARRAYED_SET}
		ensure then
			valid_index: model_indices ∋ Result.index
		end

	first: like item
			-- <Precursor>
		do
			Result := Precursor {ARRAYED_SET}
		ensure then
			valid_element: model_set ∋ Result
		end

	has alias "∋" (v: like item): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor {ARRAYED_SET} (v)
		ensure then
			definition: Result = model_set ∋ v
		end

	index_of (v: like item; i: INTEGER): INTEGER
			-- <Precursor>
		do
			Result := Precursor {ARRAYED_SET}(v, i)
		ensure then
			valid_index: model_indices ∋ Result
		end

feature -- Predicate

	iterable_has_element_reference (ys: ITERABLE [G]; x: G): BOOLEAN
			-- Does `ys' contain `x' as an element (compared by reference)?
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Result := ∃ y: ys ¦ x = y
		ensure
			definition: Result = ∃ y: ys ¦ x = y
		end

	iterable_has_element (ys: ITERABLE [G]; eq: STS_EQUALITY [G]; x: G): BOOLEAN
			-- Does `ys' contain `x' as an element (compared by `eq')?
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Result := ∃ y: ys ¦ eq (x, y)
		ensure
			definition: Result = ∃ y: ys ¦ eq (x, y)
		end

invariant
	s: attached model_set as s
	area_v2_nothing_lost: ∀ x: area_v2 ¦ s ∋ x
	area_v2_nothing_else: s |∀ agent iterable_has_element (area_v2, s.eq, ?)
	valid_index: model_indices ∋ index

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
