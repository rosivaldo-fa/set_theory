note
	description: "Test suite for {EFFECTIVE_UNIVERSE}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

deferred class
	EFFECTIVE_UNIVERSE_TESTS [G]

inherit
	SET_TESTS [G]
		rename
			set_to_be_tested as universe_to_be_tested
		redefine
			test_all,
			test_has,
			test_does_not_have,
			test_there_exists
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {EFFECTIVE_UNIVERSE}.
		note
			testing: "covers/{EFFECTIVE_UNIVERSE}"
		do
			Precursor {SET_TESTS}
			test_there_exists_character_8
			test_there_exists_character_32
			test_there_exists_native_natural_8
			test_there_exists_native_natural_16
			test_there_exists_native_natural_32
			test_there_exists_native_natural_64
			test_there_exists_native_integer_8
			test_there_exists_native_integer_16
			test_there_exists_native_integer_32
			test_there_exists_native_integer_64
			test_there_exists_native_real_32
			test_there_exists_native_real_64
			test_there_exists_g_instance
		end

feature -- Test routines (Initialization)

	test_default_create
			-- Test {EFFECTIVE_UNIVERSE}.default_create.
		note
			testing: "covers/{EFFECTIVE_UNIVERSE}.default_create"
		do
			assert ("default_create", attached (create {like universe_to_be_tested}))
		end

feature -- Test routines (Membership)

	test_has
			-- Test {EFFECTIVE_UNIVERSE}.has.
		note
			testing: "covers/{EFFECTIVE_UNIVERSE}.has"
		local
			u: like universe_to_be_tested
		do
			u := universe_to_be_tested
			assert ("u ∋ a", u ∋ a)
			assert ("u ∋ b", u ∋ b)
			assert ("u ∋ c", u ∋ c)
			assert ("u ∋ d", u ∋ d)
		end

	test_does_not_have
			-- Test {EFFECTIVE_UNIVERSE}.does_not_have.
		note
			testing: "covers/{EFFECTIVE_UNIVERSE}.does_not_have"
		local
			u: like universe_to_be_tested
		do
			u := universe_to_be_tested
			assert ("not (u ∌ a)", not (u ∌ a))
			assert ("not (u ∌ b)", not (u ∌ b))
			assert ("not (u ∌ c)", not (u ∌ c))
			assert ("not (u ∌ d)", not (u ∌ d))
		end

feature -- Test routines (Output)

	test_out
			-- Test {EFFECTIVE_UNIVERSE}.out.
		note
			testing: "covers/{EFFECTIVE_UNIVERSE}.out"
		do
			assert ("out", attached universe_to_be_tested.out)
		end

feature -- Test routines (Status report)

	test_debug_output
			-- Test {EFFECTIVE_UNIVERSE}.debug_output.
		note
			testing: "covers/{EFFECTIVE_UNIVERSE}.debug_output"
		do
			assert ("debug_output", attached universe_to_be_tested.debug_output)
		end

