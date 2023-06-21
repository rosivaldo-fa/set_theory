note
	description: "Implementation of {STS_TRANSFORMER}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	TRANSFORMER [
		A, B,
--		EQ_A -> STS_EQUALITY [A] create default_create end, -- TODO: It may be unecessary.
		EQ_B -> STS_EQUALITY [B] create default_create end
		]

inherit
	STS_TRANSFORMER [A, B, --EQ_A,
	EQ_B]
		redefine
			set_reduction
		end

feature -- Access

	eq_b: EQ_B
			-- <Precursor>
		do
			create Result
		end

feature -- Transformation

	set_map (xs: STS_SET [A, STS_EQUALITY [A]]; f: FUNCTION [A, B]): like set_map_anchor
			-- <Precursor>
		local
			l_xs: STS_SET [A, STS_EQUALITY [A]]
		do
			from
				create Result.make_empty
				l_xs := xs
			invariant
				maps_everything: (xs ∖ l_xs) |∀ agent transformer.target_set_has_value(Result, f, ?)
				nothing_else: Result |∀ agent transformer.source_set_has_argument(f, xs ∖ l_xs, ?)
			until
				l_xs.is_empty
			loop
				Result := Result & f (l_xs.any)
				l_xs := l_xs.others
			variant
				cardinality: natural_as_integer (# l_xs)
			end
		ensure then
			class
		end

	set_reduction (xs: STS_SET [A, STS_EQUALITY [A]]; leftmost: B; f: FUNCTION [B, A, B]): B
			-- <Precursor>
		local
			l_xs: STS_SET [A, STS_EQUALITY [A]]
		do
			from
				Result := leftmost
				l_xs := xs
			invariant
--				building_up: eq_b (Result, tuple_left_reduction (xs.as_tuple.right_trimmed (# l_xs), leftmost, f))
					-- NOTICE: This invariant assumes that `xs'.`as_tuple' is implemented like in {STI_SET}.
			until
				l_xs.is_empty
			loop
				Result := f (Result, l_xs.any)
				l_xs := l_xs.others
			variant
				cardinality: natural_as_integer (# l_xs)
			end
		end

feature -- Conversion

	natural_as_integer (n: like natural_anchor): INTEGER_64
			-- `n' converted into an integer value
			-- TODO: DRY.
		do
			Result := n.as_integer_64
		ensure
			class
			definition: Result = n.as_integer_64
		end

feature -- Transformer

	transformer: like Current
			-- <Precursor>
		do
			create Result
		end

feature -- Anchor

	natural_anchor: NATURAL
			-- Anchor for natural numbers
			--| TODO: Pull it up to a target-dependant class.
		do
		ensure
			class
		end

	set_map_anchor: SET [B, EQ_B]
			-- <Precursor>
		do
			create Result.make_empty
		ensure then
			class
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/Set-Theory"
end
