note
	description: "Implementation of {STST_ELEMENT_TESTS}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"
	TODO: "AutoTest may confuse {STST_ELEMENT_TESTS} with {ELEMENT_TESTS}."

class
	ELEMENT_EFFECTIVE_TESTS

inherit
	STST_ELEMENT_TESTS
		rename
			some_immediate_natural_number as some_expanded_natural_number,
			some_immediate_integer_number as some_expanded_integer_number,
			some_immediate_rational_number as some_expanded_rational_number
		undefine
			default_create
		redefine
			test_all,
			test_is_in,
			test_is_not_in,
			same_natural_number,
			some_natural_set,
			same_integer_number,
			some_integer_set,
			same_rational_number
		end

	EQA_TEST_SET

feature -- Test routines (All)

	test_all
			-- <Precursor>
		note
			testing: "covers/{STS_ELEMENT}"
		do
			Precursor {STST_ELEMENT_TESTS}
		end

feature -- Test routines (Membership)

	test_is_in
			-- <Precursor>
		note
			testing: "covers/{STS_ELEMENT}.is_in"
		do
			Precursor {STST_ELEMENT_TESTS}
		end

	test_is_not_in
			-- <Precursor>
		note
			testing: "covers/{STS_ELEMENT}.is_not_in"
		do
			Precursor {STST_ELEMENT_TESTS}
		end

feature -- Factory (Element)

	some_elements: STI_SET [STS_ELEMENT]
			-- <Precursor>
		do
			across
				1 |..| some_count.as_integer_32 as i
			from
				create Result
			loop
				Result := Result.extended (some_element, some_element_equality)
			end
		end