feature -- Test routines (Quantifier)

	test_there_exists
			-- Test {EFFECTIVE_UNIVERSE}.there_exists.
		note
			testing: "covers/{EFFECTIVE_UNIVERSE}.there_exists"
		local
			check_assert: BOOLEAN
			u_b: EFFECTIVE_UNIVERSE [BOOLEAN]
			u_c8: EFFECTIVE_UNIVERSE [CHARACTER_8]
			u_c32: EFFECTIVE_UNIVERSE [CHARACTER_32]
			u_n8: EFFECTIVE_UNIVERSE [NATURAL_8]
			u_n16: EFFECTIVE_UNIVERSE [NATURAL_16]
			u_n32: EFFECTIVE_UNIVERSE [NATURAL_32]
			u_n64: EFFECTIVE_UNIVERSE [NATURAL_64]
			u_i8: EFFECTIVE_UNIVERSE [INTEGER_8]
			u_i16: EFFECTIVE_UNIVERSE [INTEGER_16]
			u_i32: EFFECTIVE_UNIVERSE [INTEGER_32]
			u_i64: EFFECTIVE_UNIVERSE [INTEGER_64]
			u_r32: EFFECTIVE_UNIVERSE [REAL_32]
			u_r64: EFFECTIVE_UNIVERSE [REAL_64]
			u_p: EFFECTIVE_UNIVERSE [POINTER]
			u: like universe_to_be_tested
			s: EFFECTIVE_SET [G]
			eq: REFERENCE_EQUALITY [G]
		do
			create u_b
			assert (
					"excluded third",
					u_b |∃ agent (bool: BOOLEAN): BOOLEAN
						do
							Result := bool /= False and bool /= True
						end = False
				)

			assert (
					"just two possible values",
					u_b |∃ agent (bool: BOOLEAN): BOOLEAN
						do
							Result := bool xor not bool
						end = True
				)

			create u_c8
			assert (
					"no_negative_code c8",
					u_c8 |∃ agent (c8: CHARACTER_8): BOOLEAN
						do
							Result := c8.code < 0
						end = False
				)

			assert (
					"some_given_code c8",
					u_c8 |∃ agent (c8: CHARACTER_8): BOOLEAN
						do
							Result := c8.code = 89
						end = True
				)

			create u_c32
			assert (
					"some_given_code c32",
					u_c32 |∃ agent (c32: CHARACTER_32): BOOLEAN
						do
							Result := c32.code = 329
						end = True
				)

--			check_assert := {ISE_RUNTIME}.check_assert (False) -- Universe too big to test in reasonable time
--			assert (
--					"no_negative_code c32",
--					u_c32 |∃ agent (c32: CHARACTER_32): BOOLEAN
--						do
--							Result := c32.natural_32_code < 0
--						end = False
--				)
--			check_assert := {ISE_RUNTIME}.check_assert (check_assert)

			create u_n8
			assert (
					"no negative n8",
					u_n8 |∃ agent (n: NATURAL_8): BOOLEAN
						do
							Result := n < 0
						end = False
				)

			assert (
					"big enough n8",
					u_n8 |∃ agent (n: NATURAL_8): BOOLEAN
						do
							Result := n > 99
						end = True
				)

			create u_n16
			check_assert := {ISE_RUNTIME}.check_assert (False) -- Universe too big to test every assertion in reasonable time
			assert (
					"no negative n16",
					u_n16 |∃ agent (n: NATURAL_16): BOOLEAN
						do
							Result := n < 0
						end = False
				)
			check_assert := {ISE_RUNTIME}.check_assert (check_assert)

			assert (
					"big enough n16",
					u_n16 |∃ agent (n: NATURAL_16): BOOLEAN
						do
							Result := n > 999
						end = True
				)

			create u_n32
--			check_assert := {ISE_RUNTIME}.check_assert (False) -- Universe too big to test in reasonable time
--			assert (
--					"no negative n32",
--					u_n32 |∃ agent (n: NATURAL_32): BOOLEAN
--						do
--							Result := n < 0
--						end = False
--				)
--			check_assert := {ISE_RUNTIME}.check_assert (check_assert)

			assert (
					"big enough n32",
					u_n32 |∃ agent (n: NATURAL_32): BOOLEAN
						do
							Result := n > 4999
						end = True
				)

			create u_n64
--			check_assert := {ISE_RUNTIME}.check_assert (False) -- Universe too big to test in reasonable time
--			assert (
--					"no negative n64",
--					u_n64 |∃ agent (n: NATURAL_64): BOOLEAN
--						do
--							Result := n < 0
--						end = False
--				)
--			check_assert := {ISE_RUNTIME}.check_assert (check_assert)

			assert (
					"big enough n64",
					u_n64 |∃ agent (n: NATURAL_64): BOOLEAN
						do
							Result := n > 4999
						end = True
				)

			create u_i8
			assert (
					"small enough i8",
					u_i8 |∃ agent (i: INTEGER_8): BOOLEAN
						do
							Result := i > {INTEGER_8}.Max_value
						end = False
				)

			assert (
					"big enough i8",
					u_i8 |∃ agent (i: INTEGER_8): BOOLEAN
						do
							Result := i > 99
						end = True
				)

			create u_i16
			check_assert := {ISE_RUNTIME}.check_assert (False) -- Universe too big to test every assertion in reasonable time
			assert (
					"small enough i16",
					u_i16 |∃ agent (i: INTEGER_16): BOOLEAN
						do
							Result := i > {INTEGER_16}.Max_value
						end = False
				)
			check_assert := {ISE_RUNTIME}.check_assert (check_assert)

			assert (
					"big enough i16",
					u_i16 |∃ agent (i: INTEGER_16): BOOLEAN
						do
							Result := i > {INTEGER_16}.Min_value + 4999
						end = True
				)

			create u_i32
