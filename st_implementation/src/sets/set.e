note
	description: "Implementation of {STS_SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	SET [A, EQ -> STS_EQUALITY [A] create default_create end]

inherit
	STS_SET [A, EQ]
		redefine
			has,
			cardinality,
			out,
			equals,
			is_subset,
			is_strict_subset,
			is_trivial_subset,
			is_proper_subset,
			is_disjoint,
			exists,
			exists_unique,
			exists_pair,
			exists_distinct_pair,
			for_all,
			for_all_pairs,
			for_all_distinct_pairs,
			complemented,
			intersected,
			subtracted,
			equality_holds,
			set_anchor,
			subset_anchor,
			superset_anchor
		end

	DEBUG_OUTPUT
		rename
			debug_output as out
		redefine
			out
		end

create
	make_empty,
	make_singleton,
	make_extended

feature {NONE} -- Initialization

	make_empty
			-- Create an empty set, i.e. {} or ∅.
		do
			others := Current
		ensure
			is_empty: is_empty
		end

	make_singleton (a: A)
			-- Create a singleton in the form {`a'}.
		do
			create others.make_empty
			create any_storage.put (converted_element (a))
		ensure
			is_not_empty: not is_empty
			any: eq (any, a)
			others: others.is_empty
		end

	make_extended (a: A; s: STS_SET [A, EQ])
			-- Create a set whose `any' element and `others' are, respectively, `a' and `s'.
		require
			does_not_have: s ∌ a
		do
			create others.make_empty
			others := others.converted (s)
			create any_storage.put (converted_element (a))
		ensure
			is_not_empty: not is_empty
			any: eq (any, a)
			others: others ≍ s
		end

feature -- Primitive

	is_empty: BOOLEAN
			-- <Precursor>
		do
			Result := not attached any_storage
		ensure then
			definition: Result = not attached any_storage
		end

	any: like any_anchor
			-- <Precursor>
		do
			check
				attached_stored_any: attached any_storage -- not `is_empty'
			then
				Result := any_storage.item
			end
		ensure then
			attached_stored_any: attached any_storage -- not `is_empty'
			definition: Result ~ any_storage.item
		end

	others: like subset_anchor
			-- <Precursor>

	eq: EQ
			-- <Precursor>
			--| `eq' must be created on demand, otherwise a set would have an equality object for each of its elements - a huge space wasting. On descendants
			--| where the type of `eq' may be locally defined, i.e. it is not just a generic parameter, `eq' may be turned into a once query.
		do
			create Result
		ensure then
			class
		end

feature -- Membership

	has alias "∋" (a: A): BOOLEAN
			-- <Precursor>
			--| This feature is called very frequently. It is wortwhile to avoid agent indirection and recreating `eq' over and over at each comparison.
		local
			s: like subset_anchor
			l_eq: EQ
		do
			from
				s := Current
				l_eq := eq
			invariant
				not_found_yet: (Current ∖ s) |∄ agent equality_holds (a, ?)
			until
				s.is_empty or else l_eq (a, s.any)
			loop
				s := s.others
			variant
				cardinality: natural_as_integer (# s)
			end
			Result := not s.is_empty
		end

feature -- Construction

	with alias "&" (a: A): like superset_anchor
			-- <Precursor>
		do
			if Current ∋ a then
				Result := Current
			else
				Result := extended (a)
			end
		end

	without alias "/" (a: A): like subset_anchor
			-- <Precursor>
		local
			s: like subset_anchor
			l_eq: EQ
		do
			from
				Result := o
				s := Current
				l_eq := eq -- Better to avoid recreating `eq' over and over.
			invariant
				building_up: Result ≍ (Current ∖ s)
			until
				s.is_empty or else l_eq (s.any, a)
			loop
				check
					does_not_have: Result ∌ s.any -- Result ≍ (Current ∖ s)
				end
				Result := Result.extended (s.any)
				s := s.others
			variant
				cardinality: natural_as_integer (# s)
			end
			if s.is_empty then
				Result := Current
			else
				check
					unwanted_element_found: l_eq (s.any, a) -- Previous loop exit
				end
				s := s.others
				if not s.is_empty then
					check
						is_disjoint: s.is_disjoint (Result) -- Result ≍ ((Current ∖ s) / a)
					end
					Result := s.batch_extended (Result)
				end
			end
		end

	extended (a: A): like superset_anchor
			-- Current set extended with `a'
		require
			does_not_have: Current ∌ a
		do
			create Result.make_extended (a, Current)
		ensure
			is_not_empty: not Result.is_empty
			any: eq (Result.any, a)
			others: Result.others ≍ Current
		end

	batch_extended (s: STS_SET [A, EQ]): like superset_anchor
			-- Current set extended with every element in `s'
		require
			is_disjoint: is_disjoint (s)
		local
			l_s: STS_SET [A, EQ]
		do
			from
				Result := Current
				l_s := s
			invariant
--				building_prefixed_s_up: Result.as_tuple.prefix (# (s ∖ l_s)).terms ≍ (s ∖ l_s)
--				suffixed_current: Result.as_tuple.suffix (# Current).terms ≍ Current
			until
				l_s.is_empty
			loop
				check
					does_not_have: Result ∌ l_s.any -- Result ≍ (Current ∪ (s ∖ l_s))
				end
				Result := Result.extended (l_s.any)
				l_s := l_s.others
			variant
				cardinality: natural_as_integer (# l_s)
			end
		ensure
--			prefixed_s: Result.as_tuple.right_trimmed (# Current).terms ≍ s
--			suffixed_current: Result.as_tuple.left_trimmed (# s).terms ≍ Current
		end

feature -- Measurement

	cardinality alias "#": like natural_anchor
			-- <Precursor>
		local
			s: like subset_anchor
		do
			from
				s := Current
			invariant
				counting_up: Result = transformer_to_natural.set_reduction (Current ∖ s, 0, agent cumulative_successor)
			until
				s.is_empty
			loop
				Result := Result + 1
				s := s.others
			variant
				cardinality: natural_as_integer (# s)
			end
		end

feature -- Output

	out: STRING
			-- <Precursor>
			-- 	TODO: Remove.
		local
			s: STS_SET [A, EQ]
		do
			Result := "{"
			if not is_empty then
				from
					Result.append (element_out (any))
					s := others
				invariant
--					building_up: Result ~ {TRANSFORMER [A, STRING, EQ, STS_OBJECT_EQUALITY [STRING]]}.tuple_indexed_left_reduction (right_trimmed (s.n), "", 1, agent appending_term_out)
				until
					s.is_empty
				loop
					Result.append_character (',')
					check
						other_arguments_not_void: element_out (s.any) /= Void -- `element_out' definition
					end
					Result.append (element_out (s.any))
					s := s.others
				variant
					n: natural_as_integer (# s)
				end
			end
			Result.append_character ('}')
		ensure then
--			definition: Result ~ "{" + as_tuple.terms_out + "}"
		end

	element_out (a: A): STRING
			-- Terse printable representation of `a'
			-- 	TODO: Remove.
		do
			if attached a then
				check
					other_not_void: a.out /= Void -- {ANY}.out definition
				end
				create Result.make_from_separate (a.out)
			else
				Result := "Void"
			end
		ensure
			class
			definition: if attached a then
					Result ~ a.out
				else
					Result ~ "Void"
				end
		end

feature -- Comparison

	equals alias "≍" (s: STS_SET [A, EQ]): BOOLEAN
			-- <Precursor>
			--| This feature is called very frequently. It is wortwhile to avoid agent indirection and recreating `eq' over and over at each comparison.
		do
			Result := Current = s or Current ~ s or # Current = # s and then subset_relation_holds (Current, s, eq)
		end

	is_subset alias "⊆" (s: STS_SET [A, EQ]): BOOLEAN
			-- <Precursor>
			--| This feature is called very frequently. It is wortwhile to avoid agent indirection and recreating `eq' over and over at each comparison.
		do
			Result := Current = s or Current ~ s or # Current ≤ # s and then subset_relation_holds (Current, s, eq)
		end

	is_strict_subset alias "⊂" (s: STS_SET [A, EQ]): BOOLEAN
			-- <Precursor>
			--| This feature is called somewhat frequently. It is wortwhile to avoid agent indirection and recreating `eq' over and over at each comparison.
		do
			Result := Current /= s and Current /~ s and # Current < # s and then subset_relation_holds (Current, s, eq)
		end

	is_trivial_subset (s: STS_SET [A, EQ]): BOOLEAN
			-- <Precursor>
		do
			Result := is_empty or Current ≍ s
		end

	is_proper_subset (s: STS_SET [A, EQ]): BOOLEAN
			-- <Precursor>
		do
			Result := not is_empty and Current ⊂ s
		end

	is_disjoint (s: STS_SET [A, EQ]): BOOLEAN
			-- <Precursor>
		local
			s1, s2: STS_SET [A, EQ]
			l_eq: EQ
		do
			Result := True
			if not is_empty and not s.is_empty then
				from
					l_eq := eq -- Better to avoid recreating `eq' over and over.
					s1 := Current
				invariant
					definition: Result = ((Current ∖ s1) ∩ s) ≍ o
				until
					not Result or s1.is_empty
				loop
					from
						s2 := s
					invariant
						not_found_yet: (s ∖ s2) ∌ s1.any
					until
						s2.is_empty or else l_eq (s1.any, s2.any)
					loop
						s2 := s2.others
					variant
						cardinality_2: natural_as_integer (# s2)
					end
					Result := s2.is_empty
					s1 := s1.others
				variant
					cardinality_1: natural_as_integer (# s1)
				end
			end
		end

feature -- Quantifier

	exists alias "|∃" (p: PREDICATE [A]): BOOLEAN
			-- <Precursor>
		local
			s: SET [A, EQ]
		do
			from
				s := Current
			invariant
				not_yet: not transformer_to_boolean.set_reduction (Current ∖ s, False, agent cumulative_disjunction (?, p, ?))
			until
				s.is_empty or else p (s.any)
			loop
				s := s.others
			variant
				cardinality: natural_as_integer (# s)
			end
			Result := not s.is_empty
		end

	exists_unique alias "|∃!" (p: PREDICATE [A]): BOOLEAN
			-- <Precursor>
		local
			s: SET [A, EQ]
		do
			from
				s := Current
			invariant
				not_yet: ((Current ∖ s) | p) ≍ o
			until
				s.is_empty or else p (s.any)
			loop
				s := s.others
			variant
				cardinality: natural_as_integer (# s)
			end
			if not s.is_empty then
				check
					found: p (s.any) -- loop termination
				end
				Result := s.others |∄ p
			end
		end

	exists_pair (p: PREDICATE [A, A]): BOOLEAN
			-- <Precursor>
		local
			s1, s2: like subset_anchor
		do
			from
				s1 := Current
			invariant
--				definition: Result = ((Current ∖ s1).crossed (Current)).exist_xy (p)
			until
				Result or s1.is_empty
			loop
				from
					s2 := Current
				invariant
--					not_yet: (singleton (s1.any) × (Current ∖ s2)).do_not_exist_xy (p)
				until
					s2.is_empty or else p (s1.any, s2.any)
				loop
					s2 := s2.others
				variant
					cardinality_2: natural_as_integer (# s2)
				end
				Result := not s2.is_empty
				s1 := s1.others
			variant
				cardinality_1: natural_as_integer (# s1)
			end
		end

	exists_distinct_pair (p: PREDICATE [A, A]): BOOLEAN
			-- <Precursor>
		local
			s1, s2: like subset_anchor
			l_eq: EQ
		do
			from
				s1 := Current
				l_eq := eq -- Better to avoid recreating `eq' over and over.
			invariant
--				definition: Result = ((Current ∖ s1) × Current ∖ ∆ (Current ∖ s1)).exist_xy (p)
			until
				Result or s1.is_empty
			loop
				from
					s2 := Current
				invariant
--					not_yet: (singleton (s1.any) × (Current ∖ s2) ∖ ∆ (Current ∖ s2)).do_not_exist_xy (p)
				until
					s2.is_empty or else not l_eq (s1.any, s2.any) and p (s1.any, s2.any)
				loop
					s2 := s2.others
				variant
					cardinality_2: natural_as_integer (# s2)
				end
				Result := not s2.is_empty
				s1 := s1.others
			variant
				cardinality_1: natural_as_integer (# s1)
			end
		end

	for_all alias "|∀" (p: PREDICATE [A]): BOOLEAN
			-- <Precursor>
		local
			s: like subset_anchor
		do
			from
				s := Current
			invariant
				so_far_so_good: transformer_to_boolean.set_reduction (Current ∖ s, True, agent cumulative_conjunction (?, p, ?))
			until
				s.is_empty or else not p (s.any)
			loop
				s := s.others
			variant
				cardinality: natural_as_integer (# s)
			end
			Result := s.is_empty
		end

	for_all_pairs (p: PREDICATE [A, A]): BOOLEAN
			-- <Precursor>
		local
			s1, s2: like subset_anchor
		do
			from
				Result := True
				s1 := Current
			invariant
--				definition: Result = ((Current ∖ s1) × Current).for_all_xy (p)
			until
				not Result or s1.is_empty
			loop
				from
					s2 := Current
				invariant
--					so_far_so_good: (singleton (s1.any) × (Current ∖ s2)).for_all_xy (p)
				until
					s2.is_empty or else not p (s1.any, s2.any)
				loop
					s2 := s2.others
				variant
					cardinality_2: natural_as_integer (# s2)
				end
				Result := s2.is_empty
				s1 := s1.others
			variant
				cardinality_1: natural_as_integer (# s1)
			end
		end

	for_all_distinct_pairs (p: PREDICATE [A, A]): BOOLEAN
			-- <Precursor>
		local
			s1, s2: like subset_anchor
			l_eq: EQ
		do
			from
				Result := True
				s1 := Current
				l_eq := eq -- Better to avoid recreating `eq' over and over.
			invariant
--				definition: Result = ((Current ∖ s1) × Current ∖ ∆ (Current ∖ s1)).for_all_xy (p)
			until
				not Result or s1.is_empty
			loop
				from
					s2 := Current
				invariant
--					so_far_so_good: (singleton (s1.any) × (Current ∖ s2) ∖ ∆ (Current ∖ s2)).for_all_xy (p)
				until
					s2.is_empty or else not l_eq (s1.any, s2.any) and not p (s1.any, s2.any)
				loop
					s2 := s2.others
				variant
					cardinality_2: natural_as_integer (# s2)
				end
				Result := s2.is_empty
				s1 := s1.others
			variant
				cardinality_1: natural_as_integer (# s1)
			end
		end

feature -- Operation

--	subsets,
--	powerset: SUBSET_FAMILY [A, EQ]
--			-- <Precursor>
--		local
--			s: SET [A, EQ]
--			sf: SUBSET_FAMILY [A, EQ]
--		do
--			from
--				create Result.make_empty (Current)
--					check
--						not_in_family: o ∉ Result -- Result.is_empty
--						already_a_subset: o ⊆ Result.superset -- By definition
--					end
--				Result := Result.extended (o)
--				s := Current
--			invariant
--				building_up: Result ≍ {like element_to_sets}.set_reduction
--					(Current ∖ s, o.as_singleton, agent sets_plus_same_sets_with_element)
--				superset: Result.superset ≍ Current
--			until
--				s.is_empty
--			loop
--				from
--					sf := Result
--				invariant
--					preceding: attached {like element_to_sets}.set_reduction
--						(Current ∖ s, o.as_singleton, agent sets_plus_same_sets_with_element) as preceding
--					succeeding: Result ≍ (
--						preceding ∪ {like element_to_sets}.set_reduction
--							(singleton (s.any), preceding ∖ sf, agent sets_plus_same_sets_with_element)
--						)
--					same_superset: Result.superset ≍ Current
--				until
--					sf.is_empty
--				loop
--						check
--							does_not_have: sf.any ∌ s.any -- ∀ subset: sf ¦ (subset ⊆ (Current ∖ s)) ⇐ Loops invariants
--							not_in_family: -- ∀ subset: Result ¦ (subset ∈ (preceding ∖ sf)) ⇐ `succeeding' loop invariant.
--								sf.any.extended (s.any) ∉ Result
--							already_a_subset: -- sf.superset = Result.superset = Current and s.any ∈ Current
--								sf.any.extended (s.any) ⊆ Result.superset
--						end
--					Result := Result.extended (sf.any.extended (s.any))
--					sf := sf.others
--				variant
--					sf_cardinality: natural_as_integer (# sf)
--				end
--				s := s.others
--			variant
--				s_cardinality: natural_as_integer (# s)
--			end
--		end

--	trivial_subsets: SUBSET_FAMILY [A, EQ]
--			-- <Precursor>
--		do
--			Result := as_singleton
--			if not is_empty then
--					check
--						does_not_have: Result ∌ o -- Result = {Current} /= {o}
--						already_a_subset: o ⊆ Result.superset -- o.is_empty
--					end
--				Result := Result.extended (o)
--			end
--		end

--	proper_subsets: SUBSET_FAMILY [A, EQ]
--			-- <Precursor>
--			--| TODO: Clean up the algorithm...
--		local
--			s: SET [A, EQ]
--			place_holder, sf: SUBSET_FAMILY [A, EQ]
--		do
--			create Result.make_empty (Current)
--			s := Current
--			if not s.others.is_empty then
--				from
--						check
--							s_is_not_empty: not s.is_empty -- not s.others.is_empty
--							not_in_family: singleton (s.any) ∉ Result -- Result ≍ ∅
--							already_a_subset: singleton (s.any) ⊆ Result.superset -- s ≍ Current ≍ Result.superset
--						end
--					Result := Result.extended (singleton (s.any))
--					place_holder := Result
--						check
--							not_in_family: singleton (s.others.any) ∉ Result -- Result ≍ {`any'}
--							already_a_subset: singleton (s.others.any) ⊆ Result.superset -- s.others ⊂ Current ≍ Result.superset
--						end
--					Result := Result.extended (singleton (s.others.any))
--					s := s.others
--				invariant
--					definition: Result ≍ ((Current ∖ s.others).powerset / (Current ∖ s.others) / o)
--					superset: Result.superset ≍ Current
--					outer_place_holder: place_holder ≍ ((Current ∖ s).powerset / o)
--				until
--					s.others.is_empty
--				loop
--					from
--						sf := Result
--							check
--								place_holder_is_not_empty: not place_holder.is_empty -- place_holder ≍ ((Current ∖ s).powerset / o)
--								s_is_not_empty: not s.is_empty -- not s.others.is_empty
--								place_holder_any_does_not_have_s_any: place_holder.any ∌ s.any -- place_holder ⊂ (Current ∖ s).powerset
--								not_in_family: -- place_holder.any.extended (s.any) ≍ (Current ∖ s.others) ∉ Result (definition loop invariant)
--									place_holder.any.extended (s.any) ∉ Result
--								already_a_subset: place_holder.any.extended (s.any) ⊆ Result.superset -- place_holder ⊂ (Current ∖ s).powerset
--							end
--						Result := Result.extended (place_holder.any.extended (s.any))
--						place_holder := Result
--							check
--								not_in_family: singleton (s.others.any) ∉ Result -- ∀ xs: Result ¦ (xs ⊆ (Current ∖ s.others))
--								already_a_subset: singleton (s.others.any) ⊆ Result.superset -- Result.superset ≍ Current
--							end
--						Result := Result.extended (singleton (s.others.any))
--					invariant
--						sf: sf ⊆ ((Current ∖ s.others).powerset / (Current ∖ s.others) / o)
--						inner_place_holder: place_holder ≍ ((Current ∖ s.others).powerset / o)
--						building_up: Result ≍ (
--							place_holder & singleton (s.others.any) ∪ (
--								(place_holder.others ∖ sf) ↦ agent (xs: STS_SET [A, EQ]; a: A): STS_SET [A, EQ]
--									do
--										Result := xs & a
--									end (?, s.others.any)
--								)
--							)
--						same_superset: Result.superset ≍ Current
--					until
--						sf.is_empty
--					loop
--							check
--								sf_any_does_not_have: sf.any ∌ s.others.any -- sf loop invariant
--								not_in_family: sf.any.extended (s.others.any) ∉ Result -- building_up loop invariant
--								already_a_subset: sf.any.extended (s.others.any) ⊆ Result.superset -- loop invariant
--							end
--						Result := Result.extended (sf.any.extended (s.others.any))
--						sf := sf.others
--					variant
--						sf_cardinality: natural_as_integer (# sf)
--					end
--					s := s.others
--				variant
--					s_others_cardinality: natural_as_integer (# s.others)
--				end
--			end
--		end

	filtered alias "|" (p: PREDICATE [A]): like subset_anchor
			-- <Precursor>
		local
			s, previous_result, last_segment: like subset_anchor
		do
			from
				Result := o
				s := Current
			invariant
				every_compliant_element: (Current ∖ s) |∀ agent (Current ∖ s).iff (p, agent Result.has, ?)
				nothing_else: Result ⊆ (Current ∖ s)
			until
				s.is_empty
			loop
				if p (s.any) then
					from
						previous_result := Result
						check
							does_not_have: Result ∌ s.any -- Result ⊆ (Current ∖ s)
						end
						Result := Result.extended (s.any)
						last_segment := s
						s := s.others
					invariant
						previous_every_compliant_element: (Current ∖ last_segment) |∀ agent (Current ∖ last_segment).iff (p, agent previous_result.has, ?)
						previous_nothing_else: previous_result ⊆ (Current ∖ last_segment)
						compliant_segment: (last_segment ∖ s) |∀ p
						previous_result_is_disjoint: previous_result.is_disjoint (last_segment ∖ s) -- previous_result ⊆ (Current ∖ last_segment)
						building_up: Result ≍ previous_result.batch_extended (last_segment ∖ s)
					until
						s.is_empty or else not p (s.any)
					loop
						check
							loop_does_not_have: Result ∌ s.any
							-- previous_result.is_disjoint (last_segment ∖ s)
							-- Result ≍ previous_result.batch_extended (last_segment ∖ s)
						end
						Result := Result.extended (s.any)
						s := s.others
					variant
						inner_cardinality: natural_as_integer (# s)
					end
					if s.is_empty then
						check
							last_segment_is_disjoint: last_segment.is_disjoint (previous_result) -- previous_result.is_disjoint (last_segment ∖ s)
						end
							-- (last_segment ∖ s) |∀ p)
						Result := last_segment.batch_extended (previous_result)
					else
						s := s.others
					end
				else
					s := s.others
				end
			variant
				outer_cardinality: natural_as_integer (# s)
			end
		end

	complemented alias "∁" (s: STS_SET [A, EQ]): like set_anchor
			-- <Precursor>
		do
			if is_empty then
				Result := converted (s)
			else
				Result := Precursor {STS_SET} (s)
			end
		end

	intersected alias "∩" (s: STS_SET [A, EQ]): like subset_anchor
			-- <Precursor>
		do
			if s.is_empty then
				Result := o
			else
				Result := Precursor {STS_SET} (s)
			end
		end

	united alias "∪" (s: STS_SET [A, EQ]): like superset_anchor
			-- <Precursor>
		local
			diff: STS_SET [A, EQ]
		do
			diff := s ∖ Current
			check
				is_disjoint: is_disjoint (diff) -- diff = s ∖ Current
			end
			Result := batch_extended (diff)
		end

	subtracted alias "∖" (s: STS_SET [A, EQ]): like subset_anchor
			-- <Precursor>
		do
			if s.is_empty then
				Result := Current
			else
				Result := Precursor {STS_SET} (s)
			end
		end

feature -- Conversion

	natural_as_integer (n: like natural_anchor): INTEGER_64
			-- `n' converted into an integer value
			-- TODO: make it more flexible.
		do
			Result := n.as_integer_64
		ensure
			class
			definition: Result = n.as_integer_64
		end

feature -- Factory

	o,
	empty_set: like subset_anchor
			-- <Precursor>
			--| Notice: this implementation aims to prevent the creation of redundant empty sets, so preserving system space at the cost of some time.
		do
			from
				Result := Current
			invariant
				looking_up: o = Result.o
			until
				Result.is_empty
			loop
				Result := Result.others
			variant
				cardinality: natural_as_integer (# Result)
			end
		end

	singleton (a: A): like set_anchor
			-- <Precursor>
		do
			check
				does_not_have: o ∌ a -- o.is_empty
			end
			Result := o.extended (a)
		end

	converted_element (a: A): like any_anchor
			-- `a' converted to an element like `any'
		do
			Result := a
		ensure
			definition: eq (Result, a)
		end

	converted (s: STS_SET [A, EQ]): like set_anchor
			-- <Precursor>
		do
			if attached {like set_anchor} s as cs then
				Result := cs
			else
				check
					is_disjoint: o.is_disjoint (s) -- o.is_empty
				end
				Result := o.batch_extended (s)
			end
		end

feature -- Predicate

	equality_holds (x1, x2: A): BOOLEAN
			-- <Precursor>
		do
			Result := eq (x1, x2)
		ensure then
			class
		end

	subset_relation_holds (s1, s2: STS_SET [A, EQ]; a_eq: EQ): BOOLEAN
			-- Does the relation `s1' ⊆ `s1' hold?
			--| Intended to help avoiding the indirection of agents and the repeated creation of `eq' at each element comparison.
		local
			l_s1, l_s2: STS_SET [A, EQ]
			a: A
		do
			from
				Result := True
				l_s1 := s1
			invariant
				definition: Result = ((s1 ∖ l_s1) ⊆ s2)
			until
				not Result or l_s1.is_empty
			loop
				from
					a := l_s1.any
					Result := False
					l_s2 := s2
				invariant
					not_found_yet: (s2 ∖ l_s2) ∌ a
				until
					l_s2.is_empty or else a_eq (a, l_s2.any)
				loop
					l_s2 := l_s2.others
				variant
					cardinality_2: natural_as_integer (# l_s2)
				end
				Result := not l_s2.is_empty
				l_s1 := l_s1.others
			variant
				cardinality_1: natural_as_integer (# l_s1)
			end
		ensure
			class
			definition: Result = (s1 ⊆ s2)
		end

feature -- Transformer

	transformer_to_boolean: TRANSFORMER [A, BOOLEAN, STS_OBJECT_EQUALITY [BOOLEAN]]
			-- <Precursor>
		do
			create Result
		ensure then
			class
		end

	transformer_to_natural: TRANSFORMER [A, like natural_anchor, STS_OBJECT_EQUALITY [like natural_anchor]]
			-- <Precursor>
		do
			create Result
		ensure then
			class
		end

feature -- Anchor

	any_anchor: A
			-- Anchor for objects like `any'
		require
			is_not_empty: not is_empty
		do
			Result := any
		end

	set_anchor,
	subset_anchor,
	superset_anchor: SET [A, EQ]
			-- <Precursor>
		do
			Result := Current
		end

feature {NONE} -- Implementation

	any_storage: detachable CELL [like any_anchor]
			-- Storage for `any'
		note
			option: stable
		attribute
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	source: ""

end
