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
		require
			no_waste: xs.count = xs.capacity
			no_repetition: ∀ x: xs ¦ occurrences (x, xs) = 1
		do
			elements := xs
		ensure
			implementation: elements = xs
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
			if is_empty then
				Result := Current
			else
				check
					non_negative_argument: elements.count - 1 >= 0 -- not is_empty
				end
				create xs.make_empty (elements.count - 1)
				check
					destination_index_in_bound: 0 <= xs.count -- {SPECIAL}.count definition
					n_non_negative: elements.count - 1 >= 0 -- elements.count ≥ 1 ⇐ not is_empty
					n_is_small_enough_for_source: 1 + elements.count - 1 <= elements.count -- By definition
					n_is_small_enough_for_destination: 0 + elements.count - 1 <= xs.capacity -- xs.capacity = elements.count - 1
					same_type: elements.conforms_to (xs) -- By definition?
				end
				xs.copy_data (elements, 1, 0, elements.count - 1)
				check
					no_waste: xs.count = xs.capacity -- create xs.make_empty (elements.count - 1); xs.copy_data (elements, 1, 0, elements.count - 1)
					no_repetition: ∀ x: xs ¦ occurrences (x, xs) = 1 -- xs.same_items (elements, 1, 0 elements.count - 1)
				end
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
					n_non_negative: elements.count + 1 >= 0 -- elements.count ≥ 0 ⇐ {SPECIAL}.count definition
				end
				xs := elements.resized_area (elements.count + 1)
				check
					count_small_enough: xs.count < xs.capacity -- xs.capacity = xs.count + 1 = elements.count + 1
				end
				xs.extend (a)
				check
					no_waste: xs.count = xs.capacity -- xs := elements.resized_area (elements.count + 1); xs.extend (a)
					no_repetition: ∀ x: xs ¦ occurrences (x, xs) = 1 -- ∀ x: elements ¦ occurrences (x, elements) = 1 and not eq (x, a)
				end
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
				create xs.make_empty (elements.count)
				i := 0
			invariant
				xs.count = i
				building_up: ∀ j: 0 |..| (i - 1) ¦ (xs.valid_index (j) and elements.valid_index (j)) and then eq (xs [j], elements [j])
			until
				i = elements.count or else eq (elements [i], a)
			loop
					check
						valid_index: elements.valid_index (i) -- 0 ≤ i < elements.count
						count_small_enough: xs.count < xs.capacity -- xs.count = i < elements.count = xs.capacity
					end
				xs.extend (elements [i])
				i := i + 1
			variant
				elements.count - i
			end
			if i = elements.count then
				Result := Current
			else
				check
					source_index_non_negative: i + 1 >= 0 -- 0 ≤ i < elements.count
					destination_index_non_negative: i >= 0 -- 0 ≤ i < elements.count
					destination_index_in_bound: i <= xs.count -- xs.count = i
					n_non_negative: elements.count - (i + 1) >= 0 -- 0 ≤ i < elements.count
					n_is_small_enough_for_source: i + 1 + elements.count - (i + 1) <= elements.count -- Algebra
					n_is_small_enough_for_destination: i + elements.count - (i + 1) <= xs.capacity -- xs.capacity = elements.count - 1
					same_type: elements.conforms_to (xs) -- By definition?
				end
				xs.copy_data (elements, i + 1, i, elements.count - (i + 1))
				check
					n_non_negative: xs.count >= 0 -- {SPECIAL}.count definition
				end
				xs := xs.aliased_resized_area (xs.count)
				check
					no_waste: xs.count = xs.capacity -- {SPECIAL}.aliased_resized_area definition
					no_repetition: ∀ x: xs ¦ occurrences (x, xs) = 1 -- xs.count = elements.count - 1 and ∀ x: elements ¦ eq (x, a) xor ∃ y: xs ¦ eq (x, y)
				end
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
		do
			create xs.make_empty (elements.count)
			⟳ x: elements ¦
				if p (x) then
					check
						count_small_enough: xs.count < xs.capacity -- xs.count <= elements.count = xs.capacity
					end
					xs.extend (x)
				end
			⟲
			check
				n_non_negative: xs.count >= 0 -- {SPECIAL}.count definition
			end
			xs := xs.aliased_resized_area (xs.count)
			check
				no_waste: xs.count = xs.capacity -- {SPECIAL}.aliased_resized_area definition
				no_repetition: ∀ x: xs ¦ occurrences (x, xs) = 1 -- xs is built by iterating on elements of `Current'.
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


note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/Set-Theory"

end
