note
	description: "Implementation of {STST_REAL_NUMBER_PROPERTIES}."
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	REAL_NUMBER_PROPERTIES

inherit
	STST_REAL_NUMBER_PROPERTIES
		redefine
--			multipliable_ok
		end

feature -- Access

	zero: STI_REAL_NUMBER
			-- Representation of the real number 0
		once
			Result := {REAL} 0.0
		ensure then
			class
		end

	One: STI_REAL_NUMBER
			-- <Precursor>
			--| TODO: Feature tool cannot show the inherited post-conditions.
			--| TODO: What about the invariants?
		once
			Result := {REAL} 1.0
		ensure then
			class
		end

feature -- Properties (Relationship)

--	multipliable_ok (x, y: STS_REAL_NUMBER): BOOLEAN
--			-- Do the properties verified within number theory hold for {STI_REAL_NUMBER}.multipliable?
--		do
--			if Precursor {STST_REAL_NUMBER_PROPERTIES} (x, y) then
--				check
--					gcd_1: attached gcd (y.p, x.q) as gcd_1
--					gcd_2: attached gcd (x.p, y.q) as gcd_2
--					good_divisor_1: x.q.divisible (gcd_1) -- gcd_1 /= 0 ⇐ x.q /= 0
--					good_divisor_2: y.q.divisible (gcd_2) -- gcd_2 /= 0 ⇐ y.q /= 0
--					accepted_overflow:
--						{STI_REAL_NUMBER}.integer_product_overflows (x.q // gcd_1, y.q // gcd_2) and (x.q // gcd_1) ⋅ (y.q // gcd_2) ≭ Zero.p ⇒
--						x.multipliable (y)
--				then
--					Result := True
--				end
--			end
--		end

--	divisible_ok (x: STI_REAL_NUMBER; y: STS_REAL_NUMBER): BOOLEAN
--			-- Do the properties verified within number theory hold for {STI_REAL_NUMBER}.divisible?
--		do
--			check
--				good_divisor_1: x.q.divisible (gcd (y.q, x.q)) -- y.q, x.q /= 0
--				good_divisor_2: y.p ≭ Zero.p ⇒ y.p.divisible (gcd (x.p, y.p))
--				when_divisible: x.divisible (y) ⇒
--					y.p ≭ Zero.p and then ((x.q // gcd (y.q, x.q)) ⋅ (y.p // gcd (x.p, y.p))) ≭ Zero.p
--			then
--				Result := True
--			end
--		end

feature -- Properties (Implementation)

	sign_bit_status_ok (x: REAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STI_REAL_NUMBER}.sign_bit_status?
		do
			check
				two_states: x.sign_bit_status = 0 or x.sign_bit_status = 1
				when_nan: x.value.is_nan ⇒ x.sign_bit_status = 0 or x.sign_bit_status = 1
				when_negative: not x.value.is_nan and x.value < 0 ⇒ x.sign_bit_status = 1
--				when_negative_zero: x.value.is_negative_zero ⇒ x.sign_bit_status = 1
--				when_positive_zero: x.value.is_positive_zero ⇒ x.sign_bit_status = 0
				when_positive: 0 < x.value ⇒ x.sign_bit_status = 0
			then
				Result := True
			end
		end

	exponent_bit_pattern_ok (x: REAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STI_REAL_NUMBER}.exponent_bit_pattern?
		local
			x_abs: REAL_NUMBER
		do
			x_abs := x.value.abs
			check
				when_nan: x.value.is_nan ⇒ x.exponent_bit_pattern = (2 ^ {REAL_NUMBER}.Exponent_width - 1)
				when_negative: not x.value.is_nan and x.value < 0 ⇒ x.exponent_bit_pattern = x_abs.exponent_bit_pattern
				when_zero: x.value = 0 ⇒ x.exponent_bit_pattern = 0
--				when_subnormal: Zero < x.value.abs and x.value.abs < {STI_REAL_NUMBER}.epsilon ⇒ x.exponent_bit_pattern = 0
--				when_normal: {STI_REAL_NUMBER}.epsilon ≤ x.abs and x.is_finite ⇒
--					x.exponent_bit_pattern = {STI_REAL_NUMBER}.value_logb (x.value) + {REAL_NUMBER}.Exponent_bias
				when_infinite: x.value = {REAL}.negative_infinity or x.value = {REAL}.positive_infinity ⇒
					x.exponent_bit_pattern = (2 ^ {REAL_NUMBER}.Exponent_width - 1)
			then
				Result := True
			end
		end

	mantissa_bit_pattern_ok (x: REAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STI_REAL_NUMBER}.mantissa_bit_pattern?
		local
			x_abs: REAL_NUMBER
		do
			x_abs := x.value.abs
			check
				when_nan: x.value.is_nan ⇒ x.mantissa_bit_pattern /= 0
				when_negative: not x.value.is_nan and x.value < 0 ⇒ x.mantissa_bit_pattern = x_abs.mantissa_bit_pattern
				when_zero: x.value = 0 ⇒ x.mantissa_bit_pattern = 0
--				when_subnormal: Zero < x.value.abs and x.value.abs < {STI_REAL_NUMBER}.epsilon ⇒
--					0 < x.mantissa_bit_pattern and x.mantissa_bit_pattern <= {REAL_NUMBER}.Max_mantissa
--				when_normal: {STI_REAL_NUMBER}.epsilon ≤ x.abs and x.is_finite ⇒
--					0 <= x.mantissa_bit_pattern and x.mantissa_bit_pattern <= {REAL_NUMBER}.Max_mantissa
				when_infinite: x.value = {REAL}.negative_infinity or x.value = {REAL}.positive_infinity ⇒ x.mantissa_bit_pattern = 0
			then
				Result := True
			end
		end

feature -- Anchor

	real_anchor: STI_REAL_NUMBER
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
