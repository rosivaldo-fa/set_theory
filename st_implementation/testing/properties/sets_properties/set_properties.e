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
			has_ok,
			with_ok,
			without_ok,
			subsets_ok,
			powerset_ok,
			intersected_ok,
			united_ok,
			subtracted_ok,
			subtracted_symmetricaly_ok,
			mapped_ok,
			o_anchor,
			universe_anchor
		end

feature {NONE} -- Initialization

	default_create
			-- Initialize current property checker
		do
			create o.make_empty
			create eq
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
			if not ({A}).is_attached then -- TODO: "Non-separate" Void must be avoided, since it may require a "separate" Void when e.g. mapping via some
					-- f (Void).
--				if {A} /~ {separate A} then -- TODO: System crashes when an agent gets a "separate" Void actual argument.
				check
					has_default: ({A}).has_default -- {A} is a detachable type.
					does_not_have: Result ∌ ({A}).default -- Result.is_empty
				end
				Result := Result.extended (({A}).default)
--				end
			end
			a_type_id := ({detachable A}).type_id
			mem_map := {MEMORY}.memory_map
			if type_is_predefined_expanded (a_type_id) then
				across
					mem_map as al
				from
					Result := o
				loop
--					if {ISE_RUNTIME}.type_conforms_to (al.key, ({detachable STS_ORDERED_PAIR [A, A, STS_EQUALITY [A], STS_EQUALITY [A]]}).type_id) then
--						estimated_universe_size := estimated_universe_size + 2 * al.item.count.as_natural_32
------						print (estimated_universe_size) print ('%N')
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
------						print (estimated_universe_size) print ('%N')
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
------						print (estimated_universe_size) print ('%N')
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
--					else
					if {ISE_RUNTIME}.type_conforms_to (@ al.key, ({detachable STS_SET [A, STS_EQUALITY [A]]}).type_id) then
						estimated_universe_size := estimated_universe_size + {ELEMENT_TESTS}.Max_count * al.count.as_natural_32
----						print (estimated_universe_size) print ('%N')
--						if estimated_universe_size > {SETS_TESTS_RESOURCES_UNARY_N}.Max_asserted_elements then
--							check_ops := {ISE_RUNTIME}.check_assert (False)
--						end
						across
							al as x
						loop
							check
								sa: attached {STS_SET [A, STS_EQUALITY [A]]} x as sa
								-- Every object collected into al.item conforms to {detachable STS_SET [A, STS_EQUALITY [A]]}.
							then
								Result := Result ∪ converted_set (sa)
							end
						end
--						if check_ops then
--							check_ops := {ISE_RUNTIME}.check_assert (True)
--						end
--					elseif {ISE_RUNTIME}.type_conforms_to (al.key, ({detachable STS_N_TUPLE [A, STS_EQUALITY [A]]}).type_id) then
--						estimated_universe_size := estimated_universe_size + {ELEMENT_TESTS}.Max_count * al.item.count.as_natural_32
------						print (estimated_universe_size) print ('%N')
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
					end
				end
			else
				across
					mem_map as al
				loop
					if {ISE_RUNTIME}.type_conforms_to (@ al.key, a_type_id) then
						estimated_universe_size := estimated_universe_size + al.count.as_natural_32
----						print (estimated_universe_size) print ('%N')
						if estimated_universe_size > 1_708 then -- TODO: Magic number!
							check_ops := {ISE_RUNTIME}.check_assert (False)
						end
						across
							al as x
						loop
							check
								a: attached {A} x as a -- {ISE_RUNTIME}.type_conforms_to (al.key, a_type_id)
							then
								Result := Result & a
							end
						end
						if check_ops then
							check_ops := {ISE_RUNTIME}.check_assert (True)
						end
					end
				end
			end
