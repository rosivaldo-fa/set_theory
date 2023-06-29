﻿note
	description: "test application root class"
	date: "$Date: 2019-09-11 18:27:54 +0000 (Wed, 11 Sep 2019) $"
	revision: "$Revision: 103504 $"

class
	APPLICATION

create
	make

feature -- Initialization

	make
			-- Run application.
		do
			show_mutable_set_of_separate_references
		end

	show_mutable_set_of_separate_references
			-- Do some operations upon a mutable set of separate references.
		note
			EIS: "name=Bug: separate clause defeats void-safety", "protocol=URI", "src=https://support.eiffel.com/report_detail/19891", "tag=bug, compiler, void-safety"
			EIS: "name=Bug: Unexpected syntax error on descendant of ITERABLE", "protocol=URI", "src=https://groups.google.com/g/eiffel-users/c/J_sGnOIqCJM", "tag=bug, compiler, iteration"
		local
			c1: separate CHARACTER_REF
			c2: CHARACTER_REF
			c3: CHARACTER
			cs1: MUTABLE_SET [detachable separate CHARACTER_REF, STS_REFERENCE_EQUALITY [detachable separate CHARACTER_REF]]
			cs2: STI_SET [detachable separate CHARACTER_REF, STS_REFERENCE_EQUALITY [detachable separate CHARACTER_REF]]
		do
			create cs1.make_singleton (Void)
			check
				void_inserted: # cs1 = 1
			end
			create c1
			separate c1 as sep_c1 do
				sep_c1.set_item ('a')
			end
			cs1.put (c1)
			check
				c1_inserted: # cs1 = 2
			end
			create c2
			c2.set_item ('a')
			cs1.put (c2)
			check
				c2_inserted: # cs1 = 3
			end
			c3 := 'a'
			cs1.put (c3)
			check
				c3_inserted: # cs1 = 4
			end
			cs1.put (c1)
			separate c1 as sep_c1 do
				cs1.put (sep_c1.item)
			end
			cs1.put (c2)
			cs1.put (c2.item)
			cs1.put (c3)
			cs1.put ('a')
			check
				no_change: # cs1 = 4
			end
			separate c1 as sep_c1 do
				cs1.put (sep_c1.twin)
			end
			check
				c1_twin_inserted: # cs1 = 5
			end
			cs1.put (c2.twin)
			check
				c2_twin_inserted: # cs1 = 6
			end
			cs1.put (c3.to_reference)
			check
				c3_reference_inserted: # cs1 = 7
			end
			print (cs1)
			io.new_line

			create cs2.make_empty
			cs2 := cs2 & c1 & c2 & c3
			print (cs1 ∩ cs2)
			io.new_line
			print (cs2 ∩ cs1)
			io.new_line
			print (cs1)
			io.new_line
			print (cs2)
			io.new_line
			cs1.intersect (cs2)
			print (cs1)
			io.new_line

			⟳
				c: cs1 ¦
				separate c as sep_c do -- BEWARE: Not void-safe! Please see https://support.eiffel.com/report_detail/19891
					if attached sep_c then
						print (create {STRING}.make_from_separate (sep_c.out))
					else
						print ("Void")
					end
				end
				print (' ')
			⟲
			io.new_line

				-- Unexpected syntax errors (https://groups.google.com/g/eiffel-users/c/J_sGnOIqCJM)
--			∃ c: cs1 ¦ c = Void
--			∀ c: cs1 ¦ c = c
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/Set-Theory"

end