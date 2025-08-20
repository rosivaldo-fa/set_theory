note
	description: "Test suite for {STS_INTEGER_NUMBER}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

deferred class
	INTEGER_NUMBER_TESTS

inherit
	ELEMENT_TESTS
		rename
			is_not_in_ok as element_is_not_in_ok,
			test_is_in as test_element_is_in,
			test_is_not_in as test_element_is_not_in,
			element_to_be_tested as integer_number_to_be_tested
		redefine
			test_all,
			integer_number_to_be_tested
		end

	INTEGER_NUMBER_PROPERTIES

feature -- Test routines (All)

	test_all
			-- Test every routine of {STS_INTEGER_NUMBER}.
		note
			testing: "covers/{STS_INTEGER_NUMBER}"
		do
			Precursor {ELEMENT_TESTS}
			test_value
			test_is_in
			test_is_not_in
			test_zero
			test_one
			test_min_value
			test_equals
			test_unequals
			test_is_less
			test_is_less_equal
			test_is_greater
			test_is_greater_equal
			test_three_way_comparison
			test_min
			test_max
			test_divides
			test_divisible
			test_modulus
			test_abs
			test_plus
			test_identity
			test_minus
			test_opposite
			test_product
			test_integer_quotient
			test_integer_remainder
			test_adjusted_value
		end

feature -- Test routines (Primitive)

	test_value
			-- Test {STS_INTEGER_NUMBER}.value.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.value"
		do
			assert ("value", attached integer_number_to_be_tested.value)
		end

feature -- Test routines (Membership)

	test_is_in
			-- Test {STS_INTEGER_NUMBER}.is_in.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.is_in"
		local
			i: like integer_number_to_be_tested
			s: like some_set_i
		do
			i := integer_number_to_be_tested
			s := some_set_i.extended (i, some_equality_i)
			assert ("i ∈ s", i ∈ s)

			i := integer_number_to_be_tested
			s := some_set_i.prunned (i)
			assert ("not (i ∈ s)", not (i ∈ s))

			i := integer_number_to_be_tested
			s := some_set_i
			assert ("is_in", i ∈ s ⇒ True)
		end

	test_is_not_in
			-- Test {STS_INTEGER_NUMBER}.is_not_in.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.is_not_in"
		local
			i: like integer_number_to_be_tested
			s: like some_set_i
		do
			i := integer_number_to_be_tested
			s := some_set_i.prunned (i)
			assert ("i ∉ s", i ∉ s)
			assert ("i ∉ s ok", is_not_in_ok (i, s))

			i := integer_number_to_be_tested
			s := some_set_i.extended (i, some_equality_i)
			assert ("not (i ∉ s)", not (i ∉ s))
			assert ("not (i ∉ s) ok", is_not_in_ok (i, s))

			i := integer_number_to_be_tested
			s := some_set_i
			assert ("is_not_in", i ∉ s ⇒ True)
			assert ("is_not_in_ok", is_not_in_ok (i, s))
		end

feature -- Test routines (Quality)

	test_min_value_exists
			-- Test {STS_INTEGER_NUMBER}.min_value_exists.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.min_value_exists"
		do
			assert ("min_value_exists", integer_number_to_be_tested.min_value_exists ⇒ True)
		end

	test_max_value_exists
			-- Test {STS_INTEGER_NUMBER}.max_value_exists.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.max_value_exists"
		do
			assert ("max_value_exists", integer_number_to_be_tested.max_value_exists ⇒ True)
		end

feature -- Test routines (Access)

	test_zero
			-- Test {STS_INTEGER_NUMBER}.zero.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.zero"
		do
			assert ("zero", attached integer_number_to_be_tested.Zero)
		end

	test_one
			-- Test {STS_INTEGER_NUMBER}.one.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.one"
		do
			assert ("one", attached integer_number_to_be_tested.One)
		end

	test_min_value
			-- Test {STS_INTEGER_NUMBER}.min_value.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.min_value"
		do
			assert ("min_value", attached integer_number_to_be_tested.Min_value)
		end

