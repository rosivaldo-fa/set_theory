note
	description: "Implementation of {STST_RATIONAL_NUMBER_PROPERTIES}."
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	RATIONAL_NUMBER_PROPERTIES

inherit
	STST_RATIONAL_NUMBER_PROPERTIES
		redefine
			multipliable_ok
		end

feature -- Access

	zero: STI_RATIONAL_NUMBER
			-- <Precursor>
		once
		ensure then
			class
			numerator: Result.p ≍ {STI_INTEGER_NUMBER}.Zero
			denominator: Result.q ≍ {STI_INTEGER_NUMBER}.One
		end

feature -- Properties (Relationship)

	multipliable_ok (pq_1, pq_2: STS_RATIONAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STI_RATIONAL_NUMBER}.multipliable?
		do
			if multipliable_ok (pq_1, pq_2) then
				check
					gcd_1: attached gcd (pq_2.p, pq_1.q) as gcd_1
					gcd_2: attached gcd (pq_1.p, pq_2.q) as gcd_2
					good_divisor_1: pq_1.q.divisible (gcd_1) -- gcd_1 /= 0 ⇐ pq_1.q /= 0
					good_divisor_2: pq_2.q.divisible (gcd_2) -- gcd_2 /= 0 ⇐ pq_2.q /= 0
					accepted_overflow:
						{STI_RATIONAL_NUMBER}.integer_product_overflows (pq_1.q // gcd_1, pq_2.q // gcd_2) and (pq_1.q // gcd_1) ⋅ (pq_2.q // gcd_2) ≭ Zero.p ⇒
						pq_1.multipliable (pq_2)
				then
					Result := True
				end
			end
		end

feature -- Anchor

	rational_anchor: STI_RATIONAL_NUMBER
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
