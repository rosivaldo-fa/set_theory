note
	description: "Test suite for {UNIVERSE}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	UNIVERSE_TESTS [G]

inherit
	SET_TESTS [G]
		rename
			set_to_be_tested as universe_to_be_tested
		redefine
			test_all,
			test_has,
			test_does_not_have
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {UNIVERSE}.
		note
			testing: "covers/{UNIVERSE}"
		do
			Precursor {SET_TESTS}
			test_there_exists_character_8
			test_there_exists_character_32
			test_there_exists_native_natural
			test_there_exists_native_integer
			test_there_exists_native_real_32
			test_there_exists_native_real_64
		end

feature -- Test routines (Initialization)

	test_default_create
			-- Test {UNIVERSE}.default_create.
		note
			testing: "covers/{UNIVERSE}.default_create"
		do
			assert ("default_create", attached (create {like universe_to_be_tested}))
		end

feature -- Test routines (Membership)

	test_has
			-- Test {UNIVERSE}.has.
		note
			testing: "covers/{UNIVERSE}.has"
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
			-- Test {UNIVERSE}.does_not_have.
		note
			testing: "covers/{UNIVERSE}.does_not_have"
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
			-- Test {UNIVERSE}.out.
		note
			testing: "covers/{UNIVERSE}.out"
		do
			assert ("out", attached universe_to_be_tested.out)
		end

feature -- Test routines (Status report)

	test_debug_output
			-- Test {UNIVERSE}.debug_output.
		note
			testing: "covers/{UNIVERSE}.debug_output"
		do
			assert ("debug_output", attached universe_to_be_tested.debug_output)
		end

feature -- Test routines (Quantifier)

	test_there_exists_character_8
			-- Test {UNIVERSE}.there_exists_character_8.
		note
			testing: "covers/{UNIVERSE}.there_exists_character_8"
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
			-- Test {UNIVERSE}.there_exists_character_32.
		note
			testing: "covers/{UNIVERSE}.there_exists_character_32"
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

	test_there_exists_native_natural
			-- Test {UNIVERSE}.there_exists_native_natural.
		note
			testing: "covers/{UNIVERSE}.there_exists_native_natural"
		local
			u: like universe_to_be_tested
		do
			u := universe_to_be_tested
			assert (
					"NATURAL_8",
					not u.there_exists_native_natural (
								agent (n: NATURAL_64): BOOLEAN
									do
										Result := n.out.count > 3
									end,
								{NATURAL_8} 0, {NATURAL_8}.Max_value
							)
				)

			assert (
					"NATURAL_16",
					u.there_exists_native_natural (
							agent (n: NATURAL_64): BOOLEAN
								do
									Result := n.out.count > 3
								end,
							{NATURAL_16} 0, {NATURAL_16}.Max_value
						)
				)
			assert (
					"NATURAL_32",
					u.there_exists_native_natural (
							agent (n: NATURAL_64): BOOLEAN
								do
									Result := n.out.count > 5
								end,
							{NATURAL_32} 0, {NATURAL_32}.Max_value
						)
				)
		end

	test_there_exists_native_integer
			-- Test {UNIVERSE}.there_exists_native_integer.
		note
			testing: "covers/{UNIVERSE}.there_exists_native_integer"
		local
			u: like universe_to_be_tested
		do
			u := universe_to_be_tested
			assert (
					"INTEGER_8",
					not u.there_exists_native_integer (
								agent (i: INTEGER_64): BOOLEAN
									do
										Result := i.out.count > 4
									end,
								{INTEGER_8}.Min_value, {INTEGER_8}.Max_value
							)
				)

			assert (
					"INTEGER_16",
					u.there_exists_native_integer (
							agent (i: INTEGER_64): BOOLEAN
								do
									Result := i.out.count > 4
								end,
							{INTEGER_16}.Min_value, {INTEGER_16}.Max_value
						)
				)
		end

	test_there_exists_native_real_32
			-- Test {UNIVERSE}.there_exists_native_real_32.
		note
			testing: "covers/{UNIVERSE}.there_exists_native_real_32"
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
			-- Test {UNIVERSE}.there_exists_native_real_64.
		note
			testing: "covers/{UNIVERSE}.there_exists_native_real_64"
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

feature -- Factory (element to be tested)

	universe_to_be_tested: UNIVERSE [G]
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
