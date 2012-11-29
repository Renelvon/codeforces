import Data.Char (ord)
import Data.List (intercalate)

solve (0, 0) = (0, [])
solve (0, ny) | ny > 0    = (ny, replicate ny "U")
              | otherwise = (negate ny, replicate (negate ny) "D")
solve (nx, 0) | nx > 0    = (nx, replicate nx "R")
              | otherwise = (negate nx, replicate (negate nx) "L")
solve (nx, ny)
    | nx > 0 && ny > 0  = (n + n', ms ++ replicate n "RU")
    | nx > 0 && ny < 0  = (n + n', ms ++ replicate n "RD")
    | nx < 0 && ny > 0  = (n + n', ms ++ replicate n "LU")
    | nx < 0 && ny < 0  = (n + n', ms ++ replicate n "LD")
    where
        n = if abs nx <= abs ny then abs nx else abs ny
        (n', ms) = solve (nx', ny')
        nx' = (abs nx - n) * signum nx
        ny' = (abs ny - n) * signum ny

main = do
    sxc <- getChar
    sy <- readLn
    txc <- getChar
    ty <- readLn
    let sx = ord sxc - ord 'a'
    let tx = ord txc - ord 'a'
    let (n, moves) = solve (tx - sx, ty - sy)
    print n
    putStrLn $ intercalate "\n" moves
