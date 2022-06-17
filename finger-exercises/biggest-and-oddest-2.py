def biggest_and_oddest_2(num_1, num_2, num_3, num_4, num_5, num_6, num_7, num_8, num_9, num_10):
    nums = sorted(locals().values(), reverse = True)

    for num in nums:
        if num % 2 != 0:
            return f"Biggest odd number: {num}"
    
    return "There are no odd numbers."
            

print(biggest_and_oddest_2(1, 2, 3, 4, 5, 6, 7, 8, 9, 10))
print(biggest_and_oddest_2(2, 4, 6, 8, 10, 12, 14, 16, 18, 20))