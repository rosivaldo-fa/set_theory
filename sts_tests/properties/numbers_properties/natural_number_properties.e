note
	description: "Object that checks whether the properties verified within number theory hold for an implementation of {STS_NATURAL_NUMBER}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NATURAL_NUMBER_PROPERTIES

feature -- Access

	zero: like natural_anchor
			-- The natural number 0
		deferred
		ensure
			definition: Result.value = 0
		end

	one: like natural_anchor
			-- The natural number 1
		deferred
		ensure
			definition: Result.value = 1
		end

feature -- Properties (Membership)

	is_not_in_ok (l: STS_NATURAL_NUMBER; s: STS_SET [STS_NATURAL_NUMBER]): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_NATURAL_NUMBER}.is_not_in?
		do
			check
				another_definition: l ∉ s = s ∌ l
			then
				Result := True
			end
		end

feature -- Properties (Comparison)

	equals_ok (n, m, l: STS_NATURAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_NATURAL_NUMBER}.equals?
		do
			check
				reflexive: n ≍ n
				symmetric: n ≍ m implies m ≍ n
				transitive: n ≍ m and m ≍ l implies n ≍ l
				euclidian: n ≍ m and n ≍ l implies m ≍ l
			then
				Result := True
			end
		end

	unequals_ok (n, m: STS_NATURAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_NATURAL_NUMBER}.unequals?
		do
			check
				alternate_definition: n ≭ m = (n.value /= m.value)
				irreflexive: not (n ≭ n)
			then
				Result := True
			end
		end

	is_less_ok (n, m, l: STS_NATURAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_NATURAL_NUMBER}.is_less?
		do
			check
				irreflexive: not (n < n)
				asymmetric: n < m implies not (m < n)
				transitive: n < m and m < l implies n < l
			then
				Result := True
			end
		end

	is_less_equal_ok (n, m, l: STS_NATURAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_NATURAL_NUMBER}.is_less_equal?
		do
			check
				alternate_definition: n ≤ m = (n.value ≤ m.value)
				reflexive: n ≤ n
				transitive: n ≤ m and m ≤ l implies n ≤ l
				antisymmetric: n ≤ m and m ≤ n implies n ≍ m
			then
				Result := True
			end
		end

	is_greater_ok (n, m, l: STS_NATURAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_NATURAL_NUMBER}.is_greater?
		do
			check
				alternate_definition: n > m = (n.value > m.value)
				yet_another_definition: n > m = not (n ≤ m)
				irreflexive: not (n > n)
				asymmetric: n > m implies not (m > n)
				transitive: n > m and m > l implies n > l
			then
				Result := True
			end
		end

	is_greater_equal_ok (n, m, l: STS_NATURAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_NATURAL_NUMBER}.is_greater_equal?
		do
			check
				alternate_definition: n ≥ m = (n.value ≥ m.value)
				yet_another_definition: n ≥ m = not (n < m)
				reflexive: n ≥ n
				transitive: n ≥ m and m ≥ l implies n ≥ l
				antisymmetric: n ≥ m and m ≥ n implies n ≍ m
			then
				Result := True
			end
		end

	min_ok (n, m, l: STS_NATURAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_NATURAL_NUMBER}.min?
		do
			check
				idempotent: (n ∧ n) ≍ n
				commutative: (n ∧ m) ≍ (m ∧ n)
				associative: ((n ∧ m) ∧ l) ≍ (n ∧ (m ∧ l))
			then
				Result := True
			end
		end

	max_ok (n, m, l: STS_NATURAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_NATURAL_NUMBER}.max?
		do
			check
				idempotent: (n ∨ n) ≍ n
				commutative: (n ∨ m) ≍ (m ∨ n)
				associative: ((n ∨ m) ∨ l) ≍ (n ∨ (m ∨ l))
			then
				Result := True
			end
		end

feature -- Properties (Operation)

	plus_ok (n, m, l: STS_NATURAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_NATURAL_NUMBER}.plus?
		do
			check
				neutral_left_term: (zero + n) ≍ n
				neutral_right_term: (n + zero) ≍ n
				commutative: (n + m) ≍ (m + n)
				associative: ((n + m) + l) ≍ (n + (m + l))
			then
				Result := True
			end
		end

	identity_ok (n: STS_NATURAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_NATURAL_NUMBER}.identity?
		do
			check
				as_left_term: + n ≍ (n + zero)
				as_right_term: + n ≍ (zero + n)
			then
				Result := True
			end
		end

	minus_ok (n, m, l: STS_NATURAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_NATURAL_NUMBER}.minus?
		do
			check
				zero_small_enough: zero ≤ n -- By definition.
				neutral_subtrahend: (n - zero) ≍ n
				oppositely_homomorphic: m ≤ n and l ≤ n ⇒ (l ≤ m ⇒ (n - m) ≥ (n - l))
				oppositely_isomorphic: m ≤ n and l ≤ n ⇒ (l < m ⇒ n - m > n - l)
			then
				Result := True
			end
		end

	product_ok (n, m, l: STS_NATURAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_NATURAL_NUMBER}.product?
		do
			check
				neutral_left_factor: one ⋅ n ≍ n
				neutral_right_factor: n ⋅ one ≍ n
				absorbing_left_factor: zero ⋅ n ≍ zero
				absorbing_right_factor: n ⋅ zero ≍ zero
				commutative: (n ⋅ m) ≍ (m ⋅ n)
				associative: ((n ⋅ m) ⋅ l) ≍ (n ⋅ (m ⋅ l))
			then
				Result := True
			end
		end

	natural_quotient_ok (n, m: STS_NATURAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_NATURAL_NUMBER}.natural_quotient?
		do
			check
				absorbing_dividend: zero.divisible (n) ⇒ (zero // n) ≍ zero
				good_divisor: n.divisible (one) -- one /= 0
				neutral_divisor: (n // one) ≍ n
			then
				Result := True
			end
		end

	natural_remainder_ok (n, m: STS_NATURAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_NATURAL_NUMBER}.natural_remainder?
		do
			check
				absorbing_dividend: n ≍ zero and n.divisible (m) ⇒ (n \\ m) ≍ zero
				upper_bounded: n.divisible (m) ⇒ (n \\ m) < m
			then
				Result := True
			end
		end

feature -- Anchor

	natural_anchor: STS_NATURAL_NUMBER
			-- Anchor for natural numbers
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
