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
--			Result := Current ≭ i.zero -- TODO: Fix it.
			Result := p ≭ p.zero
		ensure
--			definition: Result = Current ≭ zero
			definition: Result = p ≭ p.zero
		end

feature -- Comparison

	equals alias "≍" (pq: RATIONAL_NUMBER): BOOLEAN
			-- Do current rational number and `pq' have the same numerical value?
		do
				check
						-- Class invariant: q /= 0 and pq.q /= 0
					good_divisor: p.divisible (q)
					pq_good_divisor: pq.p.divisible (pq.q)
				end
			if is_integer then
				Result := pq.is_integer and div (p, q) ≍ div (pq.p, pq.q)
			else
				if not pq.is_integer then
						check
								-- (not is_integer ⇒ rem (p, q) /= 0) and (not pq.is_integer ⇒	rem (pq.p, pq.q) /= 0)
							q_divisible_p_rem_q: q.divisible (rem (p, q))
							pq_q_divisible_pq_p_rem_pq_q: pq.q.divisible (rem (pq.p, pq.q))
						end
					Result := div (p, q) ≍ div (pq.p, pq.q) and (q / rem (p, q)) ≍ (pq.q / rem (pq.p, pq.q))
				end
			end
		ensure
				-- Class invariant: q /= 0 and pq.q /= 0
			good_divisor: p.divisible (q)
			pq_good_divisor: pq.p.divisible (pq.q)

				-- (not is_integer ⇒ rem (p, q) /= 0) and (not pq.is_integer ⇒ rem (pq.p, pq.q) /= 0)
			q_divisible_p_rem_q: not is_integer ⇒ q.divisible (rem (p, q))
			pq_q_divisible_pq_p_rem_pq_q: not pq.is_integer ⇒ pq.q.divisible (rem (pq.p, pq.q))

			when_integer: is_integer ⇒ Result = (pq.is_integer and div (p, q) ≍ div (pq.p, pq.q))
			when_not_integer: not is_integer ⇒
				Result = (not pq.is_integer and then (div (p, q) ≍ div (pq.p, pq.q) and then (q / rem (p, q)) ≍ (pq.q / rem (pq.p, pq.q))))
		end

	unequals alias "≭" (pq: RATIONAL_NUMBER): BOOLEAN
			-- Does not current rational number equal `pq'?
		do
			Result := not (Current ≍ pq)
		ensure
			definition: Result = not (Current ≍ pq)
		end

	is_less alias "<" (pq: RATIONAL_NUMBER): BOOLEAN
			-- Is current rational number less than `pq`?
		do
				check
						-- Class invariant: q /= 0 and pq.q /= 0
					good_divisor: p.divisible (q)
					other_good_divisor: pq.p.divisible (pq.q)
				end
			if is_integer then
				if pq.is_integer then
					Result := div (p, q) < div (pq.p, pq.q)
				else
					Result := div (p, q) ≤ div (pq.p, pq.q)
				end
			else
				if pq.is_integer then
					Result := div (p, q) < div (pq.p, pq.q)
				else
						check
								-- (not is_integer ⇒ rem (p, q) /= 0) and (not pq.is_integer ⇒ rem (pq.p, pq.q) /= 0)
							q_divisible_p_rem_q: q.divisible (rem (p, q))
							other_p_divisible_other_p_rem_other_q: pq.q.divisible (rem (pq.p, pq.q))
						end
					Result := div (p, q) < div (pq.p, pq.q) or div (p, q) ≍ div (pq.p, pq.q) and ((pq.q / rem (pq.p, pq.q)) < (q / rem (p, q)))
				end
			end
		ensure
				-- Class invariant: q /= 0 and pq.q /= 0
			good_divisor: p.divisible (q)
			other_good_divisor: pq.p.divisible (pq.q)

				-- (not is_integer ⇒ rem (p, q) /= 0) and (not pq.is_integer ⇒ rem (pq.p, pq.q) /= 0)
			q_divisible_p_rem_q: not is_integer ⇒ q.divisible (rem (p, q))
			other_q_divisible_other_p_rem_other_q: not pq.is_integer ⇒ pq.q.divisible (rem (pq.p, pq.q))

			when_both_integer: is_integer and pq.is_integer ⇒ Result = (div (p, q) < div (pq.p, pq.q))
			when_integer_by_fractional: is_integer and not pq.is_integer ⇒
						-- ∞ = q / rem (p, q)) > pq.q / rem (pq.p, pq.q)
					Result = div (p, q) ≤ div (pq.p, pq.q)
			when_fractional_by_integer: not is_integer and pq.is_integer ⇒
						-- ratio (q, rem (p, q)) < ratio (pq.q, rem (pq.p, pq.q)) = ∞
					Result = (div (p, q) < div (pq.p, pq.q))
			when_both_fractional: not is_integer and not pq.is_integer ⇒
				Result = (div (p, q) < div (pq.p, pq.q) or div (p, q) ≍ div (pq.p, pq.q) and ((pq.q / rem (pq.p, pq.q)) < (q / rem (p, q))))
		end

	is_less_equal alias "<=" alias "≤" (pq: RATIONAL_NUMBER): BOOLEAN
			-- Is current rational number less than or equal to `pq`?
		do
			Result := Current < pq or Current ≍ pq
		ensure
			definition: Result = (Current < pq or Current ≍ pq)
		end

	is_greater alias ">" (pq: RATIONAL_NUMBER): BOOLEAN
			-- Is current rational number greater than `pq`?
		do
			Result := pq < Current
		ensure
			definition: Result = (pq < Current)
		end

