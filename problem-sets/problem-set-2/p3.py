from itertools import count, takewhile
def frange(start, stop, step):
    return takewhile(lambda x: x< stop, count(start, step))

def monthly_fixed_payment_calc_bs(balance, annualInterestRate):
    original_balance = balance
    monthly_interest_rate = annualInterestRate / 12.0
    lower_bound = balance / 12
    upper_bound = (balance * ((1 + monthly_interest_rate)**12)) / 12.0
    boundary = 0.2

    while True:
        balance = original_balance
        monthly_payment = (lower_bound + upper_bound)/2
        i = 1

        while i < 13:
            monthly_unpaid_balance = balance - monthly_payment
            balance = monthly_unpaid_balance + (monthly_interest_rate * monthly_unpaid_balance)
            i += 1

        if balance > boundary:
            lower_bound = monthly_payment
        elif balance < - boundary:
            upper_bound = monthly_payment
        else:
            break

    return f"Lowest Payment: ${round(monthly_payment, 2)}"

print(monthly_fixed_payment_calc_bs(320000, 0.2))
print(monthly_fixed_payment_calc_bs(999999, 0.2))