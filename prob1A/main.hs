{-# OPTIONS_GHC -O2 -optc-O2 #-}

import Data.Char (isSpace)
import qualified Data.ByteString as BS
import qualified Data.ByteString.Char8 as BSC

solve :: Integer -> Integer -> Integer -> Integer
solve n m a = ((n + a - 1) `div` a) * ((m + a - 1) `div` a)

main = 
  do all <- BS.getContents
     let Just (n, r1) = readInteger all
     let Just (m, r2) = readInteger r1
     let Just (a, _)  = readInteger r2
     print (solve n m a)
  where readInteger s = BSC.readInteger (BSC.dropWhile isSpace s)
