﻿note
	description: "[
			Element that models a mathematical set.
			Notice that Eiffel Base has a {SET} class, that was renamed to {EB_SET} in order to not clash with this one, that has a more
			fundamental nature, hence the choice of keeping current's name instead of Eiffel Base's one.
		]"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SET [A, EQ -> EQUALITY [A]]

inherit
	ELEMENT
		rename
			is_in as element_is_in,
			is_not_in as element_is_not_in
		end

feature -- Primitive

	is_empty: BOOLEAN
			-- Does current set have no element?
		deferred
		end

	any: A
			-- An arbitrary element in current set
			-- NOTICE: Two equal set may have different `any'; even the same set is free to return different `any' at different times. Please see {SET}.equals.
		require
			is_not_empty: not is_empty
		deferred
		end

	others: like subset_anchor
			-- Set that has only and all the elements in current set but `any'
			--| NOTICE: There is no precondition to `others'; if current set is empty, `others' is empty too, as stated in {SET} invariant.
		deferred
		end

	eq: EQ
			-- Rule for testing equality between elements in current set
			--| Notice that the type of `eq' is hard-wired as a generic parameter. Though it is not very flexible, the alternative would be to guard with
			--| preconditions every feature where two sets are somehow compared, in order to check whether their current equalities are equivalent, and this
			--| would be rather cumbersome. Making the equality part of the set type guarantees that only compatible sets are compared at any time, with no
			--| need for preconditions.
		deferred
		end

feature -- Membership

	is_in alias "∈" (s: SET [SET [A, EQ], EQUALITY [SET [A, EQ]]]): BOOLEAN
			-- Does `s` have current set?
		do
			Result := s ∋ Current
		ensure
			definition: Result = s ∋ Current
		end

	is_not_in alias "∉" (s: SET [SET [A, EQ], EQUALITY [SET [A, EQ]]]): BOOLEAN
			-- Is not current set in `s'?
		do
			Result := not (Current ∈ s)
		ensure
			definition: Result = not (Current ∈ s)
		end

	has alias "∋" (a: A): BOOLEAN
			-- Is `a' an element in current set?
		do
			Result := Current |∃ agent equality_holds (a, ?)
		ensure
			definition: Result = (Current |∃ agent equality_holds (a, ?))
		end

	does_not_have alias "∌" (a: A): BOOLEAN
			-- Does not current set have `a'?
		do
			Result := not (Current ∋ a)
		ensure
			definition: Result = not (Current ∋ a)
		end

feature -- Construction

	with alias "&" (a: A): like superset_anchor
			-- Every element in current set, together with `a'.
		deferred
		ensure
			has_a: Result ∋ a
			nothing_lost: Current |∀ agent Result.has
			nothing_else: Result |∀ agent ored (agent has, agent equality_holds (a, ?), ?)
		end

	without alias "/" (a: A): like subset_anchor
			-- Every element in current set but `a'
		deferred
		ensure
			does_not_have_a: Result ∌ a
			nothing_lost: Current |∀ agent xored (agent Result.has, agent equality_holds (a, ?), ?)
			nothing_else: Result |∀ agent has
		end

feature -- Quality

	is_singleton: BOOLEAN
			-- Does current set have exactly one element?
		do
			Result := not is_empty and others.is_empty
		ensure
			definition: Result = (not is_empty and others.is_empty)
		end

feature -- Measurement

	cardinality alias "#": like natural_anchor
			-- Number of elements in current set
		do
			Result := transformer_to_natural.set_reduction (Current, 0, agent cumulative_successor)
		ensure
			definition: Result = transformer_to_natural.set_reduction (Current, 0, agent cumulative_successor)
		end

