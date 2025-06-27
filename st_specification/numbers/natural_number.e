note
	description: "Model of a natural number, i.e. a non-negative integer number."
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NATURAL_NUMBER

inherit
	ELEMENT
		rename
			is_in as element_is_in,
			is_not_in as element_is_not_in
		end

feature -- Primitive

	value: like native_natural_anchor
			-- Native value of current natural number
		deferred
		ensure
			adjusted: Result = adjusted_value (Result)
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
		ensure
			zero: Result.value = 0
		end

	one: like natural_anchor
			-- The natural number 1
		deferred
		ensure
			one: Result.value = 1
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
