asect 0x00

# Program to replace array elements with -1 if negative
# and +1 if non-negative
# Works OK (unless you can tell otherwise!!}

ldi r1, length
ld  r1, r1       # r1 loaded with length of array
clr r2           # r2 used for index

while            # Loop entry setup:
  cmp r2, r1     #   compare index with array length
stays lt         # Test:  are there any items left to examine?
  ldi r3, content  # r3 = start address of array items
  add r2, r3       # r3 = address of next item              
  ld  r3, r0       # r0 = next item
  if               # Setup:
    tst r0       # test next item 
  is mi            # Test:  is it negative?
    ldi r0, -1    # if so, replace it with -1
    st r3, r0
  else
    ldi r0, 1     # otherwise replace it with +1
    st  r3, r0
  fi
  inc r2           # move the index on by 1
wend             # go back to loop entry setup


halt

length: dc 15
content : dc 12,5,-6,23,4,1,88,0,-1,17,1,-9,1,4,15

end