note
	description: "Object that checks whether the properties verified within set and number theory hold for an implementation of {STS_RATIONAL_NUMBER}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	RATIONAL_NUMBER_PROPERTIES

inherit
	ELEMENT_PROPERTIES
		rename
			is_not_in_ok as element_is_not_in_ok
		end

feature -- Properties (Membership)

	is_not_in_ok (pq: STS_RATIONAL_NUMBER; s: STS_SET [STS_RATIONAL_NUMBER]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_RATIONAL_NUMBER}.is_not_in?
		do
			check
				definition: pq ∉ s = s ∌ pq
			then
				Result := True
			end
		end

feature -- Properties (Comparison)

	equals_ok (pq_1, pq_2, pq_3: STS_RATIONAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_RATIONAL_NUMBER}.equals?
		do
			check
				reflexive: pq_1 ≍ pq_1
				symmetric: pq_1 ≍ pq_2 ⇒ pq_2 ≍ pq_1
				transitive: pq_1 ≍ pq_2 and pq_2 ≍ pq_3 ⇒ pq_1 ≍ pq_3
				euclidian: pq_1 ≍ pq_3 and pq_2 ≍ pq_3 ⇒ pq_1 ≍ pq_2
			then
				Result := True
			end
		end

	unequals_ok (pq: STS_RATIONAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_RATIONAL_NUMBER}.unequals?
		do
			check
				irreflexive: not (pq ≭ pq)
			then
				Result := True
			end
		end

	is_less_ok (pq_1, pq_2, pq_3: STS_RATIONAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_RATIONAL_NUMBER}.is_less?
		do
			check
				irreflexive: not (pq_1 < pq_1)
				transitive: pq_1 < pq_2 and pq_2 < pq_3 ⇒ pq_1 < pq_3
			then
				Result := True
			end
		end

	is_less_equal_ok (pq_1, pq_2, pq_3: STS_RATIONAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_RATIONAL_NUMBER}.is_less_equal?
		do
			check
				reflexive: pq_1 ≤ pq_1
				transitive: pq_1 ≤ pq_2 and pq_2 ≤ pq_3 ⇒ pq_1 ≤ pq_3
				antisymmetric: pq_1 ≤ pq_2 and pq_2 ≤ pq_1 ⇒ pq_1 ≍ pq_2
			then
				Result := True
			end
		end

	is_greater_ok (pq_1, pq_2, pq_3: STS_RATIONAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_RATIONAL_NUMBER}.is_greater?
		do
			check
				irreflexive: not (pq_1 > pq_1)
				transitive: pq_1 > pq_2 and pq_2 > pq_3 ⇒ pq_1 > pq_3
			then
				Result := True
			end
		end

	is_greater_equal_ok (pq_1, pq_2, pq_3: STS_RATIONAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_RATIONAL_NUMBER}.is_greater_equal?
		do
			check
				reflexive: pq_1 ≥ pq_1
				transitive: pq_1 ≥ pq_2 and pq_2 ≥ pq_3 ⇒ pq_1 ≥ pq_3
				antisymmetric: pq_1 ≥ pq_2 and pq_2 ≥ pq_1 ⇒ pq_1 ≍ pq_2
			then
				Result := True
			end
		end

	min_ok (pq_1, pq_2, pq_3: STS_RATIONAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_RATIONAL_NUMBER}.min?
		do
			check
				idempotent: (pq_1 ∧ pq_1) ≍ pq_1
				commutative: (pq_1 ∧ pq_2) ≍ (pq_2 ∧ pq_1)
				associative: ((pq_1 ∧ pq_2) ∧ pq_3) ≍ (pq_1 ∧ (pq_2 ∧ pq_3))
			then
				Result := True
			end
		end

	max_ok (pq_1, pq_2, pq_3: STS_RATIONAL_NUMBER): BOOLEAN
			-- Do the properties verified within set theorpq_2 hold for {STS_RATIONAL_NUMBER}.max?
		do
			check
				idempotent: (pq_1 ∨ pq_1) ≍ pq_1
				commutative: (pq_1 ∨ pq_2) ≍ (pq_2 ∨ pq_1)
				associative: ((pq_1 ∨ pq_2) ∨ pq_3) ≍ (pq_1 ∨ (pq_2 ∨ pq_3))
			then
				Result := True
			end
		end

feature -- Properties (Math)

	gcd_ok (pq: STS_RATIONAL_NUMBER; i, j, k: STS_INTEGER_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_RATIONAL_NUMBER}.gcd?
		do
			check
				common_divisor: k | i and k | j implies k | pq.gcd (i, j)
				commutative: pq.gcd (i, j) ≍ pq.gcd (j, i)
				associative: pq.gcd (i, pq.gcd (j, k)) ≍ pq.gcd (pq.gcd (i, j), k)
			then
				Result := True
			end
		end

	rem_ok (pq: STS_RATIONAL_NUMBER; i, j: STS_INTEGER_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_RATIONAL_NUMBER}.rem?
		do
			if i.divisible (j) then
				check
					consistent: (pq.div (i, j) ⋅ j + pq.rem (i, j)) ≍ i
					identity: pq.rem (pq.rem (i, j), j) ≍ pq.rem (i, j)
				then
				end
			end
			Result := True
		end

feature -- Properties (Predicate)

	integer_product_overflows_ok (pq: STS_RATIONAL_NUMBER; i, j: STS_INTEGER_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_RATIONAL_NUMBER}.integer_product_overflows?
		do
			check
				unexpected_zero_product: i ≭ i.zero and j ≭ i.zero and i ⋅ j ≍ i.zero ⇒ pq.integer_product_overflows (i, j)
			then
				Result := True
			end
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
