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
			-- Do the properties verified within number theory hold for {STS_REAL_NUMBER}.one?
		do
			check
					good_divisor: x.divisible (y.one) -- one.is_invertible
				neutral_divisor: (x / y.one) ≍ x
			then
				Result := True
			end
		end

feature -- Properties (Quality)

	is_nan_ok (x, y: STS_REAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_REAL_NUMBER}.is_nan?
		do
			check
				absorbing_dividend: x.is_nan and x.divisible (y) ⇒ (x / y).is_nan
					good_divisor: y.is_nan ⇒ x.divisible (y) -- y /= 0
				propagating_nan_divisor: y.is_nan ⇒ (x / y).is_nan
			then
				Result := True
			end
		end

	is_negative_infinity_ok (x, y: STS_REAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_REAL_NUMBER}.is_negative_infinity?
		do
			check
				quasi_absorbing_dividend: x.is_negative_infinity and x.divisible (y) and y.is_finite ⇒
					if y < zero then
						(x / y).is_positive_infinity
					else
						(x / y).is_negative_infinity
					end
					good_divisor: y.is_negative_infinity ⇒ x.divisible (y) -- y /= 0
				nullifying_divisor: x.is_finite and y.is_negative_infinity ⇒ (x / y) ≍ zero
			then
				Result := True
			end
		end

	is_positive_infinity_ok (x, y: STS_REAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_REAL_NUMBER}.is_positive_infinity?
		do
			check
--				absorbing_left_term: x.is_positive_infinity and not y.is_nan and not y.is_negative_infinity ⇒ (x + y).is_positive_infinity
--				absorbing_right_term: not x.is_nan and not x.is_negative_infinity and y.is_positive_infinity ⇒ (x + y).is_positive_infinity
--				absorbing_minuend: x.is_positive_infinity and not y.is_nan and not y.is_positive_infinity ⇒ (x - y).is_positive_infinity
--				quasi_absorbing_subtrahend: not x.is_nan and not x.is_positive_infinity and y.is_positive_infinity ⇒ (x - y).is_negative_infinity
--				quasi_absorbing_left_factor: x.is_positive_infinity and not y.is_nan and y ≭ zero ⇒
--					if y < zero then
--						(x ⋅ y).is_negative_infinity
--					else
--						(x ⋅ y).is_positive_infinity
--					end
--				quasi_absorbing_right_factor: not x.is_nan and x ≭ zero and y.is_positive_infinity ⇒
--					if x < zero then
--						(x ⋅ y).is_negative_infinity
--					else
--						(x ⋅ y).is_positive_infinity
--					end
				quasi_absorbing_dividend: x.is_positive_infinity and x.divisible (y) and y.is_finite ⇒
					if y < zero then
						(x / y).is_negative_infinity
					else
						(x / y).is_positive_infinity
					end
					good_divisor: y.is_positive_infinity ⇒ x.divisible (y) -- y /= 0
				nullifying_divisor: x.is_finite and y.is_positive_infinity ⇒ (x / y) ≍ zero
			then
				Result := True
			end
		end

	is_rational_ok (x: STS_REAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_REAL_NUMBER}.is_rational?
		do
			check
				is_not_nan: x.is_rational ⇒ not x.is_nan
				is_not_negative_infinity: x.is_rational ⇒ not x.is_negative_infinity
				is_not_positive_infinity: x.is_rational ⇒ not x.is_positive_infinity
				is_not_infinite: x.is_rational ⇒ not x.is_infinite
				is_finite: x.is_rational ⇒ x.is_finite
			then
				Result := True
			end
		end

	is_integer_ok (x: STS_REAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_REAL_NUMBER}.is_integer?
		do
			check
				is_not_nan: x.is_integer ⇒ not x.is_nan
				is_not_negative_infinity: x.is_integer ⇒ not x.is_negative_infinity
				is_not_positive_infinity: x.is_integer ⇒ not x.is_positive_infinity
				is_not_infinite: x.is_integer ⇒ not x.is_infinite
				is_finite: x.is_integer ⇒ x.is_finite
				is_rational: x.is_integer ⇒ x.is_rational
			then
				Result := True
			end
		end

	is_natural_ok (x: STS_REAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_REAL_NUMBER}.is_natural?
		do
			check
				is_not_nan: x.is_natural ⇒ not x.is_nan
				is_not_negative_infinity: x.is_natural ⇒ not x.is_negative_infinity
				is_not_positive_infinity: x.is_natural ⇒ not x.is_positive_infinity
				is_not_infinite: x.is_natural ⇒ not x.is_infinite
				is_finite: x.is_natural ⇒ x.is_finite
				is_rational: x.is_natural ⇒ x.is_rational
				is_integer: x.is_natural ⇒ x.is_integer
			then
				Result := True
			end
		end

