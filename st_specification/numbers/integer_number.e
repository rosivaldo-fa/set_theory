note
	description: "Model of an integer number, i.e. a rational number whose denominator part equals one."
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	INTEGER_NUMBER

inherit
	ELEMENT
		rename
			is_in as element_is_in,
			is_not_in as element_is_not_in
		end

feature -- Primitive

	value: like native_integer_anchor
			-- Native value of current integer number
		deferred
		ensure
			adjusted: Result = adjusted_value (Result)
		end

feature -- Membership

	is_in alias "∈" (s: SET [INTEGER_NUMBER]): BOOLEAN
			-- Does `s` have current integer number?
		do
			Result := s ∋ Current
		ensure
			definition: Result = s ∋ Current
		end

	is_not_in alias "∉" (s: SET [INTEGER_NUMBER]): BOOLEAN
			-- Is not current integer number in `s'?
		do
			Result := not (Current ∈ s)
		ensure
			definition: Result = not (Current ∈ s)
		end

feature -- Access

	zero: like integer_anchor
			-- The integer number 0
		deferred
		ensure
			zero: Result.value = 0
		end

	one: like integer_anchor
			-- The integer number 1
		deferred
		ensure
			one: Result.value = 1
		end

feature -- Comparison

	equals alias "≍" (i: INTEGER_NUMBER): BOOLEAN
			-- Do current integer number and `i' have the same numeric value?
		do
			Result := value = i.value
		ensure
			definition: Result = (value = i.value)
		end

	unequals alias "≭" (i: INTEGER_NUMBER): BOOLEAN
			-- Does not current integer number equal `i'?
		do
			Result := not (Current ≍ i)
		ensure
			definition: Result = not (Current ≍ i)
		end

	is_less alias "<" (i: INTEGER_NUMBER): BOOLEAN
			-- Is current integer number less than `i'?
		do
			Result := value < i.value
		ensure
			definition: Result = (value < i.value)
		end

	is_less_equal alias "<=" alias "≤" alias "⩽" alias "≦" (i: INTEGER_NUMBER): BOOLEAN
			-- Is current integer number less than or equal to `i'?
		do
			Result := Current < i or Current ≍ i
		ensure
			definition: Result = (Current < i or Current ≍ i)
		end

	is_greater alias ">" (i: INTEGER_NUMBER): BOOLEAN
			-- Is current integer number greater than `i'?
		do
			Result := i < Current
		ensure
			definition: Result = (i < Current)
		end

	is_greater_equal alias ">=" alias "≥" alias "⩾" alias "≧" (i: INTEGER_NUMBER): BOOLEAN
			-- Is current integer number greater than or equal to `i'?
		do
			Result := i ≤ Current
		ensure
			definition: Result = (i ≤ Current)
		end

	three_way_comparison alias "⋚" (i: INTEGER_NUMBER): like integer_anchor
			-- If current integer number equal to `i', 0; if smaller, -1; if greater, 1.
		do
			if Current < i then
				Result := - one
			elseif i < Current then
				Result := one
			else
				Result := zero
			end
		ensure
			equal_zero: (Result ≍ zero) = (Current ≍ i)
			smaller_negative: (Result ≍ - one) = (Current < i)
			greater_positive: (Result ≍ one) = (Current > i)
		end

	min alias "∧" (i: INTEGER_NUMBER): like integer_anchor
			-- The smaller of current integer number and `i'
		do
			if Current ≤ i then
				Result := Current
			else
				Result := i
			end
		ensure
			current_if_not_greater: Current ≤ i ⇒ Result ≍ Current
			other_if_greater: Current > i ⇒ Result ≍ i
		end

	max alias "∨" (i: INTEGER_NUMBER): like integer_anchor
			-- The greater of current integer number and `i'
		do
			if Current ≥ i then
				Result := Current
			else
				Result := i
			end
		ensure
			current_if_not_smaller: Current ≥ i implies Result ≍ Current
			other_if_smaller: Current < i implies Result ≍ i
		end

feature -- Relationship

	divisible (i: INTEGER_NUMBER): BOOLEAN
			-- May current integer number be divided by `i`?
		do
--			Result := value.divisible (i.value) -- TODO: Segmentation violation!
			Result := i.value /= 0
		ensure
--			definition: Result = value.divisible (i.value) -- TODO: Segmentation violation!
			definition: Result = (i.value /= 0)
		end

	divides alias "|" (i: INTEGER_NUMBER): BOOLEAN
			-- Does current integer number divide `i', i.e. is there a integer number m such that `i' = m ⋅ `Current'?
		do
			Result := i.divisible (Current) and then (i \\ Current) ≍ zero
		ensure
			definition: Result = (i.divisible (Current) and then (i \\ Current) ≍ zero)
		end

feature -- Operation

	plus alias "+" (i: INTEGER_NUMBER): like integer_anchor
			-- Sum of current integer number with `i`
		deferred
		ensure
			definition: Result.value = adjusted_value (value + i.value)
		end

	identity alias "+": like Current
			-- Unary plus; current integer number itself.
		do
			Result := Current
		ensure
			definition: Result ≍ Current
		end

	minus alias "-" alias "−" (i: INTEGER_NUMBER): like integer_anchor
			-- Result of subtracting `i` from current integer number
		deferred
		ensure
			definition: Result.value = adjusted_value (value - i.value)
		end

	opposite alias "-" alias "−": like integer_anchor
			-- Opposite value of current number relative to `+' operation, i.e. `Current' + (- `Current') = 0.
			--| Notice that this feature is not inherited. If `Current' is represented by a two's-complement integer and and its value is the minimum possible
			--| value in such a representation, `opposite' may yield an unexpected value, most possibly the same (still negative) value, departing from
			--| `real_opposite' result.
		deferred
		ensure
			definition: Result.value = adjusted_value (- value)
		end

	product alias "*" alias "×" alias "⋅" (i: INTEGER_NUMBER): like integer_anchor
			-- Current integer number multiplied by `i`
		deferred
		ensure
			definition: Result.value = adjusted_value (value * i.value)
		end

	integer_quotient alias "//" (i: INTEGER_NUMBER): like integer_anchor
			-- Division of current integer number by `i`
		require
			good_divisor: divisible (i)
		deferred
		ensure
--			good_divisor: value.divisible (i.value) -- i.value /= 0 ⇐ divisible (i) -- TODO: Segmentation violation.
			good_divisor: i.value /= 0
			definition: Result.value = adjusted_value (value // i.value)
		end

	integer_remainder alias "\\" (i: INTEGER_NUMBER): like integer_anchor
			-- Remainder of the integer division of `Current' by `i`
		require
			good_divisor: divisible (i)
		deferred
		ensure
--			good_divisor: value.divisible (i.value) -- i.value /= 0 ⇐ divisible (i) -- TODO: Segmentation violation.
			good_divisor: i.value /= 0
			definition: Result.value = adjusted_value (value \\ i.value)
		end

feature -- Implementation

	adjusted_value (v: like value): like value
			-- `v' adjusted to represent the `value' of current integer number
		deferred
		ensure
			stable: adjusted_value (Result) = Result
		end

feature -- Anchor

	integer_anchor: INTEGER_NUMBER
			-- Anchor for integer numbers
		deferred
		end

	native_integer_anchor: INTEGER
			-- Anchor for the native representation of the value of current integer number
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
