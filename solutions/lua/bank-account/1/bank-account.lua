local BankAccount = {}
BankAccount.__index = BankAccount

function BankAccount:new()
    local instance = {
        _balance = 0,
        _is_open = true  -- Accounts start open as per tests
    }
    return setmetatable(instance, self)
end

function BankAccount:balance()
    if not self._is_open then
        error("Cannot check balance of a closed account")
    end
    return self._balance
end

function BankAccount:deposit(amount)
    if not self._is_open then
        error("Cannot deposit into a closed account")
    end
    if amount <= 0 then
        error("Deposit amount must be positive")
    end
    self._balance = self._balance + amount
end

function BankAccount:withdraw(amount)
    if not self._is_open then
        error("Cannot withdraw from a closed account")
    end
    if amount <= 0 then
        error("Withdrawal amount must be positive")
    end
    if amount > self._balance then
        error("Insufficient funds")
    end
    self._balance = self._balance - amount
end

function BankAccount:close()
    if not self._is_open then
        error("Account is already closed")
    end
    self._is_open = false
    self._balance = 0
end

return BankAccount