--			check_assert := {ISE_RUNTIME}.check_assert (False) -- Universe too big to test in reasonable time
--			assert (
--					"small enough i32",
--					u_i32 |∃ agent (i: INTEGER_32): BOOLEAN
--						do
--							Result := i > {INTEGER_32}.Max_value
--						end = False
--				)
--			check_assert := {ISE_RUNTIME}.check_assert (check_assert)

			assert (
					"big enough i32",
					u_i32 |∃ agent (i: INTEGER_32): BOOLEAN
						do
							Result := i > {INTEGER_32}.Min_value + 4999
						end = True
				)

			create u_i64
--			check_assert := {ISE_RUNTIME}.check_assert (False) -- Universe too big to test in reasonable time
--			assert (
--					"small enough i64",
--					u_i64 |∃ agent (i: INTEGER_64): BOOLEAN
--						do
--							Result := i > {INTEGER_64}.Max_value
--						end = False
--				)
--			check_assert := {ISE_RUNTIME}.check_assert (check_assert)

			assert (
					"big enough i64",
					u_i64 |∃ agent (i: INTEGER_64): BOOLEAN
						do
							Result := i > {INTEGER_64}.Min_value + 4999
						end = True
				)

			create u_r32
--			check_assert := {ISE_RUNTIME}.check_assert (False) -- Universe too big to test in reasonable time
--			assert (
--					"small enough r32",
--					u_r32 |∃ agent (x: REAL_32): BOOLEAN
--						do
--							Result := x > {REAL_32}.positive_infinity
--						end = False
--				)
--			check_assert := {ISE_RUNTIME}.check_assert (check_assert)

			assert (
					"magic negative r32",
					u_r32 |∃ agent (x: REAL_32): BOOLEAN
						do
							Result := x < - (2 ^ (-126) * 5000 / (2 ^ 24))
						end = True
				)

			create u_r64
