note
	description: "Set that has every element of a given type"
	author: "Rosivaldo Fernandes Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	UNIVERSE [G]

inherit
	SET [G]
		rename
			superset_anchor as universe_anchor
		redefine
			does_not_have,
			out
		end

	DEBUG_OUTPUT
		redefine
			out
		end

feature -- Membership

	has alias "∋" (a: G): BOOLEAN
			-- <Precursor>
			--| Notice that a universe has every thing, but it does not need to know anything about its elements, and indeed probably does not know. It has
			--| an important impact upon `there_exists'.
		do
			Result := True
		end

	does_not_have alias "∌" (a: G): BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

feature -- Construction

	extended (a: G; eq: EQUALITY [G]): like universe_anchor
			-- <Precursor>
		do
			Result := Current
		end

	prunned alias "/" (a: G): COMPLEMENT_SET [G]
			-- <Precursor>
		local
			s: EFFECTIVE_SET [G]
		do
			known_elements := known_elements.extended (a, create {REFERENCE_EQUALITY [G]})
			create s
			create Result.make (s.extended (a, create {REFERENCE_EQUALITY [G]}))
		ensure then
			knowledge_extended: known_elements ∋ a
		end

feature -- Access

	u,
	universe: like universe_anchor
			-- <Precursor>
		do
			Result := Current
		end

feature -- Quality

	is_universe: BOOLEAN = True
			-- <Precursor>
			--| Current set knows it is a universe!

feature -- Output

	out: STRING
			-- <Precursor>
		once
			Result := {UTF_CONVERTER}.string_32_to_utf_8_string_8 ("𝕌")
		ensure then
			class
		end

feature -- Status report

	debug_output: READABLE_STRING_GENERAL
			-- <Precursor>
		once
			Result := {UTF_CONVERTER}.utf_8_string_8_to_string_32 (out)
		ensure then
			class
			definition: Result ~ {UTF_CONVERTER}.utf_8_string_8_to_string_32 (out)
		end

feature -- Quantifier

	there_exists alias "|∃" (p: PREDICATE [G]): detachable BOOLEAN_REF
			-- <Precursor>
		local
			g_type_id: INTEGER_32
			q: PREDICATE [detachable separate ANY]
		do
			g_type_id := ({G}).type_id
			q := p
			if g_type_id = ({BOOLEAN}).type_id then
				Result := q (False) or q (True)
			elseif g_type_id = ({CHARACTER_8}).type_id then
				Result := there_exists_character_8 (q, {CHARACTER_8}.Min_value, {CHARACTER_8}.Max_value)
			elseif g_type_id = ({CHARACTER_32}).type_id then
				Result := there_exists_character_32 (q, {CHARACTER_32}.Min_value, {CHARACTER_32}.Max_value)
			elseif g_type_id = ({NATURAL_8}).type_id then
				Result := there_exists_native_natural_8 (q, 0, {NATURAL_8}.Max_value)
			elseif g_type_id = ({NATURAL_16}).type_id then
				Result := there_exists_native_natural_16 (q, 0, {NATURAL_16}.Max_value)
			elseif g_type_id = ({NATURAL_32}).type_id then
				Result := there_exists_native_natural_32 (q, 0, {NATURAL_32}.Max_value)
			elseif g_type_id = ({NATURAL_64}).type_id then
				Result := there_exists_native_natural_64 (q, 0, {NATURAL_64}.Max_value)
			elseif g_type_id = ({INTEGER_8}).type_id then
				Result := there_exists_native_integer_8 (q, {INTEGER_8}.Min_value, {INTEGER_8}.Max_value)
			elseif g_type_id = ({INTEGER_16}).type_id then
				Result := there_exists_native_integer (q, {INTEGER_16}.Min_value, {INTEGER_16}.Max_value)
			elseif g_type_id = ({INTEGER_32}).type_id then
				Result := there_exists_native_integer (q, {INTEGER_32}.Min_value, {INTEGER_32}.Max_value)
			elseif g_type_id = ({INTEGER_64}).type_id then
				Result := there_exists_native_integer (q, {INTEGER_64}.Min_value, {INTEGER_64}.Max_value)
			elseif g_type_id = ({REAL_32}).type_id then
				Result := there_exists_native_real_32 (q, {INTEGER_32}.Min_value, {INTEGER_32}.Max_value)
			elseif g_type_id = ({REAL_64}).type_id then
				Result := there_exists_native_real_64 (q, {INTEGER_64}.Min_value, {INTEGER_64}.Max_value)
			else
				{MEMORY}.full_collect -- Get rid of partially collected objects.
				Result := there_exists_g_instance (p, {MEMORY}.memory_map)
			end
		ensure then
			el_q: attached {PREDICATE [detachable separate ANY]} p as el_q
			boolean: ({G}).type_id = ({BOOLEAN}).type_id ⇒ Result = el_q (False) or el_q (True)
			character_8: ({G}).type_id = ({CHARACTER_8}).type_id ⇒ Result = there_exists_character_8 (el_q, {CHARACTER_8}.Min_value, {CHARACTER_8}.Max_value)
			character_32: ({G}).type_id = ({CHARACTER_32}).type_id ⇒
				Result = there_exists_character_32 (el_q, {CHARACTER_32}.Min_value, {CHARACTER_32}.Max_value)
			natural_8: ({G}).type_id = ({NATURAL_8}).type_id ⇒ Result = there_exists_native_natural_8 (el_q, 0, {NATURAL_8}.Max_value)
			natural_16: ({G}).type_id = ({NATURAL_16}).type_id ⇒ Result = there_exists_native_natural_16 (el_q, 0, {NATURAL_16}.Max_value)
			natural_32: ({G}).type_id = ({NATURAL_32}).type_id ⇒ Result = there_exists_native_natural_32 (el_q, 0, {NATURAL_32}.Max_value)
			natural_64: ({G}).type_id = ({NATURAL_64}).type_id ⇒ Result = there_exists_native_natural_64 (el_q, 0, {NATURAL_64}.Max_value)
			integer_8: ({G}).type_id = ({INTEGER_8}).type_id ⇒ Result = there_exists_native_integer_8 (el_q, {INTEGER_8}.Min_value, {INTEGER_8}.Max_value)
			integer_16: ({G}).type_id = ({INTEGER_16}).type_id ⇒ Result = there_exists_native_integer (el_q, {INTEGER_16}.Min_value, {INTEGER_16}.Max_value)
			integer_32: ({G}).type_id = ({INTEGER_32}).type_id ⇒ Result = there_exists_native_integer (el_q, {INTEGER_32}.Min_value, {INTEGER_32}.Max_value)
			integer_64: ({G}).type_id = ({INTEGER_64}).type_id ⇒ Result = there_exists_native_integer (el_q, {INTEGER_64}.Min_value, {INTEGER_64}.Max_value)
			real_32: ({G}).type_id = ({REAL_32}).type_id ⇒ Result = there_exists_native_real_32 (el_q, {INTEGER_32}.Min_value, {INTEGER_32}.Max_value)
			real_64: ({G}).type_id = ({REAL_64}).type_id ⇒ Result = there_exists_native_real_64 (el_q, {INTEGER_64}.Min_value, {INTEGER_64}.Max_value)
			some_other_g: not (
						({G}).type_id = ({BOOLEAN}).type_id or ({G}).type_id = ({CHARACTER_8}).type_id or ({G}).type_id = ({CHARACTER_32}).type_id or
						({G}).type_id = ({NATURAL_8}).type_id or ({G}).type_id = ({NATURAL_16}).type_id or ({G}).type_id = ({NATURAL_32}).type_id or
						({G}).type_id = ({NATURAL_64}).type_id or ({G}).type_id = ({INTEGER_8}).type_id or ({G}).type_id = ({INTEGER_16}).type_id or
						({G}).type_id = ({INTEGER_32}).type_id or ({G}).type_id = ({INTEGER_64}).type_id or ({G}).type_id = ({REAL_32}).type_id or
						({G}).type_id = ({REAL_64}).type_id
					) ⇒ Result = (
						agent: BOOLEAN
							do
								{MEMORY}.full_collect -- Get rid of partially collected objects.
								Result := True
							end
					).item and
				there_exists_g_instance (p, {MEMORY}.memory_map)
		end

	there_exists_character_8 (p: PREDICATE [detachable separate ANY]; min_value, max_value: INTEGER_32): BOOLEAN
			-- Does `p' hold for some {CHARACTER_8} within the interval [`min_value'.`to_character_8' .. `max_value'.`to_character_8']?
		require
			valid_characters: min_value ≤ max_value ⇒ min_value.is_valid_character_8_code and max_value.is_valid_character_8_code
		local
			i: INTEGER_32
			c: CHARACTER_8
		do
			if min_value ≤ max_value then
				from
					i := min_value
					check
						valid_character: i.is_valid_character_8_code -- min_value ≤ i ≤ max_value and precondition above
					end
					c := i.to_character_8
					Result := p (c)
				invariant
					bounded: i ≤ max_value
					not_found_before: min_value < i ⇒ not there_exists_character_8 (p, min_value, i - 1)
					valid_character: i.is_valid_character_8_code -- min_value ≤ i ≤ max_value and precondition above
					definition: Result = p (i.to_character_8)
				until
					i = max_value or Result
				loop
					i := i + 1
					check
						valid_character: i.is_valid_character_8_code -- min_value ≤ i ≤ max_value and precondition above
					end
					c := i.to_character_8
					Result := p (c)
				variant
					i: max_value - i
				end
			end
		ensure
			not_found: max_value < min_value ⇒ not Result
			found: min_value < max_value and p (min_value.to_character_8) ⇒ Result
			still_searching: min_value < max_value and not p (min_value.to_character_8) ⇒ Result = there_exists_character_8 (p, min_value + 1, max_value)
			last_chance: min_value = max_value ⇒ Result = p (min_value.to_character_8)
		end

	there_exists_character_32 (p: PREDICATE [detachable separate ANY]; min_value, max_value: NATURAL_32): BOOLEAN
			-- Does `p' hold for some {CHARACTER_32} within the interval [`min_value'.`to_character_32' .. `max_value'.`to_character_32']?
		require
			valid_characters: min_value ≤ max_value ⇒ min_value.is_valid_character_32_code and max_value.is_valid_character_32_code
		local
			n: NATURAL_32
			c: CHARACTER_32
		do
			if min_value ≤ max_value then
				from
					n := min_value
					check
						valid_character: n.is_valid_character_32_code -- min_value ≤ n ≤ max_value and precondition above
					end
					c := n.to_character_32
					Result := p (c)
				invariant
					bounded: n ≤ max_value
					not_found_before: min_value < n ⇒ not there_exists_character_32 (p, min_value, n - 1)
					valid_character: n.is_valid_character_32_code -- min_value ≤ n ≤ max_value and precondition above
					definition: Result = p (n.to_character_32)
				until
					n = max_value or Result
				loop
					n := n + 1
					check
						valid_character: n.is_valid_character_32_code -- min_value ≤ n ≤ max_value and precondition above
					end
					c := n.to_character_32
					Result := p (c)
