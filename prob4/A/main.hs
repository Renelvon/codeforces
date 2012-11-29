main = do
    w <- readLn
    let msg = if even w && w > 2 then "YES" else "NO"
    putStrLn msg
