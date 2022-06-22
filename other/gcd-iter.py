def gcdIter(a, b):
    '''
    a, b: positive integers
    
    returns: a positive integer, the greatest common divisor of a & b.
    '''
    smallest_num = None
    largest_num = None
    
    if a < b:
        smallest_num = a
        largest_num = b
    else:
        smallest_num = b
        largest_num = a
    
    for num in reversed(range(2, smallest_num + 1)):
        if smallest_num % num == 0 and largest_num % num == 0:
            return num
        else:
            continue
    
    return 1

print(gcdIter(2, 12))
print(gcdIter(6, 12))
print(gcdIter(9, 12))
print(gcdIter(17, 12))