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
	REAL_NUMBER
		rename
			is_in as real_number_is_in,
			is_not_in as real_is_not_in,
			is_invertible as real_is_invertible,
			equals as real_equals,
			unequals as real_unequals,
			is_less as real_is_less,
			is_less_equal as real_is_less_equal,
			is_greater as real_is_greater,
			three_way_comparison as real_three_way_comparison,
			divisible as real_divisible,
			quotient as real_quotient
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

--	sign: like integer_anchor
--			-- Sign of current number as an integer value (0, -1 or 1)
--		do
--			Result := Current ⋚ zero
--		ensure
--			three_way: Result ≍ (Current ⋚ zero)
--		end

	zero: like rational_anchor
			-- The rational number 0/1
		deferred
		end

	one: like rational_anchor
			-- The rational number 1/1
		deferred
		end

feature -- Quality

	is_integer: BOOLEAN
			-- Does current rational number represent an integer number?
			-- Notice that, due to rounding and truncation, implementation of `real_is_integer' might give True even if `is_integer' gives False.
		do
			Result := q | p
		ensure
			definition: Result = q | p
		end

	is_natural: BOOLEAN
			-- Does current rational number represent a natural number?
		do
			Result := is_integer and zero ≤ Current
		ensure
			definition: Result = (is_integer and zero ≤ Current)
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
				pq_good_divisor: pq.p.divisible (pq.q)
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
						pq_p_divisible_pq_p_rem_pq_q: pq.q.divisible (rem (pq.p, pq.q))
					end
					Result := div (p, q) < div (pq.p, pq.q) or div (p, q) ≍ div (pq.p, pq.q) and ((pq.q / rem (pq.p, pq.q)) < (q / rem (p, q)))
				end
			end
		ensure
				-- Class invariant: q /= 0 and pq.q /= 0
			good_divisor: p.divisible (q)
			pq_good_divisor: pq.p.divisible (pq.q)

				-- (not is_integer ⇒ rem (p, q) /= 0) and (not pq.is_integer ⇒ rem (pq.p, pq.q) /= 0)
			q_divisible_p_rem_q: not is_integer ⇒ q.divisible (rem (p, q))
			pq_q_divisible_pq_p_rem_pq_q: not pq.is_integer ⇒ pq.q.divisible (rem (pq.p, pq.q))

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

	is_greater_equal alias ">=" alias "≥" (pq: RATIONAL_NUMBER): BOOLEAN
			-- Is current rational number greater than or equal to `pq'?
		do
			Result := pq ≤ Current
		ensure
			definition: Result = (pq ≤ Current)
		end

	three_way_comparison alias "⋚" (pq: RATIONAL_NUMBER): like integer_anchor
			-- If current rational number equal to `pq`, 0; if smaller, -1; if greater, 1.
		do
			if Current < pq then
				Result := - p.one
			elseif Current ≍ pq then
				Result := p.zero
			else
				Result := p.one
			end
		ensure
			equal_zero: (Result ≍ p.zero) = (Current ≍ pq)
			smaller_negative: (Result ≍ - p.one) = (Current < pq)
			greater_positive: (Result ≍ p.one) = (Current > pq)
		end

	min alias "∧" (pq: RATIONAL_NUMBER): like rational_anchor
			-- The smaller of current rational number and `pq`
		do
			if Current ≤ pq then
				Result := Current
			else
				Result := pq
			end
		ensure
			current_if_not_greater: Current ≤ pq ⇒ Result ≍ Current
			pq_if_greater: pq < Current ⇒ Result ≍ pq
		end

	max alias "∨" (pq: RATIONAL_NUMBER): like rational_anchor
			-- The greater of current rational number and `pq'
		do
			if Current ≥ pq then
				Result := Current
			else
				Result := pq
			end
		ensure
			current_if_not_smaller: Current ≥ pq ⇒ Result ≍ Current
			pq_if_smaller: Current < pq ⇒ Result ≍ pq
		end

