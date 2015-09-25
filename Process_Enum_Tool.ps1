#Tool for enumerating processes via WIndows Powershell
function list 
{
    Get-Process
}

function listbycomp
{
        Clear-Host
        "Would you like to:"
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
}


"  _____                               ______                       "
" |  __ \                             |  ____|                      "
" | |__) | __ ___   ___ ___  ___ ___  | |__   _ __  _   _ _ __ ___  "
" |  ___/ '__/ _ \ / __/ _ \/ __/ __| |  __| | '_ \| | | | '_ ` _   \"
" | |   | | | (_) | (_|  __/\__ \__ \ | |____| | | | |_| | | | | | |"
" |_|   |_|  \___/ \___\___||___/___/ |______|_| |_|\__,_|_| |_| |_|"
""
"Select a tool"
"1. List Running Processes"
"2. List Running Processes by Company"
""
$response = Read-Host "Selection: "

if ($response -eq 1)
    {list}
elseif ($response -eq 2)
    {listbycomp}