feature -- Factory (natural number)

	same_natural_number (n: STS_NATURAL_NUMBER): like some_natural_number
			-- <Precursor>
		do
			inspect
				next_random_item \\ 2
			when 0 then
				Result := Precursor {STST_ELEMENT_TESTS} (n)
			when 1 then
				create {STI_NATURAL_NUMBER} Result.make (n.value)
			end
		end

	some_expanded_natural_number: STI_NATURAL_NUMBER
			-- <Precursor>
		do
			Result := some_native_natural_number
		end

	some_native_natural_number: NATURAL
			-- Randomly-created native natural number
		do
			Result := next_random_item.as_natural_32
		end

	some_immediate_set_n: STI_SET [STS_NATURAL_NUMBER]
			-- <Precursor>
		do
			check
				s: attached {STI_SET [STS_NATURAL_NUMBER]} some_immediate_instance (
							agent: STI_SET [STS_NATURAL_NUMBER]
								do
									across
										1 |..| some_count.as_integer_32 as i
									from
										create Result
									loop
										Result := Result.extended (some_natural_number, some_equality_n)
									end
								end
						) as s -- `some_immediate_instance' definition
				monomorphic: s.generating_type ~ {detachable STI_SET [STS_NATURAL_NUMBER]}
			then
				Result := cropped_set (s)
			end
		end

	some_immediate_universe_n: STI_UNIVERSE [STS_NATURAL_NUMBER]
			-- <Precursor>
		do
			check
				u: attached {STI_UNIVERSE [STS_NATURAL_NUMBER]} some_immediate_instance (
							agent: STI_UNIVERSE [STS_NATURAL_NUMBER]
								do
									create Result
								end
						) as u -- `some_immediate_instance' definition
				monomorphic: u.generating_type ~ {detachable STI_UNIVERSE [STS_NATURAL_NUMBER]}
			then
				Result := u
			end
		end

	some_natural_set: STS_NATURAL_SET
			-- <Precursor>
		do
			inspect
				next_random_item \\ 2
			when 0 then
				Result := Precursor {STST_ELEMENT_TESTS}
			when 1 then
				Result := some_natural_complement_set
			end
		end

	some_immediate_natural_set: STI_NATURAL_SET
			-- <Precursor>
		do
			check
				s: attached {STI_NATURAL_SET} some_immediate_instance (
							agent: STI_NATURAL_SET
								do
									across
										1 |..| some_count.as_integer_32 as i
									from
										create Result
									loop
										Result := Result.extended (some_natural_number)
									end
								end
						) as s -- `some_immediate_instance' definition
				monomorphic: s.generating_type ~ {detachable STI_NATURAL_SET}
			then
				Result := cropped_set (s)
			end
		end

	some_natural_complement_set: STI_NATURAL_COMPLEMENT_SET
			-- Randomly-fetched polymorphic natural-number complement set
		do
			Result := some_immediate_natural_complement_set
		end

	some_immediate_natural_complement_set: STI_NATURAL_COMPLEMENT_SET
			-- Randomly-fetched monomorphic natural-number complement set
		do
			check
				s: attached {STI_NATURAL_COMPLEMENT_SET} some_immediate_instance (
							agent: STI_NATURAL_COMPLEMENT_SET
								local
									s: like some_set_n
								do
									s := some_set_n
									create Result.make (s)
								end
						) as s -- `some_immediate_instance' definition
				monomorphic: s.generating_type ~ {detachable STI_NATURAL_COMPLEMENT_SET}
			then
				Result := cropped_set (s)
			end
		end

	some_immediate_natural_universe: STI_NATURAL_NUMBERS
			-- <Precursor>
		do
			check
				n: attached {STI_NATURAL_NUMBERS} some_immediate_instance (
							agent: STI_NATURAL_NUMBERS
								do
									create Result
								end
						) as n -- `some_immediate_instance' definition
				monomorphic: n.generating_type ~ {detachable STI_NATURAL_NUMBERS}
			then
				Result := n
			end
		end

feature -- Factory (integer number)

	same_integer_number (i: STS_INTEGER_NUMBER): like some_integer_number
			-- <Precursor>
		do
			inspect
				next_random_item \\ 2
			when 0 then
				Result := Precursor {STST_ELEMENT_TESTS} (i)
			when 1 then
				create {STI_INTEGER_NUMBER} Result.make (i.value)
			end
		end

	some_expanded_integer_number: STI_INTEGER_NUMBER
			-- <Precursor>
		do
			Result := some_native_integer_number
		end

	some_native_integer_number: INTEGER
			-- Randomly-created native integer number
		do
			Result := next_random_item
		end

	some_immediate_set_i: STI_SET [STS_INTEGER_NUMBER]
			-- <Precursor>
		do
			check
				s: attached {STI_SET [STS_INTEGER_NUMBER]} some_immediate_instance (
							agent: STI_SET [STS_INTEGER_NUMBER]
								do
									across
										1 |..| some_count.as_integer_32 as i
									from
										create Result
									loop
										Result := Result.extended (some_integer_number, some_equality_i)
									end
								end
						) as s -- `some_immediate_instance' definition
				monomorphic: s.generating_type ~ {detachable STI_SET [STS_INTEGER_NUMBER]}
			then
				Result := cropped_set (s)
			end
		end

	some_immediate_universe_i: STI_UNIVERSE [STS_INTEGER_NUMBER]
			-- <Precursor>
		do
			check
				u: attached {STI_UNIVERSE [STS_INTEGER_NUMBER]} some_immediate_instance (
							agent: STI_UNIVERSE [STS_INTEGER_NUMBER]
								do
									create Result
								end
						) as u -- `some_immediate_instance' definition
				monomorphic: u.generating_type ~ {detachable STI_UNIVERSE [STS_INTEGER_NUMBER]}
			then
				Result := u
			end
		end

	some_integer_set: STS_INTEGER_SET
			-- <Precursor>
		do
			inspect
				next_random_item \\ 2
			when 0 then
				Result := Precursor {STST_ELEMENT_TESTS}
			when 1 then
				Result := some_integer_complement_set
			end
		end

	some_immediate_integer_set: STI_INTEGER_SET
			-- <Precursor>
		do
			check
				s: attached {STI_INTEGER_SET} some_immediate_instance (
							agent: STI_INTEGER_SET
								do
									across
										1 |..| some_count.as_integer_32 as i
									from
										create Result
									loop
										Result := Result.extended (some_integer_number)
									end
								end
						) as s -- `some_immediate_instance' definition
				monomorphic: s.generating_type ~ {detachable STI_INTEGER_SET}
			then
				Result := cropped_set (s)
			end
		end

	some_integer_complement_set: STI_INTEGER_COMPLEMENT_SET
			-- Randomly-fetched polymorphic integer-number complement set
		do
			Result := some_immediate_integer_complement_set
		end

	some_immediate_integer_complement_set: STI_INTEGER_COMPLEMENT_SET
			-- Randomly-fetched monomorphic integer-number complement set
		do
			check
				s: attached {STI_INTEGER_COMPLEMENT_SET} some_immediate_instance (
							agent: STI_INTEGER_COMPLEMENT_SET
								local
									s: like some_set_i
								do
									s := some_set_i
									create Result.make (s)
								end
						) as s -- `some_immediate_instance' definition
				monomorphic: s.generating_type ~ {detachable STI_INTEGER_COMPLEMENT_SET}
			then
				Result := cropped_set (s)
			end
		end

	some_immediate_integer_universe: STI_INTEGER_NUMBERS
			-- <Precursor>
		do
			check
				z: attached {STI_INTEGER_NUMBERS} some_immediate_instance (
							agent: STI_INTEGER_NUMBERS
								do
									create Result
								end
						) as z -- `some_immediate_instance' definition
				monomorphic: z.generating_type ~ {detachable STI_INTEGER_NUMBERS}
			then
				Result := z
			end
		end

