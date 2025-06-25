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
			is_in as element_is_in
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

feature -- Implementation

	adjusted_value (v: like value): like value
			-- `v' adjusted to represent the `value' of current natural number
		deferred
		ensure
			stable: adjusted_value (Result) = Result
		end

feature -- Anchor

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
