note
	description: "Implementation of {STST_UNARY_TESTS}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	UNARY_TESTS [G]

inherit
	STST_UNARY_TESTS [G]
		rename
			some_immediate_natural_number as some_expanded_natural_number
		undefine
			default_create
		redefine
			some_set_g
		end

	ELEMENT_TESTS
		undefine
			test_all,
			test_is_in,
			test_is_not_in,
			some_element
		end

feature -- Factory (Set)

	some_set_g: STS_SET [G]
			-- <Precursor>
		do
			inspect
				next_random_item \\ 2
			when 0 then
				Result := Precursor {STST_UNARY_TESTS}
			when 1 then
				Result := some_complement_set_g
			end
		end

	some_immediate_set_g: STI_SET [G]
			-- <Precursor>
		do
			check
				s: attached {STI_SET [G]} some_immediate_instance (
							agent: STI_SET [G]
								do
									across
										1 |..| some_count.as_integer_32 as i
									from
										create Result
									loop
										Result := Result.extended (some_object_g, some_equality_g)
									end
								end
						) as s -- `some_immediate_instance' definition
				monomorphic: s.generating_type ~ {detachable STI_SET [G]}
			then
				Result := cropped_set (s)
			end
		end

	some_complement_set_g: STS_SET [G]
			-- Randomly-fetched polymorphic complement set of elements like {G}
		do
			Result := some_immediate_complement_set_g
		end

	some_immediate_complement_set_g: STI_COMPLEMENT_SET [G]
			-- Randomly-fetched monomorphic complement set of elements like {G}
		do
			check
				s: attached {STI_COMPLEMENT_SET [G]} some_immediate_instance (
							agent: STI_COMPLEMENT_SET [G]
								local
									s: like some_set_g
								do
									s := some_set_g
									create Result.make (s)
								end
						) as s -- `some_immediate_instance' definition
				monomorphic: s.generating_type ~ {detachable STI_COMPLEMENT_SET [G]}
			then
				Result := cropped_set (s)
			end
		end

	some_immediate_set_sg: STI_SET [STS_SET [G]]
			-- <Precursor>
		do
			check
				s: attached {STI_SET [STS_SET [G]]} some_immediate_instance (
							agent: STI_SET [STS_SET [G]]
								do
									across
										1 |..| some_count.as_integer_32 as i
									from
										create Result
									loop
										Result := Result.extended (some_set_g, some_equality_sg)
									end
								end
						) as s -- `some_immediate_instance' definition
				monomorphic: s.generating_type ~ {detachable STI_SET [STS_SET [G]]}
			then
				Result := cropped_set (s)
			end
		end

	some_immediate_set_family_g: STI_SET_FAMILY [G]
			-- <Precursor>
		do
			check
				sf: attached {STI_SET_FAMILY [G]} some_immediate_instance (
							agent: STI_SET_FAMILY [G]
								do
									across
										1 |..| some_count.as_integer_32 as i
									from
										create Result
									loop
										Result := Result.extended (some_set_g, some_equality_sg)
									end
								end
						) as sf -- `some_immediate_instance' definition
				monomorphic: sf.generating_type ~ {detachable STI_SET_FAMILY [G]}
			then
				Result := cropped_set (sf)
			end
		end

	some_immediate_universe_g: STI_UNIVERSE [G]
			-- <Precursor>
		do
			check
				u: attached {STI_UNIVERSE [G]} some_immediate_instance (
							agent: STI_UNIVERSE [G]
								do
									create Result
								end
						) as u -- `some_immediate_instance' definition
				monomorphic: u.generating_type ~ {detachable STI_UNIVERSE [G]}
			then
				Result := u
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
