note
	description: "Mutable implementation the the concept of a mathematica set"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	MUTABLE_SET [A, EQ -> STS_EQUALITY [A] create default_create end]

inherit {NONE}
		-- NOTICE: Non-conformant inheritance. We don't want a mutable set mistakenly used as if it was an immutable one.
	STS_SET [A, EQ]
		redefine
			reduced
		end

feature -- Primitive

	is_empty: BOOLEAN
			-- <Precursor>
		do
			Result := elements.is_empty
		end

	any: A
			-- <Precursor>
		do
			Result := elements [1]
		end

	others: like subset_anchor
			-- <Precursor>
		do
			across
				2 |..| elements.count as i
			from
				Result := o
			loop
				Result := Result & elements [i]
			end
		end

	eq: EQ
			-- <Precursor>
		attribute
			create Result
		end

feature -- Construction

	with alias "&" (a: A): like superset_anchor
			-- <Precursor>
		do
			across
				elements as x
			from
				Result := singleton (a)
			loop
				if not eq (a, x) then
					Result := Result & x
				end
			end
		end

	without alias "/" (a: A): like subset_anchor
			-- <Precursor>
		do
			across
				elements as x
			from
				Result := o
			loop
				if not eq (a, x) then
					Result := Result & x
				end
			end
		end

feature -- Operation

	filtered alias "|" (p: PREDICATE [A]): like subset_anchor
			-- <Precursor>
		do
			across
				elements as x
			from
				Result := o
			loop
				if p (x) then
					Result := Result & x
				end
			end
		end

	united alias "∪" (s: STS_SET [A, EQ]): like superset_anchor
			-- <Precursor>
		do
			across
				elements as x
			from
				Result := o.converted (s)
			loop
				Result := Result & x
			end
		end

feature -- Transformation

	reduced (leftmost: A; f: FUNCTION [A, A, A]): A
			-- <Precursor>
		do
			across
				elements as x
			from
				Result := leftmost
			loop
				Result := f (Result, x)
			end
		end

feature -- Factory

	o: like subset_anchor
			-- <Precursor>
		attribute
			create Result.make_empty
		end

	empty_set: like subset_anchor
			-- <Precursor>
		do
			Result := o
		end

	singleton (a: A): like set_anchor
			-- <Precursor>
		do
			create Result.make_singleton (a)
		end

feature -- Transformer

	transformer_to_element: STI_TRANSFORMER [A, A, EQ]
			-- <Precursor>
		do
			create Result
		end

	transformer_to_boolean: STI_TRANSFORMER [A, BOOLEAN, STS_OBJECT_EQUALITY [BOOLEAN]]
			-- <Precursor>
		do
			create Result
		end

	transformer_to_natural: STI_TRANSFORMER [A, like natural_anchor, STS_OBJECT_EQUALITY [like natural_anchor]]
			-- <Precursor>
		do
			create Result
		end

feature -- Anchor

	set_anchor,
	subset_anchor,
	superset_anchor,
	set_map_anchor: STI_SET [A, EQ]
			-- <Precursor>
		do
			Result := o
		end

feature {NONE} -- Implementation

	elements: ARRAY [A]
			-- Container of the elements of current set
		attribute
			create Result.make_empty
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/Set-Theory"
end
