# ==============================================================================
# 🌌 SWIFTHUB CORE v3.0 - PURE POWERSHELL ARCHITECTURE
# ==============================================================================
$ErrorActionPreference = 'Stop'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$Host.UI.RawUI.WindowTitle = "SwiftHub Core - Advanced System Gateway"

# --- GUVENLI BOLGE (Moduller Icin) ---
$hubDir = "$env:PROGRAMDATA\cyberQbit"
if (-not (Test-Path $hubDir)) { New-Item -ItemType Directory -Path $hubDir -Force | Out-Null }

# --- ARAYUZ FONKSIYONLARI ---
function Show-Header {
    Clear-Host
    Write-Host "`n   ███████╗██╗    ██╗██╗███████╗████████╗██╗  ██╗██╗   ██╗██████╗ " -ForegroundColor Cyan
    Write-Host "   ██╔════╝██║    ██║██║██╔════╝╚══██╔══╝██║  ██║██║   ██║██╔══██╗" -ForegroundColor Cyan
    Write-Host "   ███████╗██║ █╗ ██║██║█████╗     ██║   ███████║██║   ██║██████╔╝" -ForegroundColor Cyan
    Write-Host "   ╚════██║██║███╗██║██║██╔══╝     ██║   ██╔══██║██║   ██║██╔══██╗" -ForegroundColor Cyan
    Write-Host "   ███████║╚███╔███╔╝██║██║        ██║   ██║  ██║╚██████╔╝██████╔╝" -ForegroundColor Cyan
    Write-Host "   ╚══════╝ ╚══╝╚══╝ ╚═╝╚═╝        ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ " -ForegroundColor Cyan
    Write-Host "   ===============================================================" -ForegroundColor DarkGray
    Write-Host "         [ Architecture: Pure PowerShell | Zero-Footprint ]" -ForegroundColor DarkCyan
    Write-Host ""
}

function Show-Menu {
    Show-Header
    Write-Host "   [1] " -NoNewline; Write-Host "WinSwift Pro" -ForegroundColor Green; Write-Host "     (Sistem Optimizasyonu & Temizlik)" -ForegroundColor DarkGray
    Write-Host "   [2] " -NoNewline; Write-Host "DevSwift Pro" -ForegroundColor Yellow; Write-Host "     (Gelismis Calisma Ortami Kurulumu)" -ForegroundColor DarkGray
    Write-Host "   [3] " -NoNewline; Write-Host "NetSwift Pro" -ForegroundColor Magenta; Write-Host "     (Ag Yonetimi & Siber Guvenlik)" -ForegroundColor DarkGray
    Write-Host "   [4] " -NoNewline; Write-Host "Sistem Bilgisi" -ForegroundColor Cyan; Write-Host "   (Derin Donanim & Telemetri Analizi)" -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "   [0] " -NoNewline; Write-Host "Cikis Yap" -ForegroundColor Red
    Write-Host ""
}

# --- MODUL INDIRICI (Simdilik eski .bat modullerini cagirir, Phase 2'de degisecek) ---
function Invoke-Module ($Name, $Url) {
    Write-Host "`n   [*] $Name sunucudan cekiliyor... Lutfen bekleyin." -ForegroundColor Cyan
    $batPath = "$hubDir\$Name.bat"
    try {
        $bytes = (New-Object System.Net.WebClient).DownloadData("$Url?t=$((Get-Date).Ticks)")
        $str = [System.Text.Encoding]::UTF8.GetString($bytes)
        [System.IO.File]::WriteAllLines($batPath, ($str -split '\r?\n'), (New-Object System.Text.UTF8Encoding $false))
        
        Write-Host "   [OK] Modul yuklendi! Baslatiliyor..." -ForegroundColor Green
        Start-Sleep -Milliseconds 400
        
        if (Get-Command wt.exe -ErrorAction SilentlyContinue) {
            Start-Process wt.exe -ArgumentList "cmd.exe /c `"`"$batPath`"`""
        } else {
            Start-Process cmd.exe -ArgumentList "/c `"`"$batPath`"`""
        }
    } catch {
        Write-Host "`n   [X] $Name indirilemedi: $($_.Exception.Message)" -ForegroundColor Red
        Start-Sleep -Seconds 3
    }
}