feature -- Properties (Comparison)

	equals_ok (x, y, z: STS_REAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_REAL_NUMBER}.equals?
		do
			check
				reflexive: x ≍ x
				symmetric: x ≍ y ⇒ y ≍ x
				transitive: x ≍ y and y ≍ z ⇒ x ≍ z
				euclidian: x ≍ z and y ≍ z ⇒ x ≍ y
			then
				Result := True
			end
		end

	unequals_ok (x, y: STS_REAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_REAL_NUMBER}.unequals?
		do
			check
				definition: x ≭ y = (x.value /= y.value)
				irreflexive: not (x ≭ x)
			then
				Result := True
			end
		end

	is_less_ok (x, y, z: STS_REAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_REAL_NUMBER}.is_less?
		do
			check
				irreflexive: not (x < x)
				transitive: x < y and y < z ⇒ x < z
				nan: x.is_nan ⇒ ((x < y) = not y.is_nan)
				negative_infinity: x.is_negative_infinity ⇒ ((x < y) = not (y.is_nan or y.is_negative_infinity))
				positive_infinity: x.is_positive_infinity ⇒ not (x < y)
			then
				Result := True
			end
		end

	is_less_equal_ok (x, y, z: STS_REAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_REAL_NUMBER}.is_less_equal?
		do
			check
				reflexive: x ≤ x
				transitive: x ≤ y and y ≤ z ⇒ x ≤ z
				antisymmetric: x ≤ y and y ≤ x ⇒ x ≍ y
				nan: x.is_nan ⇒ x ≤ y
				negative_infinity: x.is_negative_infinity ⇒ ((x ≤ y) = not y.is_nan)
				positive_infinity: x.is_positive_infinity ⇒ ((x ≤ y) = y.is_positive_infinity)
			then
				Result := True
			end
		end

	is_greater_ok (x, y, z: STS_REAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_REAL_NUMBER}.is_greater?
		do
			check
				irreflexive: not (x > x)
				transitive: x > y and y > z ⇒ x > z
				nan: x.is_nan ⇒ not (x > y)
				negative_infinity: x.is_negative_infinity ⇒ ((x > y) = y.is_nan)
				positive_infinity: x.is_positive_infinity ⇒ (x > y or y.is_positive_infinity)
			then
				Result := True
			end
		end

	is_greater_equal_ok (x, y, z: STS_REAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_REAL_NUMBER}.is_greater_equal?
		do
			check
				reflexive: x ≥ x
				transitive: x ≥ y and y ≥ z ⇒ x ≥ z
				antisymmetric: x ≥ y and y ≥ x ⇒ x ≍ y
				nan: x.is_nan ⇒ ((x ≥ y) = y.is_nan)
				negative_infinity: x.is_negative_infinity ⇒ ((x ≥ y) = (y.is_nan or y.is_negative_infinity))
				positive_infinity: x.is_positive_infinity ⇒ x ≥ y
			then
				Result := True
			end
		end

	three_way_comparison_ok (x, y, z: STS_REAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_REAL_NUMBER}.is_greater_equal?
		do
			check
				reflexive_equality: zero ≍ (x ⋚ x)
				symmetric_equality: zero ≍ (x ⋚ y) ⇒ zero ≍ (y ⋚ x)
				transitive_equality: zero ≍ (x ⋚ y) and zero ≍ (y ⋚ z) ⇒ zero ≍ (x ⋚ z)

				reflexive_comparison: zero ≥ (x ⋚ x)
				transitive_comparison: zero ≥ (x ⋚ y) and zero ≥ (y ⋚ z) ⇒ zero ≥ (x ⋚ z)
				antisymmetric_comparison: zero ≥ (x ⋚ y) and zero ≥ (y ⋚ x) ⇒ x ≍ y

				irreflexive_strict_comparison: zero ≍ (x ⋚ x)
				transitive_strict_comparison: zero > (x ⋚ y) and zero > (y ⋚ z) ⇒ zero > (x ⋚ z)

				dual_reflexive_comparison: zero ≤ (x ⋚ x)
				dual_transitive_comparison: zero ≤ (x ⋚ y) and zero ≤ (y ⋚ z) ⇒ zero ≤ (x ⋚ z)
				dual_antisymmetric_comparison: zero ≤ (x ⋚ y) and zero ≤ (y ⋚ x) ⇒ x ≍ y

				dual_irreflexive_strict_comparison: zero ≍ (x ⋚ x)
				dual_transitive_strict_comparison: zero < (x ⋚ y) and zero < (y ⋚ z) ⇒ zero < (x ⋚ z)

				nan_y: x.is_nan ⇒ zero ≥ (x ⋚ y)
				nan_nan: x.is_nan ⇒ (zero ≍ (x ⋚ y) = y.is_nan)

				negative_infinity_nan: x.is_negative_infinity and y.is_nan ⇒ (zero < (x ⋚ y))
				negative_infinity_y: x.is_negative_infinity and not y.is_nan ⇒ (zero ≥ (x ⋚ y))

				positive_infinity: x.is_positive_infinity ⇒ (zero ≤ (x ⋚ y))
			then
				Result := True
			end
		end

	min_ok (x, y, z: STS_REAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_REAL_NUMBER}.min?
		do
			check
				idempotent: (x ∧ x) ≍ x
				commutative: (x ∧ y) ≍ (y ∧ x)
				associative: ((x ∧ y) ∧ z) ≍ (x ∧ (y ∧ z))
				absolute_minimum: x.is_nan ⇒ (x ∧ y).is_nan
			then
				Result := True
			end
		end

	max_ok (x, y, z: STS_REAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_REAL_NUMBER}.max?
		do
			check
				idempotent: (x ∨ x) ≍ x
				commutative: (x ∨ y) ≍ (y ∨ x)
				associative: ((x ∨ y) ∨ z) ≍ (x ∨ (y ∨ z))
				absolute_maximum: x.is_positive_infinity ⇒ (x ∨ y).is_positive_infinity
			then
				Result := True
			end
		end

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

feature -- Properties (Math)

	splitted_ok (x: STS_REAL_NUMBER; q: STS_INTEGER_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STS_REAL_NUMBER}.splitted?
		do
			check
				when_intinite: x.is_infinite ⇒ x.splitted (q).a ≍ x and x.splitted (q).b ≍ q
				when_nan: x.is_nan ⇒ x.splitted (q).a.is_nan and x.splitted (q).b ≍ q
				trivial_rational_splitting: x.is_rational ⇒
					x.splitted (one).a.abs ≍ x.to_rational.p.rational_abs and x.splitted (one).b.abs ≍ x.to_rational.q.rational_abs
				trivial_integer_splitting: x.is_integer ⇒ x.splitted (one).a ≍ x and x.splitted (one).b ≍ one
			then
				Result := True
			end
		end

feature -- Anchor

	real_anchor: STS_REAL_NUMBER
			-- Anchor for real naumbers
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
