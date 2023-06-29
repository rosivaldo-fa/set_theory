note
	description: "st_bugs application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS_32

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			s: MUTABLE_SET [NATURAL, OBJECT_EQUALITY [NATURAL]]
		do
			--| Add your code here
			create s.make_singleton (0)
			s.put (1)
			s.put (2)
			s.put (3)
			print (s)
		end

end
