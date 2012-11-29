{-# OPTIONS_GHC -O2 -optc-O2 #-}

import Data.List (partition, sort)
import Data.Char (ord)

reconstruct :: [Int] -> [Int] -> [Int]
reconstruct zs [] = zs
reconstruct zs (h : t) = h : (zs ++ t)

solve :: [Int] -> [Int] -> String
solve aliceNs bobNs | ds == bobNs   = "OK"
                    | otherwise     = "WRONG_ANSWER" 
    where
        ds = reconstruct zs (sort ns)
        (zs, ns) = partition (== 0) aliceNs

main = 
  do 
    aliceStr <- getLine
    bobStr <- getLine
    let intOfChar c = ord c - ord '0'
    let aliceNs = map intOfChar aliceStr
    let bobNs   = map intOfChar bobStr
    putStrLn (solve aliceNs bobNs)
