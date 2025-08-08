note
	description: "Model of a natural number, i.e. a non-negative integer number."
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NATURAL_NUMBER

inherit
	INTEGER_NUMBER
		rename
			value as integer_value,
			is_in as integer_is_in,
			is_not_in as integer_is_not_in,
			equals as integer_equals,
			unequals as integer_unequals,
			is_less as integer_is_less,
			is_less_equal as integer_is_less_equal,
			is_greater as integer_is_greater,
			is_greater_equal as integer_is_greater_equal,
			three_way_comparison as integer_three_way_comparison,
			min as integer_min,
			max as integer_max,
			divisible as integer_divisible,
			divides as integer_divides,
			modulus as identity alias "+",
			abs as identity alias "+",
			plus as integer_plus,
			minus as integer_minus,
			product as integer_product,
			integer_quotient as integer_quotient,
			integer_remainder as integer_remainder,
			adjusted_value as integer_adjusted_value
		end

feature -- Primitive

	value: like native_natural_anchor
			-- Native value of current natural number
		deferred
		ensure
			adjusted: Result = adjusted_value (Result)
			consistent: Result.as_integer_32 = integer_value
		end

feature -- Membership

	is_in alias "∈" (s: SET [NATURAL_NUMBER]): BOOLEAN
			-- Does `s` have current natural number?
		do
			Result := s ∋ Current
		ensure
			definition: Result = s ∋ Current
		end

	is_not_in alias "∉" (s: SET [NATURAL_NUMBER]): BOOLEAN
			-- Is not current natural number in `s'?
		do
			Result := not (Current ∈ s)
		ensure
			definition: Result = not (Current ∈ s)
		end

feature -- Access

	zero: like natural_anchor
			-- The natural number 0
		deferred
--		ensure
--			zero: Result.value = 0
		end

	one: like natural_anchor
			-- The natural number 1
		deferred
--		ensure
--			one: Result.value = 1
		end

feature -- Comparison

	equals alias "≍" (n: NATURAL_NUMBER): BOOLEAN
			-- Do current natural number and `n' have the same numeric value?
		do
			Result := value = n.value
		ensure
			definition: Result = (value = n.value)
		end

	unequals alias "≭" (n: NATURAL_NUMBER): BOOLEAN
			-- Does not current natural number equal `n'?
		do
			Result := not (Current ≍ n)
		ensure
			definition: Result = not (Current ≍ n)
		end

	is_less alias "<" (n: NATURAL_NUMBER): BOOLEAN
			-- Is current natural number less than `n'?
		do
			Result := value < n.value
		ensure
			definition: Result = (value < n.value)
		end

	is_less_equal alias "<=" alias "≤" alias "⩽" alias "≦" (n: NATURAL_NUMBER): BOOLEAN
			-- Is current natural number less than or equal to `n'?
		do
			Result := Current < n or Current ≍ n
		ensure
			definition: Result = (Current < n or Current ≍ n)
		end

	is_greater alias ">" (n: NATURAL_NUMBER): BOOLEAN
			-- Is current natural number greater than `n'?
		do
			Result := n < Current
		ensure
			definition: Result = (n < Current)
		end

	is_greater_equal alias ">=" alias "≥" alias "⩾" alias "≧" (n: NATURAL_NUMBER): BOOLEAN
			-- Is current natural number greater than or equal to `n'?
		do
			Result := n ≤ Current
		ensure
			definition: Result = (n ≤ Current)
		end

	three_way_comparison alias "⋚" (n: NATURAL_NUMBER): like integer_anchor
			-- If current natural number equal to `n', 0; if smaller, -1; if greater, 1.
		do
			if Current < n then
				Result := - one
			elseif n < Current then
				Result := one
			else
				Result := zero
			end
		ensure
			equal_zero: (Result ≍ zero) = (Current ≍ n)
			smaller_negative: (Result ≍ - one) = (Current < n)
			greater_positive: (Result ≍ one) = (Current > n)
		end

	min alias "∧" (n: NATURAL_NUMBER): like natural_anchor
			-- The smaller of current natural number and `n'
		do
			if Current ≤ n then
				Result := Current
			else
				Result := n
			end
		ensure
			current_if_not_greater: Current ≤ n ⇒ Result ≍ Current
			other_if_greater: Current > n ⇒ Result ≍ n
		end

	max alias "∨" (n: NATURAL_NUMBER): like natural_anchor
			-- The greater of current natural number and `n'
		do
			if Current ≥ n then
				Result := Current
			else
				Result := n
			end
		ensure
			current_if_not_smaller: Current ≥ n implies Result ≍ Current
			other_if_smaller: Current < n implies Result ≍ n
		end

feature -- Relationship

	divisible (n: NATURAL_NUMBER): BOOLEAN
			-- May current natural number be divided by `n`?
		do
--			Result := value.divisible (n.value) -- TODO: Segmentation violation!
			Result := n.value /= 0
		ensure
--			definition: Result = value.divisible (n.value) -- TODO: Segmentation violation!
			definition: Result = (n.value /= 0)
		end

	divides alias "|" (n: NATURAL_NUMBER): BOOLEAN
			-- Does current natural number divide `n', i.e. is there a natural number m such that `n' = m ⋅ `Current'?
		do
			Result := n.divisible (Current) and then (n \\ Current) ≍ zero
		ensure
			definition: Result = (n.divisible (Current) and then (n \\ Current) ≍ zero)
		end

feature -- Operation

	plus alias "+" (n: NATURAL_NUMBER): like natural_anchor
			-- Sum of current natural number with `n`
		deferred
		ensure
			definition: Result.value = adjusted_value (value + n.value)
		end

--	identity alias "+": like Current
--			-- Unary plus; current natural number itself.
--		do
--			Result := Current
--		ensure
--			definition: Result ≍ Current
--		end

	minus alias "-" alias "−" (n: NATURAL_NUMBER): like natural_anchor
			-- Result of subtracting `n` from current natural number
		require
			small_enough: n ≤ Current
		deferred
		ensure
			definition: Result.value = adjusted_value (value - n.value)
		end

	product alias "*" alias "×" alias "⋅" (n: NATURAL_NUMBER): like natural_anchor
			-- Current natural number multiplied by `n`
		deferred
		ensure
			definition: Result.value = adjusted_value (value * n.value)
		end

	natural_quotient alias "//" (n: NATURAL_NUMBER): like natural_anchor
			-- Division of current natural number by `n`
		require
			good_divisor: divisible (n)
		deferred
		ensure
--			good_divisor: value.divisible (n.value) -- n.value /= 0 ⇐ divisible (n) -- TODO: Segmentation violation.
			good_divisor: n.value /= 0
			definition: Result.value = adjusted_value (value // n.value)
		end

	natural_remainder alias "\\" (n: NATURAL_NUMBER): like natural_anchor
			-- Remainder of the natural division of `Current' by `n`
		require
			good_divisor: divisible (n)
		deferred
		ensure
--			good_divisor: value.divisible (n.value) -- n.value /= 0 ⇐ divisible (n) -- TODO: Segmentation violation.
			good_divisor: n.value /= 0
			definition: Result.value = adjusted_value (value \\ n.value)
		end

feature -- Implementation

	adjusted_value (v: like value): like value
			-- `v' adjusted to represent the `value' of current natural number
		deferred
		ensure
			stable: adjusted_value (Result) = Result
		end

feature -- Anchor

	natural_anchor: NATURAL_NUMBER
			-- Anchor for natural numbers
		deferred
		end

	native_natural_anchor: NATURAL
			-- Anchor for the native representation of the value of current natural number
			--| TODO: Make it target dependant.
		deferred
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
