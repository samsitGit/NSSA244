'''
    NSSA 244 Script Assignment 1
    Author: Sam Sit
'''

VM_LIST = []

#Task 1
def text_menu():
    #Print list of options
    print("\nEnter your option (1-7)")
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

        if command == 1:
            print("1 - Create a VM")
            create_VM()

        elif command == 2:
            print("2 - List the available VMs")
            list_VM()

        elif command == 3:
            print("3 - Start a VM")
            start_VM()

        elif command == 4:
            print("4 - Stop a VM")
            stop_VM()

        elif command == 5:
            print("5 - List the settings of a particular VM")
            desc_VM()

        elif command == 6:
            print("6 - Delete a VM")
            dele_VM()
    
    except:
        print("Invalid command. Please retry.")

    if command == 7:
        print("7 - End the program")
        end_program()


#Task 2.1 - creating and configuring the VM
def create_VM():
    print("Sure, here are a few questions to get started.")
    add_VM("test")
    add_VM("testB")
    print("VMs added")

#Task 2 helper function on adding VM to RAM
def add_VM(string):
    VM_LIST.append(string)

#Task 2.2 - listing all the VM
def list_VM():
    count = 1
    for i in VM_LIST:
        print(count, i)
        count += 1

#Task 2.3 - starting a VM
def start_VM():
    list_VM()
    start_VM_index = int(input(">> "))-1
    VM_LIST[start_VM_index] = "started"

#Task 2.4 - stopping a VM
def stop_VM():
    list_VM()
    start_VM_index = int(input(">> "))-1
    VM_LIST[start_VM_index] = "stopped"

#Task 2.5 - listing the settings of a VM
def desc_VM():
    list_VM()
    start_VM_index = int(input(">> "))-1
    VM_LIST[start_VM_index] = "desc'd"

#Task 2.6 - deleting a VM
def dele_VM():
    list_VM()
    start_VM_index = int(input(">> "))-1
    VM_LIST[start_VM_index] = "deleted"

#Task 2.7 - end the program
def end_program():
    exit()

def main():
    while True:
        process_command(text_menu())

main()