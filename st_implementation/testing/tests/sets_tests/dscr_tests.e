﻿note
	description: "Resources for test classes with a {detachable separate CHARACTER_REF} actual generic parameter"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DSCR_TESTS

inherit
	ELEMENT_TESTS

feature -- Factory (Object)

	some_separate_character_ref: detachable separate CHARACTER_REF
			-- Randomly-fetched polymorphic separate character reference
		do
			inspect
				next_random_item \\ 2
			when 0 then
				Result := some_immediate_separate_character_ref
			when 1 then
				Result := some_character_ref
			end
		end

	some_immediate_separate_character_ref: like some_separate_character_ref
			-- Randomly-fetched monomorphic separate character reference
		local
			obj: like some_immediate_instance
		do
--			from
--				obj := some_immediate_instance (new_c)
--			until
--				attached obj -- TODO: System crashes when an agent gets a "separate" Void actual argument.
--			loop
--				obj := some_immediate_instance (new_c)
--			end
			obj := some_immediate_instance (agent new_separate_character_ref)
			if attached obj then
				Result := {like new_separate_character_ref} / obj
				check
						-- `some_immediate_instance' and `new_separate_character_ref' definitions
					right_type: attached Result
					monomorphic: object_is_immediate_instance (Result, {like new_separate_character_ref})
				end
			end
		ensure
--			monomorphic: attached Result implies object_is_immediate_instance (Result, {like some_character_ref}) -- TODO: why not?
			monomorphic: attached Result implies object_is_immediate_instance (Result, {like new_separate_character_ref})
		end

	new_separate_character_ref: like some_immediate_separate_character_ref
			-- Randomly-created monomorphic separate character reference
		local
			c_ref: like new_separate_character_ref
		do
			create c_ref
			separate c_ref as sep_c_ref do
				sep_c_ref.set_item (some_character)
			end
			Result := c_ref
		ensure
			class
			monomorphic: attached Result implies object_is_immediate_instance (Result, {like some_immediate_separate_character_ref})
		end

	some_character_ref: detachable CHARACTER_REF
			-- Randomly-fetched polymorphic character reference
		do
			inspect
				next_random_item \\ 2
			when 0 then
				Result := some_immediate_character_ref
			when 1 then
				Result := some_character
			end
		end

	some_immediate_character_ref: like some_character_ref
			-- Randomly-fetched monomorphic character reference
		local
--			new_c: FUNCTION [like new_character_ref]
			obj: like some_immediate_instance
		do
--			new_c := agent new_character_ref
--			from
			obj := some_immediate_instance (agent new_character_ref)
--			until
--				attached obj -- TODO: System crashes when an agent gets a "separate" Void actual argument.
--			loop
--				obj := some_immediate_instance (new_c)
--			end
			if attached obj then
				Result := {like new_character_ref} / obj
				check
						-- `some_immediate_instance' and `new_character_ref' definitions
					right_type: attached Result
					monomorphic: object_is_immediate_instance (Result, {like new_character_ref})
				end
			end
		ensure
--			monomorphic: attached Result implies object_is_immediate_instance (Result, {like some_character_ref}) -- TODO: why not?
			monomorphic: attached Result implies object_is_immediate_instance (Result, {like new_character_ref})
		end

	new_character_ref: like some_immediate_character_ref
			-- Randomly-created monomorphic character reference
		do
			create Result
			Result.set_item (some_character)
		ensure
			class
			monomorphic: attached Result implies object_is_immediate_instance (Result, {like some_immediate_character_ref})
		end

	some_character: CHARACTER
			-- Randomly-created character
		local
			n: NATURAL
		do
			n := some_index
			check
				valid_character:
						-- 0 < n ≤ Max_count ⇐ `some_index' definition
						-- class invariant: (Min_character.natural_32_code + Max_count - 1).is_valid_character_8_code
					(Min_character.natural_32_code + n - 1).is_valid_character_8_code
			end
			Result := (Min_character.natural_32_code + n - 1).to_character_8
		ensure
			class
		end

feature {NONE} -- Implementation

	Min_character: CHARACTER = 'a'
			-- Minimum value for `some_character'

	some_index: NATURAL
			-- Randomly-created index
		do
			check
				positive: 0 < Max_count -- `Max_count' definition
			end
			Result := some_index_up_to (Max_count)
		ensure
			class
			positive: 0 < Result
			upper_bound: Result <= Max_count
		end

invariant
	valid_characters: (Min_character.natural_32_code + Max_count - 1).is_valid_character_8_code

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	source: ""
end
