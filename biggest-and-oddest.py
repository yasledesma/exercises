# Write a program that examines three variables - x, y, and z -and prints the largest odd number
# among them.
# If none of them are odd, it should print a message to that effect.

def biggest_and_oddest(x, y, z):
    nums = sorted([x, y, z], reverse = True)

    for num in nums:
        if num % 2 != 0:
            return f"Biggest odd number: {num}"
    
    return "There are no odd numbers."
            

print(biggest_and_oddest(57, 1599, 28))
print(biggest_and_oddest(95, 169, 27))
print(biggest_and_oddest(100, 1456, 2))