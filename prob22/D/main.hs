{-# OPTIONS_GHC -O2 -optc-O2 #-}

import Data.List (foldl', sort, unwords)
import Data.Char (isSpace)
import qualified Data.ByteString as BS
import qualified Data.ByteString.Char8 as BSC

pin [] (total, pins) curminend = (total + 1, curminend : pins) 
pin ((start, end) : segs) sol@(total, pins) curminend
    | start > curminend     = pin segs (total + 1, curminend : pins) end
    | end < curminend       = pin segs sol end
    | otherwise             = pin segs sol curminend
        
main = 
  do all <- BS.getContents
     let Just (n, r1) = readInt all
     let ls = sort (readMany2TR readInt r1 [])
     let (tot, pins) = pin ls (0, []) maxend
     print tot
     putStrLn $ unwords $ map show pins
  where
    readInt s = BSC.readInt (BSC.dropWhile isSpace s)
    readMany2TR readf s acc = case readf s of
        Just (x, r) -> case readf r of
            Just (y, r') -> readMany2TR readf r' (orient x y : acc)
            Nothing      -> acc
        Nothing     -> acc
    orient a b | a < b      = (a, b)
               | otherwise  = (b, a)
    maxend = 10001
