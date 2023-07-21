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
			start,
			back,
			forth,
			finish,
			go_i_th,
			go_to,
			move,
			search,
			append,
			extend,
			al_extend,
			fill,
			force,
			merge,
			merge_left,
			merge_right,
			move_item,
			put,
			array_put,
			al_put,
			sequence_put,
			put_front,
			put_i_th,
			put_left
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

	start
			-- <Precursor>
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Precursor {ARRAYED_SET}
		ensure then
			s: attached model_set as s
			mi: attached model_indices as mi
			when_empty: s.is_empty ⇒ model_extended_indices |∀ agent (i: INTEGER): BOOLEAN do Result := i ≤ index end
			when_not_empty: not s.is_empty ⇒ mi |∀ agent (i: INTEGER): BOOLEAN do Result := index ≤ i end
			same_indices: mi ≍ old model_indices
			same_sequence: mi |∀ agent (old_twin: like twin; eq: STS_EQUALITY [G]; i: INTEGER): BOOLEAN
					do
						Result := (old_twin.valid_index (i) and valid_index (i)) and then eq (old_twin [i], Current [i])
					end (old twin, s.eq, ?)
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
				old_mxi | agent (old_index, i: INTEGER): BOOLEAN do Result := i ≤ old_index end (old index, ?),
				old_mxi | agent (old_index, i: INTEGER): BOOLEAN do Result := old_index < i end (old index, ?)
				] as old_cut
			new_cut: attached {TUPLE [lower_slice, upper_slice: like model_extended_indices]} [
				mxi | agent (i: INTEGER): BOOLEAN do Result := i ≤ index end,
				mxi | agent (i: INTEGER): BOOLEAN do Result := index < i end
				] as new_cut
			lower_slice: new_cut.lower_slice ∖ old_cut.lower_slice ≍ mxi.singleton (index)
			upper_slice: old_cut.upper_slice ∖ new_cut.upper_slice ≍ mxi.singleton (index)
			mi: attached model_indices as mi
			same_indices: mi ≍ old model_indices
			same_sequence: mi |∀ agent (old_twin: like twin; eq: STS_EQUALITY [G]; i: INTEGER): BOOLEAN
					do
						Result := (old_twin.valid_index (i) and valid_index (i)) and then eq (old_twin [i], Current [i])
					end (old twin, model_set.eq, ?)
		end

	finish
			-- <Precursor>
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Precursor {ARRAYED_SET}
		ensure then
			s: attached model_set as s
			mi: attached model_indices as mi
			when_empty: s.is_empty ⇒ model_extended_indices |∀ agent (i: INTEGER): BOOLEAN do Result := index ≤ i end
			when_not_empty: not s.is_empty ⇒ mi |∀ agent (i: INTEGER): BOOLEAN do Result := i ≤ index end
			same_indices: mi ≍ old model_indices
			same_sequence: mi |∀ agent (old_twin: like twin; eq: STS_EQUALITY [G]; i: INTEGER): BOOLEAN
					do
						Result := (old_twin.valid_index (i) and valid_index (i)) and then eq (old_twin [i], Current [i])
					end (old twin, s.eq, ?)
		end

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
			mi: attached model_indices as mi
			same_indices: mi ≍ old model_indices
			same_sequence: mi |∀ agent (old_twin: like twin; eq: STS_EQUALITY [G]; i: INTEGER): BOOLEAN
					do
						Result := (old_twin.valid_index (i) and valid_index (i)) and then eq (old_twin [i], Current [i])
					end (old twin, model_set.eq, ?)
		end

	go_i_th (i: INTEGER)
			-- <Precursor>
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Precursor {ARRAYED_SET} (i)
		ensure then
			valid_extended_index: model_extended_indices ∋ index
			mi: attached model_indices as mi
			same_indices: mi ≍ old model_indices
			same_sequence: mi |∀ agent (old_twin: like twin; eq: STS_EQUALITY [G]; j: INTEGER): BOOLEAN
					do
						Result := (old_twin.valid_index (j) and valid_index (j)) and then eq (old_twin [j], Current [j])
					end (old twin, model_set.eq, ?)
		end

	go_to (p: CURSOR)
			-- <Precursor>
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Precursor {ARRAYED_SET} (p)
		ensure then
			al_c: attached {ARRAYED_LIST_CURSOR} p as al_c -- Precondition: valid_cursor (p)
			new_index: index = al_c.index
			valid_extended_index: model_extended_indices ∋ index
			mi: attached model_indices as mi
			same_indices: mi ≍ old model_indices
			same_sequence: mi |∀ agent (old_twin: like twin; eq: STS_EQUALITY [G]; i: INTEGER): BOOLEAN
					do
						Result := (old_twin.valid_index (i) and valid_index (i)) and then eq (old_twin [i], Current [i])
					end (old twin, model_set.eq, ?)
		end

	move (i: INTEGER)
			-- <Precursor>
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Precursor {ARRAYED_SET} (i)
		ensure then
			mi: attached model_indices as mi
			not_off: mi ∋ (old index + i) ⇒ mi ∋ index
			off: mi ∌ (old index + i) implies (model_extended_indices ∖ mi) ∋ index
			before: mi |∀ agent (old_index, ia_i, j: INTEGER): BOOLEAN do Result := old_index + ia_i < j end (old index, i, ?) ⇒
				mi |∀ agent (j: INTEGER): BOOLEAN do Result := index < j end
			after: mi |∀ agent (old_index, ia_i, j: INTEGER): BOOLEAN do Result := j < old_index + ia_i end (old index, i, ?) ⇒
				mi |∀ agent (j: INTEGER): BOOLEAN do Result := j < index end
			same_indices: mi ≍ old model_indices
			same_sequence: mi |∀ agent (old_twin: like twin; eq: STS_EQUALITY [G]; j: INTEGER): BOOLEAN
					do
						Result := (old_twin.valid_index (j) and valid_index (j)) and then eq (old_twin [j], Current [j])
					end (old twin, model_set.eq, ?)
		end

	search (v: like item)
			-- <Precursor>
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Precursor {ARRAYED_SET} (v)
		ensure then
			s: attached model_set as s
			mi: attached model_indices as mi
			never_look_back: index ≥ old index
			when_found: mi ∋ index ⇒ mi | agent (old_index, i: INTEGER): BOOLEAN
					do
						Result := old_index ≤ i and i ≤ index
					end (old index, ?) |∀ agent (ia_v: like item; eq: STS_EQUALITY [G]; i: INTEGER): BOOLEAN
					do
						Result := valid_index (i) and then (eq (Current [i], ia_v) = (i = index))
					end (v, s.eq, ?)
			consistent_when_found: mi ∋ index ⇒ s ∋ v
			when_not_found: mi ∌ index ⇒ (model_extended_indices ∖ mi) ∋ index and index > count
			consistent_when_not_found: s ∌ v ⇒ mi ∌ index
			same_indices: mi ≍ old model_indices
			same_sequence: mi |∀ agent (old_twin: like twin; eq: STS_EQUALITY [G]; i: INTEGER): BOOLEAN
					do
						Result := (old_twin.valid_index (i) and valid_index (i)) and then eq (old_twin [i], Current [i])
					end (old twin, s.eq, ?)
		end

