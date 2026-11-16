note
	description: "Minimal implementation of {NATURAL_SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	EFFECTIVE_NATURAL_SET

inherit
	NATURAL_SET
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

	make_extended (m: NATURAL_NUMBER; s: EFFECTIVE_NATURAL_SET)
			-- Create a set whose `given_element' element and `subset' are, respectively, `m' and `s'.
		do
			subset := s
			create given_element_storage.put (m)
		ensure
			attached_storage: attached given_element_storage
			is_not_empty: subset /= Current
			given_element: given_element ≍ m
			subset: subset = s -- TODO: Use set equality instead.
		end

feature -- Primitive

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

feature -- Membership

	has alias "∋" (m: NATURAL_NUMBER): BOOLEAN
			-- <Precursor>
		do
			if subset /= Current then -- Current set is not empty, so it is an "extended" set.
				Result := m ≍ given_element or subset ∋ m
			end
		end

feature -- Construction

	set_extended (m: NATURAL_NUMBER; eq: EQUALITY [NATURAL_NUMBER]): like set_superset_anchor
			-- <Precursor>
		do
			create Result.make_extended (m, eq, Current)
		ensure then
			equality: Result.eq = eq
			is_not_empty: Result.subset /= Result
			given_element: eq (Result.given_element, m)
			subset: Result.subset = Current -- TODO: Use set equality instead.
		end

	extended alias "&" (m: NATURAL_NUMBER): like superset_anchor
			-- <Precursor>
		do
			create Result.make_extended (m, Current)
		ensure then
			is_not_empty: Result.subset /= Result
			given_element: Result.given_element ≍ m
			subset: Result.subset = Current -- TODO: Use set equality instead.
		end

	prunned alias "/" (m: NATURAL_NUMBER): like subset_anchor
			-- <Precursor>
		do
			if subset = Current then
				Result := Current
			else -- Current set is not empty, so it is an "extended" set.
				if m ≍ given_element then
					Result := subset / m
				else
					Result := (subset / m).extended (given_element)
				end
			end
		ensure then
			when_empty: subset = Current ⇒ Result = Current -- TODO: Use set equality instead.
--			when_found: attached eq and then eq (a, given_element) ⇒ Result ≍ (subset / a)
--			when_not_found: attached eq and then not eq (a, given_element) ⇒ Result ≍ (subset / a).extended (given_element, eq)
		end

feature -- Access

	n,
	natural_numbers: UNIVERSE [NATURAL_NUMBER]
			-- <Precursor>
		once
			create Result
		ensure then
			class
		end

feature -- Quality

	is_universe: detachable BOOLEAN_REF
			-- Is current set a universe, i.e., does it have every instance of {NATURAL_NUMBER}?
			--| Detachable because it is not always knowable whether a set is a universe of not
		do
				-- TODO: Can it be made attached?
		end

feature -- Output

	out: STRING
			-- <Precursor>
		local
			s: EFFECTIVE_NATURAL_SET
			s_length: FUNCTION [EFFECTIVE_NATURAL_SET, INTEGER]
		do
			s_length := agent (ia_s: EFFECTIVE_NATURAL_SET): INTEGER
					local
						il_s: EFFECTIVE_NATURAL_SET
					do
						from
							il_s := ia_s
						until
							il_s = il_s.subset
						loop
							Result := Result + 1
							il_s := il_s.subset
						end
					end

			Result := "{"
			if subset /= Current then
				from
					Result.append (given_element.out)
					s := subset
				invariant
						-- I've got some help from Grok (https://grok.com/share/c2hhcmQtMw_863f8988-40da-4e15-8deb-b854f6a09e55)
						-- to come up with this invarint.
					building_up: s.subset /= s ⇒ Result + "," + s.out.substring (2, s.out.count) ~
							"{" + given_element.out +
							if subset.subset = subset then
								"}"
							else
								"," + subset.out.substring (2, subset.out.count)
							end
					finished: s.subset = s ⇒ Result + "}" ~
							"{" + given_element.out +
							if subset.subset = subset then
								"}"
							else
								"," + subset.out.substring (2, subset.out.count)
							end
				until
					s = s.subset
				loop
					Result.append_character (',')
					check
						other_arguments_not_void: s.given_element.out /= Void -- {NATURAL_NUMBER}.out definition
					end
					Result.append (s.given_element.out)
					s := s.subset
				variant
					s_length: s_length (s)
				end
			end
			Result.append_character ('}')
		ensure then
			empty: subset = Current ⇒ Result ~ "{}"
			singleton: subset /= Current and subset.subset = subset ⇒ Result ~ "{" + given_element.out + "}"
			otherwise: subset /= Current and subset.subset /= subset ⇒
				Result ~ "{" + given_element.out + "," + subset.out.substring (2, subset.out.count)
		end

feature -- Status report

	debug_output: READABLE_STRING_GENERAL
			-- <Precursor>
		do
			Result := {UTF_CONVERTER}.utf_8_string_8_to_string_32 (out)
		ensure then
			definition: Result ~ {UTF_CONVERTER}.utf_8_string_8_to_string_32 (out)
		end

feature -- Quantifier

	there_exists alias "|∃" (p: PREDICATE [NATURAL_NUMBER]): detachable BOOLEAN_REF
			-- <Precursor>
		do
			if subset = Current then
				Result := False
			elseif p (given_element) then
				Result := True
			else
				Result := subset |∃ p
			end
		ensure then
			when_empty: subset = Current ⇒ Result = False
			when_found: subset /= Current and then p (given_element) ⇒ Result = True
			when_not_found: subset /= Current and then not p (given_element) ⇒ Result = subset |∃ p
		end

feature -- Anchor

	given_element_anchor: EFFECTIVE_NATURAL_NUMBER
			-- Anchor for objects like `given_element'
		require
			is_not_empty: subset /= Current
		do
			Result := given_element
		end

	set_superset_anchor: EFFECTIVE_SET [NATURAL_NUMBER]
			-- Anchor for supersets of current set
		once
			create Result
		ensure then
			class
		end

	subset_anchor,
	superset_anchor: EFFECTIVE_NATURAL_SET
			-- <Precursor>
		do
			Result := Current
		end

	universe_anchor: UNIVERSE [NATURAL_NUMBER]
			-- <Precursor>
		do
			Result := n
		end

feature {NONE} -- Implementation

	given_element_storage: detachable CELL [like given_element_anchor]
			-- Storage for `given_element'
		note
			option: stable
		attribute
		end

note
	copyright: "Copyright (c) 2012-2026, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
