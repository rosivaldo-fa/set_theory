note
	description: "Implementation of {STS_SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	SET [A, EQ -> STS_EQUALITY [A] create default_create end]

inherit
	STS_SET [A, EQ]
		redefine
			subset_anchor
		end

create
	make_empty,
	make_singleton

feature {NONE} -- Initialization

	make_empty
			-- Create an empty set, i.e. {} or ∅.
		do
			others := Current
		ensure
			is_empty: is_empty
		end

	make_singleton (a: A)
			-- Create a singleton in the form {`a'}.
		do
			create others.make_empty
			create any_storage.put (converted_element (a))
		ensure
			is_not_empty: not is_empty
			any: eq (any, a)
			others: others.is_empty
		end

feature -- Primitive

	is_empty: BOOLEAN
			-- <Precursor>
		do
			Result := not attached any_storage
		ensure then
			definition: Result = not attached any_storage
		end

	any: like any_anchor
			-- <Precursor>
		do
			check
				attached_stored_any: attached any_storage -- not `is_empty'
			then
				Result := any_storage.item
			end
		ensure then
			attached_stored_any: attached any_storage -- not `is_empty'
			definition: Result ~ any_storage.item
		end

	others: like subset_anchor
			-- <Precursor>

	eq: EQ
			-- <Precursor>
			--| `eq' must be created on demand, otherwise a set would have an equality object for each of its elements - a huge space wasting. On descendants
			--| where the type of `eq' may be locally defined, i.e. it is not just a generic parameter, `eq' may be turned into a once query.
		do
			create Result
		ensure then
			class
		end

feature -- Factory

	converted_element (a: A): like any_anchor
			-- `a' converted to an element like `any'
		do
			Result := a
		ensure
			definition: eq (Result, a)
		end

feature -- Transformer

	transformer_to_boolean: TRANSFORMER [A, BOOLEAN, EQ, STS_OBJECT_EQUALITY [BOOLEAN]]
			-- <Precursor>
		do
			create Result
		ensure then
			class
		end

feature -- Anchor

	any_anchor: A
			-- Anchor for objects like `any'
		require
			is_not_empty: not is_empty
		do
			Result := any
		end

	subset_anchor: SET [A, EQ]
			-- <Precursor>
		do
			Result := Current
		end

feature {NONE} -- Implementation

	any_storage: detachable CELL [like any_anchor]
			-- Storage for `any'
		note
			option: stable
		attribute
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo Fernandes Alves"
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	source: ""
end
