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
			set_anchor,
			subset_anchor,
			superset_anchor
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
--			others: others ≍ s
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
--				not_found_yet: (Current ∖ s) |∄ agent equality_holds (a, ?)
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
--				building_up: Result ≍ (Current ∖ s)
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
--							is_disjoint: s.is_disjoint (Result) -- Result ≍ ((Current ∖ s) / a)
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
--			others: Result.others ≍ Current
		end

	batch_extended (s: STS_SET [A, EQ]): like superset_anchor
			-- Current set extended with every element in `s'
		require
--			is_disjoint: is_disjoint (s)
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
--				counting_up: Result = transformer_to_natural.set_reduction (Current ∖ s, 0, agent cumulative_successor)
			until
				s.is_empty
			loop
				Result := Result + 1
				s := s.others
			variant
				cardinality: natural_as_integer (# s)
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
--						is_disjoint: o.is_disjoint (s) -- o.is_empty
				end
				Result := o.batch_extended (s)
			end
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
