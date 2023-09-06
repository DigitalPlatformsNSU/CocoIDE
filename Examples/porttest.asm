# Port test program
# Ml Walters July 2018
asect 0

start:
	# print message
	ldi r0, msg
	ldi r2, 0xe0
	while
		ldc r0, r1 # Works with VN or HV Arch
		tst r1
	stays nz
		st r2, r1
		inc r0
		inc r2
	wend
	
loop:
	ldi r0, 0xf0 # Port address
	# Wait for button press (in r3)
	do 
		ld r0, r3
		tst r3
	until nz
	# Wait for button release
	do
		ld r0, r2
		tst r2
	until z
	
	# Next iteration
	# test pattern 1
	ldi r1, 0b10101010 
	do
		st r0, r1
		inc r0
	until z
	
	# delay - use commented out values if running Fast!
	ldi r0, 1#255
	ldi r1, 1#10
	do
		do
			dec r0
		until z
		dec r1
	until z
	
	# test pattern 2
	ldi r0, 0xf0
	ldi r1, 0b01010101 
	do
		st r0, r1
		inc r0
	until z
	
	br loop
	
	halt
msg: dc "Hello World!", 0
end	

