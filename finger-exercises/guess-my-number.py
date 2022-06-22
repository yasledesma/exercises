# I should make this one better in the future.
print("Think of a number between 0 and 99.")

start_of_range = 0
end_of_range = 100

while True:
    try:
        current_range = list()
        for num in range(start_of_range, end_of_range):
            current_range.append(num)
        guess = current_range[int(len(current_range)/2)]

        question = input(f"Did you think of {guess}? Y(yes), H(high), L(low): ").lower()

        if question == "h":
            end_of_range = guess
            continue
        elif question == "l":
            start_of_range = guess + 1
            continue
        elif question == "c":
            print("Game over. Your secret number was:", guess)
            break
        else:
            print("Sorry, I did not understand your input.")
            continue
    except:
        # In case the start and end numbers are the same number, and the array length is reduced to 0.
        # Otherwise, this would throw an out of range index error and stop the program.
        print("Game over. Your secret number was", end_of_range)
        break