--				variant
--					n: (max_value - n).as_integer_64 -- Maybe too big even for an {INTEGER_64}
				end
			end
		ensure
			not_found: max_value < min_value ⇒ not Result
			found: min_value < max_value and p (min_value.to_character_32) ⇒ Result
			still_searching: min_value < max_value and not p (min_value.to_character_32) ⇒ Result = there_exists_character_32 (p, min_value + 1, max_value)
			last_chance: min_value = max_value ⇒ Result = p (min_value.to_character_32)
		end

	there_exists_native_natural_8 (p: PREDICATE [detachable separate ANY]; min_value, max_value: NATURAL_8): BOOLEAN
			-- Does `p' hold for some {NATURAL_8} within the interval [`min_value' .. `max_value']?
		local
			n: NATURAL_8
		do
			if min_value ≤ max_value then
				from
					n := min_value
					Result := p (n)
				invariant
					bounded: n ≤ max_value
					not_found_before: min_value < n ⇒ not there_exists_native_natural_8 (p, min_value, n - 1)
					definition: Result = p (n)
				until
					n = max_value or Result
				loop
					n := n + 1
					Result := p (n)
				variant
					n: (max_value.as_integer_16 - n)
				end
			end
		ensure
			not_found: max_value < min_value ⇒ not Result
			found: min_value < max_value and p (min_value) ⇒ Result
			still_searching: min_value < max_value and not p (min_value) ⇒ Result = there_exists_native_natural_8 (p, min_value + 1, max_value)
			last_chance: min_value = max_value ⇒ Result = p (min_value)
		end

	there_exists_native_natural_16 (p: PREDICATE [detachable separate ANY]; min_value, max_value: NATURAL_16): BOOLEAN
			-- Does `p' hold for some {NATURAL_16} within the interval [`min_value' .. `max_value']?
		local
			n: NATURAL_16
		do
			if min_value ≤ max_value then
				from
					n := min_value
					Result := p (n)
				invariant
					bounded: n ≤ max_value
					not_found_before: min_value < n ⇒ not there_exists_native_natural_16 (p, min_value, n - 1)
					definition: Result = p (n)
				until
					n = max_value or Result
				loop
					n := n + 1
					Result := p (n)
				variant
					n: (max_value.as_integer_32 - n)
				end
			end
		ensure
			not_found: max_value < min_value ⇒ not Result
			found: min_value < max_value and p (min_value) ⇒ Result
			still_searching: min_value < max_value and not p (min_value) ⇒ Result = there_exists_native_natural_16 (p, min_value + 1, max_value)
			last_chance: min_value = max_value ⇒ Result = p (min_value)
		end

	there_exists_native_natural_32 (p: PREDICATE [detachable separate ANY]; min_value, max_value: NATURAL_32): BOOLEAN
			-- Does `p' hold for some {NATURAL_32} within the interval [`min_value' .. `max_value']?
		local
			n: NATURAL_32
		do
			if min_value ≤ max_value then
				from
					n := min_value
					Result := p (n)
				invariant
					bounded: n ≤ max_value
					not_found_before: min_value < n ⇒ not there_exists_native_natural_32 (p, min_value, n - 1)
					definition: Result = p (n)
				until
					n = max_value or Result
				loop
					n := n + 1
					Result := p (n)
				variant
					n: (max_value.as_integer_64 - n)
				end
			end
		ensure
			not_found: max_value < min_value ⇒ not Result
			found: min_value < max_value and p (min_value) ⇒ Result
			still_searching: min_value < max_value and not p (min_value) ⇒ Result = there_exists_native_natural_32 (p, min_value + 1, max_value)
			last_chance: min_value = max_value ⇒ Result = p (min_value)
		end

	there_exists_native_natural_64 (p: PREDICATE [detachable separate ANY]; min_value, max_value: NATURAL_64): BOOLEAN
			-- Does `p' hold for some {NATURAL_64} within the interval [`min_value' .. `max_value']?
		local
			n: NATURAL_64
		do
			if min_value ≤ max_value then
				from
					n := min_value
					Result := p (n)
				invariant
					bounded: n ≤ max_value
					not_found_before: min_value < n ⇒ not there_exists_native_natural_64 (p, min_value, n - 1)
					definition: Result = p (n)
				until
					n = max_value or Result
				loop
					n := n + 1
					Result := p (n)
