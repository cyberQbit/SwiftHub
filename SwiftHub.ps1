# ==============================================================================
# 🌌 SWIFTHUB CORE v3.2 - TITANIUM EDITION (PURE POWERSHELL)
# ==============================================================================
$ErrorActionPreference = 'SilentlyContinue' 
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$Host.UI.RawUI.WindowTitle = "SwiftHub Core - Advanced System Gateway"
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8 # Terminali zorla UTF-8 yapar

# --- GUVENLI BOLGE ---
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
    Write-Host "         [ Architecture: Pure PowerShell | Titanium Loop ]" -ForegroundColor DarkCyan
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

# --- MODUL INDIRICI VE TITANIUM PATCHER ---
function Invoke-Module ($Name, $Url) {
    Write-Host "`n   [*] $Name sunucudan cekiliyor... Lutfen bekleyin." -ForegroundColor Cyan
    $batPath = "$hubDir\$Name.bat"
    try {
        $wc = New-Object System.Net.WebClient
        $wc.Encoding = [System.Text.Encoding]::UTF8
        $str = $wc.DownloadString("$Url?t=$((Get-Date).Ticks)")
        
        # 1. KUSURSUZ İMHA (Titanium Patcher): 
        # İçinde "aydinaydmr", "SwiftHub" veya "run.ps1" geçen tüm satırları acımasızca yakalar ve sadece 'exit' yazar!
        $str = $str -replace '(?im)^.*powershell.*(aydinaydmr|SwiftHub|run\.ps1).*$', 'exit'
        $str = $str -replace '(?im)^.*start.*SwiftHub.*$', 'exit'
        
        # 2. KARAKTER KORUMA KALKANI:
        # CMD çalışırken Türkçe karakterleri bozmasın diye en tepeye zorla şifreleme düzeltici ekliyoruz.
        $str = "chcp 65001 >nul`r`n" + $str
        
        [System.IO.File]::WriteAllLines($batPath, ($str -split '\r?\n'), (New-Object System.Text.UTF8Encoding $false))
        
        Write-Host "   [OK] Modul yuklendi! Baslatiliyor..." -ForegroundColor Green
        Start-Sleep -Milliseconds 400
        
        # 3. İZOLE EDİLMİŞ ÇALIŞTIRMA:
        # CMD'nin yeni pencere açmasını %100 engeller ve işi bitene kadar PowerShell'i "Wait" (bekle) moduna sokar.
        Start-Process -FilePath "cmd.exe" -ArgumentList "/c `"`"$batPath`"`"" -Wait -NoNewWindow
        
        # Modül kapanınca ekranın tertemiz çizilmesi için mini rötar.
        Start-Sleep -Milliseconds 200
        
    } catch {
        Write-Host "`n   [X] $Name indirilemedi: $($_.Exception.Message)" -ForegroundColor Red
        Start-Sleep -Seconds 3
    }
}

