note
	description: "Object that checks whether the properties verified within set and number theory hold for an implementation of {STS_REAL_NUMBER}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	REAL_NUMBER_PROPERTIES

inherit
	ELEMENT_PROPERTIES
		rename
			is_not_in_ok as element_is_not_in_ok
		end

feature -- Access

	zero: like real_anchor
			-- The real number 0
		deferred
		ensure
			definition: Result.value = 0
		end

	one: like real_anchor
			-- The real number 1
		deferred
		ensure
			definition: Result.value = 1
		end

feature -- Properties (Membership)

	is_not_in_ok (x: STS_REAL_NUMBER; s: STS_SET [STS_REAL_NUMBER]): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_REAL_NUMBER}.is_not_in?
		do
			check
				definition: x ∉ s = s ∌ x
			then
				Result := True
			end
		end

feature -- Properties (Access)

	one_ok (x, y: STS_REAL_NUMBER): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_REAL_NUMBER}.one?
		do
			check
					good_divisor: x.divisible (y.one) -- one.is_invertible
				neutral_divisor: (x / y.one) ≍ x
			then
				Result := True
			end
		end

feature -- Properties (Comparison)

--	equals_ok (x, y, z: STS_REAL_NUMBER): BOOLEAN
--			-- Do the properties verified within number theory hold for {STS_REAL_NUMBER}.equals?
--		do
--			check
--				reflexive: x ≍ x
--				symmetric: x ≍ y ⇒ y ≍ x
--				transitive: x ≍ y and y ≍ z ⇒ x ≍ z
--				euclidian: x ≍ z and y ≍ z ⇒ x ≍ y
--			then
--				Result := True
--			end
--		end

--	unequals_ok (x: STS_REAL_NUMBER): BOOLEAN
--			-- Do the properties verified within number theory hold for {STS_REAL_NUMBER}.unequals?
--		do
--			check
--				irreflexive: not (x ≭ x)
--			then
--				Result := True
--			end
--		end

--	is_less_ok (x, y, z: STS_REAL_NUMBER): BOOLEAN
--			-- Do the properties verified within number theory hold for {STS_REAL_NUMBER}.is_less?
--		do
--			check
--				irreflexive: not (x < x)
--				transitive: x < y and y < z ⇒ x < z
--			then
--				Result := True
--			end
--		end

--	is_less_equal_ok (x, y, z: STS_REAL_NUMBER): BOOLEAN
--			-- Do the properties verified within number theory hold for {STS_REAL_NUMBER}.is_less_equal?
--		do
--			check
--				reflexive: x ≤ x
--				transitive: x ≤ y and y ≤ z ⇒ x ≤ z
--				antisymmetric: x ≤ y and y ≤ x ⇒ x ≍ y
--			then
--				Result := True
--			end
--		end

--	is_greater_ok (x, y, z: STS_REAL_NUMBER): BOOLEAN
--			-- Do the properties verified within number theory hold for {STS_REAL_NUMBER}.is_greater?
--		do
--			check
--				irreflexive: not (x > x)
--				transitive: x > y and y > z ⇒ x > z
--			then
--				Result := True
--			end
--		end

--	is_greater_equal_ok (x, y, z: STS_REAL_NUMBER): BOOLEAN
--			-- Do the properties verified within number theory hold for {STS_REAL_NUMBER}.is_greater_equal?
--		do
--			check
--				reflexive: x ≥ x
--				transitive: x ≥ y and y ≥ z ⇒ x ≥ z
--				antisymmetric: x ≥ y and y ≥ x ⇒ x ≍ y
--			then
--				Result := True
--			end
--		end

--	min_ok (x, y, z: STS_REAL_NUMBER): BOOLEAN
--			-- Do the properties verified within number theory hold for {STS_REAL_NUMBER}.min?
--		do
--			check
--				idempotent: (x ∧ x) ≍ x
--				commutative: (x ∧ y) ≍ (y ∧ x)
--				associative: ((x ∧ y) ∧ z) ≍ (x ∧ (y ∧ z))
--			then
--				Result := True
--			end
--		end

