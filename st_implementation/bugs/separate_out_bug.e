note
	description: "Object that reproduces a bug on {ANY}.out value of separate, generic objects"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name={(separate) A}.out inconsistent results", "protocol=URI", "src=https://support.eiffel.com/report_detail/19890", "tag=separate, bug, compiler, SCOOP"

deferred class
	SEPARATE_OUT_BUG [A]

feature -- Bug

	reproduce_separate_out_bug
			-- Reproduce a bug on `out' value of separate, generic objects.
		note
			EIS: "name={(separate) A}.out inconsistent results", "protocol=URI", "src=https://support.eiffel.com/report_detail/19890", "tag=separate, bug, compiler, SCOOP"
		local
			a: A
			s1, s2: STRING
		do
			from
			until False
			loop
				a := some_object_a
				s1 := object_out (a)
				s2 := object_out (a)
				check
					s1.hash_code = s2.hash_code
				then
				end
			end
		ensure
			class
		end

feature {NONE} -- Implementation

	some_object_a: A
			-- Some object of type {A}
		deferred
		ensure
			class
		end

	object_out (a: A): STRING
			-- New string containing terse printable representation of `a'
		do
			if a /= Void then
				create Result.make_from_separate (a.out)
			else
				create Result.make_empty
			end
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