feature -- Comparison

	equals alias "≍" (s: SET [A, EQ]): BOOLEAN
			-- Do current set and `s' have exactly the same elements?
			--| NOTICE: As expected, the order of the elements within the two sets is irrelevant, as are the types of the
			--| sets themselves; in order to be regarded equal, sets just must have the same elements under the same
			--| equality. By the way, redefining `is_equal' is not an option, since `is_equal' post-conditions require that
			--| `s' is like `Current', and two sets must be comparable according to the types of their elements and of their
			--| equalities only, not by the type of the sets temselves.
		do
			Result := (Current |∀ agent s.has) and (s |∀ agent has)
		ensure
			definition: Result = ((Current |∀ agent s.has) and (s |∀ agent has))
		end

	unequals alias "≭" (s: SET [A, EQ]): BOOLEAN
			-- Does not current set equal `s'?
		do
			Result := not (Current ≍ s)
		ensure
			definition: Result = not (Current ≍ s)
		end

	is_subset alias "⊆" (s: SET [A, EQ]): BOOLEAN
			-- Does `s' include current set, i.e. does `s' have every element in current set?
		do
			Result := Current |∀ agent s.has
		ensure
			definition: Result = (Current |∀ agent s.has)
		end

	is_not_subset alias "⊈" (s: SET [A, EQ]): BOOLEAN
			-- Is not current set a subset of `s'?
		do
			Result := not (Current ⊆ s)
		ensure
			definition: Result = not (Current ⊆ s)
		end

	is_superset alias "⊇" (s: SET [A, EQ]): BOOLEAN
			-- Does current set include `s'?
		do
			Result := s ⊆ Current
		ensure
			definition: Result = (s ⊆ Current)
		end

	is_not_superset alias "⊉" (s: SET [A, EQ]): BOOLEAN
			-- Does not current set include `s'?
		do
			Result := not (Current ⊇ s)
		ensure
			definition: Result = not (Current ⊇ s)
		end

	is_comparable (s: SET [A, EQ]): BOOLEAN
			-- Is current set a subset or a superset of `s'?
		do
			Result := Current ⊆ s or s ⊆ Current
		ensure
			definition: Result = (Current ⊆ s or s ⊆ Current)
		end

	is_not_comparable (s: SET [A, EQ]): BOOLEAN
			-- Is not current set a subset or a superset of `s'?
		do
			Result := not is_comparable (s)
		ensure
			definition: Result = not is_comparable (s)
		end

	is_strict_subset alias "⊂" (s: SET [A, EQ]): BOOLEAN
			-- Does `s' include current set and are both sets unequal?
		do
			Result := Current ⊆ s and Current ≭ s
		ensure
			definition: Result = (Current ⊆ s and Current ≭ s)
		end

	is_not_strict_subset alias "⊄" (s: SET [A, EQ]): BOOLEAN
			-- Is not current set a strict subset of `s'?
		do
			Result := not (Current ⊂ s)
		ensure
			definition: Result = not (Current ⊂ s)
		end

	is_strict_superset alias "⊃" (s: SET [A, EQ]): BOOLEAN
			-- Does current set include `s' strictly?
		do
			Result := s ⊂ Current
		ensure
			definition: Result = (s ⊂ Current)
		end

	is_not_strict_superset alias "⊅" (s: SET [A, EQ]): BOOLEAN
			-- Does not current set include `s' strictly?
		do
			Result := not (Current ⊃ s)
		ensure
			definition: Result = not (Current ⊃ s)
		end

	is_trivial_subset (s: SET [A, EQ]): BOOLEAN
			-- Is current set the empty or the full susbset of `s'?
		do
			Result := Current ≍ o or Current ≍ s
		ensure
			definition: Result = (Current ≍ o or Current ≍ s)
		end

	is_trivial_superset (s: SET [A, EQ]): BOOLEAN
			-- Is `s' a trivial subset of current set?
		do
			Result := s.is_trivial_subset (Current)
		ensure
			definition: Result = s.is_trivial_subset (Current)
		end

	is_proper_subset (s: SET [A, EQ]): BOOLEAN
			-- Is current set a non-trivial subset of `s'?
		do
			Result := Current ⊆ s and Current ≭ o and Current ≭ s
		ensure
			definition: Result = (Current ⊆ s and Current ≭ o and Current ≭ s)
		end

	is_proper_superset (s: SET [A, EQ]): BOOLEAN
			-- Is `s' a proper subset of current set?
		do
			Result := s.is_proper_subset (Current)
		ensure
			definition: Result = s.is_proper_subset (Current)
		end

	is_disjoint (s: SET [A, EQ]): BOOLEAN
			-- Do current set and `s' have no common element?
		do
			Result := (Current ∩ s) ≍ o
		ensure
			definition: Result = (Current ∩ s) ≍ o
		end

	intersects (s: SET [A, EQ]): BOOLEAN
			-- Do current set and `s' have any common element?
		do
			Result := not is_disjoint (s)
		ensure
			definition: Result = not is_disjoint (s)
		end

feature -- Relationship

--	is_partitioned (ss: SET_OF_SETS [A, EQ]): BOOLEAN
--			-- Is `ss' a partition of current set, i.e. a partition whose union equals current set?
--		do
--			Result := (Current ≍ ⋃ ss) and ss.is_partition
--		ensure
--			definition: Result = ((Current ≍ ⋃ ss) and ss.is_partition)
--		end