feature -- Factory (rational number)

	same_rational_number (r: STS_RATIONAL_NUMBER): like some_rational_number
			-- <Precursor>
		do
			inspect
				next_random_item \\ 2
			when 0 then
				Result := Precursor {STST_ELEMENT_TESTS} (r)
			when 1 then
				Result := same_rational_number (r)
--				create {STI_RATIONAL_NUMBER} Result.make (i.value)
			end
		end

	some_expanded_rational_number: STI_RATIONAL_NUMBER
			-- <Precursor>
		local
			den: like some_integer_number
		do
			from
				den := some_integer_number
			until
				den ≭ den.zero
			loop
				den := some_integer_number
			end
			create Result.make (some_integer_number, den)
		end

--	some_native_rational_number: RATIONAL
--			-- Randomly-created native rational number
--		do
--			Result := next_random_item
--		end

	some_immediate_set_r: STI_SET [STS_RATIONAL_NUMBER]
			-- <Precursor>
		do
			check
				s: attached {STI_SET [STS_RATIONAL_NUMBER]} some_immediate_instance (
							agent: STI_SET [STS_RATIONAL_NUMBER]
								do
									across
										1 |..| some_count.as_integer_32 as i
									from
										create Result
									loop
										Result := Result.extended (some_rational_number, some_equality_r)
									end
								end
						) as s -- `some_immediate_instance' definition
				monomorphic: s.generating_type ~ {detachable STI_SET [STS_RATIONAL_NUMBER]}
			then
				Result := cropped_set (s)
			end
		end

	some_immediate_universe_r: STI_UNIVERSE [STS_RATIONAL_NUMBER]
			-- <Precursor>
		do
			check
				u: attached {STI_UNIVERSE [STS_RATIONAL_NUMBER]} some_immediate_instance (
							agent: STI_UNIVERSE [STS_RATIONAL_NUMBER]
								do
									create Result
								end
						) as u -- `some_immediate_instance' definition
				monomorphic: u.generating_type ~ {detachable STI_UNIVERSE [STS_RATIONAL_NUMBER]}
			then
				Result := u
			end
		end

--	some_rational_set: STS_RATIONAL_SET
--			-- <Precursor>
--		do
--			inspect
--				next_random_item \\ 2
--			when 0 then
--				Result := Precursor {STST_ELEMENT_TESTS}
--			when 1 then
--				Result := some_rational_complement_set
--			end
--		end

--	some_immediate_rational_set: STI_RATIONAL_SET
--			-- <Precursor>
--		do
--			check
--				s: attached {STI_RATIONAL_SET} some_immediate_instance (
--							agent: STI_RATIONAL_SET
--								do
--									across
--										1 |..| some_count.as_rational_32 as i
--									from
--										create Result
--									loop
--										Result := Result.extended (some_rational_number)
--									end
--								end
--						) as s -- `some_immediate_instance' definition
--				monomorphic: s.generating_type ~ {detachable STI_RATIONAL_SET}
--			then
--				Result := cropped_set (s)
--			end
--		end

--	some_rational_complement_set: STI_RATIONAL_COMPLEMENT_SET
--			-- Randomly-fetched polymorphic rational-number complement set
--		do
--			Result := some_immediate_rational_complement_set
--		end

--	some_immediate_rational_complement_set: STI_RATIONAL_COMPLEMENT_SET
--			-- Randomly-fetched monomorphic rational-number complement set
--		do
--			check
--				s: attached {STI_RATIONAL_COMPLEMENT_SET} some_immediate_instance (
--							agent: STI_RATIONAL_COMPLEMENT_SET
--								local
--									s: like some_set_r
--								do
--									s := some_set_r
--									create Result.make (s)
--								end
--						) as s -- `some_immediate_instance' definition
--				monomorphic: s.generating_type ~ {detachable STI_RATIONAL_COMPLEMENT_SET}
--			then
--				Result := cropped_set (s)
--			end
--		end

--	some_immediate_rational_universe: STI_RATIONAL_NUMBERS
--			-- <Precursor>
--		do
--			check
--				z: attached {STI_RATIONAL_NUMBERS} some_immediate_instance (
--							agent: STI_RATIONAL_NUMBERS
--								do
--									create Result
--								end
--						) as z -- `some_immediate_instance' definition
--				monomorphic: z.generating_type ~ {detachable STI_RATIONAL_NUMBERS}
--			then
--				Result := z
--			end
--		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
