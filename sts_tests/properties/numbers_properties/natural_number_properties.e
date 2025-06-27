note
	description: "Object that checks whether the properties verified within set theory hold for an implementation of {STS_NATURAL_NUMBER}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NATURAL_NUMBER_PROPERTIES

feature -- Properties (Membership)

	is_not_in_ok (l: STS_NATURAL_NUMBER; s: STS_SET [STS_NATURAL_NUMBER]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_NATURAL_NUMBER}.is_not_in?
		do
			check
				another_definition: l ∉ s = s ∌ l
			then
				Result := True
			end
		end

feature -- Properties (Comparison)

	equals_ok (n, m, l: STS_NATURAL_NUMBER): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_NATURAL_NUMBER}.equals?
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
			-- Do the properties verified within set theory hold for {STS_NATURAL_NUMBER}.unequals?
		do
			check
				alternate_definition: n ≭ m = (n.value /= m.value)
				irreflexive: not (n ≭ n)
			then
				Result := True
			end
		end

	is_less_ok (n, m, l: STS_NATURAL_NUMBER): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_NATURAL_NUMBER}.is_less?
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
			-- Do the properties verified within set theory hold for {STS_NATURAL_NUMBER}.is_less_equal?
		do
			check
				reflexive: n ≤ n
				transitive: n ≤ m and m ≤ l implies n ≤ l
				antisymmetric: n ≤ m and m ≤ n implies n ≍ m
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
