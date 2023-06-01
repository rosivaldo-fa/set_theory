note
	description: "Implementation of {STS_TRANSFORMER}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	TRANSFORMER [
		A, B,
		EQ_A -> STS_EQUALITY [A] create default_create end, -- TODO: It may be unecessary.
		EQ_B -> STS_EQUALITY [B] create default_create end
		]

inherit
	STS_TRANSFORMER [A, B, EQ_A, EQ_B]
		redefine
			set_reduction
		end

feature -- Access

	eq_b: EQ_B
			-- <Precursor>
		do
			create Result
		end

feature -- Transformation

	set_reduction (xs: STS_SET [A, STS_EQUALITY [A]]; start: B; f: FUNCTION [B, A, B]): B
			-- <Precursor>
		local
			l_xs: STS_SET [A, STS_EQUALITY [A]]
		do
			from
				Result := start
				l_xs := xs
			invariant
--				building_up: eq_b (Result, tuple_left_reduction (xs.as_tuple.right_trimmed (# l_xs), start, f))
					-- NOTICE: This invariant assumes that `xs'.`as_tuple' is implemented like in {STI_SET}.
			until
				l_xs.is_empty
			loop
				Result := f (Result, l_xs.any)
				l_xs := l_xs.others
--			variant
--				cardinality: natural_as_integer (# l_xs)
			end
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo Fernandes Alves"
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	source: ""
end
