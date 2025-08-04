note
	description: "Object that checks whether the properties verified within number theory hold for an implementation of {STS_INTEGER_NUMBER}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	INTEGER_NUMBER_PROPERTIES

inherit
	ELEMENT_PROPERTIES
		rename
			is_not_in_ok as element_is_not_in_ok
		end

feature -- Access

	zero: like integer_anchor
			-- The integer number 0
		deferred
		ensure
			definition: Result.value = 0
		end

	one: like integer_anchor
			-- The integer number 1
		deferred
		ensure
			definition: Result.value = 1
		end

feature -- Properties (Membership)

	is_not_in_ok (i: STS_INTEGER_NUMBER; s: STS_SET [STS_INTEGER_NUMBER]): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_INTEGER_NUMBER}.is_not_in?
		do
			check
				another_definition: i ∉ s = s ∌ i
			then
				Result := True
			end
		end

feature -- Properties (Comparison)

	equals_ok (i, j, k: STS_INTEGER_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_INTEGER_NUMBER}.equals?
		do
			check
				reflexive: i ≍ i
				symmetric: i ≍ j implies j ≍ i
				transitive: i ≍ j and j ≍ k implies i ≍ k
				euclidian: i ≍ j and i ≍ k implies j ≍ k
			then
				Result := True
			end
		end

	unequals_ok (i, j: STS_INTEGER_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_INTEGER_NUMBER}.unequals?
		do
			check
				alternate_definition: i ≭ j = (i.value /= j.value)
				irreflexive: not (i ≭ i)
			then
				Result := True
			end
		end

	is_less_ok (i, j, k: STS_INTEGER_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_INTEGER_NUMBER}.is_less?
		do
			check
				irreflexive: not (i < i)
				asymmetric: i < j implies not (j < i)
				transitive: i < j and j < k implies i < k
			then
				Result := True
			end
		end

	is_less_equal_ok (i, j, k: STS_INTEGER_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_INTEGER_NUMBER}.is_less_equal?
		do
			check
				alternate_definition: i ≤ j = (i.value ≤ j.value)
				reflexive: i ≤ i
				transitive: i ≤ j and j ≤ k implies i ≤ k
				antisymmetric: i ≤ j and j ≤ i implies i ≍ j
			then
				Result := True
			end
		end

	is_greater_ok (i, j, k: STS_INTEGER_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_INTEGER_NUMBER}.is_greater?
		do
			check
				alternate_definition: i > j = (i.value > j.value)
				yet_another_definition: i > j = not (i ≤ j)
				irreflexive: not (i > i)
				asymmetric: i > j implies not (j > i)
				transitive: i > j and j > k implies i > k
			then
				Result := True
			end
		end

	is_greater_equal_ok (i, j, k: STS_INTEGER_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_INTEGER_NUMBER}.is_greater_equal?
		do
			check
				alternate_definition: i ≥ j = (i.value ≥ j.value)
				yet_another_definition: i ≥ j = not (i < j)
				reflexive: i ≥ i
				transitive: i ≥ j and j ≥ k implies i ≥ k
				antisymmetric: i ≥ j and j ≥ i implies i ≍ j
			then
				Result := True
			end
		end

	min_ok (i, j, k: STS_INTEGER_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_INTEGER_NUMBER}.min?
		do
			check
				idempotent: (i ∧ i) ≍ i
				commutative: (i ∧ j) ≍ (j ∧ i)
				associative: ((i ∧ j) ∧ k) ≍ (i ∧ (j ∧ k))
			then
				Result := True
			end
		end

	max_ok (i, j, k: STS_INTEGER_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_INTEGER_NUMBER}.max?
		do
			check
				idempotent: (i ∨ i) ≍ i
				commutative: (i ∨ j) ≍ (j ∨ i)
				associative: ((i ∨ j) ∨ k) ≍ (i ∨ (j ∨ k))
			then
				Result := True
			end
		end

feature -- Properties (Relationship)

	divides_ok (i, j, k: STS_INTEGER_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_INTEGER_NUMBER}.divides?
		do
			check
				quasi_reflexive: i ≭ zero ⇒ i | i
				transitive: i | j and j | k ⇒ i | k
				antisymmetric: i | j and j | i ⇒ i ≍ j
			then
				Result := True
			end
		end

feature -- Properties (Operation)

	modulus_ok (i: STS_INTEGER_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_INTEGER_NUMBER}.modulus?
		do
			check
				when_negative: i < zero implies i.modulus ≍ - i
				when_non_negative: i ≥ zero implies i.modulus ≍ i
			then
				Result := True
			end
		end

	plus_ok (i, j, k: STS_INTEGER_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_INTEGER_NUMBER}.plus?
		do
			check
				neutral_left_term: (zero + i) ≍ i
				neutral_right_term: (i + zero) ≍ i
				commutative: (i + j) ≍ (j + i)
				associative: ((i + j) + k) ≍ (i + (j + k))
			then
				Result := True
			end
		end

	identity_ok (i: STS_INTEGER_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_INTEGER_NUMBER}.identity?
		do
			check
				as_left_term: + i ≍ (i + zero)
				as_right_term: + i ≍ (zero + i)
			then
				Result := True
			end
		end

	minus_ok (i, j, k: STS_INTEGER_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_INTEGER_NUMBER}.minus?
		do
			check
				neutral_subtrahend: (i - zero) ≍ i
				oppositely_homomorphic: k ≤ j ⇒ (i - k) ≥ (i - j)
				oppositely_isomorphic: k < j ⇒ i - k > i - j
			then
				Result := True
			end
		end

	opposite_ok (i: STS_INTEGER_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_INTEGER_NUMBER}.opposite?
		do
			check
				opposite_left_term: ((- i) + i) ≍ zero
				opposite_right_term: (i + (- i)) ≍ zero
				as_subtrahend: - i ≍ (zero - i)
				as_left_factor: - i ≍ (i ⋅ (- one))
				as_right_factor: - i ≍ ((- one) ⋅ i)
				divisible: i.divisible (- one) -- (- one).is_invertible
				as_quotient: - i ≍ (i // (- one))
			then
				Result := True
			end
		end

	product_ok (i, j, k: STS_INTEGER_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_INTEGER_NUMBER}.product?
		do
			check
				neutral_left_factor: one ⋅ i ≍ i
				neutral_right_factor: i ⋅ one ≍ i
				absorbing_left_factor: zero ⋅ i ≍ zero
				absorbing_right_factor: i ⋅ zero ≍ zero
				commutative: (i ⋅ j) ≍ (j ⋅ i)
				associative: ((i ⋅ j) ⋅ k) ≍ (i ⋅ (j ⋅ k))
			then
				Result := True
			end
		end

	integer_quotient_ok (i, j: STS_INTEGER_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_INTEGER_NUMBER}.integer_quotient?
		do
			check
				absorbing_dividend: zero.divisible (i) ⇒ (zero // i) ≍ zero
				good_divisor: i.divisible (one) -- one /= 0
				neutral_divisor: (i // one) ≍ i
			then
				Result := True
			end
		end

	integer_remainder_ok (i, j: STS_INTEGER_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_INTEGER_NUMBER}.integer_remainder?
		do
			check
				absorbing_dividend: i ≍ zero and i.divisible (j) ⇒ (i \\ j) ≍ zero
				upper_bounded: i.divisible (j) ⇒ (i \\ j) < j
			then
				Result := True
			end
		end

feature -- Anchor

	integer_anchor: STS_INTEGER_NUMBER
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
