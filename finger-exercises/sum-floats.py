import re

def sum_floats(str):
    nums = re.split(r"[\s,]+", str)
    sum = 0

    for num in nums:
        sum += float(num)

    return sum

print(sum_floats("1.23, 2.4, 23.123"))
print(sum_floats("5.32, 6.25, 8.5"))
print(sum_floats("2.587, 43.4, 2.96"))
print(sum_floats("19.123, 9.55, 9.158"))