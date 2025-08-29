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
			default_create,
			sign,
			min,
			max,
			multipliable,
			modulus,
			abs,
			converted_integer,
			integer_product_overflows
		end

create
	default_create,
	make

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

	make (num, den: STS_INTEGER_NUMBER)
			-- Create a rational number whose value `p'/`q' equals `num'/`den'
		require
			non_zero_denominator: den ≭ {INTEGER_NUMBER}.Zero
		do
			p := num.value
			q := den.value
		ensure
			numerator: p ≍ num
			denominator: q ≍ den
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

feature -- Access

	sign: like integer_anchor
			-- <Precursor>
		do
			Result := p.sign ⋅ q.sign -- TODO: Take native sign bit instead?
		end

	zero: RATIONAL_NUMBER
			-- <Precursor>
		once
		ensure then
			class
			numerator: Result.p ≍ {INTEGER_NUMBER}.Zero
			denominator: Result.q ≍ {INTEGER_NUMBER}.One
		end

	one: RATIONAL_NUMBER
			-- <Precursor>
		once
			create Result.make ({INTEGER_NUMBER}.One, {INTEGER_NUMBER}.One)
		ensure then
			class
			numerator: Result.p ≍ {INTEGER_NUMBER}.One
			denominator: Result.q ≍ {INTEGER_NUMBER}.One
		end

feature -- Comparison

	min alias "∧" (pq: STS_RATIONAL_NUMBER): like Rational_anchor
			-- <Precursor>
		do
			if Current ≤ pq then
				Result := Current
			else
				check
					non_zero_denominator: pq.q ≭ {INTEGER_NUMBER}.zero -- {STS_RATIONAL_NUMBER} invariant
				end
				create Result.make (pq.p, pq.q)
			end
		end

	max alias "∨" (pq: STS_RATIONAL_NUMBER): like Rational_anchor
			-- <Precursor>
		do
			if Current ≥ pq then
				Result := Current
			else
				check
					non_zero_denominator: pq.q ≭ {INTEGER_NUMBER}.zero -- {STS_RATIONAL_NUMBER} invariant
				end
				create Result.make (pq.p, pq.q)
			end
		end

feature -- Relationship

	multipliable (pq: STS_RATIONAL_NUMBER): BOOLEAN
			-- <Precursor>
			--| NOTICE: This refinement assumes that a product overflow that occasionly unequals zero will *consistently* produce a non-zero result.
		local
			l_gcd_1, l_gcd_2: like gcd
		do
			l_gcd_1 := gcd (pq.p, q)
			l_gcd_2 := gcd (p, pq.q)
			check
				good_divisor_1: q.divisible (l_gcd_1) -- l_gcd_1 /= 0 ⇐ q /= 0
				good_divisor_2: pq.q.divisible (l_gcd_2) -- l_gcd_2 /= 0 ⇐ pq.q /= 0
			end
			Result := (q // l_gcd_1) ⋅ (pq.q // l_gcd_2) ≭ Zero.p
		ensure then
			gcd_1: attached gcd (pq.p, q) as gcd_1
			gcd_2: attached gcd (p, pq.q) as gcd_2
			good_divisor_1: q.divisible (gcd_1)
			good_divisor_2: pq.q.divisible (gcd_2)
			definition: Result = (q // gcd_1) ⋅ (pq.q // gcd_2) ≭ Zero.p
		end

feature -- Operation

	modulus,
	abs: like rational_anchor
			-- <Precursor>
		do
			if p.sign ⋅ q.sign ≥ q.Zero then
				Result := Current
			elseif p ≍ {INTEGER_NUMBER}.Min_value then
				if q ≍ {INTEGER_NUMBER}.Min_value then
						-- Current = One
					Result := Current
				else
					check
						good_divisor: p.divisible (- q) -- Class invariant: q /= 0
					end
					Result := p / - q
				end
			elseif q ≍ {INTEGER_NUMBER}.Min_value then
				check
					good_divisor: (- p).divisible (q) -- q ≍ {INTEGER_NUMBER}.Min_value /= 0
				end
				Result := - p / q
			else
				check
					good_divisor: (- p).divisible (q) -- Class invariant: q /= 0
				end
				Result := - p / q
			end
		end

	opposite alias "-" alias "−": like rational_anchor
			-- <Precursor>
		do

			if q > q.Zero then
				if p ≭ {INTEGER_NUMBER}.Min_value then
					check
						(- p).sign ≍ - p.sign
						minus_p_divisible_q: (- p).divisible (q) -- q > 0
					end
					create Result.make (- p, q)
				else
					check
						(- q).sign ≍ - q.sign -- q ≭ {INTEGER_NUMBER}.Min_value ⇐ q > 0
						p_divisible_minus_q: p.divisible (- q) -- - q < 0 ⇐ q > 0
					end
					create Result.make (p, - q)
				end
			else
				if p ≭ {INTEGER_NUMBER}.Min_value then
					check
						(- p).sign ≍ - p.sign
						minus_p_divisible_q: (- p).divisible (q) -- Class invariant: q /= 0
					end
					create Result.make (- p, q)
				elseif q ≭ {INTEGER_NUMBER}.Min_value then

					check
						(- q).sign ≍ - q.sign
						p_divisible_minus_q: p.divisible (- q) -- - q /= 0 ⇐ Class invariant: q /= 0
					end
					create Result.make (p, - q)
				else
						-- p / q = {INTEGER_NUMBER}.Min_value / {INTEGER_NUMBER}.Min_value
					create Result.make (- p.One, q.One)
				end
			end
		end

feature -- Factory

	converted_integer (i: STS_INTEGER_NUMBER): like integer_anchor
			-- <Precursor>
		do
			if attached {like integer_anchor} i as exp_i then
				Result := exp_i
			else
				Result := i.value
			end
		ensure then
			class
		end

feature -- Predicate

	integer_product_overflows (i, j: STS_INTEGER_NUMBER): BOOLEAN
			-- <Precursor>
		do
			Result := i < i.zero and j < i.zero and i.max_value_exists and then i < i.max_value // j or
				i < i.zero and j > i.zero and i.min_value_exists and then i < i.min_value // j or
				i > i.zero and j < - i.one and i.min_value_exists and then i > i.min_value // j or
				i > i.zero and j > i.zero and i.max_value_exists and then i > i.max_value // j
		ensure then
			class
		end

feature -- Anchor

	integer_anchor: INTEGER_NUMBER
			-- <Precursor>
		once
		ensure then
			class
		end

	rational_anchor: RATIONAL_NUMBER
			-- <Precursor>
		once
		ensure then
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
