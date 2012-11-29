{-# OPTIONS_GHC -O2 -optc-O2 #-}

import Data.List (groupBy, intercalate, partition, sort)

readNamesTR 0 acc = return acc
readNamesTR n acc = do
    s <- getLine
    readNamesTR (n - 1) (s : acc)

count (names, surnames) = preparedfullnames 
    where
        preparedfullnames = (prepare names, prepare surnames)
        prepare = (map tag) . (groupBy sameInit) . sort
        tag x = (length x, (head . head) x, x)
        sameInit name1 name2 = head name1 == head name2

thrd (_, _, x) = x

push [] acc = acc
push (x : xs) acc = push xs (x : acc)

alignTR acc namestack surnamestack _    ([], ss) = zip namestack (push (concatMap thrd ss) surnamestack) ++ acc
alignTR acc namestack surnamestack diff (ns, []) = zip (push (concatMap thrd ns) namestack) surnamestack ++ acc
alignTR acc namestack surnamestack diff (ns@((countn, cn, ln) : ns'), ss@((counts, cs, ls) : ss'))
    | cn < cs                           = alignTR acc (push ln namestack) surnamestack (diff + countn) (ns', ss)
    | cs < cn                           = alignTR acc namestack (push ls surnamestack) (diff - counts) (ns, ss')
    | countn == counts                  = alignTR (zip ln ls ++ acc) namestack surnamestack diff (ns', ss')

    | countn > counts && diff == 0      = let (ln', ln'') = splitAt counts ln in
        alignTR (zip ln' ls ++ acc) (push ln'' namestack) surnamestack (countn - counts) (ns', ss')

    | countn > counts && diff > 0       = let (ln', ln'') = splitAt counts ln in
        alignTR (zip ln' ls ++ acc) namestack surnamestack diff ((countn - counts, cn, ln'') : ns', ss')

    | countn > counts && diff < 0       = let draw = min (abs diff) (countn - counts) in let (ln', ln'') = splitAt draw ln in
        alignTR acc (push ln' namestack) surnamestack (diff + draw) ((countn - draw, cn, ln'') : ns', ss)

    | countn < counts && diff == 0      = let (ls', ls'') = splitAt countn ls in
        alignTR (zip ln ls' ++ acc) namestack (push ls'' surnamestack) (countn - counts) (ns', ss')

    | countn < counts && diff > 0       = let draw = min diff (counts - countn) in let (ls', ls'') = splitAt draw ls in
        alignTR acc namestack (push ls' surnamestack) (diff - draw) (ns, (counts - draw, cs, ls'') : ss')

    | countn < counts && diff < 0       = let (ls', ls'') = splitAt countn ls in 
        alignTR (zip ln ls' ++ acc) namestack surnamestack diff (ns', (counts - countn, cs, ls'') : ss')

output cs = intercalate ", " $ map (\(x, y) -> x ++ " " ++ y) cs

solve = output . sort . (alignTR [] [] [] 0) . count

main = do 
     nS <- getLine
     let n = read nS
     names    <- readNamesTR n []
     surnames <- readNamesTR n []
     putStrLn (solve (names, surnames))
