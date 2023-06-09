'''
    NSSA 244 Script Assignment 1
    Author: Sam Sit

    Make sure you are using Windows 10 with Hyper-V set up with the following command:
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All

    Run the following command to run the script if your computer does not allow scripts:
    powershell -ExecutionPolicy Bypass -File SA01.ps1

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
        CreateVMFunc
    }
    elseif ($command -eq 2) {
        Write-Host "2 - List the available VMs"
        ListVMFunc
    }
    elseif ($command -eq 3) {
        Write-Host "3 - Start a VM"
        StartVMFunc
    }
    elseif ($command -eq 4) {
        Write-Host "4 - Stop a VM"
        StopVMFunc
    }
    elseif ($command -eq 5) {
        Write-Host "5 - List the settings of a particular VM"
        DescribeVMFunc
    }
    elseif ($command -eq 6) {
        Write-Host "6 - Delete a VM"
        DeleteVMFunc
    }
    elseif ($command -eq 7) {
        Write-Host "7 - End the program"
        End-Program
    }
}

# Task 2.1 - creating and configuring the VM
function CreateVMFunc {
    # Prompt the user to enter a name for the VM
    $VMName = Read-Host "Enter a name for the VM"
    
    # Define the VM properties using a hashtable
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
    
    # Create the VM using the New-VM cmdlet and pass the hashtable as parameters
    New-VM @VM

    # Display a confirmation message with the name of the created VM
    Write-Host "VM $VMName has been created."
}



# Task 2.2 - listing all the VMs
function ListVMFunc {
    param()

    # Call the Get-VM function to get a list of available VMs
    $vms = Get-VM

    $index = 1
    $vms | ForEach-Object {
        Write-Host "$index. $($_.Name)"
        $index++
    }

}

# Task 2.3 - starting a VM
function StartVMFunc {
    param()

    # Call the Get-VM function to get a list of available VMs
    $vms = Get-VM

    # Prompt the user to select a VM to start
    Write-Host "Select a virtual machine to start:"
    $index = 1
    $vms | ForEach-Object {
        Write-Host "$index. $($_.Name)"
        $index++
    }

    $selectedVM = Read-Host "Enter the number of the VM to start"

    # Get the name of the selected VM
    $selectedVMInfo = $vms[$selectedVM - 1]
    $VMName = $selectedVMInfo.Name

    try {
        # Start the selected VM
        Write-Host "Starting VM: $VMName"
        Start-VM -Name $VMName
        Write-Host "VM '$VMName' is started."
    }
    catch {
        # Catch and print any errors that occur
        Write-Host "Failed to start VM '$VMName'. Error: $_" -ForegroundColor Red
    }
}


# Task 2.4 - stopping a VM
function StopVMFunc {
    param()

    # Call the Get-VM function to get a list of available VMs
    $vms = Get-VM

    # Prompt the user to select a VM to stop
    Write-Host "Select a virtual machine to stop:"
    $index = 1
    $vms | ForEach-Object {
        Write-Host "$index. $($_.Name)"
        $index++
    }

    $selectedVM = Read-Host "Enter the number of the VM to stop"

    # Get the name of the selected VM
    $selectedVMInfo = $vms[$selectedVM - 1]
    $VMName = $selectedVMInfo.Name

    try {
        # Stop the selected VM
        Write-Host "Stopping VM: $VMName"
        Stop-VM -Name $VMName
        Write-Host "VM '$VMName' is stopped."
    }
    catch {
        # Catch and print any errors that occur
        Write-Host "Failed to stop VM '$VMName'. Error: $_" -ForegroundColor Red
    }
}

# Task 2.5 - listing the settings of a VM
function DescribeVMFunc {
    param()

    # Call the Get-VM function to get a list of available VMs
    $vms = Get-VM

    # Prompt the user to select a VM to get the settings
    Write-Host "Select a virtual machine to get the settings:"
    $index = 1
    $vms | ForEach-Object {
        Write-Host "$index. $($_.Name)"
        $index++
    }

    $selectedVM = Read-Host "Enter the number of the VM to get the settings"

    # Get the name of the selected VM
    $selectedVMInfo = $vms[$selectedVM - 1]
    $VMName = $selectedVMInfo.Name

    try {
        # Get the virtual hardware configuration settings of the selected VM
        $vm = Get-VM -Name $VMName
        $vm | Format-Table Name, State, CPUUsage, MemoryAssigned, Uptime, Status, Version -AutoSize

    }
    catch {
        # Catch and print any errors that occur
        Write-Host "Failed to get settings for VM '$VMName'. Error: $_" -ForegroundColor Red
    }
}


# Task 2.6 - deleting a VM
function DeleteVMFunc {
    param()

    # Call the Get-VM function to get a list of available VMs
    $vms = Get-VM

    # Prompt the user to select a VM to delete
    Write-Host "Select a virtual machine to delete:"
    $index = 1
    $vms | ForEach-Object {
        Write-Host "$index. $($_.Name)"
        $index++
    }

    $selectedVM = Read-Host "Enter the number of the VM to delete"

    # Get the name of the selected VM
    $selectedVMInfo = $vms[$selectedVM - 1]
    $VMName = $selectedVMInfo.Name

    try {
        # Delete the selected VM
        Write-Host "Deleting VM: $VMName"
        Remove-VM -Name $VMName -Force
        Write-Host "VM '$VMName' is deleted."
    }
    catch {
        # Catch and print any errors that occur
        Write-Host "Failed to delete VM '$VMName'. Error: $_" -ForegroundColor Red
    }
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