note
	description: "Mutable implementation of the concept of a mathematical set"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	MUTABLE_SET [A, EQ -> STS_EQUALITY [A] create default_create end]

inherit
	STS_SET [A, EQ]
		redefine
			exists_pair,
			exists_distinct_pair,
			for_all_pairs,
			for_all_distinct_pairs,
			complemented,
			mapped
		end

create
	make_empty,
	make_singleton

create {MUTABLE_SET}
	make_from_special

feature {NONE} -- Initialization

	make_empty
			-- Create an empty set, i.e. {} or ∅.
		do
			create elements.make_empty (0)
		ensure
			is_empty: is_empty
		end

	make_singleton (a: A)
			-- Create a singleton in the form {`a'}.
		do
			create elements.make_filled (a, 1)
		ensure
			is_not_empty: not is_empty
			any: eq (any, a)
			others: others.is_empty
		end

	make_from_special (xs: SPECIAL [A])
			-- Create a set with every element in `xs'.
		local
			i, j: INTEGER
		do
			from
				elements := xs.twin
				i := 0
			invariant
				valid_outer_k: ∀ k: 0 |..| (i - 1) ¦ elements.valid_index (k) -- 0 ≤ k < i < elements.count
				no_repetition: ∀ k: 0 |..| (i - 1) ¦ occurrences (elements [k], elements) = 1
			until
				i = elements.count
			loop
				from
					j := i + 1
				invariant
					valid_i: elements.valid_index (i) -- 0 ≤ i < elements.count
					valid_inner_k: ∀ k: (i + 1) |..| (j - 1) ¦ elements.valid_index (k) -- 0 ≤ i < k < j < elements.count
					repetitions_pruned: ∀ k: (i + 1) |..| (j - 1) ¦ not eq (elements [i], elements [k])
				until
					j = elements.count
				loop
					check
						valid_index: elements.valid_index (j) -- 0 ≤ i < j < elements.count
					end
					if eq (elements [i], elements [j]) then
						check
							source_index_non_negative: j + 1 >= 0 -- 0 ≤ i < j
							destination_index_non_negative: j >= 0 -- 0 ≤ i < j
							destination_index_in_bound: j <= elements.count -- 0 ≤ i < j < elements.count
							n_non_negative: elements.count - (j + 1) >= 0 -- 0 ≤ i < j < elements.count
							n_is_small_enough_for_source: j + 1 + elements.count - (j + 1) <= elements.count -- Algebra
							n_is_small_enough_for_destination: j + elements.count - (j + 1) <= elements.capacity -- 0 ≤ i < j < elements.count ≤ elements.capacity
						end
						elements.move_data (j + 1, j, elements.count - (j + 1))
						check
							less_than_count: 1 <= elements.count -- elements.count > 0 ⇐ 0 ≤ i < j < elements.count
						end
						elements.remove_tail (1)
					else
						j := j + 1
					end
				variant
					elements.count - j
				end
				i := i + 1
			variant
				elements.count - i
			end
			check
				n_non_negative: elements.count >= 0 -- {SPECIAL}.count definition
			end
			elements := elements.aliased_resized_area (elements.count)
		ensure
			source_unchanged: xs ~ old xs.twin
			nothing_lost: ∀ x: xs ¦ ∃ y: elements ¦ eq (x, y)
			nothing_else: ∀ x: elements ¦ ∃ y: xs ¦ eq (x, y)
			no_repetition: ∀ x: elements ¦ occurrences (x, elements) = 1
			no_waste: elements.count = elements.capacity
		end

feature -- Primitive

	is_empty: BOOLEAN
			-- <Precursor>
		do
			Result := elements.count = 0
		ensure then
			implementation: Result = (elements.count = 0)
		end

	any: A
			-- <Precursor>
		do
			check
				valid_index: elements.valid_index (0) -- not is_empty
			end
			Result := elements [0]
		ensure then
			valid_index: elements.valid_index (0) -- not is_empty
			implementation: eq (Result, elements [0])
		end

	others: like subset_anchor
			-- <Precursor>
		local
			xs: SPECIAL [A]
		do
			if elements.count = 0 then
				Result := Current
			else
				xs := elements.twin
				check
					no_more_than_count: 1 <= xs.count -- 0 < xs.count
				end
				xs.remove_head (1)
				create Result.make_from_special (xs)
			end
		end

	eq: EQ
			-- <Precursor>
		attribute
			create Result
		end

feature -- Construction

	with alias "&" (a: A): like superset_anchor
			-- <Precursor>
		local
			xs: SPECIAL [A]
		do
			if ∃ x: elements ¦ eq (x, a) then
				Result := Current
			else
				check
					n_non_negative: elements.count + 1 >= 0 -- elements.count >= 0
				end
				xs := elements.resized_area (elements.count + 1)
				check
					count_small_enough: xs.count < xs.capacity -- xs.count = elements.count < elements.count + 1 = xs.capacity
				end
				xs.extend (a)
				create Result.make_from_special (xs)
			end
		end

	without alias "/" (a: A): like subset_anchor
			-- <Precursor>
		local
			i: INTEGER
			xs: SPECIAL [A]
		do
			from
			invariant
				valid_indices: ∀ j: 0 |..| (i - 1) ¦ elements.valid_index (j) -- 0 <= j < i < elements.count
				not_found_yet: ∀ j: 0 |..| (i - 1) ¦ not eq (elements [j], a)
				valid_index: i /= elements.count ⇒ elements.valid_index (i) -- 0 <= i < elements.count
			until
				i = elements.count or else eq (elements [i], a)
			loop
				i := i + 1
			variant
				elements.count - i
			end
			if i = elements.count then
				Result := Current
			else
				xs := elements.twin
				check
					source_index_non_negative: i + 1 >= 0 -- 0 <= i < elements.count
					destination_index_non_negative: i >= 0 -- 0 <= i < elements.count
					destination_index_in_bound: i <= xs.count -- 0 <= i < elements.count = xs.xount
					n_non_negative: xs.count - (i + 1) >= 0 -- 0 <= i < elements.count = xs.xount
					n_is_small_enough_for_source: i + 1 + xs.count - (i + 1) <= xs.count -- Algebra
					n_is_small_enough_for_destination: i + xs.count - (i + 1) <= xs.capacity -- xs.count <= xs.capacity
				end
				xs.move_data (i + 1, i, xs.count - (i + 1))
				check
					no_more_than_count: 1 <= xs.count -- 0 <= i < elements.count = xs.xount
				end
				xs.remove_tail (1)
				create Result.make_from_special (xs)
			end
		end

feature -- Quantifier

	exists_pair (p: PREDICATE [A, A]): BOOLEAN
			-- <Precursor>
		do
			Result := ∃ x: elements ¦ ∃ y: elements ¦ p (x, y)
		end

	exists_distinct_pair (p: PREDICATE [A, A]): BOOLEAN
			-- <Precursor>
		do
			Result := ∃ x: elements ¦ ∃ y: elements ¦ p (x, y) and not eq (x, y)
		end

	for_all_pairs (p: PREDICATE [A, A]): BOOLEAN
			-- <Precursor>
		do
			Result := ∀ x: elements ¦ ∀ y: elements ¦ p (x, y)
		end

	for_all_distinct_pairs (p: PREDICATE [A, A]): BOOLEAN
			-- <Precursor>
		do
			Result := ∀ x: elements ¦ ∀ y: elements ¦ not eq (x, y) ⇒ p (x, y)
		end

feature -- Operation

	filtered alias "|" (p: PREDICATE [A]): like subset_anchor
			-- <Precursor>
		local
			xs: SPECIAL [A]
			i: INTEGER
		do
			from
				xs := elements.twin
			invariant
				decrescent: xs.count ≤ elements.count
				valid_elements_indices: ∀ j: 0 |..| (i - 1 + (elements.count - xs.count)) ¦ elements.valid_index (j) -- 0 <= j < i + (elements.count - xs.count) < elements.count
				valid_xs_indices: ∀ k: 0 |..| (i - 1) ¦ xs.valid_index (k) -- 0 <= k < i < xs.count
				every_compliant_element: ∀ j: 0 |..| (i - 1 + (elements.count - xs.count)) ¦ p (elements [j]) = ∃ k: 0 |..| (i - 1) ¦ eq (elements [j], xs [k])
				nothing_else: ∀ k: 0 |..| (i - 1) ¦ ∃ j: 0 |..| (i - 1 + (elements.count - xs.count)) ¦ eq (xs [k], elements [j])
			until
				i = xs.count
			loop
				if p (xs [i]) then
					i := i + 1
				else
					check
						source_index_non_negative: i + 1 >= 0 -- 0 <= i < xs.count
						destination_index_non_negative: i >= 0 -- 0 <= i < xs.count
						destination_index_in_bound: i <= xs.count -- 0 <= i < xs.count
						n_non_negative: xs.count - (i + 1) >= 0 -- 0 <= i < xs.count
						n_is_small_enough_for_source: i + 1 + xs.count - (i + 1) <= xs.count -- Algebra
						n_is_small_enough_for_destination: i + xs.count - (i + 1) <= xs.capacity -- xs.count <= xs.capacity
					end
					xs.move_data (i + 1, i, xs.count - (i + 1))
					check
						no_more_than_count: 1 <= xs.count -- 0 <= i < xs.xount
					end
					xs.remove_tail (1)
				end
			variant
				xs.count - i
			end
			create Result.make_from_special (xs)
		end

	complemented alias "∁" (s: STS_SET [A, EQ]): like set_anchor
			-- <Precursor>
		local
			l_s: STS_SET [A, EQ]
			xs: SPECIAL [A]
		do
			from
				create xs.make_empty ((# s).as_integer_32) -- # s >= 0
				l_s := s
			invariant
				nothing_lost: ((s ∖ l_s) | agent does_not_have) |∀ agent (ia_xs: SPECIAL [A]; x: A): BOOLEAN do Result := ∃ y: ia_xs ¦ eq (x, y) end (xs, ?)
				nothing_else: ∀ x: xs ¦ ((s ∖ l_s) | agent does_not_have) ∋ x
			until
				l_s.is_empty
			loop
				if does_not_have (l_s.any) then
					check
						count_small_enough: xs.count < xs.capacity -- xs.count < # s = xs.capacity
					end
					xs.extend (l_s.any)
				end
				l_s := l_s.others
			variant
				cardinality: {STI_SET [A, EQ]}.natural_as_integer (# l_s)
			end
			check
				n_non_negative: xs.count >= 0 -- {SPECIAL}.count definition
			end
			xs := xs.aliased_resized_area (xs.count)
			check
				no_waste: xs.count = xs.capacity -- {SPECIAL}.aliased_resized_area definition
				no_repetition: ∀ x: xs ¦ occurrences (x, xs) = 1 -- xs is built by iterating on elements of `s'.
			end
			create Result.make_from_special (xs)
		end

	united alias "∪" (s: STS_SET [A, EQ]): like superset_anchor
			-- <Precursor>
		local
			l_s: STS_SET [A, EQ]
			xs: SPECIAL [A]
		do
			from
				check
					n_non_negative: elements.count + (# s).as_integer_32 >= 0 -- elements.count >= 0 and #s >= 0
				end
				xs := elements.resized_area (elements.count + (# s).as_integer_32)
				l_s := s
			invariant
				every_element_here: Current |∀ agent (ia_xs: SPECIAL [A]; x: A): BOOLEAN do Result := ∃ y: ia_xs ¦ eq (x, y) end (xs, ?)
				every_element_there: (s ∖ l_s) |∀ agent (ia_xs: SPECIAL [A]; x: A): BOOLEAN do Result := ∃ y: ia_xs ¦ eq (x, y) end (xs, ?)
				nothing_else: ∀ x: xs ¦ has (x) or (s ∖ l_s).has (x)
			until
				l_s.is_empty
			loop
				if not ∃ x: xs ¦ eq (x, l_s.any) then
					check
						count_small_enough: xs.count < xs.capacity -- xs.count < elements.count + # s = xs.capacity
					end
					xs.extend (l_s.any)
				end
				l_s := l_s.others
			variant
				cardinality: {STI_SET [A, EQ]}.natural_as_integer (# l_s)
			end
			check
				n_non_negative: xs.count >= 0 -- {SPECIAL}.count definition
			end
			xs := xs.aliased_resized_area (xs.count)
			check
				no_waste: xs.count = xs.capacity -- {SPECIAL}.aliased_resized_area definition
				no_repetition: ∀ x: xs ¦ occurrences (x, xs) = 1 -- xs.same_items (elements, 0, 0, elements.count);
				-- above: if not ∃ x: xs ¦ eq (x, l_s.any) then... prevents repetitions within xs.
			end
			create Result.make_from_special (xs)
		end

feature -- Transformation

	mapped alias "↦" (f: FUNCTION [A, A]): like set_map_anchor
			-- <Precursor>
		local
			xs: SPECIAL [A]
			y: A
		do
			create xs.make_empty (elements.count)
			⟳ x: elements ¦
				y := f (x)
				if not (∃ z: xs ¦ eq (y, z)) then
					check
						count_small_enough: xs.count < xs.capacity -- xs.count < elements.count = xs.capacity
					end
					xs.extend (y)
				end
			⟲
			xs := xs.aliased_resized_area (xs.count)
			check
				no_waste: xs.count = xs.capacity -- {SPECIAL}.aliased_resized_area definition
				no_repetition: ∀ x: xs ¦ occurrences (x, xs) = 1 -- Above: if not (∃ z: xs ¦ eq (y, z)) then... prevents repetitions within xs.
			end
			create Result.make_from_special (xs)
		end
feature -- Factory

	o: like subset_anchor
			-- <Precursor>
		do
			create Result.make_empty
		end

	empty_set: like subset_anchor
			-- <Precursor>
		do
			Result := o
		end

	singleton (a: A): like set_anchor
			-- <Precursor>
		do
			create Result.make_singleton (a)
		end

feature -- Transformer

	transformer_to_element: STI_TRANSFORMER [A, A, EQ]
			-- <Precursor>
		do
			create Result
		end

	transformer_to_boolean: STI_TRANSFORMER [A, BOOLEAN, STS_OBJECT_EQUALITY [BOOLEAN]]
			-- <Precursor>
		do
			create Result
		end

	transformer_to_natural: STI_TRANSFORMER [A, like natural_anchor, STS_OBJECT_EQUALITY [like natural_anchor]]
			-- <Precursor>
		do
			create Result
		end

feature -- Anchor

	set_anchor,
	subset_anchor,
	superset_anchor,
	set_map_anchor: MUTABLE_SET [A, EQ]
			-- <Precursor>
		do
			Result := Current
		end

feature {NONE} -- Implementation

	elements: SPECIAL [A]
			-- Container of the elements in current set
		attribute
			create Result.make_empty (0)
		end

	occurrences (x: A; xs: SPECIAL [A]): like natural_anchor
			-- How many occurrences of `x' are there in `xs'?
		do
			⟳ y: xs ¦
				if eq (x, y) then
					Result := Result + 1
				end
			⟲
		ensure
			definition: Result = special_reduction (
							xs, agent (ia_x, y: A; acc: like natural_anchor): like natural_anchor
								do
									Result := acc
									if eq (ia_x, y) then
										Result := Result + 1
									end
								end (x, ?, ?),
							0
						)
		end

	special_reduction (xs: SPECIAL [A]; f: FUNCTION [A, like natural_anchor, like natural_anchor]; rightmost: like natural_anchor): like natural_anchor
			-- `xs' reduced by `f' to a numeric, natural value
		local
			reversed_xs: READABLE_INDEXABLE_ITERATION_CURSOR [A]
		do
			reversed_xs := xs.new_cursor.reversed
			Result := rightmost
			⟳ x: reversed_xs ¦ Result := f (x, Result) ⟲
		ensure
			class
			base: xs.count = 0 ⇒ Result = rightmost
			induction: xs.count > 0 ⇒ Result = special_reduction (xs.aliased_resized_area (xs.count - 1), f, f (xs [xs.count - 1], rightmost))
		end

invariant
	no_repetition: ∀ x: elements ¦ occurrences (x, elements) = 1
	no_waste: elements.count = elements.capacity

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/Set-Theory"

end