--				variant
--					n: (max_value.as_integer_64 - n.as_integer_64) -- Maybe too big a difference even for an {INTEGER_64}
				end
			end
		ensure
			not_found: max_value < min_value ⇒ not Result
			found: min_value < max_value and p (min_value) ⇒ Result
			still_searching: min_value < max_value and not p (min_value) ⇒ Result = there_exists_native_natural_64 (p, min_value + 1, max_value)
			last_chance: min_value = max_value ⇒ Result = p (min_value)
		end

	there_exists_native_integer_8 (p: PREDICATE [detachable separate ANY]; min_value, max_value: INTEGER_8): BOOLEAN
			-- Does `p' hold for some native integer number within the interval [`min_value' .. `max_value']?
		local
			i: INTEGER_8
		do
			if min_value ≤ max_value then
				from
					i := min_value
					Result := p (i)
				invariant
					bounded: i ≤ max_value
					not_found_before: min_value < i ⇒ not there_exists_native_integer_8 (p, min_value, i - 1)
					definition: Result = p (i)
				until
					i = max_value or Result
				loop
					i := i + 1
					Result := p (i)
				variant
					i: max_value - i
				end
			end
		ensure
			not_found: max_value < min_value ⇒ not Result
			found: min_value < max_value and p (min_value) ⇒ Result
			still_searching: min_value < max_value and not p (min_value) ⇒ Result = there_exists_native_integer_8 (p, min_value + 1, max_value)
			last_chance: min_value = max_value ⇒ Result = p (min_value)
		end

	there_exists_native_integer (p: PREDICATE [detachable separate ANY]; min_value, max_value: INTEGER_64): BOOLEAN
			-- Does `p' hold for some native integer number within the interval [`min_value' .. `max_value']?
		local
			i: INTEGER_64
		do
			if min_value ≤ max_value then
				from
					i := min_value
					Result := p (i)
				invariant
					bounded: i ≤ max_value
					not_found_before: min_value < i ⇒ not there_exists_native_integer (p, min_value, i - 1)
					definition: Result = p (i)
				until
					i = max_value or Result
				loop
					i := i + 1
					Result := p (i)
