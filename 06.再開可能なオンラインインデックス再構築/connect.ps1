Clear-Host
While ($true){
    try{
        $ret = Invoke-Sqlcmd -ServerInstance SoL-LN.techsummit.local -Database db1 -Username sa -P <Password> -Query "SELECT @@SERVERNAME AS ServerName" -QueryTimeout 1 -ConnectionTimeout 1 -ErrorAction SilentlyContinue
        Write-Host ("[{0}] Getting Data.... Server : {1}" -f (Get-Date), $ret[0])
    }catch{
        Write-Host ("[{0}] Attempting connection" -f (Get-Date))
    }finally{
        Start-Sleep -Seconds 2
    }
}
