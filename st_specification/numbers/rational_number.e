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

feature -- Anchor

	integer_anchor: INTEGER_NUMBER
			-- Anchor for integer numbers
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
