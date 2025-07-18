﻿note
	description: "Implementation of {STS_SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	SET [G]

inherit
	STS_SET [G]
		redefine
			default_create,
			out
		end

	DEBUG_OUTPUT
		redefine
			default_create,
			out
		end

create
	default_create,
	make_extended

feature {NONE} -- Initialization

	default_create
			-- Create an empty set
		do
		ensure then
			is_empty: subset = Current
		end

	make_extended (a: G; a_eq: STS_EQUALITY [G]; s: STS_SET [G])
			-- Create a set whose `given_element' element and `subset' are, respectively, `a' and `s'.
		do
			eq := a_eq
			subset := s
			create given_element_storage.put (a)
		ensure
			attached_storage: attached given_element_storage
			eq: eq = a_eq
			is_not_empty: subset /= Current
			attached_eq: attached eq
			given_element: eq (given_element, a)
			subset: subset = s -- TODO: Use set equality instead.
		end

feature -- Membership

	has alias "∋" (a: G): BOOLEAN
			-- <Precursor>
		do
			if subset /= Current then -- Current set is not empty, so it is an "extended" set.
				check
					attached eq -- `make_extended' and `extended' definitions
				then
					Result := eq (a, given_element) or subset ∋ a
				end
			end
		end

feature -- Construction

	extended (a: G; a_eq: STS_EQUALITY [G]): like superset_anchor
			-- Current set extended with `a`, whose equality with any other element is defined by `a_eq`
		do
			create Result.make_extended (a, a_eq, Current)
		ensure then
			equality: Result.eq = a_eq
			is_not_empty: Result.subset /= Result
			given_element: a_eq (Result.given_element, a)
			subset: Result.subset = Current -- TODO: Use set equality instead.
		end

	prunned (a: G): like subset_anchor
			-- <Precursor>
		do
			if subset = Current then
				Result := Current
			else -- Current set is not empty, so it is an "extended" set.
				check
					attached eq -- `make_extended' and `extended' definitions
				then
					if eq (a, given_element) then
						Result := subset.prunned (a)
					else
						Result := subset.prunned (a).extended (given_element, eq)
					end
				end
			end
		ensure then
			when_empty: not attached eq ⇒ Result = Current -- TODO: Use set equality instead.
--			when_found: attached eq and then eq (a, given_element) ⇒ Result ≍ subset.prunned (a)
--			when_not_found: attached eq and then not eq (a, given_element) ⇒ Result ≍ subset.prunned (a).extended (given_element, eq)
		end

feature -- Access

	universe: like universe_anchor
			-- <Precursor>
		do
			create Result
		ensure then
			class
		end

feature -- Output

	out: STRING
			-- <Precursor>
		do
			if Current = subset then
				Result := "{}"
			else
				Result := subset.out
				Result.append (" & (")
				Result.append (element_out (given_element))
				Result.append_character (')')
			end
		ensure then
			base: Current = subset ⇒ Result ~ "{}"
			induction: Current /= subset ⇒ Result ~ subset.out + " & (" + element_out (given_element) + ")"
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
		rescue
			if {EXCEPTIONS}.tag_name ~ "when_attached" then
					-- If a.out contains the address of an object, the GC may have changed such an address. Just hope it remains stable for now.
				retry
			end
		end

feature -- Status report

	debug_output: READABLE_STRING_GENERAL
			-- <Precursor>
		do
			Result := {UTF_CONVERTER}.utf_8_string_8_to_string_32 (out)
		ensure then
			definition: Result ~ {UTF_CONVERTER}.utf_8_string_8_to_string_32 (out)
		end

feature -- Quality

	is_universe: detachable BOOLEAN_REF
			-- <Precursor>
		do
		end

--feature -- Conversion

--	converted (s: SET [G]): like set_anchor
--			-- `s' converted to a set like current one
--		local
--			l_s: SET [G]
--		do
--			if attached {like set_anchor} s as cs then
--				Result := cs
--			else
--				from
--					create Result
--					l_s := s
--				invariant
--	--				TODO
--				until
--					l_s = l_s.subset
--				loop
--					check
--						attached l_s.eq as l_s_eq -- l_s /= l_s.subset
--					then
--						Result := Result.extended (l_s.given_element, l_s_eq)
--					end
--					l_s := l_s.subset
----				variant TODO
----					cardinality: natural_as_integer (# l_s)
--				end
--			end
--		end

feature -- Anchor

	set_anchor: SET [G]
			-- Anchor for sets like current set
		do
			Result := Current
		end

	subset_anchor: STS_SET [G]
			-- <Precursor>
		do
			Result := Current
		end

	superset_anchor: SET [G]
			-- <Precursor>
		do
			Result := Current
		end

	universe_anchor: UNIVERSE [G]
			-- <Precursor>
		do
			Result := universe
		ensure then
			class
		end

feature {SET, NATURAL_SET} -- Implementation

	given_element: like given_element_anchor
			-- An arbitrary element in current set
		require
			is_not_empty: subset /= Current
		do
			check
				attached_given_element_storage: attached given_element_storage as ges -- not `is_empty'
			then
				Result := ges.item
			end
		ensure then
			attached_stored_any: attached given_element_storage as ges -- not `is_empty'
			definition: Result ~ ges.item
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
		require
			is_not_empty: subset /= Current
		do
			Result := given_element
		end

invariant
	storage: subset /= Current ⇒ attached given_element_storage
	equality: subset /= Current ⇒ attached eq

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
