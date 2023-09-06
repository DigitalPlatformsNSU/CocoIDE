#$arch=vn # Set Architecture to Von Neuman (vn) or Harvard (hv). 
#$page=0
       
		asect 0
L1:     setsp -16       # set stack 16 bytes below the end of memory (for I/O)
        ldi r0,0x80     # initialise regs.
		ldi r1, 0
		ldc r0, r1 		# Test for Harvard Arch ldc instr
        ldi r1,0x81
        ldi r2,0x82
        ldi r3,0x83
        pushall         # push all of  them onto the stack 

        clr r0
        clr r1
        clr r2
        clr r3          # now clear them all
        popall          # and pop the old values off the stack

        addsp -mydata._  	# allocate stack frame


           ldi     r1,"?"  	# some data

           ldsa    r2,mydata.a   # b="?"
           st      r2,r1

           ldsa    r2,mydata.b   # r2->c
           ld      r2,r3         # r3=c
           inc     r3            # r3=c+1
           st      r2,r3         # c=c+1 

        addsp mydata._  # deallocate stack frame
        halt
asect 0x80
test_ldc:		dc 0x11
        
################# local (automatic, stack) memory structure
        tplate mydata
# local variables on stack:
a:      ds      4	#$dec
b:      ds      4	#$hex	
c:      ds      6	#$hex

end


