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
			some_immediate_natural_number as some_expanded_natural_number
		undefine
			default_create
		redefine
			test_all,
			test_is_in,
			test_is_not_in,
			same_natural_number
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

	some_immediate_set_of_natural_numbers: STI_SET [STS_NATURAL_NUMBER]
			-- <Precursor>
		do
			check
				s: attached {STI_SET [STS_NATURAL_NUMBER]} some_immediate_instance (
							agent: STI_SET [STS_NATURAL_NUMBER]
								local
									eq: STS_OBJECT_EQUALITY [STS_NATURAL_NUMBER]
								do
									across
										1 |..| some_count.as_integer_32 as i
									from
										create eq
										create Result
									loop
										Result := Result.extended (some_natural_number, eq)
									end
								end
						) as s -- `some_immediate_instance' definition
				monomorphic: s.generating_type ~ {detachable STI_SET [STS_NATURAL_NUMBER]}
			then
				Result := cropped_set (s)
			end
		end

	some_immediate_universe_of_natural_numbers: STI_UNIVERSE [STS_NATURAL_NUMBER]
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

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
