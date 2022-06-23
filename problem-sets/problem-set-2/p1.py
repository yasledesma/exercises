def yearly_credit_balance_calc(balance: int | float, annualInterestRate: float, monthlyPaymentRate: float) -> str:
    '''
    Returns the end-of-the-year credit balance for someone who's only been making 
    the minimum montly payment on their credit card.

    Parameters
    ----------
    balance : int or float 
        the outstanding balance on the credit card
    annualInterestRate : float 
        annual interest rate as a decimal
    monthlyPaymentRate : float 
        minimum monthly payment rate as a decimal

    Return value
    ----------
    returns : str 
        a string with the remaining balance at the end of a 12 month period
    '''

    i = 1

    while i < 13:
        monthly_interest_rate = annualInterestRate / 12.0
        minimum_monthly_payment = monthlyPaymentRate * balance
        monthly_unpaid_balance = balance - minimum_monthly_payment
        monthly_balance = monthly_unpaid_balance + (monthly_interest_rate * monthly_unpaid_balance) 
        balance = monthly_balance
        i += 1

    return f"Remaining balance: ${round(monthly_balance, 2)}"


print(yearly_credit_balance_calc(42, 0.2, 0.04))
print(yearly_credit_balance_calc(484, 0.2, 0.04))