$createRoot = $PSScriptRoot

$cwd = Get-Location 
$root = "$createRoot/.."
$app = "server"
$appLocation = "$root/$app"

try {
    Set-Location $root
    Write-Host "create $app with official express generator"
    Invoke-Expression "npx express-generator $app --no-view"
    
    Set-Location $appLocation

    Write-Host "add our template (with typescript config)"
    Remove-Item -Path ./bin -Force -Recurse
    Remove-Item -Path ./routes -Force -Recurse
    Remove-Item -Path ./app.js -Force
    Get-ChildItem -Path "$createRoot/template" | Copy-Item -Destination $appLocation -Recurse -Container
    
    Write-Host "add npm dependencies"
    yarn add morgan cookie-parser
    yarn add -D @types/express @types/morgan @types/cookie-parser typescript ts-node nodemon

    Write-Host "set scripts i package.json"
    [PsCustomObject]$packageJson = Get-Content -Path ./package.json | ConvertFrom-Json
    $packageJson.scripts.start = "nodemon app.ts"
    ($packageJson | ConvertTo-Json) | Set-Content -Path ./package.json

    Start-Process "C:\Program Files\Google\Chrome\Application\chrome.exe" "http://localhost:3001"
    yarn start
}
finally {
    set-location $cwd
    #only for dev : Remove-Item -Path $appLocation -Force -Recurse
}