feature -- Quantifier

	exists alias "|∃" (p: PREDICATE [A]): BOOLEAN
			-- Existential quantifier: does `p' hold for some element in current set?
		note
			EIS: "name=Quantifiers", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#quantifiers", "tag=operator, syntax"
		do
			Result := transformer_to_boolean.set_reduction (Current, False, agent cumulative_disjunction (?, p, ?))
		ensure
			definition: Result = transformer_to_boolean.set_reduction (Current, False, agent cumulative_disjunction (?, p, ?))
		end

	does_not_exist alias "|∄" (p: PREDICATE [A]): BOOLEAN
			-- Existence negation: does `p' hold for no element in current set?
		note
			EIS: "name=Quantifiers", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#quantifiers", "tag=operator, syntax"
		do
			Result := not (Current |∃ p)
		ensure
			definition: Result = not (Current |∃ p)
		end

	exists_unique alias "|∃!" (p: PREDICATE [A]): BOOLEAN
			-- Uniqueness quantifier: does `p' hold for just one element in current set?
		note
			EIS: "name=Quantifiers", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#quantifiers", "tag=operator, syntax"
		do
			Result := (Current | p).is_singleton
		ensure
			definition: Result = (Current | p).is_singleton
		end

	exists_pair (p: PREDICATE [A, A]): BOOLEAN
			-- Does `p' hold for some pair of elements in current set?
		note
			EIS: "name=Quantifiers", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#quantifiers", "tag=operator, syntax"
		do
--			Result := (× Current).exist_xy (p)
		ensure
--			definition: Result = (× Current).exist_xy (p)
		end

	does_not_exist_pair (p: PREDICATE [A, A]): BOOLEAN
			-- Does `p' hold for no pair of elements in current set?
		note
			EIS: "name=Quantifiers", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#quantifiers", "tag=operator, syntax"
		do
			Result := not exists_pair (p)
		ensure
			definition: Result = not exists_pair (p)
		end

	exists_distinct_pair (p: PREDICATE [A, A]): BOOLEAN
			-- Does `p' hold for some pair of distinct elements in current set?
		note
			EIS: "name=Quantifiers", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#quantifiers", "tag=operator, syntax"
		do
--			Result := (× Current ∖ ∆ Current).exist_xy (p)
		ensure
--			definition: Result = (× Current ∖ ∆ Current).exist_xy (p)
		end

	for_all alias "|∀" (p: FUNCTION [A, BOOLEAN]): BOOLEAN
			-- Universal quantifier: does `p' hold for every element in current set?
		note
			EIS: "name=Quantifiers", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#quantifiers", "tag=operator, syntax"
		do
			Result := transformer_to_boolean.set_reduction (Current, True, agent cumulative_conjunction (?, p, ?))
		ensure
			definition: Result = transformer_to_boolean.set_reduction (Current, True, agent cumulative_conjunction (?, p, ?))
		end

	for_all_pairs (p: PREDICATE [A, A]): BOOLEAN
			-- Does `p' hold for every pair of elements in current set?
		note
			EIS: "name=Quantifiers", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#quantifiers", "tag=operator, syntax"
		do