--	max_ok (x, y, z: STS_REAL_NUMBER): BOOLEAN
--			-- Do the properties verified within number theory hold for {STS_REAL_NUMBER}.max?
--		do
--			check
--				idempotent: (x ∨ x) ≍ x
--				commutative: (x ∨ y) ≍ (y ∨ x)
--				associative: ((x ∨ y) ∨ z) ≍ (x ∨ (y ∨ z))
--			then
--				Result := True
--			end
--		end

feature -- Properties (Relationship)

--	multipliable_ok (x, y: STS_REAL_NUMBER): BOOLEAN
--			-- Do the properties verified within number theory hold for {STS_REAL_NUMBER}.multipliable?
--		do
--			check
--				gcd_1: attached gcd (y.p, x.q) as gcd_1
--				gcd_2: attached gcd (x.p, y.q) as gcd_2
--				good_divisor_1: x.q.divisible (gcd_1) -- gcd_1 /= 0 ⇐ x.q /= 0
--				good_divisor_2: y.q.divisible (gcd_2) -- gcd_2 /= 0 ⇐ y.q /= 0
--				unexpected_zero_product: -- Which is possible only upon an overflow.
--					(x.q // gcd_1) ⋅ (y.q // gcd_2) ≍ zero.p ⇒ not x.multipliable (y)
--			then
--				Result := True
--			end
--		end

feature -- Properties (Operation)

--	plus_ok (x, y: STS_REAL_NUMBER): BOOLEAN
--			-- Do the properties verified within number theory hold for {STS_REAL_NUMBER}.plus?
--		do
--			check
--				neutral_left_term: (zero + x) ≍ x
--				neutral_right_term: (x + zero) ≍ x
--				commutative: (x + y) ≍ (y + x)
--			then
--				Result := True
--			end
--		end

--	minus_ok (x, y: STS_REAL_NUMBER): BOOLEAN
--			-- Do the properties verified within number theory hold for {STS_REAL_NUMBER}.minus?
--		do
--			check
--				quasi_neutral_minuend: (zero - x) ≍ - x
--				neutral_subtrahend: (x - zero) ≍ x
--				quasi_commutative: (x - y).abs ≍ (y - x).abs
--			then
--				Result := True
--			end
--		end

--	opposite_ok (x: STS_REAL_NUMBER): BOOLEAN
--			-- Do the properties verified within number theory hold for {STS_REAL_NUMBER}.opposite?
--		do
--			check
--				inverted_sign: (- x).sign ≍ - x.sign
--			then
--				Result := True
--			end
--		end

--	product_ok (x, y: STS_REAL_NUMBER): BOOLEAN
--			-- Do the properties verified within number theory hold for {STS_REAL_NUMBER}.product?
--		do
--			check
--				left_good_factor: one.multipliable (x) -- 1 is a neutral factor.
--				neutral_left_factor: (one ⋅ x) ≍ x
--				right_good_factor: x.multipliable (one) -- 1 is a neutral factor.
--				neutral_right_factor: x ⋅ one ≍ x
--				absorbing_left_good_factor: zero.multipliable (x) -- Denominator equal to 1 is a neutral factor.
--				absorbing_left_factor: (zero ⋅ x) ≍ zero
--				absorbing_right_good_factor: x.multipliable (zero) -- Denominator equal to 1 is a neutral factor.
--				absorbing_right_factor: x ⋅ zero ≍ zero
--				commutative: x.multipliable (y) ⇒
--					y.multipliable (x) -- Commutativity
--					and then (x ⋅ y) ≍ (y ⋅ x)
--			then
--				Result := True
--			end
--		end

--	quotient_ok (x: STS_REAL_NUMBER): BOOLEAN
--			-- Do the properties verified within number theory hold for {STS_REAL_NUMBER}.quotient?
--		do
--			check
--				absorbing_dividend: zero.divisible (x) ⇒ (zero / x) ≍ zero
--					good_divisor: x.divisible (one) -- 1 is an invertible, neutral factor.
--				neutral_divisor: (x / one) ≍ x
--			then
--				Result := True
--			end
--		end

feature -- Anchor

	real_anchor: STS_REAL_NUMBER
			-- Anchor for real naumbers
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
