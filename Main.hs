import System.Random (randomRIO)
import Control.Monad (replicateM)
import System.CPUTime (getCPUTime)



-- Quick Sort
quickSort :: Ord a => [a] -> [a]
quickSort [] = [] -- in the case of an empty list (meaning it is already sorted)
quickSort (x:xs) =
  quickSort [y | y <- xs, y <= x] -- recursively sort elements less than or equal to the pivot (x)
  ++ [x] ++ -- add the pivot to the middle
  quickSort [y | y <- xs, y > x] -- recursively sort elements greater than the pivot (x)



-- Merge Sort
mergeSort :: Ord a => [a] -> [a]
mergeSort [] = [] -- in the case of an empty list (meaning it is already sorted)
mergeSort [x] = [x] -- in the case of a single element list (meaning it is already sorted)
mergeSort xs = merge (mergeSort left) (mergeSort right) -- recursively sort and merge left and right halves
  where
    (left, right) = splitAt (length xs `div` 2) xs -- split list into two equal halves
    merge :: Ord a => [a] -> [a] -> [a] -- merge function for combining sorted lists 
    -- if one list is empty, return the other list (for next two lines)
    merge xs [] = xs 
    merge [] ys = ys 
    merge (x:xs) (y:ys)
      -- add smaller element between x and y to results and continue merging
      | x <= y    = x : merge xs (y:ys) 
      | otherwise = y : merge (x:xs) ys
      
      
      
      
-- For timing the results of merge sort and quick sort
timeIt :: IO a -> IO (a, Double)
timeIt action = do
    start <- getCPUTime -- record start time
    result <- action -- perform the action
    end <- getCPUTime -- record end time
    let diff = fromIntegral (end - start) / 10^12 -- calculate time in secoods (end - start)
    return (result, diff) -- return the result and time taken




-- Test function (main driver)
testSorts :: IO ()
testSorts = do
    randomNumbers <- replicateM 1000 (randomRIO (1, 1000) :: IO Int) -- generate a list of 1000 random numbers
    let sortedNumbers = [1..1000] :: [Int]
    let reverseSortedNumbers = reverse sortedNumbers
    
    -- quick sort
    putStrLn "Quick sort on randomNumbers:"
    (_, quickSortTime) <- timeIt $ return $ quickSort randomNumbers -- time the quick sort function
    putStrLn $ "Time elapsed: " ++ show quickSortTime ++ " seconds\n\n" -- print times of quick sort

    putStrLn "Quick sort on sortedNumbers:"
    (_, quickSortTime) <- timeIt $ return $ quickSort sortedNumbers -- time the quick sort function
    putStrLn $ "Time elapsed: " ++ show quickSortTime ++ " seconds\n\n"  -- print times of quick sort
    
    putStrLn "Quick sort on reverseSortedNumbers:"
    (_, quickSortTime) <- timeIt $ return $ quickSort reverseSortedNumbers -- time the quick sort function
    putStrLn $ "Time elapsed: " ++ show quickSortTime ++ " second\n\n"  -- print times of quick sort

    -- merge sort 
    putStrLn "Merge sort randomNumbers:"
    (_, mergeSortTime) <- timeIt $ return $ mergeSort randomNumbers -- time the merge sort function
    putStrLn $ "Time elapsed: " ++ show mergeSortTime ++ " seconds\n\n" -- print times for merge sort

    putStrLn "Merge sort on sortedNumbers:"
    (_, mergeSortTime) <- timeIt $ return $ mergeSort sortedNumbers -- time the merge sort function
    putStrLn $ "Time elapsed: " ++ show mergeSortTime ++ " seconds\n\n" -- print times for merge sort

    putStrLn "Merge sort on reverseSortedNumbers:"
    (_, mergeSortTimeRandom) <- timeIt $ return $ mergeSort reverseSortedNumbers -- time the merge sort function
    putStrLn $ "Time taken: " ++ show mergeSortTimeRandom ++ " seconds" -- print times for merge sort


main :: IO ()
main = testSorts -- main
