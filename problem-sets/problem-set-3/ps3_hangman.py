# Hangman game
#

# -----------------------------------
# Helper code
# You don't need to understand this helper code,
# but you will have to know how to use the functions
# (so be sure to read the docstrings!)

import random
import string

WORDLIST_FILENAME = "/home/yasmin/cs/exercises/problem-sets/problem-set-3/words.txt"

def loadWords():
    """
    Returns a list of valid words. Words are strings of lowercase letters.
    
    Depending on the size of the word list, this function may
    take a while to finish.
    """
    print("Loading word list from file...")
    # inFile: file
    inFile = open(WORDLIST_FILENAME, 'r')
    # line: string
    line = inFile.readline()
    # wordlist: list of strings
    wordlist = line.split()
    print("  ", len(wordlist), "words loaded.")
    return wordlist

def chooseWord(wordlist):
    """
    wordlist (list): list of words (strings)

    Returns a word from wordlist at random
    """
    return random.choice(wordlist)

# end of helper code
# -----------------------------------

# Load the list of words into the variable wordlist
# so that it can be accessed from anywhere in the program
wordlist = loadWords()



def isWordGuessed(secretWord, lettersGuessed):
    '''
    secretWord: string, the word the user is guessing
    lettersGuessed: list, what letters have been guessed so far
    returns: boolean, True if all the letters of secretWord are in lettersGuessed;
      False otherwise
    '''
    for letter in secretWord:
      if letter in lettersGuessed:
        continue
      else:
        return False
    
    return True



def getGuessedWord(secretWord, lettersGuessed):
    '''
    secretWord: string, the word the user is guessing
    lettersGuessed: list, what letters have been guessed so far
    returns: string, comprised of letters and underscores that represents
      what letters in secretWord have been guessed so far.
    '''
    guessed_word = list("_" * len(secretWord))

    if lettersGuessed == []:
      return " ".join(guessed_word)

    for letter in lettersGuessed:
      if " ".join(guessed_word) == secretWord:
        break
      idx = [i for i, e in enumerate(secretWord) if e == letter]
      if idx != []:
        for i in idx:
          guessed_word[i] = letter
    
    return " ".join(guessed_word)



def getAvailableLetters(lettersGuessed):
    '''
    lettersGuessed: list, what letters have been guessed so far
    returns: string, comprised of letters that represents what letters have not
      yet been guessed.
    '''
    remaining_letters = list(string.ascii_lowercase)
    
    for letter in lettersGuessed:
      if letter in remaining_letters:
        remaining_letters.pop(remaining_letters.index(letter))
    
    return "".join(remaining_letters)
    


def hangman(secretWord):
    '''
    secretWord: string, the secret word to guess.

    Starts up an interactive game of Hangman.

    * At the start of the game, let the user know how many 
      letters the secretWord contains.

    * Ask the user to supply one guess (i.e. letter) per round.

    * The user should receive feedback immediately after each guess 
      about whether their guess appears in the computers word.

    * After each round, you should also display to the user the 
      partially guessed word so far, as well as letters that the 
      user has not yet guessed.

    Follows the other limitations detailed in the problem write-up.
    '''
    welcome_message = f"Welcome to the game Hangman!\nI am thinking of a word that is {len(secretWord)} letters long...\n-------------"
    print(welcome_message)

    GUESSES_LEFT = 8

    lettersGuessed = list()

    guess_message = None

    while GUESSES_LEFT > 0:
      if isWordGuessed(secretWord, lettersGuessed):
        print("Congratulations, you won!")
        break

      available_letters = getAvailableLetters(lettersGuessed)
      message = f"You have {GUESSES_LEFT} guesses left.\nAvailable letters: {available_letters}."
      print(message)
      letter = input("Please guess a letter: ")
      
      if letter in lettersGuessed:
        guess_message = "Oops! You've already guessed that letter"
      else:
        lettersGuessed.append(letter)
        if letter in secretWord:
          guess_message = "Good guess"
        else:
          guess_message = "Oops! That letter is not in my word"
          GUESSES_LEFT -= 1

      print(f"{guess_message}: {getGuessedWord(secretWord, lettersGuessed)}")
      print("-------------")
    
    if GUESSES_LEFT == 0:
      print(f"Sorry, you ran out of guesses. The word was {secretWord}. ")






# When you've completed your hangman function, uncomment these two lines
# and run this file to test! (hint: you might want to pick your own
# secretWord while you're testing)

secretWord = chooseWord(wordlist).lower()
hangman(secretWord)
