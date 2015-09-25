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
"  _____                               ______                       "
" |  __ \                             |  ____|                      "
" | |__) | __ ___   ___ ___  ___ ___  | |__   _ __  _   _ _ __ ___  "
" |  ___/ '__/ _ \ / __/ _ \/ __/ __| |  __| | '_ \| | | | '_ ` _   \"
" | |   | | | (_) | (_|  __/\__ \__ \ | |____| | | | |_| | | | | | |"
" |_|   |_|  \___/ \___\___||___/___/ |______|_| |_|\__,_|_| |_| |_|"
""
}

#A function of the main menu used by other functions to return to main
function main
{
    Clear-Host
    banner
    "Select a tool"
    "1. List Running Processes"
    "2. List Running Processes by Company"
    "3. Validate a process' signature"
    ""
    $response = Read-Host "Selection"
        if ($response -eq 1)
            {list}
        elseif ($response -eq 2)
            {listbycomp}
        elseif ($response -eq 3)
            {validate}
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
        "Would you like to"
        "1. See results in the shell"
        "2. Export resilts to a CSV"
    $a = Read-Host "Selection: "
    if ($a -eq "1")
        {Get-Process | Group-Object company | Sort-Object name}
    elseif ($a -eq "2")
        {$b = Read-Host "What would you like to name your file?"
        ""
        $c = Read-Host "Where would you like to save your file?"
        Get-Process | Group-Object company | Sort-Object name | Export-Csv -path $c$b.csv}
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
    "Whould you like to:"
    "1. Return to Main Menu"
    "2. Exit"
    $end =  Read-Host "Selection"
        if ($end = 1)
            {main}
        elseif ($end = 2)
            {exit}
}
function bye
{
    "Good Bye"
}

clear-host
banner
    "Select a tool"
    "1. List Running Processes"
    "2. List Running Processes by Company"
    "3. Validate a process' signature"
    #"4. List Running Processes Which"
    #"   Do Not Possess a Valid Signature"
    #  #4 is in work
    ""
    $response = Read-Host "Selection"
        if ($response -eq 1)
            {list}
        elseif ($response -eq 2)
            {listbycomp}
        elseif ($response -eq 3)
            {validate}
