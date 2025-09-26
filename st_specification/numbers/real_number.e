note
	description: "[
					Model of a real number, i.e. a complex number whose imaginary part is zero.
			
					A finite representation, IEEE 754-like, is assumed, although with some minor changes it would allow even an implementation with real numbers
					of arbitrary precision. Anyway, this specification does not try to offer a high-grade numeric class. Its intent is just to introduce examples
					of how several numeric types and sets may receive a set-theoretic treatment.
			
					It is Noteworthy that this specification does not inherit from {NUMERIC} or {COMPARABLE}, since those classes use covariant arguments, which
					this library avoids as much as possible.
		]"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	REAL_NUMBER

inherit
	ELEMENT
		rename
			is_in as element_is_in,
			is_not_in as element_is_not_in
		end

feature -- Primitive

	value: like native_real_anchor
			-- Native value of current real number
		deferred
		ensure
			adjusted: Result = adjusted_value (Result)
		end

feature -- Membership

	is_in alias "∈" (s: SET [REAL_NUMBER]): BOOLEAN
			-- Does `s` have current real number?
		do
			Result := s ∋ Current
		ensure
			definition: Result = s ∋ Current
		end

	is_not_in alias "∉" (s: SET [REAL_NUMBER]): BOOLEAN
			-- Is not current real number in `s'?
		do
			Result := not (Current ∈ s)
		ensure
			definition: Result = not (Current ∈ s)
		end

feature -- Implementation

	adjusted_value (v: like value): like value
			-- `v' adjusted to represent the `value' of a real number like current
		deferred
		ensure
			stable: adjusted_value (Result) = Result
		end

feature -- Anchor

	native_real_anchor: REAL
			-- Anchor for native representation of real numbers
		once
		ensure
			class
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
