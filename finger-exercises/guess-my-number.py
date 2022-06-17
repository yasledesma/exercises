start_of_range = 5
end_of_range = 50
current_range = end_of_range - start_of_range
guess = current_range / 2

# while True:
#     question = input("Enter 'h' to indicate the guess is too high. Enter 'l' to indicate the guess is too low. Enter 'c' to indicate I guessed correctly: ")

#     if question == "h":
#         end_of_range = guess + 1
#         range = end_of_range - start_of_range
#     elif question == "l":
#         start_of_range = guess - 1
#         range = end_of_range - start_of_range
#     else:
#         print("Game over. Your secret number was:", guess)
#         break

# print("New range:", current_range, "Guess:", guess)

for num in range(start_of_range, end_of_range):
    if num == guess:
        print(f"Is your guess {num + current_range} (y, l, h)?")
        break