feature -- Relationship

	multipliable (pq: RATIONAL_NUMBER): BOOLEAN
			-- May current rational number be multiplied by `pq`?
			--| As explained at `product' header, an occasional overflow when multiplying denominators (both unequal to `zero' by definition) may produce an
			--| unexpected product equal to `zero'. Hence the need for this predicate.
		local
			l_gcd_1, l_gcd_2: like gcd
		do
			l_gcd_1 := gcd (pq.p, q)
			l_gcd_2 := gcd (p, pq.q)
			check
				good_divisor_1: q.divisible (l_gcd_1) -- l_gcd_1 /= 0 ⇐ q /= 0
				good_divisor_2: pq.q.divisible (l_gcd_2) -- l_gcd_2 /= 0 ⇐ pq.q /= 0
			end
			Result := not integer_product_overflows (q // l_gcd_1, pq.q // l_gcd_2)
		ensure
				-- TODO: Debugger gets scrambled!
--			gcd_1: attached {like integer_anchor} gcd (pq.p, q) as gcd_1
--			gcd_2: attached {like integer_anchor} gcd (p, pq.q) as gcd_2
			gcd_1: attached {INTEGER_NUMBER} gcd (pq.p, q) as gcd_1
			gcd_2: attached {INTEGER_NUMBER} gcd (p, pq.q) as gcd_2
			good_divisor_1: q.divisible (gcd_1) -- gcd_1 /= 0 ⇐ q /= 0
			good_divisor_2: pq.q.divisible (gcd_2) -- gcd_2 /= 0 ⇐ pq.q /= 0
			good_factors: not integer_product_overflows (q // gcd_1, pq.q // gcd_2) ⇒ Result -- Otherwise we might get a denominator unexpectedly equal to zero.
		end

	divisible (pq: RATIONAL_NUMBER): BOOLEAN
			-- May current rational number be divided by `pq`?
		do
			Result := pq.is_invertible and then multipliable (pq.inverse)
		ensure
			definition: Result = (pq.is_invertible and then multipliable (pq.inverse))
		end

feature -- Operation

	modulus,
	abs: like rational_anchor
			-- Distance from current rational number to the origin of the real number line
		do
			if Current < zero then
				Result := - Current
			else
				Result := Current
			end
		ensure then
			when_negative: Current < zero ⇒ Result ≍ (- Current)
			when_non_negative: Current ≥ zero ⇒ Result ≍ Current
		end

	plus alias "+" (pq: RATIONAL_NUMBER): like rational_anchor
			-- Sum of current rational number with `pq`
		local
			l_gcd, pq_q_by_gcd: INTEGER_NUMBER
		do
			l_gcd := gcd (q, pq.q)
			check
				non_zero_gcd: l_gcd ≭ zero.p -- q /= 0 and pq.q /= 0
			end
			pq_q_by_gcd := pq.q // l_gcd
			check
				good_divisor: (p * pq_q_by_gcd + pq.p * (q // l_gcd)).divisible (q * pq_q_by_gcd) -- (pq.q // l_gcd) /= 0
			end
			Result := (p * pq_q_by_gcd + pq.p * (q // l_gcd)) / (q * pq_q_by_gcd)
		ensure
				-- a/b + c/d = (ad+cb)/bd = ((ad+cb)/g)/(bd/g) = (ad/g+cb/g)/(bd/g) = (a(d/g)+c(b/g))/(b(d/g)), where g = gcd (b, d)
			el_gcd: attached gcd (q, pq.q) as el_gcd
			non_zero_gcd: el_gcd ≭ zero.p -- q /= 0 and pq.q /= 0
			good_divisor: (p * (pq.q // el_gcd) + pq.p * (q // el_gcd)).divisible (q * (pq.q // el_gcd)) -- (pq.q // el_gcd) /= 0
			el_ratio: attached ((p * (pq.q // el_gcd) + pq.p * (q // el_gcd)) / (q * (pq.q // el_gcd))) as el_ratio

			numerator: Result.p ≍ el_ratio.p
			denominator: Result.q ≍ el_ratio.q
		end

	minus alias "-" alias "−" (pq: RATIONAL_NUMBER): like rational_anchor
			-- Result of subtracting `pq` from current rational number
		local
			l_gcd, pq_q_by_gcd: INTEGER_NUMBER
		do
			l_gcd := gcd (q, pq.q)
			check
				non_zero_gcd: l_gcd ≭ zero.p -- q /= 0 and pq.q /= 0
			end
			pq_q_by_gcd := pq.q // l_gcd
			check
				good_divisor: (p * pq_q_by_gcd - pq.p * (q // l_gcd)).divisible (q * pq_q_by_gcd) -- (pq.q // l_gcd) /= 0
			end
			Result := (p * pq_q_by_gcd - pq.p * (q // l_gcd)) / (q * pq_q_by_gcd)
		ensure
				-- Please have a look at `plus' definition.
			el_gcd: attached gcd (q, pq.q) as el_gcd
			non_zero_gcd: el_gcd ≭ zero.p -- q /= 0 and pq.q /= 0
			good_divisor: (p * (pq.q // el_gcd) - pq.p * (q // el_gcd)).divisible (q * (pq.q // el_gcd)) -- (pq.q // el_gcd) /= 0
			el_ratio: attached ((p * (pq.q // el_gcd) - pq.p * (q // el_gcd)) / (q * (pq.q // el_gcd))) as el_ratio

			numerator: Result.p ≍ el_ratio.p
			denominator: Result.q ≍ el_ratio.q
		end

	opposite alias "-" alias "−": like rational_anchor
			-- Opposite value of current number relative to addition, i.e. `Current' + (- `Current') = 0.
			--| It departs from {REAL_NUMBER}.opposite in order to allow the latter to produce "negative" zeros without obliging current class to do the same.
			-- TODO: properties, tests
		deferred
		ensure
			sign: Result.sign ≍ - sign
			abs_value: Result.abs ≍ abs
		end

	product alias "*" alias "×" alias "⋅" (pq: RATIONAL_NUMBER): like rational_anchor
			-- Current rational number multiplied by `pq`
			--| NOTICE: There is a precondition! If the implementation of {INTEGER_NUMBER}.product produces overflows, we may get a denominator unexpectedly
			--| equal to `zero'. Since we can't assume that a particular overflow will consistently produce a value unequal to `zero', we better to avoid
			--| overflows altogether.
			--| Notice also that an occasional overflow on calculating the numerator, even if it yields a zero, does not produce an invalid rational number.
		require
			good_factor: multipliable (pq)
		local
			l_gcd_1, l_gcd_2: like gcd
		do
			l_gcd_1 := gcd (p, pq.q)
			l_gcd_2 := gcd (pq.p, q)
			check
				non_zero_gcd_1: l_gcd_1 ≭ zero.p -- pq.q /= 0
				non_zero_gcd_2: l_gcd_2 ≭ zero.p -- q /= 0
				good_divisor: ((p // l_gcd_1) * (pq.p // l_gcd_2)).divisible ((q // l_gcd_2) * (pq.q // l_gcd_1)) -- q /= 0 and pq.q /= 0
			end
			Result := ((p // l_gcd_1) * (pq.p // l_gcd_2)) / ((q // l_gcd_2) * (pq.q // l_gcd_1))
		ensure
			gcd_1: attached gcd (p, pq.q) as gcd_1
			gcd_2: attached gcd (pq.p, q) as gcd_2
			non_zero_gcd_1: gcd_1 ≭ zero.p -- pq.q /= 0
			non_zero_gcd_2: gcd_2 ≭ zero.p -- q /= 0
			good_divisor: ((p // gcd_1) * (pq.p // gcd_2)).divisible ((q // gcd_2) * (pq.q // gcd_1)) -- q /= 0 and pq.q /= 0
			el_ratio: attached (((p // gcd_1) * (pq.p // gcd_2)) / ((q // gcd_2) * (pq.q // gcd_1))) as el_ratio

			numerator: Result.p ≍ el_ratio.p
			denominator: Result.q ≍ el_ratio.q
		end

	quotient alias "/" alias "÷" (pq: RATIONAL_NUMBER): like rational_anchor
			-- Division of current rational number by `pq`
		require
			good_divisor: divisible (pq)
		do
			check
				good_factor: multipliable (pq.inverse) -- divisible (pq)
			end
			Result := Current ⋅ pq.inverse
		ensure
			good_factor: multipliable (pq.inverse) -- divisible (pq)
			numerator: Result.p ≍ (Current ⋅ pq.inverse).p
			denominator: Result.q ≍ (Current ⋅ pq.inverse).q
		end

	reciprocal,
	inverse: like rational_anchor
			-- Reciprocal (AKA inverse) value of current rational number relative to multiplication, i.e. `Current' ⋅ `reciprocal' = `Current' ⋅ `inverse' = 1.
		require
			is_invertible: is_invertible
		do
			check
				good_divisor: q.divisible (p) -- p /= 0 ⇐ is_invertible
			end
			Result := q / p
		ensure
			good_divisor: q.divisible (p) -- p /= 0 ⇐ is_invertible
			numerator: Result.p ≍ (q / p).p
			denominator: Result.q ≍ (q / p).q
		end

feature -- Conversion

	to_integer_number: like integer_anchor
			-- Current rational number converted to an integer number
		require
			is_integer: is_integer
		do
			check
				good_divisor: p.divisible (q) -- Class invariant
			end
			Result := p // q
		ensure
			definition: Result ≍ (p // q)
		end

	to_natural_number: like natural_anchor
			-- Current rational number converted to a natural number
		require
			is_natural: is_natural
		do
			check
				good_divisor: p.divisible (q) -- Class invariant
				p_over_q_is_natural: is_natural -- Current.is_natural
			end
			Result := (p // q).to_natural_number
		ensure
			definition: Result ≍ (p // q).to_natural_number
		end

feature -- Factory

	converted_integer (i: INTEGER_NUMBER): like integer_anchor
			-- `i' converted to a integer number like `integer_anchor'
		do
			Result := i
		ensure
			definition: Result.value = integer_anchor.adjusted_value (i.value)
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

feature -- Predicate

	integer_product_overflows (i, j: INTEGER_NUMBER): BOOLEAN
			-- Does the product `i' ⋅ `j' overflow?
		do
			Result := i < i.zero and j < i.zero and i.max_value_exists and then i < i.max_value // j or
				i < i.zero and j > i.zero and i.min_value_exists and then i < i.min_value // j or
				i > i.zero and j < - i.one and i.min_value_exists and then i > i.min_value // j or
				i > i.zero and j > i.zero and i.max_value_exists and then i > i.max_value // j
		ensure
			definition: Result = (
						i < i.zero and j < i.zero and i.max_value_exists and then i < i.max_value // j or
						i < i.zero and j > i.zero and i.min_value_exists and then i < i.min_value // j or
						i > i.zero and j < - i.one and i.min_value_exists and then -- TODO: It assumes a two's-complement implementation, where
						i > i.min_value // j or -- i.min_value // - 1 overflows.
						i > i.zero and j > i.zero and i.max_value_exists and then i > i.max_value // j
					)
		end

feature -- Anchor

	rational_anchor: RATIONAL_NUMBER
			-- Anchor for rational numbers
		deferred
		end

	integer_anchor: INTEGER_NUMBER
			-- Anchor for integer numbers
		deferred
		end

	natural_anchor: NATURAL_NUMBER
			-- Anchor for natural numbers
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
