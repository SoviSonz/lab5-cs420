import random
import time



# quick sort 
def quick_sort(arr):
    if len(arr) <= 1:
        return arr # if the list has a length of 1 or 0, then return it (already sorted)
    pivot = arr[len(arr) // 2]
    left = [x for x in arr if x < pivot] # elements less than the pivot
    middle = [x for x in arr if x == pivot] # elements equal to the pivot
    right = [x for x in arr if x > pivot] # elements greater than the pivot
    return quick_sort(left) + middle + quick_sort(right) # recursively sort left and right parts and combine



# merge sort 
def merge_sort(arr):
    if len(arr) <= 1:
        return arr # if the list has a length of 1 or 0, then return it (already sorted)
    mid = len(arr) // 2 
    left = arr[:mid] # left half of the array
    right = arr[mid:] # right half of the array
    return merge(merge_sort(left), merge_sort(right)) # recursively sort left and right halves and merge them



def merge(left, right):
    result = [] # Resulting merged list
    i = j = 0
    # add smaller element to the list and increment index value of list that was chosen between the two
    while i < len(left) and j < len(right):
        if left[i] < right[j]:
            result.append(left[i]) 
            i += 1
        else:
            result.append(right[j])
            j += 1
    # add leftover elements to results list 
    result.extend(left[i:]) 
    result.extend(right[j:]) 
    return result



# time function
def time_it(func, *args):
    start = time.time() # record start time
    result = func(*args) # perform the function with given arguments
    end = time.time() # record end time
    return result, end - start # return the result and the time it took to finish



# test function
def test_sorts():
    random_arr = [random.randint(1, 1000) for _ in range(1000)] # generate a list of 1000 random numbers
    ordered_arr = [num for num in range(0, 1001)]
    reversed_arr = [num for num in range(1000, -1, -1)]


    # quick sort 
    print("Testing quick sort on random array of 1000 integers:")
    _, quick_sort_time = time_it(quick_sort, random_arr) # time quick sort algorithm on random array
    print(f"Time elapsed: {quick_sort_time} seconds\n\n") 

    print("Testing quick sort on ordered array of 1000 integers:")
    _, quick_sort_time = time_it(quick_sort, ordered_arr) # time quick sort algorithm on ordered array
    print(f"Time elapsed: {quick_sort_time} seconds\n\n") 

    print("Testing quick sort on reversed array of 1000 integers:")
    _, quick_sort_time = time_it(quick_sort, reversed_arr) # time quick sort algorithm on reversed array
    print(f"Time elapsed: {quick_sort_time} seconds\n\n") 


    # since it passes by reference...
    random_arr = [random.randint(1, 1000) for _ in range(1000)]
    ordered_arr = [num for num in range(0, 1001)]
    reversed_arr = [num for num in range(1000, -1, -1)]

    
    # merge sort
    print("Testing merge sort on random array of 1000 integers:")
    _, merge_sort_time = time_it(merge_sort, random_arr) # time merge sort algorithm
    print(f"Time elapsed: {merge_sort_time} seconds\n\n") 

    print("Testing merge sort on ordered array of 1000 integers:")
    _, merge_sort_time = time_it(merge_sort, ordered_arr) # time merge sort algorithm
    print(f"Time elapsed: {merge_sort_time} seconds\n\n") 

    print("Testing merge sort on reversed array of 1000 integers:")
    _, merge_sort_time = time_it(merge_sort, reversed_arr) # time merge sort algorithm
    print(f"Time elapsed: {merge_sort_time} seconds\n\n") 

if __name__ == "__main__":
    test_sorts() # main driver
