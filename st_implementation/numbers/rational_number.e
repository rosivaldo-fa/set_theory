note
	description: "[
			Implementation of {STS_RATIONAL_NUMBER}.
			
			Notice that, as stated at {STS_RATIONAL_NUMBER} description, that specification (and this implementation)) does not try to offer a high-grade
			numeric class. Its intent is just to introduce examples of how several numeric types and sets may receive a set-theoretic treatment.
			
			Ideally, {STS_RATIONAL_NUMBER} could inherit from {STS_HOMOGENEOUS_ORDERED_PAIR [STS_INTEGER_NUMBER, ...]}. However, for the sake of regularity,
			in such a case {STS_COMPLEX_NUMBER} should inherit from {STS_HOMOGENEOUS_ORDERED_PAIR [STS_REAL_NUMBER, ...]}. But then {STS_RATIONAL_NUMBER} would
			inherit twice from {STS_HOMOGENEOUS_ORDERED_PAIR}, and such a double inheritance would be valid only if both {STS_HOMOGENEOUS_ORDERED_PAIR} ancestors
			had the same actual generic parameters, which would not be the case. Such a mess does not occur here, since {COMPLEX_NUMBER} is not an ancestor of
			{RATIONAL_NUMBER}, and each one of these classes can inherit from the appropriate derivation of {STS_HOMOGENEOUS_ORDERED_PAIR}. Inheriting from
			{HOMOGENEOUS_ORDERED_PAIR} is not possible because the (renamed) fields `a' and `b' would change their expansion status, which is a forbidden
			construct. The same observations apply to the hypothesis of inheriting from {STS_COMPOSABLE_ORDERED_PAIR} and {COMPOSABLE_ORDERED_PAIR}.
		]"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

expanded class
	RATIONAL_NUMBER

inherit
	STS_RATIONAL_NUMBER
		rename
			p as numerator,
			q as denominator
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			-- Create the rational number 0/1.
		do
			p := {INTEGER_NUMBER}.Zero
			q := {INTEGER_NUMBER}.One
		ensure then
			numerator: p ≍ {INTEGER_NUMBER}.Zero
			denominator: q ≍ {INTEGER_NUMBER}.One
		end

feature -- Primitive

	p: like Integer_anchor
			-- Numerator of current rational number

	numerator: like Integer_anchor
			-- <Precursor>
		do
			Result := p
		ensure then
			definition: Result ≍ p
		end

	q: like Integer_anchor
			-- Denominator of current rational number

	denominator: like Integer_anchor
			-- <Precursor>
		do
			Result := q
		ensure then
			definition: Result ≍ q
		end

--feature -- Access

--	zero: RATIONAL_NUMBER
--			-- <Precursor>
--		once
--			create p
--			create q.make (1)
--		ensure then
--			class
--		end

feature -- Anchor

	integer_anchor: INTEGER_NUMBER
			-- <Precursor>
		once
		ensure then
			class
		end

--	rational_anchor: RATIONAL_NUMBER
--			-- <Precursor>
--		once
--			Result := zero
--		ensure then
--			class
--		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