--			Result := (× Current).for_all_xy (p)
		ensure
--			definition: Result = (× Current).for_all_xy (p)
		end

	for_all_distinct_pairs (p: PREDICATE [A, A]): BOOLEAN
			-- Does `p' hold for every pair of distinct elements in current set?
		note
			EIS: "name=Quantifiers", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#quantifiers", "tag=operator, syntax"
		do
--			Result := (× Current ∖ ∆ Current).for_all_xy (p)
		ensure
--			definition: Result = (× Current ∖ ∆ Current).for_all_xy (p)
		end

feature -- Operation

--	subsets,
--	powerset: SUBSET_FAMILY [A, EQ]
--			-- Every subset of current set
--		deferred
--		ensure
--			definition: Result ≍
--				element_to_sets.set_reduction (Current, o.as_singleton, agent sets_plus_same_sets_with_element)
--			superset: Result.superset ≍ Current
--		end

--	trivial_subsets: SUBSET_FAMILY [A, EQ]
--			-- Family with only the empty and the full subsets of current set
--		do
--			Result := as_singleton & o
--		ensure
--			definition: Result ≍ (as_singleton & o)
--			superset: Result.superset ≍ Current
--		end

--	proper_subsets: SUBSET_FAMILY [A, EQ]
--			-- Every non-trivial subset of current set
--		do
--			Result := powerset / Current / o
--		ensure
--			definition: Result ≍ (powerset / Current / o)
--			superset: Result.superset ≍ Current
--		end

	filtered alias "|" (p: PREDICATE [A]): like subset_anchor
			-- Every element in current set for which `p' holds
		deferred
		ensure
			every_compliant_element: Current |∀ agent iff (p, agent Result.has, ?)
			nothing_else: Result ⊆ Current
		end

	complemented alias "∁" (s: SET [A, EQ]): like set_anchor
			-- Complement of current set relative to `s', i.e. every element in `s' that is not in current set.
		require
			is_subset: Current ⊆ s
		do
			Result := s | agent does_not_have
		ensure
			definition: Result ≍ (s | agent does_not_have)
		end

	intersected alias "∩" (s: SET [A, EQ]): like subset_anchor
			-- Intersection of current set and `s', i.e. every element in current set that is in `s'.
		do
			Result := Current | agent s.has
		ensure
			definition: Result ≍ (Current | agent s.has)
		end

	united alias "∪" (s: SET [A, EQ]): like superset_anchor
			-- Union of current set and `s', i.e. every element that is in current set or in `s'.
		deferred
		ensure
			every_element_here: Current ⊆ Result
			every_element_there: s ⊆ Result
			nothing_else: Result |∀ agent ored (agent has, agent s.has, ?)
		end

	subtracted alias "∖" (s: SET [A, EQ]): like subset_anchor
			-- Difference of current set and `s', i.e. every element that is in current set but not in `s'.
		do
			Result := Current | agent s.does_not_have
		ensure
			definition: Result ≍ (Current | agent s.does_not_have)
		end

	subtracted_symmetricaly alias "⊖" (s: SET [A, EQ]): like set_anchor
			-- Symmetric difference of current set and `s', i.e. every element that is in current set or in `s' but not in both.
		do
			Result := (Current ∪ s) | agent xored (agent has, agent s.has, ?)
		ensure
			definition: Result ≍ ((Current ∪ s) | agent xored (agent has, agent s.has, ?))
		end

