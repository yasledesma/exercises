num = int(input("Enter an interger: "))

for pwr in reversed(range(1, 6)):
    root = num ** (1/pwr)
    if round(root % num, 1) == round(root):
        print("Root =", round(root), "Power =", pwr)
        break
# ??? I really don't understand how this works, but it's the only way I find it does???
else:
    print(f"Root and power of {num} don't exist in the range 0 < pwr < 6.") 