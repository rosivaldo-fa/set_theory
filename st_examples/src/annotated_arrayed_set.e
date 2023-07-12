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
			array_at,
			i_th, at,
			has,
			index_of,
			array_item,
			occurrences,
			disjoint,
			is_equal,
			is_subset,
			is_superset,
			is_inserted,
			valid_cursor,
			valid_cursor_index,
			valid_index,
			array_valid_index,
			compare_objects,
			compare_references,
			back,
			forth,
			finish
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
		end

	model_indices: STI_SET [INTEGER, STS_OBJECT_EQUALITY [INTEGER]]
			-- Representation, as a mathematical set, of all indices valid for accessing items in current arrayed set
		do
			create Result.make_empty
			⟳ i: 1 |..| count ¦ Result := Result.extended (i) ⟲
		end

	model_extended_indices: STI_SET [INTEGER, STS_OBJECT_EQUALITY [INTEGER]]
			-- Representation, as a mathematical set, of all indices used to traverse current arrayed set
		do
			create Result.make_empty
			⟳ i: 0 |..| (count + 1) ¦ Result := Result.extended (i) ⟲
		end

feature -- Access

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
			Result := Precursor {ARRAYED_SET} (v, i)
		ensure then
			valid_extended_index: model_extended_indices ∋ Result
		end

	array_item (i: INTEGER): G assign array_put
			-- <Precursor>
		do
			Result := Precursor {ARRAYED_SET} (i)
		ensure then
			valid_element: model_set ∋ Result
		end

feature -- Measurement

	occurrences (v: like item): INTEGER
			-- <Precursor>
		do
			Result := Precursor {ARRAYED_SET} (v)
		ensure then
			s: attached model_set as s
			not_found: s ∌ v ⇒ Result = 0
			found: s ∋ v ⇒ Result > 0
			definition: Result.as_natural_32 = # (
							model_indices | agent (eq: STS_EQUALITY [G]; ia_v: like item; i: INTEGER): BOOLEAN
								do
									Result := valid_index (i) and then eq (ia_v, Current [i])
								end (s.eq, v, ?)
						)
		end

feature -- Comparison

	disjoint (other: TRAVERSABLE_SUBSET [G]): BOOLEAN
			-- <Precursor>
		note
			EIS: "name=Error within implementation of {ARRAYED_SET}.disjoint", "protocol=URI", "src=https://support.eiffel.com/report_detail/19894", "tag=Bug, EiffelBase"
		do
			Result := Precursor {ARRAYED_SET} (other)
		ensure then
			s: attached model_set as s
			definition: Result = ∀ x: other ¦ s ∌ x
		end

	is_equal (other: ANNOTATED_ARRAYED_SET [G]): BOOLEAN
			-- <Precursor>
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Result := Precursor {ARRAYED_SET} (other)
		ensure then
			s: attached model_set as s
			mi: attached model_indices as mi
			same_equality: Result ⇒ object_comparison = other.object_comparison
			same_elements: object_comparison = other.object_comparison ⇒ (Result ⇒ s ≍ other.model_set)
			same_sequence: object_comparison = other.object_comparison ⇒ Result = (
						mi ≍ other.model_indices and mi |∀ agent (ia_other: ANNOTATED_ARRAYED_SET [G]; eq: STS_EQUALITY [G]; i: INTEGER): BOOLEAN
							do
								Result := (valid_index (i) and ia_other.valid_index (i)) and then eq (Current [i], ia_other [i])
							end (other, s.eq, ?)
					)
		end

	is_subset alias "⊆" (other: TRAVERSABLE_SUBSET [G]): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor {ARRAYED_SET} (other)
		ensure then
			definition: Result = model_set |∀ agent other.has
		end

	is_superset alias "⊇" (other: SUBSET [G]): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor {ARRAYED_SET} (other)
		ensure then
			s: attached model_set as s
			definition: Result = ∀ x: other ¦ s ∋ x
		end

