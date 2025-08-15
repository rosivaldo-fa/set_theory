note
	description: "[
					Real number in the form p/q, where p and q are integer numbers and q /= 0.
			
					This specification does not try to offer a high-grade numeric class. Its intent is just to introduce examples of how several numeric types
					and sets may receive a set-theoretic treatment.
					
					Notice that this specification also does not impose a canonical representation, e.g. gcd (p, q) = 1 or q > 0. Hence the implementation is
					free to impose, or not, such restrictions or whatever more is deemed necessary.
					
					I'm glad to thank the guys at Boost.org, whose Rational library (https://www.boost.org/doc/libs/1_77_0/libs/rational/) provided me with
					great insights about rational number comparison.
		]"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	RATIONAL_NUMBER

inherit
	ELEMENT
		rename
			is_in as element_is_in,
			is_not_in as element_is_not_in
		end

feature -- Primitive

	p,
	numerator: like integer_anchor
			-- Numerator of current rational number
		deferred
		end

	q,
	denominator: like integer_anchor
			-- Denominator of current rational number
		deferred
		end

feature -- Membership

	is_in alias "∈" (s: SET [RATIONAL_NUMBER]): BOOLEAN
			-- Does `s` have current rational number?
		do
			Result := s ∋ Current
		ensure
			definition: Result = s ∋ Current
		end

	is_not_in alias "∉" (s: SET [RATIONAL_NUMBER]): BOOLEAN
			-- Is not current rational number in `s'?
		do
			Result := not (Current ∈ s)
		ensure
			definition: Result = not (Current ∈ s)
		end

feature -- Access

	zero: like rational_anchor
			-- The rational number 0/1
		deferred
		ensure
			numerator: Result.p ≍ Result.p.zero
		end

	one: like rational_anchor
			-- The rational number 1/1
		deferred
		ensure
			definition: Result.p ≍ Result.q
		end

feature -- Quality

	is_integer: BOOLEAN
			-- Does current rational number represent an integer number?
			-- Notice that, due to rounding and truncation, implementation of `real_is_integer' might give True even if `is_integer' gives False.
		do
				check
					good_divisor: p.divisible (q) -- Class invariant: q /= 0
				end
			Result := (p \\ q) ≍ p.zero
		ensure
			good_divisor: p.divisible (q) -- Class invariant: q /= 0
			definition: Result = (p \\ q) ≍ p.zero
		end

	is_invertible: BOOLEAN
			-- Does current rational number have a multiplicative inverse (AKA reciprocal)?
		do
--			Result := Current ≭ zero.p -- TODO: Fix it.
			Result := p ≭ p.zero
		ensure
--			definition: Result = Current ≭ zero
			definition: Result = p ≭ p.zero
		end

feature -- Math

	div (i, j: INTEGER_NUMBER): like integer_anchor
			-- The quotient `i'/`j' rounded towards negative infinity, i.e.
			-- ⌊`i'/`j'⌋.
		require
			good_divisor: i.divisible (j)
		do
			if (i \\ j) ≍ zero.p then
				Result := converted_integer (i // j)
			elseif i < zero.p then
				if j < zero.p then
					Result := converted_integer (i // j)
				else
						check
							j > zero.p -- i.divisible (j)
						end
					Result := converted_integer (i // j - one.p)
				end
			else
					check
						i > zero.p -- (i \\ j) /= 0
					end
				if j < zero.p then
					Result := converted_integer (i // j - one.p)
				else
						check
							j > zero.p -- i.divisible (j)
						end
					Result := converted_integer (i // j)
				end
			end
		ensure
			when_integer: (i \\ j) ≍ zero.p implies Result ≍ (i // j)
			when_both_negative:
				(i \\ j) ≭ zero.p and i < zero.p and j < zero.p implies
				Result ≍ (i // j)
			when_negative_by_positive:
				(i \\ j) ≭ zero.p and i < zero.p and j > zero.p implies
				Result ≍ (i // j - one.p)
			when_positive_by_negative:
				(i \\ j) ≭ zero.p and i > zero.p and j < zero.p implies
				Result ≍ (i // j - one.p)
			when_both_positive:
				(i \\ j) ≭ zero.p and i > zero.p and j > zero.p implies
				Result ≍ (i // j)
		end

feature -- Factory

	converted_integer (i: INTEGER_NUMBER): like integer_anchor
			-- `i' converted to a integer number like `integer_anchor'
		do
			Result := i
		ensure
			definition: Result.value = integer_anchor.adjusted_value (i.value)
		end

feature -- Anchor

	integer_anchor: INTEGER_NUMBER
			-- Anchor for integer numbers
		deferred
		end

	rational_anchor: RATIONAL_NUMBER
			-- Anchor for rational numbers
		deferred
		end

invariant
	numerator: numerator ≍ p
	denominator: denominator ≍ q
	non_zero_denominator: q ≭ q.zero

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