--			check_assert := {ISE_RUNTIME}.check_assert (False) -- Universe too big to test in reasonable time
--			assert (
--					"small enough r64",
--					u_r64 |∃ agent (x: REAL_64): BOOLEAN
--						do
--							Result := x > {REAL_64}.positive_infinity
--						end = False
--				)
--			check_assert := {ISE_RUNTIME}.check_assert (check_assert)

			assert (
					"magic negative  r64",
					u_r64 |∃ agent (x: REAL_64): BOOLEAN
						do
							Result := x < - (2 ^ (-1022) * 5000 / (2 ^ 53))
						end = True
				)

			create u_p
			assert ("hic sunt dracones",
				not attached (u_p |∃ agent (p: POINTER): BOOLEAN do end)
				)

			u := universe_to_be_tested
				-- Let's populate the universe.
			create s
			create eq
			s := s.extended (a, eq)
			s := s.extended (b, eq)
			s := s.extended (c, eq)
			s := s.extended (d, eq)

			assert ("impossible",
					u |∃ agent (x: G; il_u: SET [G]): BOOLEAN
						do
							Result := il_u ∌ x
						end (?, u) = False
				)

			assert ("inevitable",
					u |∃ agent (x: G; il_s: SET [G]): BOOLEAN
						do
							Result := il_s ∋ x
						end (?, s) = True
				)
		end

	test_there_exists_character_8
			-- Test {EFFECTIVE_UNIVERSE}.there_exists_character_8.
		note
			testing: "covers/{EFFECTIVE_UNIVERSE}.there_exists_character_8"
		local
			u: like universe_to_be_tested
		do
			u := universe_to_be_tested
			assert (
					"no_negative_code",
					not u.there_exists_character_8 (
								agent (c8: CHARACTER_8): BOOLEAN
									do
										Result := c8.code < 0
									end,
								{CHARACTER_8}.Min_value, {CHARACTER_8}.Max_value
							)
				)

			assert (
					"some_given_code",
					u.there_exists_character_8 (
							agent (c8: CHARACTER_8): BOOLEAN
								do
									Result := c8.code = 89
								end,
							{CHARACTER_8}.Min_value, {CHARACTER_8}.Max_value
						)
				)
		end

	test_there_exists_character_32
			-- Test {EFFECTIVE_UNIVERSE}.there_exists_character_32.
		note
			testing: "covers/{EFFECTIVE_UNIVERSE}.there_exists_character_32"
		local
			u: like universe_to_be_tested
		do
			u := universe_to_be_tested
			assert (
					"no_negative_code",
					not u.there_exists_character_32 (
								agent (c32: CHARACTER_32): BOOLEAN
									do
										Result := c32.code < 0
									end,
								{CHARACTER_32}.Min_value, 1023
							)
				)

			assert (
					"some_given_code",
					u.there_exists_character_32 (
							agent (c32: CHARACTER_32): BOOLEAN
								do
									Result := c32.code = 329
								end,
							{CHARACTER_32}.Min_value, {CHARACTER_32}.Max_value
						)
				)
		end

	test_there_exists_native_natural_8
			-- Test {EFFECTIVE_UNIVERSE}.there_exists_native_natural_8.
		note
			testing: "covers/{EFFECTIVE_UNIVERSE}.there_exists_native_natural_8"
		local
			u: like universe_to_be_tested
		do
			u := universe_to_be_tested
			assert (
					"no negative",
					not u.there_exists_native_natural_8 (
								agent (n: NATURAL_8): BOOLEAN
									do
										Result := n < 0
									end,
								0, {NATURAL_8}.Max_value
							)
				)

			assert (
					"big enough",
					u.there_exists_native_natural_8 (
							agent (n: NATURAL_8): BOOLEAN
								do
									Result := n.out.count > 2
								end,
							0, {NATURAL_8}.Max_value
						)
				)
		end

	test_there_exists_native_natural_16
			-- Test {EFFECTIVE_UNIVERSE}.there_exists_native_natural_16.
		note
			testing: "covers/{EFFECTIVE_UNIVERSE}.there_exists_native_natural_16"
		local
			u: like universe_to_be_tested
		do
			u := universe_to_be_tested
			assert (
					"no negative",
					not u.there_exists_native_natural_16 (
								agent (n: NATURAL_16): BOOLEAN
									do
										Result := n < 0
									end,
								{NATURAL_8}.Max_value + 1, {NATURAL_8}.Max_value + {NATURAL_16} 5_000
							)
				)

			assert (
					"big enough",
					u.there_exists_native_natural_16 (
							agent (n: NATURAL_16): BOOLEAN
								do
									Result := n > 4_999
								end,
							0, {NATURAL_16}.Max_value
						)
				)
		end

	test_there_exists_native_natural_32
			-- Test {EFFECTIVE_UNIVERSE}.there_exists_native_natural_32.
		note
			testing: "covers/{EFFECTIVE_UNIVERSE}.there_exists_native_natural_32"
		local
			u: like universe_to_be_tested
		do
			u := universe_to_be_tested
			assert (
					"no negative",
					not u.there_exists_native_natural_32 (
								agent (n: NATURAL_32): BOOLEAN
									do
										Result := n < 0
									end,
								{NATURAL_16}.Max_value + 1, {NATURAL_16}.Max_value + 5_000
							)
				)

			assert (
					"big enough",
					u.there_exists_native_natural_32 (
							agent (n: NATURAL_32): BOOLEAN
								do
									Result := n > 99_999
								end,
							95_000, {NATURAL_32}.Max_value
						)
				)
		end

	test_there_exists_native_natural_64
			-- Test {EFFECTIVE_UNIVERSE}.there_exists_native_natural_64.
		note
			testing: "covers/{EFFECTIVE_UNIVERSE}.there_exists_native_natural_64"
		local
			u: like universe_to_be_tested
		do
			u := universe_to_be_tested
			assert (
					"no negative",
					not u.there_exists_native_natural_64 (
								agent (n: NATURAL_64): BOOLEAN
									do
										Result := n < 0
									end,
								{NATURAL_32}.Max_value + 1, {NATURAL_32}.Max_value + 5_000
							)
				)

			assert (
					"big enough",
					u.there_exists_native_natural_64 (
							agent (n: NATURAL_64): BOOLEAN
								do
									Result := n > 5_000_000_000
								end,
							4_999_995_000, {NATURAL_64}.Max_value
						)
				)
		end

	test_there_exists_native_integer_8
			-- Test {EFFECTIVE_UNIVERSE}.there_exists_native_integer_8.
		note
			testing: "covers/{EFFECTIVE_UNIVERSE}.there_exists_native_integer_8"
		local
			u: like universe_to_be_tested
		do
			u := universe_to_be_tested
			assert (
					"not too big",
					not u.there_exists_native_integer_8 (
								agent (i: INTEGER_8): BOOLEAN
									do
										Result := i > {INTEGER_8}.Max_value
									end,
								{INTEGER_8}.Min_value, {INTEGER_8}.Max_value
							)
				)

			assert (
					"big enough",
					u.there_exists_native_integer_8 (
							agent (i: INTEGER_8): BOOLEAN
								do
									Result := i > 29
								end,
							{INTEGER_8}.Min_value, {INTEGER_8}.Max_value
						)
				)
		end

	test_there_exists_native_integer_16
			-- Test {EFFECTIVE_UNIVERSE}.there_exists_native_integer_16.
		note
			testing: "covers/{EFFECTIVE_UNIVERSE}.there_exists_native_integer_16"
		local
			u: like universe_to_be_tested
		do
			u := universe_to_be_tested
			assert (
					"not too big",
					not u.there_exists_native_integer_16 (
								agent (i: INTEGER_16): BOOLEAN
									do
										Result := i > {INTEGER_16}.Max_value
									end,
								{INTEGER_8}.Max_value + {INTEGER_16} 1, {INTEGER_8}.Max_value + {INTEGER_16} 5000
							)
				)

			assert (
					"big enough",
					u.there_exists_native_integer_16 (
							agent (i: INTEGER_16): BOOLEAN
								do
									Result := i > 1729
								end,
							{INTEGER_8}.Max_value + {INTEGER_16} 1, {INTEGER_8}.Max_value + {INTEGER_16} 5000
						)
				)
		end

	test_there_exists_native_integer_32
			-- Test {EFFECTIVE_UNIVERSE}.there_exists_native_integer_32.
		note
			testing: "covers/{EFFECTIVE_UNIVERSE}.there_exists_native_integer_32"
		local
			u: like universe_to_be_tested
		do
			u := universe_to_be_tested
			assert (
					"not too big",
					not u.there_exists_native_integer_32 (
								agent (i: INTEGER_32): BOOLEAN
									do
										Result := i > {INTEGER_32}.Max_value
									end,
								{INTEGER_16}.Max_value + 1, {INTEGER_16}.Max_value + 5000
							)
				)

			assert (
					"big enough",
					u.there_exists_native_integer_32 (
							agent (i: INTEGER_32): BOOLEAN
								do
									Result := i > {INTEGER_16}.Max_value + 1729
								end,
							{INTEGER_16}.Max_value + 1, {INTEGER_16}.Max_value + 5000
						)
				)
		end

	test_there_exists_native_integer_64
			-- Test {EFFECTIVE_UNIVERSE}.there_exists_native_integer_64.
		note
			testing: "covers/{EFFECTIVE_UNIVERSE}.there_exists_native_integer_64"
		local
			u: like universe_to_be_tested
		do
			u := universe_to_be_tested
			assert (
					"not too big",
					not u.there_exists_native_integer_64 (
								agent (i: INTEGER_64): BOOLEAN
									do
										Result := i > {INTEGER_64}.Max_value
									end,
								{INTEGER_32}.Max_value + 1, {INTEGER_32}.Max_value + 5000
							)
				)

			assert (
					"big enough",
					u.there_exists_native_integer_64 (
							agent (i: INTEGER_64): BOOLEAN
								do
									Result := i > {INTEGER_32}.Max_value + 1729
								end,
							{INTEGER_32}.Max_value + 1, {INTEGER_32}.Max_value + 5000
						)
				)
		end

	test_there_exists_native_real_32
			-- Test {EFFECTIVE_UNIVERSE}.there_exists_native_real_32.
		note
			testing: "covers/{EFFECTIVE_UNIVERSE}.there_exists_native_real_32"
		local
			u: like universe_to_be_tested
		do
			u := universe_to_be_tested
			assert (
					"negative only",
					not u.there_exists_native_real_32 (
								agent (x: REAL_32): BOOLEAN
									do
										Result := 0 < x
									end,
								{INTEGER_8}.Min_value, {INTEGER_8} -1
							)
				)

			assert (
					"positive too",
					u.there_exists_native_real_32 (
							agent (x: REAL_32): BOOLEAN
								do
									Result := 0 < x
								end,
							{INTEGER_8}.Min_value, {INTEGER_8}.Max_value
						)
				)
		end

	test_there_exists_native_real_64
			-- Test {EFFECTIVE_UNIVERSE}.there_exists_native_real_64.
		note
			testing: "covers/{EFFECTIVE_UNIVERSE}.there_exists_native_real_64"
		local
			u: like universe_to_be_tested
		do
			u := universe_to_be_tested
			assert (
					"negative only",
					not u.there_exists_native_real_64 (
								agent (x: REAL_64): BOOLEAN
									do
										Result := 0 < x
									end,
								{INTEGER_8}.Min_value, {INTEGER_8} -1
							)
				)

			assert (
					"positive too",
					u.there_exists_native_real_64 (
							agent (x: REAL_64): BOOLEAN
								do
									Result := 0 < x
								end,
							{INTEGER_8}.Min_value, {INTEGER_8}.Max_value
						)
				)
		end

	test_there_exists_g_instance
			-- Test {EFFECTIVE_UNIVERSE}.there_exists_g_instance.
		note
			testing: "covers/{EFFECTIVE_UNIVERSE}.there_exists_g_instance"
		local
			u: like universe_to_be_tested
			s: SET [G]
			eq: REFERENCE_EQUALITY [G]
		do
				-- Let's make something.
			create {EFFECTIVE_SET [G]} s
			create eq
			s := s.extended (a, eq)
			s := s.extended (b, eq)
			s := s.extended (c, eq)
			s := s.extended (d, eq)

			u := universe_to_be_tested
			{MEMORY}.full_collect
			assert (
					"no identity breaking",
					not u.there_exists_g_instance (
								agent (x: G): BOOLEAN
									do
										Result := x /= x
									end,
								{MEMORY}.objects_instance_of_type (({G}).type_id)
							)
				)

			{MEMORY}.full_collect
			assert (
					"Need some luck (or cheating).",
					u.there_exists_g_instance (
							agent (x: G): BOOLEAN
								do
									Result := attached x and then x.out.has ('b')
								end,
							{MEMORY}.objects_instance_of_type (({G}).type_id)
						)
				)

			s := s.prunned (a) -- `s' and its elements keep their existence until here.
		end

feature -- Factory (element to be tested)

	universe_to_be_tested: EFFECTIVE_UNIVERSE [G]
			-- Universe meant to be under tests
		do
			create Result
		ensure then
			class
		end

note
	copyright: "Copyright (c) 2012-2026, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
