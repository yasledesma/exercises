def isIn(char, aStr):
    '''
    char: a single character
    aStr: an alphabetized string
    
    returns: True if char is in aStr; False otherwise
    '''
    try:
        middle = aStr[round(len(aStr)/2)]

        if char == middle :
            return True
        else:
            if char < middle:
                return isIn(char, aStr[:round(len(aStr)/2)])
            else:
                return isIn(char, aStr[round(len(aStr)/2):])
    except:
        return False

print(isIn("z", "abcdefghijklmnopq"))