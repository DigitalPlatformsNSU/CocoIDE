#$page=0 # IDE Directive
asect 0x00

# Program to replace array elements with -1 if negative
# and +1 if non-negative
# BUG INSERTED (see below)
# Program now self-modifying. With this data set we get an infinite loop.
# Memory window and PC show the correct picture as long as you are not
# running in fastest mode (because it's an infinite loop)
# The following comments refer only to the given data set. Other data sets
# will cause different modifications (and therefore quite different behaviours)
# Watch carefully what happens to the source-code highlighting the second
# and subsequent times the "pl" condition in the "if" construct is encountered.
# A two-byte branch instruction hhas been replaced by
#   move r0, r1
#   add r0, r2
# so the source/object highlighting lingers on that line for two cycles
# After the third iteration the target address for the branch at the end of the
# loop has been changed to 0x01, and the highlighting simply cannot cope
# The PC contains 01, and the correct memory cell is highlighted, but the
# source/object highlighting is pointing at 'wend' (i.e. the branch instruction
# that has already been executed), which is at the other end of the program.

ldi r1, length
ldc  r1, r1       # r1 loaded with length of array
clr r2           # r2 used for index

while            # Loop entry setup:
  cmp r2, r1     #   compare index with array length
stays lt         # Test:  are there any items left to examine?  (MODIFIED 2nd iteration)
  ldi r3, content  # r3 = start address of array items
  add r2, r3       # r3 = address of next item              
  ldc  r3, r3       # THIS IS A STUDENT-INSPIRED BUG (should be ld r3, r0)
  if               # Setup:
    tst r0       # test next item 
  is pl            # Test:  is it non-negative?  (MODIFIED 1st iteration)
    ldi r0, 1    # if so, replace it with +1
  else
    ldi r0, -1     # otherwise replace it with -1
  fi
  st  r3, r0       # THIS IS WHERE THE BUG HAS ITS EFFECT
  inc r2           # move the index on by 1
wend             # go back to loop entry setup  (MODIFIED 3rd iteration)


halt

length: dc 15
content: dc 12,5,-6,23,4,1,88,0,-1,17,1,-9,1,4,15

end