--			print ("# u: ") print (# Result) print ('%N')
		end

	eq: EQ
			-- <Precursor>

feature -- Properties (Membership)

	has_ok (s: STS_SET [A, EQ]; a: A): BOOLEAN
			-- <Precursor>
		local
			sa: STS_SET [A, EQ]
		do
			if type_is_predefined_expanded (({A}).type_id) then
				sa := singleton (a) -- This makes `a' collectible by `current_universe'.
			end
			Result := Precursor {STP_SET_PROPERTIES} (s, a)
		end

feature -- Properties (Construction)

	with_ok (s: STS_SET [A, EQ]; a: A): BOOLEAN
			-- <Precursor>
		local
			sa: STS_SET [A, EQ]
		do
			if type_is_predefined_expanded (({A}).type_id) then
				sa := singleton (a) -- This makes `a' collectible by `current_universe'.
			end
			Result := Precursor {STP_SET_PROPERTIES} (s, a)
		end

	without_ok (s: STS_SET [A, EQ]; a: A): BOOLEAN
			-- <Precursor>
		local
			sa: STS_SET [A, EQ]
		do
			if type_is_predefined_expanded (({A}).type_id) then
				sa := singleton (a) -- This makes `a' collectible by `current_universe'.
			end
			Result := Precursor {STP_SET_PROPERTIES} (s, a)
		end

feature -- Properties (Operation)

	subsets_ok (a: A; s0, s1, s2: STS_SET [A, EQ]): BOOLEAN
			-- <Precursor>
		local
			sa: STS_SET [A, EQ]
		do
			if type_is_predefined_expanded (({A}).type_id) then
				sa := singleton (a) -- This makes `a' collectible by `current_universe'.
			end
			Result := Precursor {STP_SET_PROPERTIES} (a, s0, s1, s2)
		end

	powerset_ok (a: A; s0, s1, s2: STS_SET [A, EQ]): BOOLEAN
			-- <Precursor>
		local
			sa: STS_SET [A, EQ]
		do
			if type_is_predefined_expanded (({A}).type_id) then
				sa := singleton (a) -- This makes `a' collectible by `current_universe'.
			end
			Result := Precursor {STP_SET_PROPERTIES} (a, s0, s1, s2)
		end

	intersected_ok (a: A; s1, s2, s3, s4: STS_SET [A, EQ]): BOOLEAN
			-- <Precursor>
		local
			sa: STS_SET [A, EQ]
		do
			if type_is_predefined_expanded (({A}).type_id) then
				sa := singleton (a) -- This makes `a' collectible by `current_universe'.
			end
			Result := Precursor {STP_SET_PROPERTIES} (a, s1, s2, s3, s4)
		end

	united_ok (a: A; s1, s2, s3, s4: STS_SET [A, EQ]): BOOLEAN
			-- <Precursor>
		local
			sa: STS_SET [A, EQ]
		do
			if type_is_predefined_expanded (({A}).type_id) then
				sa := singleton (a) -- This makes `a' collectible by `current_universe'.
			end
			Result := Precursor {STP_SET_PROPERTIES} (a, s1, s2, s3, s4)
		end

	subtracted_ok (a: A; s1, s2, s3, s4, s5: STS_SET [A, EQ]): BOOLEAN
			-- <Precursor>
		local
			sa: STS_SET [A, EQ]
		do
			if type_is_predefined_expanded (({A}).type_id) then
				sa := singleton (a) -- This makes `a' collectible by `current_universe'.
			end
			Result := Precursor {STP_SET_PROPERTIES} (a, s1, s2, s3, s4, s5)
		end

	subtracted_symmetricaly_ok (a: A; s1, s2, s3: STS_SET [A, EQ]): BOOLEAN
			-- <Precursor>
		local
			sa: STS_SET [A, EQ]
		do
			if type_is_predefined_expanded (({A}).type_id) then
				sa := singleton (a) -- This makes `a' collectible by `current_universe'.
			end
			Result := Precursor {STP_SET_PROPERTIES} (a, s1, s2, s3)
		end

feature -- Properties (Transformation)

	mapped_ok (s: STS_SET [A, EQ]; f: FUNCTION [A, A]): BOOLEAN
			-- <Precursor>
		local
			sa: STS_SET [A, EQ]
		do
			sa := s ↦ f -- This makes `f' (x) collectible by `current_universe', for every x ∈ `s'.
			Result := Precursor {STP_SET_PROPERTIES} (s, f)
		end

	reduced_ok (s: SET [A, EQ]; leftmost: A; f: FUNCTION [A, A, A]): BOOLEAN
			-- Do the properties verified within set theory hold for {STI_SET}.reduced?
		do
			check
--				definition: eq (s.reduced (leftmost, f), s.as_tuple.left_reduced (leftmost, f))
				-- NOTICE: This property applies to {SET}.reduced implementation; other implementations need not comply to such a property. Please see
				-- the comment at {STS_SET}.reduced header.
			then
				Result := True
			end
		end

feature -- Conversion

	converted_set (s: STS_SET [A, STS_EQUALITY [A]]): SET [A, EQ]
			-- Set with every element in `s', but compared by {EQ}.
		local
			l_s: STS_SET [A, STS_EQUALITY [A]]
		do
			from
				Result := o
				l_s := s
			invariant
				every_element: (s ∖ l_s) |∀ agent Result.has
				nothing_else: # Result ≤ # (s ∖ l_s)
			until
				l_s.is_empty
			loop
				Result := Result & l_s.any
				l_s := l_s.others
			variant
				cardinality: {SET [A, EQ]}.natural_as_integer (# l_s)
			end
		ensure
			every_element: s |∀ agent Result.has
			nothing_else: # Result ≤ # s
		end

feature -- Predicate

	type_is_predefined_expanded (t_id: INTEGER): BOOLEAN
			-- Does `t_id' represent a predefined expanded type (i.e. INTEGER, CHAR, REAL etc.)?
		do
			Result := t_id = ({POINTER}).type_id or
				t_id = ({CHARACTER_8}).type_id or
				t_id = ({CHARACTER_32}).type_id or
				t_id = ({BOOLEAN}).type_id or
				t_id = ({INTEGER_8}).type_id or
				t_id = ({INTEGER_16}).type_id or
				t_id = ({INTEGER_32}).type_id or
				t_id = ({INTEGER_64}).type_id or
				t_id = ({NATURAL_8}).type_id or
				t_id = ({NATURAL_16}).type_id or
				t_id = ({NATURAL_32}).type_id or
				t_id = ({NATURAL_64}).type_id or
				t_id = ({REAL_32}).type_id or
				t_id = ({REAL_64}).type_id
		ensure
			definition: Result = (
						t_id = ({POINTER}).type_id or
						t_id = ({CHARACTER_8}).type_id or
						t_id = ({CHARACTER_32}).type_id or
						t_id = ({BOOLEAN}).type_id or
						t_id = ({INTEGER_8}).type_id or
						t_id = ({INTEGER_16}).type_id or
						t_id = ({INTEGER_32}).type_id or
						t_id = ({INTEGER_64}).type_id or
						t_id = ({NATURAL_8}).type_id or
						t_id = ({NATURAL_16}).type_id or
						t_id = ({NATURAL_32}).type_id or
						t_id = ({NATURAL_64}).type_id or
						t_id = ({REAL_32}).type_id or
						t_id = ({REAL_64}).type_id
					)
		end

feature -- Transformer

--	transformer_to_set: TRANSFORMER [A, STS_SET [A, EQ], EQ, STS_SET_EQUALITY [A, EQ]]
--			-- <Precursor>
--		do
--			create Result
--		ensure then
--			class
--		end

feature {NONE} -- Anchor

	o_anchor,
	universe_anchor: SET [A, EQ]
			-- <Precursor>
		do
			Result := o
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/Set-Theory"

end