--	crossed alias "×" (s: SET [A, EQ]): like product_anchor
--			-- The cartesian product of current set and `s'
--		do
--			Result := element_to_element.cartesian_product (Current, s)
--		ensure
--			definition: Result ≍ element_to_element.cartesian_product (Current, s)
--		end

--	squared alias "×": like square_anchor
--			-- Current set crossed with itself
--			--| Of course, it would be better to express such a square with an s², but Eiffel does not have postfixed operators.
--		do
--			Result := Current × Current
--		ensure
--			definition: Result ≍ (Current × Current)
--		end

--	diagonal alias "∆": like diagonal_anchor
--			-- Every element x in current set, mapped to the respective identical pair (x, x).
--			--| Indeed the alias of this feature should be the Greek capital letter delta ("Δ", or "%u0x0394", as in
--			--| https://proofwiki.org/w/index.php?title=Symbols:Greek/Delta&oldid=454484), but Eiffel is going to accept Greek letters as part of identifiers, so
--			--| the alias was changed to "%u0x2206".
--		do
--			Result := (× Current).filtered_xy (agent equality_holds)
--		ensure
--			definition: Result ≍ (× Current).filtered_xy (agent equality_holds)
--		end

--	raised alias "^" (n: NATURAL): like n_tuple_set_anchor
--			-- The cartesian product of `n' instances of current set
--		do
--			Result := ∏ n_times (n)
--		ensure
--			definition: Result ≍ (∏ n_times (n))
--		end

--	crossed_tuples (ts: SET [N_TUPLE [A, EQ], N_TUPLE_EQUALITY [A, EQ]]): like n_tuple_set_anchor
--			-- Current set "crossed" with `ts', i.e. set with every tuple in `ts' preceded by every element in current set.
--		do
--			Result := tuple_extensor.set_map (element_to_tuple.cartesian_product (Current, ts), agent second_after_first)
--		ensure
--			definition: Result ≍ tuple_extensor.set_map (element_to_tuple.cartesian_product (Current, ts), agent second_after_first)
--		end

feature -- Transformation

	mapped alias "↦" (f: FUNCTION [A, A]): like set_map_anchor
			-- Current set mapped by `f' to a set of the same kind
			--| TODO: Make it a {SET_FAMILY} in {SET_OF_SETS}?
		do
			Result := transformer_to_element.set_map (Current, f)
		ensure
			definition: Result ≍ transformer_to_element.set_map (Current, f)
		end

	reduced (leftmost: A; f: FUNCTION [A, A, A]): A
			-- Current set reduced by `f' to a value like `leftmost'
			-- NOTICE: Since the order of the elements in a set is irrelevant, the value of `reduced' may differ for two equal sets,
			-- unless `f' is commutative. Indeed, since an implementation set is free to iterate over its elements differently at
			-- different times, even the same set may produce different results for different applications of
			-- {SET}.reduced (`leftmost', `f'), where `leftmost' and `f' are the same.
		do
			Result := transformer_to_element.set_reduction (Current, leftmost, f)
		ensure
			definition: eq (Result, transformer_to_element.set_reduction (Current, leftmost, f))
		end

	proper_reduced (f: FUNCTION [A, A, A]): A
			-- Current non-empty set reduced by `f' to a value like {A}
			-- NOTICE: Please see the notice at `reduced' header.
		require
			is_not_empty: not is_empty
		do
			Result := others.reduced (any, f)
		ensure
			definition: eq (Result, others.reduced (any, f))
		end

feature -- Factory

	o,
	empty_set: like subset_anchor
			-- Set with no element, i.e. {} or ∅.
		deferred
		ensure
			definition: Result.is_empty
		end

	singleton (a: A): like set_anchor
			-- Set that has `a' as its sole element, i.e. {`a'}.
		deferred
		ensure
			has_a: Result ∋ a
			nothing_else: Result.is_singleton
		end

