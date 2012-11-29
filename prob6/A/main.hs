import Data.List (or, sort, tails)

triangle (a, b, c) = a < b + c && b < a + c && c < a + b

main = do
    s <- getLine
    let snums = sort [read x | x <- words s]
    let combs = [(a, b, c) |
                    (a : ss)  <- tails snums,
                    (b : ss') <- tails ss,
                    c <- ss']
    let msg = if or [triangle comb | comb <- combs] then "TRIANGLE"
              else if or [c == a + b | (a, b, c) <- combs] then "SEGMENT"
              else "IMPOSSIBLE"
    putStrLn msg