feature -- Status report

	is_inserted (v: G): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor {ARRAYED_SET} (v)
		ensure then
			definition: Result ⇒ model_set ∋ v
		end

	valid_cursor (p: CURSOR): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor {ARRAYED_SET} (p)
		ensure then
			definition: Result = (attached {ARRAYED_LIST_CURSOR} p as al_c and then model_extended_indices ∋ al_c.index)
		end

	valid_cursor_index (i: INTEGER): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor {ARRAYED_SET} (i)
		ensure then
			definition: Result = model_extended_indices ∋ i
		end

	valid_index (i: INTEGER): BOOLEAN
			-- <Precursor>
		note
			EIS: "name=Wrong post-condition of {ARRAYED_SET}.valid_index", "protocol=URI", "src=https://support.eiffel.com/report_detail/19895", "tag=Bug, EiffelBase"
		do
			Result := Precursor {ARRAYED_SET} (i)
		ensure then
			definition: Result = model_indices ∋ i
		end

	array_valid_index (i: INTEGER): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor {ARRAYED_SET} (i)
		ensure then
			definition: Result = (model_extended_indices / (count + 1) / count) ∋ i
		end

feature -- Status setting

	compare_objects
			-- <Precursor>
		do
			Precursor {ARRAYED_SET}
		ensure then
			object_equality: model_set.eq.generating_type <= {detachable STS_OBJECT_EQUALITY [G]}
		end

	compare_references
			-- <Precursor>
		do
			Precursor {ARRAYED_SET}
		ensure then
			reference_equality: model_set.eq.generating_type <= {detachable STS_REFERENCE_EQUALITY [G]}
		end