feature -- Predicate

	equality_holds (x1, x2: A): BOOLEAN
			-- Does `eq' (`x1', `x2') hold?
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Result := eq (x1, x2)
		ensure
			definition: Result = eq (x1, x2)
		end

	ored (p1, p2: PREDICATE [A]; x: A): BOOLEAN
			-- Does `p1' (`x') or `p2' (`x') hold?
			-- TODO: Pull it up?
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Result := p1 (x) or p2 (x)
		ensure
			class
			definition: Result = (p1 (x) or p2 (x))
		end

	xored (p1, p2: PREDICATE [A]; x: A): BOOLEAN
			-- Does `p1' (`x') or `p2' (`x') hold exclusively, i.e. does `p1' (`x') xor `p2' (`x') hold?
			-- TODO: Pull it up?
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Result := p1 (x) xor p2 (x)
		ensure
			class
			definition: Result = (p1 (x) xor p2 (x))
		end

	iff (p1, p2: PREDICATE [A]; x: A): BOOLEAN
			-- Is `p1' (`x') equivalent to `p2' (`x'), i.e. does `p1' (`x') hold if and only if `p2' (`x') holds?
			-- TODO: Pull it up?
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Result := p1 (x) = p2 (x)
		ensure
			class
			definition: Result = (p1 (x) = p2 (x))
		end

feature -- Reduction

	cumulative_disjunction (acc: BOOLEAN; p: PREDICATE [A]; x: A): BOOLEAN
			-- Logical disjunction of `acc' and `p' (`x'), i.e. `acc' or `p' (`x').
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Result := acc or p (x)
		ensure
			class
			definition: Result = (acc or p (x))
		end

	cumulative_conjunction (acc: BOOLEAN; p: FUNCTION [A, BOOLEAN]; x: A): BOOLEAN
			-- Logical conjunction of `acc' and `p' (`x'), i.e. `acc' and `p' (`x').
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Result := acc and p (x)
		ensure
			class
			definition: Result = (acc and p (x))
		end

	cumulative_successor (acc: like natural_anchor; x: A): like natural_anchor
			-- Natural number that succeeds `acc', i.e. `acc' + 1; `x' is ignored.
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Result := acc + 1
		ensure
			class
			definition: Result = acc + 1
		end

feature -- Transformer

	transformer_to_element: TRANSFORMER [A, A, EQ]
			-- Transformer between types derived from {A}
		deferred
		end

	transformer_to_boolean: TRANSFORMER [A, BOOLEAN, OBJECT_EQUALITY [BOOLEAN]]
			-- Transformer of objects whose types derive from {A} to objects whose types derive from {BOOLEAN}
		deferred
		end

	transformer_to_natural: TRANSFORMER [A, like natural_anchor, OBJECT_EQUALITY [like natural_anchor]]
			-- Transformer of objects whose types derive from {A} to objects whose types derive from {like natural_anchor}
		deferred
		end

--	transformer_to_set: TRANSFORMER [A, SET [A, EQ], SET_EQUALITY [A]]
--			-- Transformer of objects whose types derive from {A} to objects whose types derive from {SET [A, EQ]}
--		deferred
--		end

feature -- Anchor

	natural_anchor: NATURAL
			-- Anchor for natural numbers
			--| TODO: Pull it up to a target-dependant class.
		do
		ensure
			class
		end

	set_anchor: SET [A, EQ]
			-- Anchor for sets like current one
		deferred
		end

	subset_anchor: SET [A, EQ]
			-- Anchor for subsets of current set
		deferred
		end

	superset_anchor: SET [A, EQ]
			-- Anchor for supersets of current set
		deferred
		end

--	product_anchor: SET_OF_ORDERED_PAIRS [A, A, EQ, EQ]
--			-- Anchor for Cartesian products
--		deferred
--		end

--	square_anchor: SET_OF_ORDERED_PAIRS [A, A, EQ, EQ]
--			-- Anchor for Cartesian squares
--		deferred
--		end

--	diagonal_anchor: SET_OF_ORDERED_PAIRS [A, A, EQ, EQ]
--			-- Anchor for Cartesian diagonals
--		deferred
--		end

--	n_tuple_set_anchor: SET [N_TUPLE [A, EQ], N_TUPLE_EQUALITY [A, EQ]]
--			-- Set of n-tuples of terms like the elements in this set
--		deferred
--		end

	set_map_anchor: SET [A, EQ]
			-- Anchor for set maps
		deferred
		end

invariant
	consistent_emptiness: is_empty ⇒ others.is_empty
	no_repetition: not is_empty ⇒ others ∌ any

note
	copyright: "Copyright (c) 2012-2024, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
