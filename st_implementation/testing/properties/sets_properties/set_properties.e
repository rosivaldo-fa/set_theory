note
	description: "Implementation of {STP_SET_PROPERTIES}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	SET_PROPERTIES [A, EQ -> STS_EQUALITY [A] create default_create end]

inherit
	STP_SET_PROPERTIES [A, EQ]
		redefine
			default_create,
			o_anchor,
			universe_anchor
		end

feature {NONE} -- Initialization

	default_create
			-- Initialize current property checker
		do
			create o.make_empty
		end

feature -- Access

	o: like o_anchor
			-- <Precursor>

	current_universe: like universe_anchor
			-- <Precursor>
		local
			a_type_id: like {TYPE [A]}.type_id
			mem_map: HASH_TABLE [ARRAYED_LIST [ANY], INTEGER]
			estimated_universe_size: NATURAL
			check_ops: BOOLEAN
		do
			Result := o
----			if not ({A}).is_attached then -- TODO: "Non-separate" Void must be avoided, since it may require a "separate" Void when e.g. mapping via some
----										  -- f (Void).
----				if {A} /~ {separate A} then -- TODO: System crashes when an agent gets a "separate" Void actual argument.
----						check
----							has_default: ({A}).has_default -- {A} is a detachable type.
----							does_not_have: Result ∌ ({A}).default -- Result.is_empty
----						end
----					Result := Result.extended (({A}).default)
----				end
----			end
--			a_type_id := ({detachable A}).type_id
--			mem_map := {MEMORY}.memory_map
--			if type_is_predefined_expanded (a_type_id) then
--				across
--					mem_map as al
--				from
--					Result := o
--				loop
--					if {ISE_RUNTIME}.type_conforms_to (al.key, ({detachable STS_ORDERED_PAIR [A, A, STS_EQUALITY [A], STS_EQUALITY [A]]}).type_id) then
--						estimated_universe_size := estimated_universe_size + 2 * al.item.count.as_natural_32
----						print (estimated_universe_size) print ('%N')
--						if estimated_universe_size > {SETS_TESTS_RESOURCES_UNARY_N}.Max_asserted_elements then
--							check_ops := {ISE_RUNTIME}.check_assert (False)
--						end
--							across
--								al.item is x
--							loop
--								check
--									ab: attached {STS_ORDERED_PAIR [A, A, STS_EQUALITY [A], STS_EQUALITY [A]]} x as ab
--										-- Every object collected into al.item conforms to
--										-- {detachable STS_ORDERED_PAIR [A, A, STS_EQUALITY [A], STS_EQUALITY [A]]}.
--								then
--									Result := Result & ab.a & ab.b
--								end
--							end
--						if check_ops then
--							check_ops := {ISE_RUNTIME}.check_assert (True)
--						end
--					elseif
--						{ISE_RUNTIME}.type_conforms_to (
--							al.key, ({detachable STS_ORDERED_PAIR [A, detachable ANY, STS_EQUALITY [A], STS_EQUALITY [detachable ANY]]}).type_id
--							)
--					then
--						estimated_universe_size := estimated_universe_size + 2 * al.item.count.as_natural_32
----						print (estimated_universe_size) print ('%N')
--						if estimated_universe_size > {SETS_TESTS_RESOURCES_UNARY_N}.Max_asserted_elements then
--							check_ops := {ISE_RUNTIME}.check_assert (False)
--						end
--							across
--								al.item is x
--							loop
--								check
--									ay: attached {STS_ORDERED_PAIR [A, detachable ANY, STS_EQUALITY [A], STS_EQUALITY [detachable ANY]]} x as ay
--										-- Every object collected into al.item conforms to
--										-- {detachable STS_ORDERED_PAIR [A, detachable ANY, STS_EQUALITY [A], STS_EQUALITY [detachable ANY]]}.
--								then
--									Result := Result & ay.a
--								end
--							end
--						if check_ops then
--							check_ops := {ISE_RUNTIME}.check_assert (True)
--						end
--					elseif
--						{ISE_RUNTIME}.type_conforms_to (
--							al.key, ({detachable STS_ORDERED_PAIR [detachable ANY, A, STS_EQUALITY [detachable ANY], STS_EQUALITY [A]]}).type_id
--							)
--					then
--						estimated_universe_size := estimated_universe_size + 2 * al.item.count.as_natural_32
----						print (estimated_universe_size) print ('%N')
--						if estimated_universe_size > {SETS_TESTS_RESOURCES_UNARY_N}.Max_asserted_elements then
--							check_ops := {ISE_RUNTIME}.check_assert (False)
--						end
--							across
--								al.item is x
--							loop
--								check
--									xb: attached {STS_ORDERED_PAIR [detachable ANY, A, STS_EQUALITY [detachable ANY], STS_EQUALITY [A]]} x as xb
--										-- Every object collected into al.item conforms to
--										-- {detachable STS_ORDERED_PAIR [detachable ANY, A, STS_EQUALITY [detachable ANY], STS_EQUALITY [A]]}.
--								then
--									Result := Result & xb.b
--								end
--							end
--						if check_ops then
--							check_ops := {ISE_RUNTIME}.check_assert (True)
--						end
--					elseif {ISE_RUNTIME}.type_conforms_to (al.key, ({detachable STS_SET [A, STS_EQUALITY [A]]}).type_id) then
--						estimated_universe_size := estimated_universe_size + {SETS_TESTS_RESOURCES}.Max_count * al.item.count.as_natural_32
----						print (estimated_universe_size) print ('%N')
--						if estimated_universe_size > {SETS_TESTS_RESOURCES_UNARY_N}.Max_asserted_elements then
--							check_ops := {ISE_RUNTIME}.check_assert (False)
--						end
--							across
--								al.item is x
--							loop
--								check
--									sa: attached {STS_SET [A, STS_EQUALITY [A]]} x as sa
--										-- Every object collected into al.item conforms to {detachable STS_SET [A, STS_EQUALITY [A]]}.
--								then
--									Result := Result ∪ converted_set (sa)
--								end
--							end
--						if check_ops then
--							check_ops := {ISE_RUNTIME}.check_assert (True)
--						end
--					elseif {ISE_RUNTIME}.type_conforms_to (al.key, ({detachable STS_N_TUPLE [A, STS_EQUALITY [A]]}).type_id) then
--						estimated_universe_size := estimated_universe_size + {SETS_TESTS_RESOURCES}.Max_count * al.item.count.as_natural_32
----						print (estimated_universe_size) print ('%N')
--						if estimated_universe_size > {SETS_TESTS_RESOURCES_UNARY_N}.Max_asserted_elements then
--							check_ops := {ISE_RUNTIME}.check_assert (False)
--						end
--							across
--								al.item is x
--							loop
--								check
--									ta: attached {STS_N_TUPLE [A, STS_EQUALITY [A]]} x as ta
--										-- Every object collected into al.item conforms to {detachable STS_N_TUPLE [A, STS_EQUALITY [A]]}.
--								then
--									Result := Result ∪ converted_set (ta.terms)
--								end
--							end
--						if check_ops then
--							check_ops := {ISE_RUNTIME}.check_assert (True)
--						end
--					end
--				end
--			else
--				across
--					mem_map as al
--				loop
--					if {ISE_RUNTIME}.type_conforms_to (al.key, a_type_id) then
--						estimated_universe_size := estimated_universe_size + al.item.count.as_natural_32
----						print (estimated_universe_size) print ('%N')
--						if estimated_universe_size > 1_708 then -- TODO: Magic number!
--							check_ops := {ISE_RUNTIME}.check_assert (False)
--						end
--							across
--								al.item is x
--							loop
--								check
--									a: attached {A} x as a -- {ISE_RUNTIME}.type_conforms_to (al.key, a_type_id)
--								then
--									Result := Result & a
--								end
--							end
--						if check_ops then
--							check_ops := {ISE_RUNTIME}.check_assert (True)
--						end
--					end
--				end
--			end
--			print ("# u: ") print (# Result) print ('%N')
		end

feature {NONE} -- Anchor

	o_anchor: SET [A, EQ]
			-- <Precursor>
		do
			Result := o
		end

	universe_anchor: SET [A, EQ]
			-- <Precursor>
		do
			Result := current_universe
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	source: ""
end
