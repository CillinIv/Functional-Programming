----------------------------------
-- add a type declaration
-- to each of the named expressions
i1:: Integer  -- I have done the first one for you
i1 = 45

i2 :: [Char]
i2 = "123"

i3 :: Bool
i3 = 45 <= i1

i4 :: Char
i4 = 'c'

i5 :: [[Char]]
i5 = ["abc","ok"]

i6 :: [Char]
i6 = head i5

i7 :: [Char]
i7 = tail "abc"  -- Recall a string is a shorthand for a list of Char

i8 :: (Bool, Double)
i8 = (True,4.5)

i9 :: [Integer]
i9 = [i1,34]

-------------------------------------------------
-- For each named expression replace "undefined"
-- with an expression with the same type as the declaration


j1:: (String,Integer)
j1 = ("String", 21)

j2:: [Integer]
j2 = [32,64,128]

j3:: Char
j3 = 'a'


j4:: Double
j4 = 3.142


j5:: (Integer,String,Integer,Char)
j5 = (32, "hello", 64, 'a')

j6:: ([Char],(Bool,String))
j6 = (['a','b'], (True, "greeting"))

j7:: [[Bool]]
j7 = [[True, False], [False, True]]

j8:: [(String,Bool)]
j8 = [("Hello", False), ("Greetings", True)]