if ($args[0] -eq "auto") {
    foreach ($proc in Get-Process) {
        if ($proc.ProcessName -eq "factorio") {
            Write-Output "Already running .. quitting"
            exit
        }
    }

    Write-Output "Not running, continuing process"
}

# Read in username
$username = Get-Content -Path ".\Steam Username.txt"
Write-Output "Username is $username"

# Move to working dir
Push-Location D:\Factorio\

# Update
D:\SteamCmd\SteamCmd.exe +force_install_dir D:/Factorio/Game +login $($username) +app_update 427520 validate +quit

# Kill ze old one
taskkill /f /im "factorio.exe"
Remove-Item C:\Users\Administrator\AppData\Roaming\Factorio\.lock

# Start
.\Game\bin\x64\factorio --start-server .\Data\SaveGame.zip --map-gen-settings .\Data\map-gen-settings.json --map-settings .\Data\map-settings.json --server-settings .\Data\server-settings.json --console-log .\Data\log.txt
