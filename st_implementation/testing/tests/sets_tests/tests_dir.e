note
	description: "Resources for test classes with a {detachable INTEGER_REF} actual generic parameter"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TESTS_DIR

inherit
	ELEMENT_TESTS

feature -- Factory (Object)

	some_integer_ref: detachable INTEGER_REF
			-- Randomly-fetched polymorphic integer-number reference
		do
			inspect next_random_item \\ 2
			when 0 then
				Result := some_immediate_integer_ref
			when 1 then
				Result := some_integer
			end
		end

	some_immediate_integer_ref: like some_integer_ref
			-- Randomly-fetched monomorphic integer-number reference
		local
			obj: like some_immediate_instance
			new_i: FUNCTION [like new_integer_ref]
		do
			new_i := agent new_integer_ref
			obj := some_immediate_instance (new_i)
			if attached obj then
				Result := {like new_integer_ref} / obj
					check
							-- `some_immediate_instance' and `new_integer_ref' definitions
						right_type: attached Result
						monomorphic: Result.generating_type ~ {like new_integer_ref}
					end
			end
		ensure
			monomorphic: attached Result implies Result.generating_type ~ {like some_integer_ref}
		end

	new_integer_ref: like some_immediate_integer_ref
			-- Randomly-created monomorphic integer-number reference
		do
			Result := some_integer.to_reference
		ensure
			class
			monomorphic: attached Result implies Result.generating_type ~ {like some_immediate_integer_ref}
		end

	some_integer: INTEGER
			-- Randomly-created integer number
		do
			Result := next_random_item \\ Max_count.as_integer_32 - Max_count.as_integer_32 // 2
		ensure
			class
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	source: ""
end
