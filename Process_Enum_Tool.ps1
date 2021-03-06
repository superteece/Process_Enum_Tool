######################################################################
#  ____  ____        _____                                           #
# |  _ \/ ___|      | ____|_ __  _   _ _ __ ___                      #
# | |_) \___ \ _____|  _| | '_ \| | | | '_ ` _ \                     #
# |  __/ ___) |_____| |___| | | | |_| | | | | | |                    # 
# |_|   |____/      |_____|_| |_|\__,_|_| |_| |_|                    #
#                                                                    #
#Tool for enumerating processes via Windows Powershell               #
#TC Johnson                                                          #
#TC@geekministry.org                                                 #
#ASCII Art created at: patorjk.com/software/taag/                    #
#Special thanks to the folks at Freenode #Powershell                 #
######################################################################


function banner
{

Write-Host "  ____  ____        _____                       " -foreground Green
Write-Host " |  _ \/ ___|      | ____|_ __  _   _ _ __ ___  " -foreground Green
Write-Host " | |_) \___ \ _____|  _| | '_ \| | | | '_ ` _  \" -foreground Green
Write-Host " |  __/ ___) |_____| |___| | | | |_| | | | | | |" -foreground Green
Write-Host " |_|   |____/      |_____|_| |_|\__,_|_| |_| |_|" -foreground Green
""
}

#A function of the main menu used by other functions to return to main
function main
{
    Clear-Host
    banner
    Write-Host "Select a tool"
    Write-Host "1. List Running Processes"
    Write-Host "2. List Running Processes by Company"
    Write-Host "3. Validate a process' signature"
    Write-Host "4. Auto Validate signatures of all processes"
    Write-Host ""
    Write-Host "0. Exit"
    ""
    $menuSelect = Read-host "Selection"
    Switch ($menuSelect)
       {
        1 {list}
        2 {listbycomp}
        3 {validate}
        4 {autoCheck}
        0 {Clear-Host; Break}
       Default {main}
     }
}

#Simply list all running processes.
function list
{
    Get-Process
    end
}

#Return a list of companies and how many processes are running under their name
#The list can be displayed in the shell or output to a CSV
function listbycomp
{
        Clear-Host
        Write-Host "Would you like to"
        Write-Host "1. See results in the shell"
        Write-Host "2. Export results to a CSV"
        $menuSelect = Read-host "Selection"
        Switch ($menuSelect)
        {
            1 {Get-Process | Group-Object company | Sort-Object name}
            2 {$b = Read-Host "What would you like to name your file?"
               ""
               $c = Read-Host "Where would you like to save your file?"
               Get-Process | Group-Object company | Sort-Object name | Export-Csv -path $c$b.csv}
            Default {Write-Host "Invalid Selection"}
     }
    end
}

#Get the list of running processes and select one to validate the signature of its executable
function validate
{
Get-Process
$procName = Read-Host "Enter the name of the process to validate"
    $procValidate = Get-Process $procName | select -Expand Path | select -Unique
    Get-AuthenticodeSignature "$procValidate"
    end
}

#Automatically check the signature validity of each running process
function autoCheck
{
foreach ($item in Get-Process)
    {
    $procValidate = Get-Process $item.Name | select -Expand Path | select -Unique
    Get-AuthenticodeSignature "$procValidate"
    }
    end
}

#Runs at the end of each operation to give the option of returning to the main menu
function end
{
    ""
    ""
    Read-Host 'Press Enter to return to main menu...' | Out-Null
    main
}

function bye
{
    "Good Bye"
}


main