feature -- Element change

	append (s: SEQUENCE [G])
			-- <Precursor>
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Precursor {ARRAYED_SET} (s)
		ensure then
			old_mi: attached old model_indices as old_mi
			s: attached model_set as ms
			mi: attached model_indices as mi
			appended_indices: # mi = (# old_mi + s.count.as_natural_32)
			prefix: old_mi |∀ agent (old_twin: like twin; eq: STS_EQUALITY [G]; i: INTEGER): BOOLEAN
					do
						Result := (old_twin.valid_index (i) and valid_index (i)) and then eq (old_twin [i], Current [i])
					end (old twin, ms.eq, ?)
			suffix: (mi ∖ old_mi) |∀ agent (ia_s: SEQUENCE [G]; eq: STS_EQUALITY [G]; old_count, i: INTEGER): BOOLEAN
					local
						p: ITERATION_CURSOR [G]
					do
						p := ia_s.new_cursor
						⟳ j: 1 |..| (i - old_count - 1) ¦ p.forth ⟲
						Result := (valid_index (i) and not ia_s.after) and then eq (Current [i], p.item)
					end (s, ms.eq, old count, ?)
		end

	extend (v: G)
			-- <Precursor>
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Precursor {ARRAYED_SET} (v)
		ensure then
			old_s: attached old model_set as old_s
			s: attached model_set as s
			old_mi: attached old model_indices as old_mi
			mi: attached model_indices as mi
			elements: s ≍ (old_s & v)
			same_indices: old_s ∋ v ⇒ mi ≍ old_mi
			same_sequence: old_s ∋ v ⇒ mi |∀ agent (old_twin: like twin; eq: STS_EQUALITY [G]; i: INTEGER): BOOLEAN
					do
						Result := (old_twin.valid_index (i) and valid_index (i)) and then eq (old_twin [i], Current [i])
					end (old twin, s.eq, ?)
			extended_indices: old_s ∌ v ⇒ (mi ∖ old_mi) ≍ mi.singleton ((# mi).as_integer_32)
			extended_sequence: old_s ∌ v ⇒ mi |∀ agent (ia_v: G; old_twin: like twin; eq: STS_EQUALITY [G]; i: INTEGER): BOOLEAN
					do
						if valid_index (i) then -- Always true, indeed.
							if old_twin.valid_index (i) then
								Result := eq (old_twin [i], Current [i])
							else
								Result := eq (Current [i], ia_v)
							end
						end
					end (v, old twin, s.eq, ?)
		end

	al_extend (v: like item)
			-- <Precursor>
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Precursor {ARRAYED_SET} (v)
		ensure then
			old_s: attached old model_set as old_s
			s: attached model_set as s
			old_mi: attached old model_indices as old_mi
			mi: attached model_indices as mi
			elements: s ≍ (old_s & v)
			extended_indices: # mi = (# old_mi + 1)
			extended_sequence: mi |∀ agent (ia_v: like item; old_twin: like twin; eq: STS_EQUALITY [G]; i: INTEGER): BOOLEAN
					do
						if valid_index (i) then -- Always true, indeed.
							if old_twin.valid_index (i) then
								Result := eq (old_twin [i], Current [i])
							else
								Result := eq (Current [i], ia_v)
							end
						end
					end (v, old twin, s.eq, ?)
		end

	fill (other: CONTAINER [G])
			-- <Precursor>
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Precursor {ARRAYED_SET} (other)
		ensure then
			old_s: attached old model_set as old_s
			old_mi: attached old model_indices as old_mi
			s: attached model_set as s
			mi: attached model_indices as mi
			current_nothing_lost: old_s ⊆ s
			other_nothing_lost: ∀ v: other ¦ s ∋ v
			nothing_else: s |∀ agent s.ored (agent old_s.has, agent other.has, ?)
			extended_indices: # mi = # old_mi + (# s - # old_s)
			prefix: old_mi |∀ agent (old_twin: like twin; eq: STS_EQUALITY [G]; i: INTEGER): BOOLEAN
					do
						Result := (old_twin.valid_index (i) and valid_index (i)) and then eq (old_twin [i], Current [i])
					end (old twin, s.eq, ?)
			suffix: (mi ∖ old_mi) |∀ agent (old_twin: like twin; ia_other: CONTAINER [G]; i: INTEGER): BOOLEAN
					do
						Result := valid_index (i) and then (not (old_twin ∋ Current [i]) and ia_other.has (Current [i]))
					end (old twin, other, ?)
		end

	force (v: like item)
			-- <Precursor>
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Precursor {ARRAYED_SET} (v)
		ensure then
			old_mi: attached old model_indices as old_mi
			s: attached model_set as s
			mi: attached model_indices as mi
			extended: s ≍ old (model_set & v)
			extended_indices: # mi = # old_mi + 1
			front: old_mi |∀ agent (old_twin: like twin; eq: STS_EQUALITY [G]; i: INTEGER): BOOLEAN
					do
						Result := (old_twin.valid_index (i) and valid_index (i)) and then eq (old_twin [i], Current [i])
					end (old twin, s.eq, ?)
			last: (mi ∖ old_mi) |∀ agent (ia_v: like item; eq: STS_EQUALITY [G]; i: INTEGER): BOOLEAN
					do
						Result := valid_index (i) and then eq (Current [i], ia_v)
					end (v, s.eq, ?)
		end

	merge (other: CONTAINER [G])
			-- <Precursor>
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Precursor {ARRAYED_SET} (other)
		ensure then
			old_s: attached old model_set as old_s
			old_mi: attached old model_indices as old_mi
			s: attached model_set as s
			mi: attached model_indices as mi
			current_nothing_lost: old_s ⊆ s
			other_nothing_lost: ∀ v: other ¦ s ∋ v
			nothing_else: s |∀ agent s.ored (agent old_s.has, agent other.has, ?)
			extended_indices: # mi = # old_mi + (# s - # old_s)
			prefix: old_mi |∀ agent (old_twin: like twin; eq: STS_EQUALITY [G]; i: INTEGER): BOOLEAN
					do
						Result := (old_twin.valid_index (i) and valid_index (i)) and then eq (old_twin [i], Current [i])
					end (old twin, s.eq, ?)
			suffix: (mi ∖ old_mi) |∀ agent (old_twin: like twin; ia_other: CONTAINER [G]; i: INTEGER): BOOLEAN
					do
						Result := valid_index (i) and then (not (old_twin ∋ Current [i]) and ia_other.has (Current [i]))
					end (old twin, other, ?)
		end

	merge_left (other: ARRAYED_LIST [G])
			-- <Precursor>
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Precursor {ARRAYED_SET} (other)
		ensure then
			old_s: attached old model_set as old_s
			s: attached model_set as s
			mi: attached model_indices as mi
			current_nothing_lost: old_s ⊆ s
			other_nothing_lost: ∀ v: old other.twin ¦ s ∋ v
			nothing_else: s |∀ agent s.ored (agent old_s.has, agent (old other.twin).has, ?)
			extended_indices: # mi = old (# model_indices + other.count.as_natural_32)
			prefix: mi | agent (old_index, i: INTEGER): BOOLEAN
					do
						Result := i < old_index
					end (old index, ?) |∀ agent (old_twin: like twin; eq: STS_EQUALITY [G]; i: INTEGER): BOOLEAN
					do
						Result := (valid_index (i) and old_twin.valid_index (i)) and then eq (Current [i], old_twin [i])
					end (old twin, s.eq, ?)
			middle: mi | agent (old_index, i: INTEGER): BOOLEAN
					do
						Result := old_index ≤ i and i < index
					end (old index, ?) |∀ agent (old_other_twin: ARRAYED_LIST [G]; eq: STS_EQUALITY [G]; old_index, i: INTEGER): BOOLEAN
					do
						Result := (valid_index (i) and old_other_twin.valid_index (i - old_index + 1)) and then eq (Current [i], old_other_twin [i - old_index + 1])
					end (old other.twin, s.eq, old index, ?)
			suffix: mi | agent (i: INTEGER): BOOLEAN
					do
						Result := index ≤ i and i ≤ count
					end |∀ agent (old_twin: like twin; eq: STS_EQUALITY [G]; old_other_count, i: INTEGER): BOOLEAN
					do
						Result := (valid_index (i) and old_twin.valid_index (i - old_other_count)) and then eq (Current [i], old_twin [i - old_other_count])
					end (old twin, s.eq, old other.count, ?)
		end

	merge_right (other: ARRAYED_LIST [G])
			-- <Precursor>
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Precursor {ARRAYED_SET} (other)
		ensure then
			old_s: attached old model_set as old_s
			s: attached model_set as s
			mi: attached model_indices as mi
			current_nothing_lost: old_s ⊆ s
			other_nothing_lost: ∀ v: old other.twin ¦ s ∋ v
			nothing_else: s |∀ agent s.ored (agent old_s.has, agent (old other.twin).has, ?)
			extended_indices: # mi = old (# model_indices + other.count.as_natural_32)
			prefix: mi | agent (i: INTEGER): BOOLEAN
					do
						Result := i ≤ index
					end |∀ agent (old_twin: like twin; eq: STS_EQUALITY [G]; i: INTEGER): BOOLEAN
					do
						Result := (valid_index (i) and old_twin.valid_index (i)) and then eq (Current [i], old_twin [i])
					end (old twin, s.eq, ?)
			middle: mi | agent (old_other_count, i: INTEGER): BOOLEAN
					do
						Result := index < i and i ≤ (index + old_other_count)
					end (old other.count, ?) |∀ agent (old_other_twin: ARRAYED_LIST [G]; eq: STS_EQUALITY [G]; i: INTEGER): BOOLEAN
					do
						Result := (valid_index (i) and old_other_twin.valid_index (i - index)) and then eq (Current [i], old_other_twin [i - index])
					end (old other.twin, s.eq, ?)
			suffix: mi | agent (old_other_count, i: INTEGER): BOOLEAN
					do
						Result := index + old_other_count < i and i ≤ count
					end (old other.count, ?) |∀ agent (old_twin: like twin; eq: STS_EQUALITY [G]; old_other_count, i: INTEGER): BOOLEAN
					do
						Result := (valid_index (i) and old_twin.valid_index (i - old_other_count)) and then eq (Current [i], old_twin [i - old_other_count])
					end (old twin, s.eq, old other.count, ?)
		end

	move_item (v: G)
			-- <Precursor>
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Precursor {ARRAYED_SET} (v)
		ensure then
			s: attached model_set as s
			mi: attached model_indices as mi
			same_set: s ≍ old model_set
			same_indices: mi ≍ old model_indices
			new_index: index = old index + 1
			valid_old_index: valid_index (index - 1) -- same_indices
			new_position: s.eq (Current [index - 1], v)

			old_twin: attached old twin as old_twin
			v_positions: attached (
					mi | agent (ia_old_twin: like twin; ia_v: G; eq: STS_EQUALITY [G]; i: INTEGER): BOOLEAN
						do
							Result := ia_old_twin.valid_index (i) and then eq (ia_old_twin [i], ia_v)
						end (old_twin, v, s.eq, ?)
				) as v_positions
			first_v_position_set: attached (
					mi | agent (ia_v_positions: STI_SET [INTEGER, STS_OBJECT_EQUALITY [INTEGER]]; ind: INTEGER): BOOLEAN
						do
							Result := ia_v_positions |∀ agent (i, j: INTEGER): BOOLEAN
									do
										Result := i ≤ j
									end (ind, ?)
						end (v_positions, ?)
				) as first_v_position_set
			first_v_position_set_is_not_empty: not first_v_position_set.is_empty -- Precondition: has (v)
			first_v_position: attached first_v_position_set.any as first_v_position

			below_index_first_segment: first_v_position < index ⇒ mi |∀ agent
						(ia_old_twin: like twin; eq: STS_EQUALITY [G]; ia_first_v_position, i: INTEGER): BOOLEAN
					do
						Result := i < ia_first_v_position ⇒ (valid_index (i) and ia_old_twin.valid_index (i)) and then eq (Current [i], ia_old_twin [i])
					end (old_twin, s.eq, first_v_position, ?)
			below_index_second_segment: first_v_position < index ⇒ mi |∀ agent
						(ia_old_twin: like twin; eq: STS_EQUALITY [G]; ia_first_v_position, i: INTEGER): BOOLEAN
					do
						Result := ia_first_v_position ≤ i and i < index - 1 ⇒ (valid_index (i) and ia_old_twin.valid_index (i + 1)) and then
							eq (Current [i], ia_old_twin [i + 1])
					end (old_twin, s.eq, first_v_position, ?)
			below_index_last_segment: first_v_position < index ⇒ mi |∀ agent (ia_old_twin: like twin; eq: STS_EQUALITY [G]; i: INTEGER): BOOLEAN
					do
						Result := index ≤ i and i ≤ count ⇒ (valid_index (i) and ia_old_twin.valid_index (i)) and then eq (Current [i], ia_old_twin [i])
					end (old_twin, s.eq, ?)

			above_old_index_first_segment: index - 1 < first_v_position ⇒ mi |∀ agent (ia_old_twin: like twin; eq: STS_EQUALITY [G]; i: INTEGER): BOOLEAN
					do
						Result := 1 ≤ i and i < index - 1 ⇒ (valid_index (i) and ia_old_twin.valid_index (i)) and then eq (Current [i], ia_old_twin [i])
					end (old_twin, s.eq, ?)
			above_old_index_penultimate_segment: index - 1 < first_v_position ⇒ mi |∀ agent
						(ia_old_twin: like twin; eq: STS_EQUALITY [G]; ia_first_v_position, i: INTEGER): BOOLEAN
					do
						Result := index ≤ i and i ≤ ia_first_v_position ⇒ (valid_index (i) and ia_old_twin.valid_index (i - 1)) and then
							eq (Current [i], ia_old_twin [i - 1])
					end (old_twin, s.eq, first_v_position, ?)
			above_old_index_last_segment: index - 1 < first_v_position ⇒ mi |∀ agent
						(ia_old_twin: like twin; eq: STS_EQUALITY [G]; ia_first_v_position, i: INTEGER): BOOLEAN
					do
						Result := ia_first_v_position < i and i ≤ count ⇒ (valid_index (i) and ia_old_twin.valid_index (i)) and then
							eq (Current [i], ia_old_twin [i])
					end (old_twin, s.eq, first_v_position, ?)
		end

	put (v: G)
			-- <Precursor>
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Precursor {ARRAYED_SET} (v)
		ensure then
			old_s: attached old model_set as old_s
			s: attached model_set as s
			old_mi: attached old model_indices as old_mi
			mi: attached model_indices as mi
			elements: s ≍ (old_s & v)
			same_indices: old_s ∋ v ⇒ mi ≍ old_mi
			same_sequence: old_s ∋ v ⇒ mi |∀ agent (old_twin: like twin; eq: STS_EQUALITY [G]; i: INTEGER): BOOLEAN
					do
						Result := (old_twin.valid_index (i) and valid_index (i)) and then eq (old_twin [i], Current [i])
					end (old twin, s.eq, ?)
			extended_indices: old_s ∌ v ⇒ (mi ∖ old_mi) ≍ mi.singleton ((# mi).as_integer_32)
			extended_sequence: old_s ∌ v ⇒ mi |∀ agent (ia_v: G; old_twin: like twin; eq: STS_EQUALITY [G]; i: INTEGER): BOOLEAN
					do
						if valid_index (i) then -- Always true, indeed.
							if old_twin.valid_index (i) then
								Result := eq (old_twin [i], Current [i])
							else
								Result := eq (Current [i], ia_v)
							end
						end
					end (v, old twin, s.eq, ?)
		end

	array_put (v: G; i: INTEGER)
			-- <Precursor>
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Precursor {ARRAYED_SET} (v, i)
		ensure then
			old_twin: attached old twin as old_twin
			s: attached model_set as s
			inserted: s ∋ v
			mxi: attached model_extended_indices as mxi
			same_indices: mxi ≍ old model_extended_indices
			same_prefix: mxi |∀ agent (ia_old_twin: like twin; eq: STS_EQUALITY [G]; ia_i, j: INTEGER): BOOLEAN
					do
						Result := j < ia_i ⇒ (array_valid_index (j) and ia_old_twin.array_valid_index (j)) and then eq (array_item (j), ia_old_twin.array_item (j))
					end (old_twin, s.eq, i, ?)
			replaced_item: s.eq (array_item (i), v)
			same_suffix: mxi |∀ agent (ia_old_twin: like twin; eq: STS_EQUALITY [G]; ia_i, j: INTEGER): BOOLEAN
					do
						Result := ia_i < j and j < count ⇒ (array_valid_index (j) and ia_old_twin.array_valid_index (j)) and then
							eq (array_item (j), ia_old_twin.array_item (j))
					end (old_twin, s.eq, i, ?)
		end

	al_put (v: like item)
			-- <Precursor>
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Precursor {ARRAYED_SET} (v)
		ensure then
			old_twin: attached old twin as old_twin
			s: attached model_set as s
			inserted: s ∋ v
			mi: attached model_indices as mi
			same_indices: mi ≍ old model_indices
			same_prefix: mi |∀ agent (ia_old_twin: like twin; eq: STS_EQUALITY [G]; i: INTEGER): BOOLEAN
					do
						Result := i < index ⇒ (valid_index (i) and ia_old_twin.valid_index (i)) and then eq (Current [i], ia_old_twin [i])
					end (old_twin, s.eq, ?)
			valid_index: valid_index (index) -- Precondition: writable
			replaced_item: s.eq (Current [index], v)
			same_suffix: mi |∀ agent (ia_old_twin: like twin; eq: STS_EQUALITY [G]; i: INTEGER): BOOLEAN
					do
						Result := index < i ⇒ (valid_index (i) and ia_old_twin.valid_index (i)) and then eq (Current [i], ia_old_twin [i])
					end (old_twin, s.eq, ?)
		end

	sequence_put (v: like item)
			-- <Precursor>
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Precursor {ARRAYED_SET} (v)
		ensure then
			s: attached model_set as s
			mi: attached model_indices as mi
			elements: s ≍ old (model_set & v)
			extended_indices: # mi = old (# model_indices + 1)
			extended_sequence: mi |∀ agent (ia_v: like item; old_twin: like twin; eq: STS_EQUALITY [G]; i: INTEGER): BOOLEAN
					do
						if valid_index (i) then -- Always true, indeed.
							if old_twin.valid_index (i) then
								Result := eq (old_twin [i], Current [i])
							else
								Result := eq (Current [i], ia_v)
							end
						end
					end (v, old twin, s.eq, ?)
		end

	put_front (v: like item)
			-- <Precursor>
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Precursor {ARRAYED_SET} (v)
		ensure then
			s: attached model_set as s
			mi: attached model_indices as mi
			inserted: s ≍ old (model_set & v)
			extended_indices: # mi = old (# model_indices + 1)
			new_index: index = old index + 1
			valid_index: valid_index (1) -- count > 0
			first: s.eq (Current [1], v)
			tail: mi |∀ agent (old_twin: like twin; eq: STS_EQUALITY [G]; ia_v: like item; i: INTEGER): BOOLEAN
					do
						Result := 1 < i ⇒ (valid_index (i) and old_twin.valid_index (i - 1)) and then eq (Current [i], old_twin [i - 1])
					end (old twin, s.eq, v, ?)
		end

	put_i_th (v: like i_th; i: INTEGER)
			-- <Precursor>
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Precursor {ARRAYED_SET} (v, i)
		ensure then
			old_twin: attached old twin as old_twin
			s: attached model_set as s
			inserted: s ∋ v
			mi: attached model_indices as mi
			same_indices: mi ≍ old model_indices
			same_prefix: mi |∀ agent (ia_old_twin: like twin; eq: STS_EQUALITY [G]; ia_i, j: INTEGER): BOOLEAN
					do
						Result := j < ia_i ⇒ (valid_index (j) and ia_old_twin.valid_index (j)) and then eq (Current [j], ia_old_twin [j])
					end (old_twin, s.eq, i, ?)
			replaced_item: s.eq (Current [i], v)
			same_suffix: mi |∀ agent (ia_old_twin: like twin; eq: STS_EQUALITY [G]; ia_i, j: INTEGER): BOOLEAN
					do
						Result := ia_i < j ⇒ (valid_index (j) and ia_old_twin.valid_index (j)) and then eq (Current [j], ia_old_twin [j])
					end (old_twin, s.eq, i, ?)
		end

	put_left (v: like item)
			-- <Precursor>
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Precursor {ARRAYED_SET} (v)
		ensure then
			old_twin: attached old twin as old_twin
			s: attached model_set as s
			mi: attached model_indices as mi
			inserted: s ∋ v
			extended_indices: # mi = old (# model_indices + 1)
			prefix: mi |∀ agent (ia_old_twin: like twin; eq: STS_EQUALITY [G]; old_index, i: INTEGER): BOOLEAN
				do
					Result := i < old_index ⇒ (valid_index (i) and ia_old_twin.valid_index (i)) and then eq (Current [i], ia_old_twin [i])
				end (old_twin, s.eq, old index, ?)
			valid_index: valid_index (old index) -- 1 ≤ old index ≤ old count + 1 ≤ count
			new_item: s.eq (Current [old index], v)
			suffix: mi |∀ agent (ia_old_twin: like twin; eq: STS_EQUALITY [G]; old_index, i: INTEGER): BOOLEAN
				do
					Result := old_index < 1 ⇒ (valid_index (i) and ia_old_twin.valid_index (i - 1)) and then eq (Current [i], ia_old_twin [i - 1])
				end (old_twin, s.eq, old index, ?)
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