feature -- Test routines (Comparison)

	test_equals
			-- Test {STS_INTEGER_NUMBER}.equals.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.equals"
		local
			i: like integer_number_to_be_tested
			j: like some_integer_number
		do
			i := integer_number_to_be_tested
			assert ("same entity", i ≍ i)
			assert ("same entity ok", equals_ok (i, i, i))

			i := integer_number_to_be_tested
			j := same_integer_number (i)
			assert ("same_integer_number", i ≍ j)
			assert ("same_integer_number ok", equals_ok (i, j, same_integer_number (j)))

			from
				i := integer_number_to_be_tested
				j := some_integer_number
			until
				j.value /= i.value
			loop
				j := some_integer_number
			end
			assert ("not (i ≍ j)", not (i ≍ j))
			assert ("not (i ≍ j) ok", equals_ok (i, j, some_integer_number))

			i := integer_number_to_be_tested
			j := some_integer_number
			assert ("equals", i ≍ j ⇒ True)
			assert ("equals ok", equals_ok (i, j, some_integer_number))
		end

	test_unequals
			-- Test {STS_INTEGER_NUMBER}.unequals.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.unequals"
		local
			i: like integer_number_to_be_tested
			j: like some_integer_number
		do
			i := integer_number_to_be_tested
			assert ("same entity", not (i ≭ i))
			assert ("same entity ok", unequals_ok (i, i))

			i := integer_number_to_be_tested
			j := same_integer_number (i)
			assert ("same_integer_number", not (i ≭ i))
			assert ("same_integer_number ok", unequals_ok (i, j))

			from
				i := integer_number_to_be_tested
				j := some_integer_number
			until
				j.value /= i.value
			loop
				j := some_integer_number
			end
			assert ("i ≭ j", i ≭ j)
			assert ("i ≭ j ok", unequals_ok (i, j))

			i := integer_number_to_be_tested
			j := some_integer_number
			assert ("unequals", i ≍ j ⇒ True)
			assert ("unequals ok", unequals_ok (i, j))
		end

	test_is_less
			-- Test {STS_INTEGER_NUMBER}.is_less.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.is_less"
		local
			i: like integer_number_to_be_tested
			j: like some_integer_number
		do
			from
				i := integer_number_to_be_tested
				j := some_integer_number
			until
				i.value < j.value
			loop
				i := integer_number_to_be_tested
				j := some_integer_number
			end
			assert ("i < j", i < j)
			assert ("i < j ok", is_less_ok (i, j, some_integer_number))

			from
				i := integer_number_to_be_tested
				j := some_integer_number
			until
				i.value ≥ j.value
			loop
				i := integer_number_to_be_tested
				j := some_integer_number
			end
			assert ("not (i < j)", not (i < j))
			assert ("not (i < j) ok", is_less_ok (i, j, some_integer_number))

			i := integer_number_to_be_tested
			j := some_integer_number
			assert ("is_less", i < j ⇒ True)
			assert ("is_less ok", is_less_ok (i, j, some_integer_number))
		end

	test_is_less_equal
			-- Test {STS_INTEGER_NUMBER}.is_less_equal.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.is_less_equal"
		local
			i: like integer_number_to_be_tested
			j: like some_integer_number
		do
			from
				i := integer_number_to_be_tested
				j := some_integer_number
			until
				i.value ≤ j.value
			loop
				i := integer_number_to_be_tested
				j := some_integer_number
			end
			assert ("i ≤ j", i ≤ j)
			assert ("i ≤ j ok", is_less_equal_ok (i, j, some_integer_number))

			from
				i := integer_number_to_be_tested
				j := some_integer_number
			until
				i.value > j.value
			loop
				i := integer_number_to_be_tested
				j := some_integer_number
			end
			assert ("not (i ≤ j)", not (i ≤ j))
			assert ("not (i ≤ j) ok", is_less_equal_ok (i, j, some_integer_number))

			i := integer_number_to_be_tested
			j := some_integer_number
			assert ("is_less_equal", i ≤ j ⇒ True)
			assert ("is_less_equal_ok", is_less_equal_ok (i, j, some_integer_number))
		end

	test_is_greater
			-- Test {STS_INTEGER_NUMBER}.is_greater.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.is_greater"
		local
			i: like integer_number_to_be_tested
			j: like some_integer_number
		do
			from
				i := integer_number_to_be_tested
				j := some_integer_number
			until
				i.value > j.value
			loop
				i := integer_number_to_be_tested
				j := some_integer_number
			end
			assert ("i > j", i > j)
			assert ("i > j ok", is_greater_ok (i, j, some_integer_number))

			from
				i := integer_number_to_be_tested
				j := some_integer_number
			until
				i.value ≤ j.value
			loop
				i := integer_number_to_be_tested
				j := some_integer_number
			end
			assert ("not (i > j)", not (i > j))
			assert ("not (i > j) ok", is_greater_ok (i, j, some_integer_number))

			i := integer_number_to_be_tested
			j := some_integer_number
			assert ("is_greater", i > j ⇒ True)
			assert ("is_greater ok", is_greater_ok (i, j, some_integer_number))
		end

	test_is_greater_equal
			-- Test {STS_INTEGER_NUMBER}.is_greater_equal.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.is_greater_equal"
		local
			i: like integer_number_to_be_tested
			j: like some_integer_number
		do
			from
				i := integer_number_to_be_tested
				j := some_integer_number
			until
				i.value ≥ j.value
			loop
				i := integer_number_to_be_tested
				j := some_integer_number
			end
			assert ("i ≥ j", i ≥ j)
			assert ("i ≥ j ok", is_greater_equal_ok (i, j, some_integer_number))

			from
				i := integer_number_to_be_tested
				j := some_integer_number
			until
				i.value < j.value
			loop
				i := integer_number_to_be_tested
				j := some_integer_number
			end
			assert ("not (i ≥ j)", not (i ≥ j))
			assert ("not (i ≥ j) ok", is_greater_equal_ok (i, j, some_integer_number))

			i := integer_number_to_be_tested
			j := some_integer_number
			assert ("is_greater_equal", i ≥ j ⇒ True)
			assert ("is_greater_equal_ok", is_less_equal_ok (i, j, some_integer_number))
		end

	test_three_way_comparison
			-- Test {STS_INTEGER_NUMBER}.three_way_comparison.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.three_way_comparison"
		local
			i: like integer_number_to_be_tested
			j: like some_integer_number
		do
			from
				i := integer_number_to_be_tested
				j := some_integer_number
			until
				i < j
			loop
				i := integer_number_to_be_tested
				j := some_integer_number
			end
			assert ("negative", i ⋚ j ≍ - One)

			i := integer_number_to_be_tested
			assert ("same_entity", i ⋚ i ≍ Zero)
			assert ("same_integer_number", i ⋚ same_integer_number (i) ≍ Zero)

			from
				i := integer_number_to_be_tested
				j := some_integer_number
			until
				i > j
			loop
				i := integer_number_to_be_tested
				j := some_integer_number
			end
			assert ("positive", i ⋚ j ≍ One)

			i := integer_number_to_be_tested
			j := some_integer_number
			assert ("three_way_comparison", attached (i ⋚ j))
		end

	test_min
			-- Test {STS_INTEGER_NUMBER}.min.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.min"
		local
			i: like integer_number_to_be_tested
			j: like some_integer_number
		do
			from
				i := integer_number_to_be_tested
				j := some_integer_number
			until
				i ≤ j
			loop
				i := integer_number_to_be_tested
				j := some_integer_number
			end
			assert ("i", (i ∧ j) ≍ i)
			assert ("i ok", min_ok (i, j, some_integer_number))

			from
				i := integer_number_to_be_tested
				j := some_integer_number
			until
				i ≥ j
			loop
				i := integer_number_to_be_tested
				j := some_integer_number
			end
			assert ("j", (i ∧ j) ≍ j)
			assert ("j ok", min_ok (i, j, some_integer_number))

			i := integer_number_to_be_tested
			j := some_integer_number
			assert ("min", attached (i ∧ j))
			assert ("min ok", min_ok (i, j, some_integer_number))
		end

	test_max
			-- Test {STS_INTEGER_NUMBER}.max.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.max"
		local
			i: like integer_number_to_be_tested
			j: like some_integer_number
		do
			from
				i := integer_number_to_be_tested
				j := some_integer_number
			until
				i ≥ j
			loop
				i := integer_number_to_be_tested
				j := some_integer_number
			end
			assert ("i", (i ∨ j) ≍ i)
			assert ("i ok", max_ok (i, j, some_integer_number))

			from
				i := integer_number_to_be_tested
				j := some_integer_number
			until
				i ≤ j
			loop
				i := integer_number_to_be_tested
				j := some_integer_number
			end
			assert ("j", (i ∨ j) ≍ j)
			assert ("j ok", max_ok (i, j, some_integer_number))

			i := integer_number_to_be_tested
			j := some_integer_number
			assert ("max", attached (i ∨ j))
			assert ("max ok", max_ok (i, j, some_integer_number))
		end

