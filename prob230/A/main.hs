{-# OPTIONS_GHC -O3 -optc-O3 #-}

import Data.List (sort)

fight s [] = "YES"
fight s ((x, y) : ds) | s > x     = fight (s + y) ds
                      | otherwise = "NO"

getPair = do
    pair <- getLine
    let (x : y : _) = (map read . words) pair
    return (x, y)

getDragons 0 acc = return acc
getDragons n acc = do
    (x, y) <- getPair
    getDragons (n - 1) ((x, y) : acc)

main = do 
    (s, n) <- getPair 
    dragons <- getDragons n []
    putStrLn (fight s (sort dragons))
