type Pos = (Int, Int)

origin :: Pos
origin = (0,0)

left :: Pos -> Pos
--left (x,y) = (x-1,y)
left (x,y)
    | x - 1 < 0 = (80,y)
    | otherwise = (x-1,y)

right :: Pos -> Pos
--right (x,y) = (x+1,y)
right (x,y)
    | x + 1 > 80 = (0,y)
    | otherwise = (x+1,y)

up :: Pos -> Pos
-- up (x,y) = (x,y+1)
up (x,y)
    | y + 1 > 80 = (x,0)
    | otherwise = (x,y+1)

down :: Pos -> Pos
--down (x,y) = (x,y-1)
down (x,y)
    | y - 1 < 0 = (x,80)
    | otherwise = (x,y-1)