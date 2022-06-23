def monthly_fixed_payment_calc(balance: int | float, annualInterestRate: float) -> str:
    '''
    Returns the minimum monthly payment needed in order pay off a credit card balance within 12 months.

    Parameters
    ----------
    balance : int or float 
        the outstanding balance on the credit card
    annualInterestRate : float 
        annual interest rate as a decimal

    Return value
    ----------
    returns : str 
        a string with the lowest possible payment that can be made to pay off the credit card balance whitin 12 months
    '''
    monthly_payment = 10
    original_balance = balance

    while True:
        i = 1
        while i < 13:
            monthly_interest_rate = annualInterestRate / 12.0
            monthly_unpaid_balance = balance - monthly_payment
            balance = monthly_unpaid_balance + (monthly_interest_rate * monthly_unpaid_balance)
            i += 1

        if balance > 0:
            monthly_payment += 10
            balance = original_balance
            continue
        else:
            break

    return f"Lowest Payment: ${monthly_payment}"

print(monthly_fixed_payment_calc(3329, 0.2))
print(monthly_fixed_payment_calc(4773, 0.2))
print(monthly_fixed_payment_calc(3926, 0.2))