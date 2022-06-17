# Longest substring in alphabetical order is: beggh
s = 'azcbobobegghakl'

def chars_in_alphabetical_order(string):
    chars = list(string)
    consecutive_chars = ""
    longest = ""

    for i, char in enumerate(chars):
        try:
            if char <= chars[i + 1]:
                consecutive_chars = consecutive_chars + char
            else:
                consecutive_chars = consecutive_chars + char
                consecutive_chars = consecutive_chars + "-"
        except:
            continue

    lst = consecutive_chars.split("-")

    for word in lst:
        if len(word) > len(longest):
            longest = word

    return longest

print(chars_in_alphabetical_order(s))