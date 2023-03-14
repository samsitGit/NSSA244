'''
    NSSA 244 Script Assignment 1
    Author: Sam Sit
'''

#Task 1
def text_menu():
    #Print list of options
    print("Enter your option (1-7)")
    print("\t1. Create a VM")
    print("\t2. List the available VMs")
    print("\t3. Start a VM")
    print("\t4. Stop a VM")
    print("\t5. List the settings of a particular VM")
    print("\t6. Delete a VM")
    print("\t7. End the program\n")

    #Ask user for command
    command = input(">> ")
    return command

def main():
    text_menu()

main()