# --- NATIVE SYSINFO MOTORU (Artik dosya yazmaya gerek yok!) ---
function Invoke-SysInfo {
    Show-Header
    Write-Host "   [*] Donanim sensorleri ve WMI verileri analiz ediliyor...`n" -ForegroundColor Blue
    $ErrorActionPreference = 'SilentlyContinue'

    Write-Host "   [ISLETIM SISTEMI]" -ForegroundColor Cyan
    $os = Get-CimInstance Win32_OperatingSystem
    Write-Host "     Model   : $($os.Caption) $($os.OSArchitecture)"
    Write-Host "     Surum   : Version $($os.Version) (Build $($os.BuildNumber))"
    $uptime = (Get-Date) - $os.LastBootUpTime
    Write-Host "     Calisma : $($uptime.Days) Gun, $($uptime.Hours) Saat, $($uptime.Minutes) Dakika`n"

    Write-Host "   [ISLEMCI (CPU)]" -ForegroundColor Cyan
    $cpu = Get-CimInstance Win32_Processor
    Write-Host "     Model       : $($cpu.Name)"
    Write-Host "     Cekirdek    : $($cpu.NumberOfCores) Core / $($cpu.NumberOfLogicalProcessors) Thread"
    Write-Host "     Baz Hizi    : $([math]::Round($cpu.MaxClockSpeed / 1000, 2)) GHz`n"

    Write-Host "   [BELLEK (RAM)]" -ForegroundColor Cyan
    $ram = Get-CimInstance Win32_PhysicalMemory
    $totalRam = [math]::Round(($ram | Measure-Object Capacity -Sum).Sum / 1GB, 2)
    Write-Host "     Kapasite    : $totalRam GB"
    Write-Host "     Hiz         : $(($ram | Select-Object -First 1).Speed) MHz`n"

    Write-Host "   [GRAFIK KARTI (GPU)]" -ForegroundColor Cyan
    $gpus = Get-CimInstance Win32_VideoController
    foreach ($g in $gpus) {
        $vramGB = [math]::Round($g.AdapterRAM / 1GB, 0)
        if ($vramGB -eq 4 -or $vramGB -lt 0) {
            $reg = Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\*" | Where-Object DriverDesc -eq $g.Name
            if ($reg."HardwareInformation.qwMemorySize") { $vramGB = [math]::Round($reg."HardwareInformation.qwMemorySize" / 1GB, 0) }
        }
        Write-Host "     Model       : $($g.Name) ($vramGB GB VRAM)"
        if ($g.CurrentHorizontalResolution) { Write-Host "     Ekran       : $($g.CurrentHorizontalResolution)x$($g.CurrentVerticalResolution) @ $($g.CurrentRefreshRate)Hz" }
        else { Write-Host "     Ekran       : Dahili Ekran Bagli Degil (Optimus/Render GPU)" }
        Write-Host ""
    }

    Write-Host "   [DEPOLAMA VE DISK ANALIZI]" -ForegroundColor Cyan
    Get-CimInstance Win32_LogicalDisk | Where DriveType -eq 3 | ForEach-Object { Write-Host "     Surucu $($_.DeviceID)    : $([math]::Round($_.FreeSpace/1GB,2)) GB Bos / $([math]::Round($_.Size/1GB,2)) GB Toplam" }
    
    Write-Host "     --- Donanim Telemetrisi ---" -ForegroundColor DarkGray
    foreach ($pd in Get-PhysicalDisk) {
        Write-Host "     Aygit       : $($pd.FriendlyName) ($($pd.MediaType) - $([math]::Round($pd.Size/1GB,0)) GB)"
        Write-Host "     Durum       : $($pd.HealthStatus)"
        $rel = $pd | Get-StorageReliabilityCounter
        if ($rel) {
            if ($rel.Temperature) { Write-Host "     Sicaklik    : $($rel.Temperature) °C" }
            if ($rel.PowerOnHours) { Write-Host "     Calisma     : $($rel.PowerOnHours) Saat" }
            if ($rel.Wear -gt 0) { Write-Host "     Yipranma    : %$($rel.Wear)" }
        }
        Write-Host ""
    }

    Write-Host "   ===============================================================" -ForegroundColor DarkGray
    Write-Host "   Ana menuye donmek icin [ENTER] tusuna basin..." -ForegroundColor DarkCyan
    Read-Host
}

# --- ANA DONGU (MAIN LOOP) ---
while ($true) {
    Show-Menu
    $choice = Read-Host "   Seciminiz"
    switch ($choice) {
        '1' { Invoke-Module "WinSwift" "https://raw.githubusercontent.com/cyberQbit/WinSwift/main/WinSwift.bat" }
        '2' { Invoke-Module "DevSwift" "https://raw.githubusercontent.com/cyberQbit/DevSwift/main/DevSwift.bat" }
        '3' { Invoke-Module "NetSwift" "https://raw.githubusercontent.com/cyberQbit/NetSwift/main/NetSwift.bat" }
        '4' { Invoke-SysInfo }
        '0' {
            Write-Host "`n   [+] Sistem baglantisi kesiliyor..." -ForegroundColor Cyan; Start-Sleep -Milliseconds 300
            Write-Host "   [+] Onbellek ve gecici hafiza temizleniyor..." -ForegroundColor Blue; Start-Sleep -Milliseconds 300
            Write-Host "   [OK] cyberQbit Ekosistemi guvenli bir sekilde kapatildi." -ForegroundColor Green; Start-Sleep -Milliseconds 400
            Write-Host "`n   Gorusmek uzere, Komutan!`n" -ForegroundColor DarkGray; Start-Sleep -Milliseconds 600
            exit
        }
        default { Write-Host "   [!] Gecersiz secim!" -ForegroundColor Red; Start-Sleep -Seconds 1 }
    }
}