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

#Task 2
def process_command(command):
    try:
        command = int(command)
    except:
        print("Invalid command. Please retry.\n")
    if command == 1:
        print("1")
    elif command == 2:
        print("2")
    elif command == 3:
        print("3")
    elif command == 4:
        print("4")
    elif command == 5:
        print("5")
    elif command == 6:
        print("6")
    elif command == 7:
        print("Command 7")
        print("Exiting the program")
        exit()
    else:
        print("Incorrect command. Please retry.\n")

def main():
    process_command(text_menu())

main()