feature -- Test routines (Relationship)

	test_divides
			-- Test {STS_INTEGER_NUMBER}.divides.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.divides"
		local
			i: like integer_number_to_be_tested
			j: like some_integer_number
		do
			from
				i := integer_number_to_be_tested
			until
				i ≭ One
			loop
				i := integer_number_to_be_tested
			end
			j := (some_integer_number ⋅ i) + One
			assert ("not (i | j)", not (i | j))
			assert ("not (i | j) ok", divides_ok (i, j, some_integer_number))

			i := integer_number_to_be_tested
			j := some_integer_number
			assert ("divides", (i | j) ⇒ True)
			assert ("divides_ok", divides_ok (i, j, some_integer_number))
		end

	test_divisible
			-- Test {STS_INTEGER_NUMBER}.divisible.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.divisible"
		local
			i: like integer_number_to_be_tested
			j: like some_integer_number
		do
			from
				i := integer_number_to_be_tested
				j := some_integer_number
			until
				j ≭ zero
			loop
				j := some_integer_number
			end
			assert ("i.divisible (j)", i.divisible (j))

			i := integer_number_to_be_tested
			j := some_integer_number.zero
			assert ("not i.divisible (j)", not i.divisible (j))

			i := integer_number_to_be_tested
			j := some_integer_number
			assert ("divisible", i.divisible (j) ⇒ True)
		end

