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

feature -- Access

	zero: like rational_anchor
			-- The rational number 0/1
		deferred
		ensure
			definition: Result ≍ Result.zero
		end

	one: like rational_anchor
			-- The rational number 1/1
		deferred
		ensure
			definition: Result ≍ Result.one
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
			-- Do the properties verified within number theory hold for {STS_RATIONAL_NUMBER}.max?
		do
			check
				idempotent: (pq_1 ∨ pq_1) ≍ pq_1
				commutative: (pq_1 ∨ pq_2) ≍ (pq_2 ∨ pq_1)
				associative: ((pq_1 ∨ pq_2) ∨ pq_3) ≍ (pq_1 ∨ (pq_2 ∨ pq_3))
			then
				Result := True
			end
		end

feature -- Properties (Relationship)

	multipliable_ok (pq_1, pq_2: STS_RATIONAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_RATIONAL_NUMBER}.multipliable?
		do
			check
				gcd_1: attached gcd (pq_2.p, pq_1.q) as gcd_1
				gcd_2: attached gcd (pq_1.p, pq_2.q) as gcd_2
				good_divisor_1: pq_1.q.divisible (gcd_1) -- gcd_1 /= 0 ⇐ pq_1.q /= 0
				good_divisor_2: pq_2.q.divisible (gcd_2) -- gcd_2 /= 0 ⇐ pq_2.q /= 0
				unexpected_zero_product: -- Which is possible only upon an overflow.
					(pq_1.q // gcd_1) ⋅ (pq_2.q // gcd_2) ≍ zero.p ⇒ not pq_1.multipliable (pq_2)
			then
				Result := True
			end
		end

feature -- Properties (Operation)

	plus_ok (pq_1, pq_2: STS_RATIONAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_RATIONAL_NUMBER}.plus?
		do
			check
				neutral_left_term: (zero + pq_1) ≍ pq_1
				neutral_right_term: (pq_1 + zero) ≍ pq_1
				commutative: (pq_1 + pq_2) ≍ (pq_2 + pq_1)
			then
				Result := True
			end
		end

	minus_ok (pq_1, pq_2: STS_RATIONAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_RATIONAL_NUMBER}.minus?
		do
			check
				quasi_neutral_minuend: (zero - pq_1) ≍ - pq_1
				neutral_subtrahend: (pq_1 - zero) ≍ pq_1
				quasi_commutative: (pq_1 - pq_2).abs ≍ (pq_2 - pq_1).abs
			then
				Result := True
			end
		end

	opposite_ok (pq: STS_RATIONAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_RATIONAL_NUMBER}.opposite?
		do
			check
				inverted_sign: (- pq).sign ≍ - pq.sign
			then
				Result := True
			end
		end

	product_ok (pq_1, pq_2: STS_RATIONAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_RATIONAL_NUMBER}.product?
		do
			check
				left_good_factor: one.multipliable (pq_1) -- 1 is a neutral factor.
				neutral_left_factor: (one ⋅ pq_1) ≍ pq_1
				right_good_factor: pq_1.multipliable (one) -- 1 is a neutral factor.
				neutral_right_factor: pq_1 ⋅ one ≍ pq_1
				absorbing_left_good_factor: zero.multipliable (pq_1) -- Denominator equal to 1 is a neutral factor.
				absorbing_left_factor: (zero ⋅ pq_1) ≍ zero
				absorbing_right_good_factor: pq_1.multipliable (zero) -- Denominator equal to 1 is a neutral factor.
				absorbing_right_factor: pq_1 ⋅ zero ≍ zero
				commutative: pq_1.multipliable (pq_2) ⇒
					pq_2.multipliable (pq_1) -- Commutativity
					and then (pq_1 ⋅ pq_2) ≍ (pq_2 ⋅ pq_1)
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

feature -- Math

	gcd (i, j: STS_INTEGER_NUMBER): STS_INTEGER_NUMBER
			-- Greatest common divisor of `i' and `j'
			-- TODO: DRY!
		do
			if j ≍ zero.p then
				Result := i.abs
			else
				check
					good_divisor: i.divisible (j) -- j /= 0
				end
				Result := gcd (j, i \\ j)
			end
		ensure
			base: j ≍ zero.p implies Result ≍ i.abs
			good_divisor: j ≭ zero.p implies i.divisible (j)
			induction: j ≭ zero.p implies Result ≍ gcd (j, i \\ j)
		end

feature -- Anchor

	rational_anchor: STS_RATIONAL_NUMBER
			-- Anchor for rational naumbers
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