feature -- Math

	gcd (i, j: INTEGER_NUMBER): like integer_anchor
			-- Greatest common divisor of `i' and `j'
		do
			if j ≍ i.zero then
				Result := converted_integer (i.abs)
			else
					check
						good_divisor: i.divisible (j) -- j /= 0
					end
				Result := gcd (j, i \\ j)
			end
		ensure
			base: j ≍ i.zero implies Result ≍ i.abs
			good_divisor: j ≭ i.zero implies i.divisible (j)
			induction: j ≭ i.zero implies Result ≍ gcd (j, i \\ j)
		end

	div (i, j: INTEGER_NUMBER): like integer_anchor
			-- The quotient `i'/`j' rounded towards negative infinity, i.e. ⌊`i'/`j'⌋.
		require
			good_divisor: i.divisible (j)
		do
			if (i \\ j) ≍ i.zero then
				Result := converted_integer (i // j)
			elseif i < i.zero then
				if j < i.zero then
					Result := converted_integer (i // j)
				else
					check
						j > i.zero -- i.divisible (j)
					end
					Result := converted_integer (i // j - i.one)
				end
			else
				check
					i > i.zero -- (i \\ j) /= 0
				end
				if j < i.zero then
					Result := converted_integer (i // j - i.one)
				else
					check
						j > i.zero -- i.divisible (j)
					end
					Result := converted_integer (i // j)
				end
			end
		ensure
			when_integer: (i \\ j) ≍ i.zero ⇒ Result ≍ (i // j)
			when_both_negative: (i \\ j) ≭ i.zero and i < i.zero and j < i.zero ⇒ Result ≍ (i // j)
			when_negative_by_positive: (i \\ j) ≭ i.zero and i < i.zero and j > i.zero ⇒ Result ≍ (i // j - i.one)
			when_positive_by_negative: (i \\ j) ≭ i.zero and i > i.zero and j < i.zero ⇒ Result ≍ (i // j - i.one)
			when_both_positive: (i \\ j) ≭ i.zero and i > i.zero and j > i.zero ⇒ Result ≍ (i // j)
		end

	rem (i, j: INTEGER_NUMBER): like integer_anchor
			-- The remainder of the quotient `i'/`j' when the latter is rounded towards negative infinity, i.e. `i' - j⋅⌊`i'/`j'⌋.
		require
			good_divisor: i.divisible (j)
		do
			if (i \\ j) ≍ i.zero then
				Result := converted_integer (i \\ j)
			elseif i < i.zero then
				if j < i.zero then
					Result := converted_integer (i \\ j)
				else
					check
						j > i.zero -- i.divisible (j)
					end
					Result := converted_integer (i \\ j + j)
				end
			else
				check
					i > i.zero -- (i \\ j) /= 0
				end
				if j < i.zero then
					Result := converted_integer (i \\ j + j)
				else
					check
						j > i.zero -- i.divisible (j)
					end
					Result := converted_integer (i \\ j)
				end
			end
		ensure
			when_integer: (i \\ j) ≍ i.zero ⇒ Result ≍ (i \\ j)
			when_both_negative: (i \\ j) ≭ i.zero and i < i.zero and j < i.zero ⇒ Result ≍ (i \\ j)
			when_negative_by_positive: (i \\ j) ≭ i.zero and i < i.zero and j > i.zero ⇒ Result ≍ (i \\ j + j)
			when_positive_by_negative: (i \\ j) ≭ i.zero and i > i.zero and j < i.zero ⇒ Result ≍ (i \\ j + j)
			when_both_positive: (i \\ j) ≭ i.zero and i > i.zero and j > i.zero ⇒ Result ≍ (i \\ j)
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
