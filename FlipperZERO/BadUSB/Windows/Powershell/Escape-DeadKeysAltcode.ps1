#                                                                    _..._       .-'''-.                 .-'''-.
#                                                                 .-'_..._''.   '   _    \  .---.       '   _    \
# /|                                                            .' .'      '.\/   /` '.   \ |   |.--. /   /` '.   \
# ||    .-.          .-                                        / .'          .   |     \  ' |   ||__|.   |     \  '
# ||     \ \        / /                               .-,.--. . '            |   '      |  '|   |.--.|   '      |  '
# ||  __  \ \      / /                          __    |  .-. || |            \    \     / / |   ||  |\    \     / /
# ||/'__ '.\ \    / /            .--------.  .:--.'.  | |  | || |             `.   ` ..' /  |   ||  | `.   ` ..' /
# |:/`  '. '\ \  / /             |____    | / |   \ | | |  | |. '                '-...-'`   |   ||  |    '-...-'`
# ||     | | \ `  /                  /   /  `" __ | | | |  '-  \ '.          .              |   ||  |
# ||\    / '  \  /                 .'   /    .'.''| | | |       '. `._____.-'/              |   ||__|
# |/\'..' /   / /                 /    /___ / /   | |_| |         `-.______ /               '---'
# '  `'-'`|`-' /                 |         |\ \._,\ '/|_|                  `
#          '..'                  |_________| `--'  `"

﻿[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)][string]$InputFile
)

# Check if the input file exists
if (-not (Test-Path $InputFile)) {
    Write-Error "The input file does not exist."
    exit 1
}

# Read the contents of the input file
$content = Get-Content -Path $InputFile

# Initialize an empty array to hold the updated lines
$updatedContent = @()

foreach($line in $content) {
    if($line -match "[~``'^`]"){
        $updatedLine = $line.Replace("STRING", "ALTCODE")
        $updatedContent += $updatedLine
    } else {
        $updatedContent += $line
    }
}

# Remove lines equal to "STRING" after trimming
$updatedContent = $updatedContent.Trim() -replace "(`n|^)STRING(`n|$)", ""


# Prepare the output file name by adding "-edit" before the file extension
$outputFile = [System.IO.Path]::GetFileNameWithoutExtension($InputFile) + "-edit" + [System.IO.Path]::GetExtension($InputFile)

# Write the updated content to the output file
Set-Content -Path $outputFile -Value $updatedContent