feature -- Test routines (Operation)

	test_modulus
			-- Test {STS_INTEGER_NUMBER}.modulus.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.modulus"
		local
			i: like integer_number_to_be_tested
		do
			i := integer_number_to_be_tested
			assert ("modulus", attached i.modulus)
			assert ("modulus_ok", modulus_ok (i))
		end

	test_abs
			-- Test {STS_INTEGER_NUMBER}.abs.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.abs"
		local
			i: like integer_number_to_be_tested
		do
			i := integer_number_to_be_tested
			assert ("abs", attached i.abs)
			assert ("abs_ok", abs_ok (i))
		end

	test_plus
			-- Test {STS_INTEGER_NUMBER}.plus.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.plus"
		local
			i: like integer_number_to_be_tested
			j: like some_integer_number
		do
			i := integer_number_to_be_tested
			j := some_integer_number
			assert ("plus", attached (i + j))
			assert ("plus_ok", plus_ok (i, j, some_integer_number))
		end

	test_identity
			-- Test {STS_INTEGER_NUMBER}.identity.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.identity"
		local
			i: like integer_number_to_be_tested
		do
			i := integer_number_to_be_tested
			assert ("identity", attached (+ i))
			assert ("identity_ok", identity_ok (i))
		end

	test_minus
			-- Test {STS_INTEGER_NUMBER}.minus.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.minus"
		local
			i: like integer_number_to_be_tested
			j: like some_integer_number
		do
			i := integer_number_to_be_tested
			j := some_integer_number
			assert ("minus", attached (i - j))
			assert ("minus ok", minus_ok (i, j, some_integer_number))
		end

	test_opposite
			-- Test {STS_INTEGER_NUMBER}.opposite.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.opposite"
		local
			i: like integer_number_to_be_tested
		do
			i := integer_number_to_be_tested
			assert ("opposite", attached (- i))
			assert ("opposite_ok", opposite_ok (i))
		end

	test_product
			-- Test {STS_INTEGER_NUMBER}.product.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.product"
		local
			i: like integer_number_to_be_tested
			j: like some_integer_number
		do
			i := integer_number_to_be_tested
			j := some_integer_number
			assert ("product", attached (i ⋅ j))
			assert ("product ok", product_ok (i, j, some_integer_number))
		end

	test_integer_quotient
			-- Test {STS_INTEGER_NUMBER}.integer_quotient.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.integer_quotient"
		local
			i: like integer_number_to_be_tested
			j: like some_integer_number
		do
			from
				i := integer_number_to_be_tested
				j := some_integer_number
			until
				i.divisible (j)
			loop
				j := some_integer_number
			end
			assert ("integer_quotient", attached (i // j))
			assert ("integer_quotient ok", integer_quotient_ok (i, j))
		end

	test_integer_remainder
			-- Test {STS_INTEGER_NUMBER}.integer_remainder.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.integer_remainder"
		local
			i: like integer_number_to_be_tested
			j: like some_integer_number
		do
			from
				i := integer_number_to_be_tested
				j := some_integer_number
			until
				i.divisible (j)
			loop
				j := some_integer_number
			end
			assert ("integer_remainder", attached (i \\ j))
			assert ("integer_remainder ok", integer_remainder_ok (i, j))
		end

feature -- Test routines (Implementation)

	test_adjusted_value
			-- Test {STS_INTEGER_NUMBER}.adjusted_value.
		note
			testing: "covers/{STS_INTEGER_NUMBER}.adjusted_value"
		do
			assert ("adjusted_value", attached integer_number_to_be_tested.adjusted_value (next_random_item))
		end

feature {NONE} -- Factory (element to be tested)

	integer_number_to_be_tested: like some_immediate_integer_number
			-- Integer number meant to be under tests
		do
			Result := some_immediate_integer_number
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
