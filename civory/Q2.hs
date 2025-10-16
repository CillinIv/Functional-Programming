-- Please fill in your name and student number
-- Student Name : Cillín Ivory  
-- Student Number : 20083798

-- This question is worth  30 Marks



--  In this section replace each "X2 = undefined" with "X2 = fully-parenthesiszed-expression"



-- such that X1 and X2 evaluate to the same value.

-- You may want to consult the table of precedences (see Lab-03)

-- you should use ghci to check is your answer correct.

--- For example I have done "a2" below



a1 = 3 + 5 * 5

a2 = (3 + (5 * 5))





------------------------------

b1:: Bool

b1 = 10 == 2 + 4

b2 =  (10 == (2 + 4))



------------------------------

c1 = length [1,2,3] + 5 * 6

c2 = (length [1,2,3] + (5 * 6))



-----------------------------

d1 = 5 ^ length [3,3,4]

d2 =  (5 ^ (length[3,3,4]))



-----------------------------

e1 = head [2,3,4]  ^ 2*3

e2 = (head [2,3,4] ^ 2 )*3



-----------------------------

f1 = 3 == 4  &&  2 > 5 * 3

f2 =  ((3 == 4)  &&  2 > (5 * 3))



------------------------------

g1 = True && 3 < 4 `div`3

g2 = (True && 3 < (4 `div`3))



