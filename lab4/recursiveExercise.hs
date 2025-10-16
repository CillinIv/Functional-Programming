import System.Win32 (COORD(x), aCCESS_SYSTEM_SECURITY)
sumDown :: Int -> Int 


sumDown x
    | x > 0 = x + sumDown (x - 1)
    | otherwise = 0



exponention :: Int -> Int -> Int

exponention x y
    | y > 0 = x * exponention x (y - 1)
    | otherwise = 1



fibonacci :: Int -> Int

fibonacci x
    | x == 1 = 1
    | x == 0 = 0
    | otherwise = fibonacci(x - 1) + fibonacci(x - 2)


--mylnit :: [a] -> [a]

--mylint x
-- | x == [] = []

myAnd :: [Bool] -> Bool 

myAnd x
    | 