feature -- Cursor movement

	back
			-- <Precursor>
			-- The post-condition is rather convoluted and somewhat unnecessary, but the intent is just to show how index moving relates to slicing
			-- `model_extended_indices'.
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Precursor {ARRAYED_SET}
		ensure then
			old_mxi: attached old model_extended_indices as old_mxi
			mxi: attached model_extended_indices as mxi
			old_cut: attached {TUPLE [lower_slice, upper_slice: like model_extended_indices]} [
				old_mxi | agent (old_index, i: INTEGER): BOOLEAN do Result := i < old_index end (old index, ?),
				old_mxi | agent (old_index, i: INTEGER): BOOLEAN do Result := old_index ≤ i end (old index, ?)
				] as old_cut
			new_cut: attached {TUPLE [lower_slice, upper_slice: like model_extended_indices]} [
				mxi | agent (i: INTEGER): BOOLEAN do Result := i < index end,
				mxi | agent (i: INTEGER): BOOLEAN do Result := index ≤ i end
				] as new_cut
			lower_slice: old_cut.lower_slice ∖ new_cut.lower_slice ≍ mxi.singleton (index)
			upper_slice: new_cut.upper_slice ∖ old_cut.upper_slice ≍ mxi.singleton (index)
		end

	forth
			-- <Precursor>
			-- The post-condition is rather convoluted and somewhat unnecessary, but the intent is just to show how index moving relates to slicing
			-- `model_extended_indices'.
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Precursor {ARRAYED_SET}
		ensure then
			old_mxi: attached old model_extended_indices as old_mxi
			mxi: attached model_extended_indices as mxi
			old_cut: attached {TUPLE [lower_slice, upper_slice: like model_extended_indices]} [
				old_mxi | agent (old_index, i: INTEGER): BOOLEAN do Result := i < old_index end (old index, ?),
				old_mxi | agent (old_index, i: INTEGER): BOOLEAN do Result := old_index ≤ i end (old index, ?)
				] as old_cut
			new_cut: attached {TUPLE [lower_slice, upper_slice: like model_extended_indices]} [
				mxi | agent (i: INTEGER): BOOLEAN do Result := i < index end,
				mxi | agent (i: INTEGER): BOOLEAN do Result := index ≤ i end
				] as new_cut
			lower_slice: new_cut.lower_slice ∖ old_cut.lower_slice ≍ mxi.singleton (index)
			upper_slice: old_cut.upper_slice ∖ new_cut.upper_slice ≍ mxi.singleton (index)
		end

	finish
			-- <Precursor>
		do
			Precursor {ARRAYED_SET}
		ensure then
			s: attached model_set as s
			when_empty: s.is_empty ⇒ model_extended_indices |∀ agent (i: INTEGER): BOOLEAN do Result := index ≤ i end
			when_not_empty: not s.is_empty ⇒ model_indices |∀ agent (i: INTEGER): BOOLEAN do Result := i ≤ index end
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
	model_set_reference_equality: not object_comparison ⇒ s.eq.generating_type <= {detachable STS_REFERENCE_EQUALITY [G]}
	model_set_object_equality: object_comparison ⇒ s.eq.generating_type <= {detachable STS_OBJECT_EQUALITY [G]}
	model_set_nothing_lost: ∀ x: Current ¦ s ∋ x
	model_set_nothing_else: s |∀ agent has

	mi: attached model_indices as mi
	model_indices_nothing_lost: ∀ i: 1 |..| count ¦ mi ∋ i
	model_indices_nothing_else: mi |∀ agent (1 |..| count).has

	mxi: attached model_extended_indices as mxi
	model_extended_indices_definition: mxi ≍ (mi & 0 & (count + 1))

	area_nothing_lost: ∀ x: area ¦ s ∋ x
	area_nothing_else: s |∀ agent iterable_has_element (area, s.eq, ?)

	area_v2_nothing_lost: ∀ x: area_v2 ¦ s ∋ x
	area_v2_nothing_else: s |∀ agent iterable_has_element (area_v2, s.eq, ?)

	extended_valid_index: mxi ∋ index
	cursor_extended_valid_index: mxi ∋ cursor.index
	first_valid_element: not is_empty ⇒ s ∋ first
	item_valid_element: readable or not off or valid_index (index) ⇒ s ∋ item
	item_for_iteration_valid_element: not off ⇒ s ∋ item_for_iteration
	last_valid_element: not is_empty ⇒ s ∋ last

	new_cursor_nothing_lost: s |∀ agent iterable_has_element (new_cursor, s.eq, ?)
	new_cursor_nothing_else: ∀ x: new_cursor ¦ s.has (x)
	new_cursor_first_index: mi |∀ agent (first_index, i: INTEGER): BOOLEAN do Result := first_index ≤ i end (new_cursor.first_index, ?) -- file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures
	new_cursor_last_index: mi |∀ agent (last_index, i: INTEGER): BOOLEAN do Result := i ≤ last_index end (new_cursor.last_index, ?) -- file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures

	to_array_nothing_lost: s |∀ agent iterable_has_element_reference (to_array, ?)
	to_array_nothing_else: ∀ x: to_array ¦ s.has (x)

	count_definition: count = (# mi).as_integer_32
	lower_definition: mi |∀ agent (i: INTEGER): BOOLEAN do Result := lower ≤ i end -- file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures
	upper_definition: mi |∀ agent (i: INTEGER): BOOLEAN do Result := i ≤ upper end -- file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures
	before_definition: before = mxi |∀ agent (i: INTEGER): BOOLEAN do Result := index ≤ i end -- file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures
	after_definition: after = mxi |∀ agent (i: INTEGER): BOOLEAN do Result := i ≤ index end -- file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures
	all_default_definition: ({G}).has_default ⇒ all_default = s |∀ agent (s.eq).holds (?, ({G}).default)
	exhausted_quasi_definition: exhausted ⇒ (mxi ∖ mi) ∋ index
	full_definition: full = ((# mi).as_integer_32 = capacity)
	is_empty_definition: is_empty = s.is_empty
	isfirst_definition: isfirst = (mi ∋ index and mi |∀ agent (i: INTEGER): BOOLEAN do Result := index ≤ i end) -- file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures
	islast_definition: islast = (mi ∋ index and mi |∀ agent (i: INTEGER): BOOLEAN do Result := i ≤ index end) -- file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures
	off_definition: off = (mxi ∖ mi) ∋ index
	readable_definition: readable = mi ∋ index
	writable_definition: writable = mi ∋ index

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