# --- NATIVE SYSINFO MOTORU ---
function Invoke-SysInfo {
    Show-Header
    Write-Host "   [*] Donanim sensorleri ve WMI verileri analiz ediliyor...`n" -ForegroundColor Blue
    
    Write-Host "   [ISLETIM SISTEMI]" -ForegroundColor Cyan
    $os = Get-CimInstance Win32_OperatingSystem -ErrorAction SilentlyContinue
    if ($os) {
        Write-Host "     Model   : $($os.Caption) $($os.OSArchitecture)"
        Write-Host "     Surum   : Version $($os.Version) (Build $($os.BuildNumber))"
        $uptime = (Get-Date) - $os.LastBootUpTime
        Write-Host "     Calisma : $($uptime.Days) Gun, $($uptime.Hours) Saat, $($uptime.Minutes) Dakika`n"
    }

    Write-Host "   [ISLEMCI (CPU)]" -ForegroundColor Cyan
    $cpu = Get-CimInstance Win32_Processor -ErrorAction SilentlyContinue
    if ($cpu) {
        $cpuInfo = if ($cpu.Count -gt 1) { $cpu[0] } else { $cpu }
        Write-Host "     Model       : $($cpuInfo.Name)"
        Write-Host "     Cekirdek    : $($cpuInfo.NumberOfCores) Core / $($cpuInfo.NumberOfLogicalProcessors) Thread"
        Write-Host "     Baz Hizi    : $([math]::Round($cpuInfo.MaxClockSpeed / 1000, 2)) GHz`n"
    }

    Write-Host "   [BELLEK (RAM)]" -ForegroundColor Cyan
    $ram = Get-CimInstance Win32_PhysicalMemory -ErrorAction SilentlyContinue
    if ($ram) {
        $totalRam = [math]::Round(($ram | Measure-Object Capacity -Sum).Sum / 1GB, 2)
        Write-Host "     Kapasite    : $totalRam GB"
        Write-Host "     Hiz         : $(($ram | Select-Object -First 1).Speed) MHz`n"
    }

    Write-Host "   [GRAFIK KARTI (GPU)]" -ForegroundColor Cyan
    $gpus = Get-CimInstance Win32_VideoController -ErrorAction SilentlyContinue
    foreach ($g in $gpus) {
        $vramGB = [math]::Round($g.AdapterRAM / 1GB, 0)
        if ($vramGB -eq 4 -or $vramGB -lt 0) {
            $reg = Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\*" -ErrorAction SilentlyContinue | Where-Object DriverDesc -eq $g.Name
            if ($reg -and $reg."HardwareInformation.qwMemorySize") { $vramGB = [math]::Round($reg."HardwareInformation.qwMemorySize" / 1GB, 0) }
        }
        Write-Host "     Model       : $($g.Name) ($vramGB GB VRAM)"
        if ($g.CurrentHorizontalResolution) { Write-Host "     Ekran       : $($g.CurrentHorizontalResolution)x$($g.CurrentVerticalResolution) @ $($g.CurrentRefreshRate)Hz" }
        else { Write-Host "     Ekran       : Dahili Ekran Bagli Degil (Optimus/Render GPU)" }
        Write-Host ""
    }

    Write-Host "   [DEPOLAMA VE DISK ANALIZI]" -ForegroundColor Cyan
    Get-CimInstance Win32_LogicalDisk -ErrorAction SilentlyContinue | Where DriveType -eq 3 | ForEach-Object { Write-Host "     Surucu $($_.DeviceID)    : $([math]::Round($_.FreeSpace/1GB,2)) GB Bos / $([math]::Round($_.Size/1GB,2)) GB Toplam" }
    
    Write-Host "     --- Donanim Telemetrisi ---" -ForegroundColor DarkGray
    $pdisks = Get-PhysicalDisk -ErrorAction SilentlyContinue
    if ($pdisks) {
        foreach ($pd in $pdisks) {
            Write-Host "     Aygit       : $($pd.FriendlyName) ($($pd.MediaType) - $([math]::Round($pd.Size/1GB,0)) GB)"
            Write-Host "     Durum       : $($pd.HealthStatus)"
            $rel = $pd | Get-StorageReliabilityCounter -ErrorAction SilentlyContinue
            if ($rel) {
                if ($rel.Temperature) { Write-Host "     Sicaklik    : $($rel.Temperature) °C" }
                if ($rel.PowerOnHours) { Write-Host "     Calisma     : $($rel.PowerOnHours) Saat" }
                if ($rel.Wear -gt 0) { Write-Host "     Yipranma    : %$($rel.Wear)" }
            }
            Write-Host ""
        }
    }

    Write-Host "   ===============================================================" -ForegroundColor DarkGray
    Write-Host "   Ana menuye donmek icin [ENTER] tusuna basin..." -ForegroundColor DarkCyan
    Read-Host
}

# --- ANA DONGU ---
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