--				variant
--					i: max_value - i -- Maybe too big even for an {INTEGER_64}
				end
			end
		ensure
			not_found: max_value < min_value ⇒ not Result
			found: min_value < max_value and p (min_value) ⇒ Result
			still_searching: min_value < max_value and not p (min_value) ⇒ Result = there_exists_native_integer (p, min_value + 1, max_value)
			last_chance: min_value = max_value ⇒ Result = p (min_value)
		end

	there_exists_native_real_32 (p: PREDICATE [detachable separate ANY]; min_pattern, max_pattern: INTEGER_32): BOOLEAN
			-- Does `p' hold for some {REAL_32} number whose binary pattern lies within the interval [`min_pattern' .. `max_pattern']?
		local
			i: INTEGER_32
			x: REAL_32
		do
			if min_pattern ≤ max_pattern then
				from
					i := min_pattern
					x := real_32_from_bit_pattern (i)
					Result := p (x)
				invariant
					bounded: i ≤ max_pattern
					not_found_before: min_pattern < i ⇒ not there_exists_native_real_32 (p, min_pattern, i - 1)
					definition: Result = p (real_32_from_bit_pattern (i))
				until
					i = max_pattern or Result
				loop
					i := i + 1
					x := real_32_from_bit_pattern (i)
					Result := p (x)
