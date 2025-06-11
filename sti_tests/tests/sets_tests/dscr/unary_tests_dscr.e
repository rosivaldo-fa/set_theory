note
	description: "{STST_UNARY_TESTS}, derived for {detachable separate CHARACTER_REF} generic parameter."
	author: "Rosivaldo Fernandes Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	UNARY_TESTS_DSCR

inherit
	UNARY_TESTS [detachable separate CHARACTER_REF]
		rename
			some_object_g as some_separate_character_ref,
			same_object_g as same_object_dscr,
			object_standard_twin_g as object_standard_twin_dscr,
			object_twin_g as object_twin_dscr,
			object_deep_twin_g as object_deep_twin_dscr,

			some_equality_g as some_equality_dscr,
			some_reference_equality_g as some_reference_equality_dscr,
			some_object_standard_equality_g as some_object_standard_equality_dscr,
			some_object_equality_g as some_object_equality_dscr,
			some_object_deep_equality_g as some_object_deep_equality_dscr,
			some_equality_sg as some_equality_sdscr,
			some_reference_equality_sg as some_reference_equality_sdscr,
			some_object_standard_equality_sg as some_object_standard_equality_sdscr,
			some_object_equality_sg as some_object_equality_sdscr,
			some_object_deep_equality_sg as some_object_deep_equality_sdscr,

			some_set_g as some_set_dscr,
			some_immediate_set_g as some_immediate_set_dscr,

			some_set_sg as some_set_sdscr,
			some_immediate_set_sg as some_immediate_set_sdscr,
			some_set_family_g as some_set_family_dscr,
			some_immediate_set_family_g as some_immediate_set_family_dscr
		end

feature -- Factory (Separate character reference)

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

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
