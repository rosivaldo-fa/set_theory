note
	description: "Implementation of {STS_SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	SET [G]

inherit
	STS_SET [G]
		redefine
			out
		end

	DEBUG_OUTPUT
		rename
			debug_output as out
		redefine
			out
		end

create
	default_create,
	make_extended

feature {NONE} -- Initialization

	make_extended (a: G; a_eq: STS_EQUALITY [G]; s: SET [G])
			-- Create a set whose `given_element' element and `subset' are, respectively, `a' and `s'.
		do
			eq := a_eq
			subset := s
			create given_element_storage.put (a)
		ensure
			attached_storage: attached given_element_storage
			attached_eq: attached eq
			given_element: eq (given_element, a)
			subset: subset = s -- TODO: Use set equality instead.
		end

feature -- Membership

	has alias "∋" (a: G): BOOLEAN
			-- <Precursor>
		do
			Result := attached eq and then eq (a, given_element) or subset /= Current and then subset ∋ a
		end

feature -- Construction

	extended (a: G; a_eq: STS_EQUALITY [G]): like superset_anchor
			-- <Precursor>
		do
			create Result.make_extended (a, a_eq, Current)
		ensure then
			equality: Result.eq = a_eq
			given_element: a_eq (Result.given_element, a)
			subset: Result.subset = Current -- TODO: Use set equality instead.
		end

	prunned (a: G): like subset_anchor
			-- <Precursor>
		do
			if not attached eq then
				Result := Current
			elseif eq (a, given_element) then
				Result := subset.prunned (a)
			else
				Result := subset.prunned (a).extended (given_element, eq)
			end
		ensure then
			when_empty: not attached eq ⇒ Result = Current -- TODO: Use set equality instead.
--			when_found: attached eq and then eq (a, given_element) ⇒ Result ≍ subset.prunned (a)
--			when_not_found: attached eq and then not eq (a, given_element) ⇒ Result ≍ subset.prunned (a).extended (given_element, eq)
		end

feature -- Output

	out: STRING
			-- <Precursor>
		local
			s: SET [G]
		do
			Result := "{"
			if Current /= subset then
				from
					Result.append (element_out (given_element))
					s := subset
				invariant
--					building_up: Result ~ {TRANSFORMER [A, STRING, EQ, STS_OBJECT_EQUALITY [STRING]]}.tuple_indexed_left_reduction (right_trimmed (s.n), "", 1, agent appending_term_out)
				until
					Current = subset
				loop
					Result.append_character (',')
					check
						other_arguments_not_void: element_out (s.given_element) /= Void -- `element_out' definition
					end
					Result.append (element_out (s.given_element))
					s := s.subset
--				variant
--					n: natural_as_integer (# s)
				end
			end
			Result.append_character ('}')
		ensure then
			base: Current = subset ⇒ Result ~ "{}"
			induction: Current /= subset ⇒ Result ~ "{" + element_out (given_element) + "," + subset.out.substring (2, subset.out.count)
		end

	element_out (a: G): STRING
			-- Terse printable representation of `a'
		do
			if attached a then
				check
					other_not_void: a.out /= Void -- {ANY}.out definition
				end
				create Result.make_from_separate (a.out)
			else
				Result := "Void"
			end
		ensure
			class
			when_attached: attached a ⇒ Result ~ a.out
			when_detached: not attached a ⇒ Result ~ "Void"
		end

feature -- Anchor

	subset_anchor,
	superset_anchor: SET [G]
			-- <Precursor>
		do
			Result := Current
		end

feature {SET} -- Implementation

	given_element: like given_element_anchor
			-- An arbitrary element in current set
		do
			check
				attached_stored_any: attached given_element_storage -- not `is_empty'
			then
				Result := given_element_storage.item
			end
		ensure then
			attached_stored_any: attached given_element_storage -- not `is_empty'
			definition: Result ~ given_element_storage.item
		end

	subset: like subset_anchor
			-- Set of all elements in current set but, possibly, `given_element'
		attribute
			Result := Current
		end

	eq: detachable STS_EQUALITY [G]
			-- Rule for testing equality between `given_element' and any other element
		note
			option: stable
		attribute
		end

feature {NONE} -- Implementation

	given_element_storage: detachable CELL [like given_element_anchor]
			-- Storage for `given_element'
		note
			option: stable
		attribute
		end

feature {NONE} -- Anchor

	given_element_anchor: G
			-- Anchor for objects like `given_element'
		do
			Result := given_element
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