--				variant
--					i: max_pattern.as_integer_64 - i -- Maybe too big even for an {INTEGER_64}
				end
			end
		ensure
			not_found: max_pattern < min_pattern ⇒ not Result
			found: min_pattern < max_pattern and p (real_32_from_bit_pattern (min_pattern)) ⇒ Result
			still_searching: min_pattern < max_pattern and not p (real_32_from_bit_pattern (min_pattern)) ⇒
				Result = there_exists_native_real_32 (p, min_pattern + 1, max_pattern)
			last_chance: min_pattern = max_pattern ⇒ Result = p (real_32_from_bit_pattern (min_pattern))
		end

	there_exists_native_real_64 (p: PREDICATE [detachable separate ANY]; min_pattern, max_pattern: INTEGER_64): BOOLEAN
			-- Does `p' hold for some {REAL_64} number whose binary pattern lies within the interval [`min_pattern' .. `max_pattern']?
		local
			i: INTEGER_64
			x: REAL_64
		do
			if min_pattern ≤ max_pattern then
				from
					i := min_pattern
					x := real_64_from_bit_pattern (i)
					Result := p (x)
				invariant
					bounded: i ≤ max_pattern
					not_found_before: min_pattern < i ⇒ not there_exists_native_real_64 (p, min_pattern, i - 1)
					definition: Result = p (real_64_from_bit_pattern (i))
				until
					i = max_pattern or Result
				loop
					i := i + 1
					x := real_64_from_bit_pattern (i)
					Result := p (x)
