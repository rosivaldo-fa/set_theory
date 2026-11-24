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

feature -- Implementation

	adjusted_value (v: like value): like value
			-- `v' adjusted to represent the `value' of current integer number
		deferred
		ensure
			stable: adjusted_value (Result) = Result
		end

feature -- Anchor

	native_integer_anchor: INTEGER
			-- Anchor for the native representation of the value of current integer number
			--| TODO: Make it target dependant.
		deferred
		end

note
	copyright: "Copyright (c) 2012-2026, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
