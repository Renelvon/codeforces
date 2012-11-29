{-# OPTIONS_GHC -O2 -optc-O2 #-}

import Data.Char (isSpace)
import qualified Data.ByteString as BS
import qualified Data.ByteString.Char8 as BSC

solve 0 0 (gotA, remA) (gotB, remB) tot
    | gotA + gotB <= tot - 2    = solve (head remA) (head remB) (gotA + 1, tail remA) (gotB + 1, tail remB) tot
    | gotA + gotB == tot - 1    = (gotA + 1, gotB)
    | otherwise                 = (gotA, gotB)

solve tA 0 (stateA@(gotA, remA)) (gotB, remB) tot
    | gotA + gotB <= tot - 1    = solve tA (head remB) stateA (gotB + 1, tail remB) tot
    | otherwise                 = (gotA, gotB) 

solve 0 tB (gotA, remA) (stateB@(gotB, remB)) tot
    | gotA + gotB <= tot - 1    = solve (head remA) tB (gotA + 1, tail remA) stateB tot
    | otherwise                 = (gotA, gotB) 

solve tA tB stateA stateB tot
    | tA > tB                   = solve (tA - tB) 0 stateA stateB tot
    | otherwise                 = solve 0 (tB - tA) stateA stateB tot

main = 
  do all <- BS.getContents
     let Just (tot, r1) = readInt all
     let (ls, _)  = readMany readInt r1
     let (totA, totB) = solve 0 0 (0, ls) (0, reverse ls) tot
     putStrLn (show totA ++ " " ++ show totB)
  where readInt s = BSC.readInt (BSC.dropWhile isSpace s)
        readMany readf s = case readf s of
          Just (x, r) -> let (xs, t) = readMany readf r
                         in  (x : xs, t)
          Nothing     -> ([], s)
