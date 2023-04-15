'''
    NSSA 244 Script Assignment 1
    Author: Sam Sit
'''

# Task 1
function Show-Menu {
    # Print list of options
    Write-Host "`nEnter your option (1-7)"
    Write-Host "`t1. Create a VM"
    Write-Host "`t2. List the available VMs"
    Write-Host "`t3. Start a VM"
    Write-Host "`t4. Stop a VM"
    Write-Host "`t5. List the settings of a particular VM"
    Write-Host "`t6. Delete a VM"
    Write-Host "`t7. End the program`n"

    # Ask user for command
    $command = Read-Host ">> "
    return $command
}

# Task 2
function Process-Command($command) {
    try {
        $command = [int]$command
    }
    catch {
        Write-Host "Invalid command. Please retry."
    }

    if ($command -eq 1) {
        Write-Host "1 - Create a VM"
        Create-VM
    }
    elseif ($command -eq 2) {
        Write-Host "2 - List the available VMs"
        List-VM
    }
    elseif ($command -eq 3) {
        Write-Host "3 - Start a VM"
        Start-VM
    }
    elseif ($command -eq 4) {
        Write-Host "4 - Stop a VM"
        Stop-VM
    }
    elseif ($command -eq 5) {
        Write-Host "5 - List the settings of a particular VM"
        Describe-VM
    }
    elseif ($command -eq 6) {
        Write-Host "6 - Delete a VM"
        Delete-VM
    }
    elseif ($command -eq 7) {
        Write-Host "7 - End the program"
        End-Program
    }
}

# Task 2.1 - creating and configuring the VM
function Create-VM {
    $VMName = Read-Host "Enter a name for the VM"
    
    $VM = @{
        Name = $VMName
        MemoryStartupBytes = 2147483648
        Generation = 2
        NewVHDPath = "C:\Virtual Machines\$VMName\$VMName.vhdx"
        NewVHDSizeBytes = 53687091200
        BootDevice = "VHD"
        Path = "C:\Virtual Machines\$VMName"
        SwitchName = (Get-VMSwitch).Name
    }
    
    New-VM @VM

    Write-Host "VM $VMName has been created."
}


# Task 2.2 - listing all the VMs
function List-VM {
    param()

    # Get a list of VMs
    $vms = Get-VM

    # Display the list of VMs with a number prefix
    $index = 1
    $vms | ForEach-Object {
        Write-Host "$index. $_"
        $index++
    }
}

# Task 2.3 - starting a VM
function Start-VM {
    param()

    # Call the List-VM function to get a list of available VMs
    $vms = Get-VM

    # Prompt the user to select a VM to start
    Write-Host "Select a virtual machine to start:"
    $index = 1
    $vms | ForEach-Object {
        Write-Host "$index. $_"
        $index++
    }

    $selectedVM = Read-Host "Enter the number of the VM to start"

    # Get the name of the selected VM
    $VMName = $vms[$selectedVM - 1]

    try {
        # Start the selected VM
        Write-Host "Starting VM: $VMName"
        Start-VM -Name $VMName
        Write-Host "VM '$VMName' has been started."
    } catch {
        # Catch and print any errors that occur
        Write-Host "Failed to start VM '$VMName'. Error: $_" -ForegroundColor Red
    }
}


# Task 2.4 - stopping a VM
function Stop-VM {
    List-VM

}

# Task 2.5 - listing the settings of a VM
function Describe-VM {
    List-VM

}

# Task 2.6 - deleting a VM
function Delete-VM {
    List-VM

}

# Task 2.7 - end the program
function End-Program {
    exit
}

function main() {
    while ($true) {
        Process-Command(Show-Menu)
    }
}

main