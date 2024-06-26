#include <iostream>
#include <array>
#include <string>

using namespace std;

const int MAX_ACCOUNTS = 100;

string usernames[MAX_ACCOUNTS];
string passwords[MAX_ACCOUNTS];
double balances[MAX_ACCOUNTS];
int accountCount = 0;

bool registerUser(string username, string password) {
    if (accountCount >= MAX_ACCOUNTS) {
        cout << "Bank is at full capacity." << endl;
        return false;
    }
    for (int i = 0; i < accountCount; ++i) {
        if (usernames[i] == username) {
            cout << "Username already exists." << endl;
            return false;
        }
    }
    usernames[accountCount] = username;
    passwords[accountCount] = password;
    balances[accountCount] = 0.0;
    accountCount++;
    cout << "User registered successfully." << endl;
    return true;
}

int findAccount(string username, string password) {
    for (int i = 0; i < accountCount; ++i) {
        if (usernames[i] == username && passwords[i] == password) {
            return i;
        }
    }
    return -1;
}

int findRecipAccount(string username) {
    for (int i = 0; i < accountCount; ++i) {
        if (usernames[i] == username) {
            return i;
        }
    }
    return -1;
}

void checkBalance(int index) {
    cout << "Current balance: " << balances[index] << endl;
}

void depositMoney(int index, double amount) {
    if (amount > 0) {
        balances[index] += amount;
        cout << "Deposited: " << amount << ". New balance: " << balances[index] << endl;
    } else {
        cout << "Deposit amount must be positive." << endl;
    }
}

void closeAccount(int index, string username) {
    --accountCount;
    cout << "Account closed." << endl;
    for (int i = index; i < accountCount; ++i) {
        usernames[i] = usernames[i + 1];
        passwords[i] = passwords[i + 1];
        balances[i] = balances[i + 1];
    }
}

void editUserDetails(int index) {
    string newUsername, newPassword;
    cout << "Enter new username: ";
    cin >> newUsername;
    cout << "Enter new password: ";
    cin >> newPassword;

    for (int i = 0; i < accountCount; ++i) {
        if (usernames[i] == newUsername && i != index) {
            cout << "Username already exists. Try a different one." << endl;
            return;
        }
    }

    usernames[index] = newUsername;
    passwords[index] = newPassword;
    cout << "User details updated successfully." << endl;
}

void transferMoney(int fromIndex, int toIndex, double amount) {
    if (amount > 0 && balances[fromIndex] >= amount) {
        balances[fromIndex] -= amount;
        balances[toIndex] += amount;
        cout << "Transfer of $" << amount << " successful." << endl;
        cout << "New balance of sender: " << balances[fromIndex] << endl;
    } else {
        cout << "Transfer failed. Invalid amount or insufficient balance." << endl;
    }
}

int main() {
    int choice;
    string username, password;
    double amount;

    while (true) {
        cout << "\nBanking System Menu:\n";
        cout << "1. Register\n";
        cout << "2. Deposit Money\n";
        cout << "3. Check Balance\n";
        cout << "4. Transfer Money\n";
        cout << "5. Edit User Details\n";
        cout << "6. Close Account\n";
        cout << "7. Exit\n";
        cout << "Enter your choice: ";
        cin >> choice;

        switch (choice) {
            case 1:
                cout << "Enter username: ";
                cin >> username;
                cout << "Enter password: ";
                cin >> password;
                registerUser(username, password);
                break;
            case 2:
                cout << "Enter username: ";
                cin >> username;
                cout << "Enter password: ";
                cin >> password;
                {
                    int index = findAccount(username, password);
                    if (index != -1) {
                        cout << "Enter amount to deposit: ";
                        cin >> amount;
                        depositMoney(index, amount);
                    } else {
                        cout << "Invalid username or password." << endl;
                    }
                }
                break;
            case 3:
                cout << "Enter username: ";
                cin >> username;
                cout << "Enter password: ";
                cin >> password;
                {
                    int index = findAccount(username, password);
                    if (index != -1) {
                        checkBalance(index);
                    } else {
                        cout << "Invalid username or password." << endl;
                    }
                }
                break;
            case 4:
                cout << "Enter sender's username: ";
                cin >> username;
                cout << "Enter sender's password: ";
                cin >> password;
                {
                    int senderIndex = findAccount(username, password);
                    if (senderIndex != -1) {
                        cout << "Enter recipient's username: ";
                        cin >> username;
                        int recipientIndex = findRecipAccount(username);
                        if (recipientIndex != -1) {
                            cout << "Enter amount to transfer: ";
                            cin >> amount;
                            transferMoney(senderIndex, recipientIndex, amount);
                        } else {
                            cout << "Recipient account not found." << endl;
                        }
                    } else {
                        cout << "Invalid username or password." << endl;
                    }
                }
                break;
            case 5:
                cout << "Enter username: ";
                cin >> username;
                cout << "Enter password: ";
                cin >> password;
                {
                    int index = findAccount(username, password);
                    if (index != -1) {
                        editUserDetails(index);
                    } else {
                        cout << "Invalid username or password." << endl;
                    }
                }
                break;
            case 6:
                cout << "Enter username: ";
                cin >> username;
                cout << "Enter password: ";
                cin >> password;
                {
                    int index = findAccount(username, password);
                    if (index != -1) {
                        closeAccount(index, username);
                    } else {
                        cout << "Invalid username or password." << endl;
                    }
                }
                break;
            case 7:
                cout << "Thank you for using the banking system. Goodbye!" << endl;
                return 0;
            default:
                cout << "Invalid choice. Please try again." << endl;
        }
    }

    return 0;
}
