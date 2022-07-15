def genPrimes():
    primes = [2]

    counter = 2

    while True:
        rest = list()

        if counter == primes[-1]:
            yield counter
        
        for x in primes:
            if counter % x == 0:
                rest.append(x)
        
        if len(rest) > 0:
            counter += 1
        else:
            primes.append(counter)
            counter += 1
            yield primes[-1]

    
primeGenerator = genPrimes()

print(primeGenerator.__next__())
print(primeGenerator.__next__())
print(primeGenerator.__next__())
print(primeGenerator.__next__())
print(primeGenerator.__next__())
print(primeGenerator.__next__())
print(primeGenerator.__next__())
print(primeGenerator.__next__())
print(primeGenerator.__next__())
print(primeGenerator.__next__())