--				variant
--					i: max_pattern - i -- Maybe too big even for an {INTEGER_64}
				end
			end
		ensure
			not_found: max_pattern < min_pattern ⇒ not Result
			found: min_pattern < max_pattern and p (real_64_from_bit_pattern (min_pattern)) ⇒ Result
			still_searching: min_pattern < max_pattern and not p (real_64_from_bit_pattern (min_pattern)) ⇒
				Result = there_exists_native_real_64 (p, min_pattern + 1, max_pattern)
			last_chance: min_pattern = max_pattern ⇒ Result = p (real_64_from_bit_pattern (min_pattern))
		end

	there_exists_g_instance (p: PREDICATE [G]; mem_map: HASH_TABLE [ARRAYED_LIST [ANY], INTEGER]): BOOLEAN
			-- Is there an instance x of {G} such that `p' (x) holds?
		local
			type_id: like {TYPE [G]}.type_id
		do
			if not ({G}).is_attached then
				check
					has_default: ({G}).has_default -- {G} is a detachable type.
				end
				Result := p (({G}).default)
			end
			if not Result then
				type_id := ({detachable G}).type_id
				Result := ∃ al: mem_map ¦ if {ISE_RUNTIME}.type_conforms_to (@ al.key, type_id) then
							∃ x: al ¦ if attached {G} x as a then p (a) else False end
						else
							False
						end
			end
		ensure
			default_case: not ({G}).is_attached and then ({G}).has_default and then p (({G}).default) ⇒ Result
			general_case: ({G}).is_attached or else not ({G}).has_default or else not p (({G}).default) ⇒
				Result = ∃ al: mem_map ¦ if {ISE_RUNTIME}.type_conforms_to (@ al.key, ({detachable G}).type_id) then
							∃ x: al ¦ if attached {G} x as a then p (a) else False end
						else
							False
						end
		end

feature -- Anchor

	subset_anchor: SET [G]
			-- <Precursor>
		do
			Result := Current
		end

	universe_anchor: UNIVERSE [G]
			-- <Precursor>
		do
			Result := Current
		end

feature {NONE} -- Implementation

	known_elements: EFFECTIVE_SET [G]
			-- Elements explicitly known to be in current universe
			--| This set is necessary for making possible to answer `there_exists' query.
		attribute
			create Result
		end

feature {NONE} -- Implementation

	real_32_from_bit_pattern (p: INTEGER_32): REAL_32
			-- The bit pattern `p' converted to a {REAL_32} value
			--| Assumptions:
			--| The bit pattern of `p', unchanged, is interpreted a 32-bit, base 2, IEEE 754, floating point number with the following parameters:
			--| sign bit: 1 bit;
			--| exponent width: 8 bits;
			--| significand (mantissa) precision: 24 bits (23 explicitly stored).
			--| `Result' layout: s_eeee_eeee_mmm_mmmm_mmmm_mmmm_mmmm_mmmm
		external
			"C inline"
		alias
			"{
				union {
					EIF_INTEGER_32 i_32;
					EIF_REAL_32 r_32;
					} ir_32;
				ir_32.i_32 = $p;
				return ir_32.r_32;
			}"
		ensure
			class
		end

	real_64_from_bit_pattern (p: INTEGER_64): REAL_64
			-- The bit pattern `p' converted to a {REAL_64} value
			--| Assumptions:
			--| The bit pattern of `p', unchanged, is interpreted a 64-bit, base 2, IEEE 754, floating point number with the following parameters:
			--| sign bit: 1 bit;
			--| exponent width: 11 bits;
			--| significand (mantissa) precision: 53 bits (52 explicitly stored).
			--| `Result' layout: s_eee_eeee_eeee_mmmm_mmmm_mmmm_mmmm_mmmm_mmmm_mmmm_mmmm_mmmm_mmmm_mmmm_mmmm_mmmm
		external
			"C inline"
		alias
			"{
				union {
					EIF_INTEGER_64 i_64;
					EIF_REAL_64 r_64;
					} ir_64;
				ir_64.i_64 = $p;
				return ir_64.r_64;
			}"
		ensure
			class
		end

invariant
	is_universe: is_universe

note
	copyright: "Copyright (c) 2012-2026, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
