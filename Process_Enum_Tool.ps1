######################################################################
#  _____                               ______                        #
# |  __ \                             |  ____|                       #
# | |__) | __ ___   ___ ___  ___ ___  | |__   _ __  _   _ _ __ ___   #
# |  ___/ '__/ _ \ / __/ _ \/ __/ __| |  __| | '_ \| | | | '_ ` _  \ #
# | |   | | | (_) | (_|  __/\__ \__ \ | |____| | | | |_| | | | | | | #
# |_|   |_|  \___/ \___\___||___/___/ |______|_| |_|\__,_|_| |_| |_| #
#                                                                    #
#Tool for enumerating processes via Windows Powershell               #
######################################################################


function banner
{

Write-Host "  _____                               ______                       " -foreground Green
Write-Host " |  __ \                             |  ____|                      " -foreground Green
Write-Host " | |__) | __ ___   ___ ___  ___ ___  | |__   _ __  _   _ _ __ ___  " -foreground Green
Write-Host " |  ___/ '__/ _ \ / __/ _ \/ __/ __| |  __| | '_ \| | | | '_ ` _   \" -foreground Green
Write-Host " | |   | | | (_) | (_|  __/\__ \__ \ | |____| | | | |_| | | | | | |" -foreground Green
Write-Host " |_|   |_|  \___/ \___\___||___/___/ |______|_| |_|\__,_|_| |_| |_|" -foreground Green
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
    Write-Host ""
    Write-Host "0. Exit"
    ""
    $menuSelect = Read-host "Selection"
    Switch ($menuSelect)
     {
       1 {list}
       2 {listbycomp}
       3 {validate}
       0 {Write-Host "Goodbye" -ForegroundColor Red}
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

#Runs at the end of each operation to give the option of returning to the main menu or exiting the script
function end
{
    ""
    ""
    $end =  Read-Host "Press ENTER to return to the main menu"
        if ($end = 1)
            {main}
        elseif ($end = 2)
            {}
}
function bye
{
    "Good Bye"
}

clear-host
banner
    Clear-Host
    banner
    Write-Host "Select a tool"
    Write-Host "1. List Running Processes"
    Write-Host "2. List Running Processes by Company"
    Write-Host "3. Validate a process' signature"
    Write-Host ""
    Write-Host "0. Exit"
    ""
    $menuSelect = Read-host "Selection"
    Switch ($menuSelect)
       {
        1 {list}
        2 {listbycomp}
        3 {validate}
        0 {Write-Host "Goodbye" -ForegroundColor Red}
        Default {main}
       }