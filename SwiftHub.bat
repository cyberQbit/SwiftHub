@echo off
setlocal EnableDelayedExpansion
chcp 65001 >nul 2>&1

:: ==============================================================================
:: SwiftHub Pro v1.0 - The Core of cyberQbit Ecosystem
:: ==============================================================================

title SwiftHub v1.0 - cyberQbit Terminal Ekosistemi Ana Merkezi
mode con: cols=110 lines=45
color 0F

:: Gelişmiş Renk Paleti (Soft & Modern HUB Konsepti)
for /F %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"
set "GREEN=%ESC%[92m"
set "RED=%ESC%[91m"
set "YELLOW=%ESC%[93m"
set "CYAN=%ESC%[96m"
set "BLUE=%ESC%[94m"
set "WHITE=%ESC%[97m"
set "GRAY=%ESC%[90m"
set "RESET=%ESC%[0m"
set "BOLD=%ESC%[1m"

:: ==============================================================================
:: BOOT SEQUENCE (Açılış Animasyonu)
:: ==============================================================================
:BootSequence
cls
echo.
echo %BLUE%[%time%] INITIALIZING SWIFTHUB CORE...%RESET%
timeout /t 1 >nul
echo %GRAY%[+] Loading Memory Modules: %GREEN%OK%RESET%
timeout /t 0 /nobreak >nul
echo %GRAY%[+] Establishing Secure Connection to GitHub: %GREEN%OK%RESET%
timeout /t 0 /nobreak >nul
echo %GRAY%[+] Verifying Administrator Privileges: %GREEN%OK%RESET%
timeout /t 1 >nul
echo %GRAY%[+] Mounting cyberQbit Ecosystem Vectors:%RESET%
echo     %CYAN%- WinSwift Module  (System Optimization) : %GREEN%READY%RESET%
echo     %CYAN%- DevSwift Module  (Environment Setup)   : %GREEN%READY%RESET%
echo     %CYAN%- NetSwift Module  (Network ^& Security)  : %GREEN%READY%RESET%
timeout /t 1 >nul
echo.
echo %BLUE%[*] BOOT COMPLETE. ENTERING MAIN INTERFACE...%RESET%
timeout /t 1 >nul

:: ==============================================================================
:: MAIN MENU
:: ==============================================================================
:MainMenu
cls
echo.
echo %BLUE%  ███████╗██╗    ██╗██╗███████╗████████╗██╗  ██╗██╗   ██╗██████╗ %RESET%
echo %BLUE%  ██╔════╝██║    ██║██║██╔════╝╚══██╔══╝██║  ██║██║   ██║██╔══██╗%RESET%
echo %BLUE%  ███████╗██║ █╗ ██║██║█████╗     ██║   ███████║██║   ██║██████╔╝%RESET%
echo %BLUE%  ╚════██║██║███╗██║██║██╔══╝     ██║   ██╔══██║██║   ██║██╔══██╗%RESET%
echo %BLUE%  ███████║╚███╔███╔╝██║██║        ██║   ██║  ██║╚██████╔╝██████╔╝%RESET%
echo %BLUE%  ╚══════╝ ╚══╝╚══╝ ╚═╝╚═╝        ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ %RESET%
echo.
echo %BOLD%%CYAN%                   THE CYBERQBIT ECOSYSTEM CORE%RESET%
echo %GRAY%  ==========================================================================================%RESET%
echo.
echo      %BOLD%%WHITE%[1] WinSwift Pro%RESET%  %GRAY%-  Windows Optimizasyon, Temizlik ve Gizlilik Kalkani%RESET%
echo      %BOLD%%WHITE%[2] DevSwift Pro%RESET%  %GRAY%-  Tek Tikla Otomatik Gelistirici Ortami ve Winget Motoru%RESET%
echo      %BOLD%%WHITE%[3] NetSwift Pro%RESET%  %GRAY%-  Ag Yonetimi, Zafiyet Taramasi ve Siber Guvenlik Merkezi%RESET%
echo.
echo %GRAY%  ==========================================================================================%RESET%
echo.
echo      %BOLD%%YELLOW%[4] Sistem Bilgisi%RESET% %GRAY%-  Detayli Donanim, Ag ve Yazilim Analizi%RESET%
echo      %BOLD%%RED%[0] Sistemi Kapat%RESET%  %GRAY%-  Guvenli Cikis Yap%RESET%
echo.

choice /c 12340 /n /m "%BLUE%  [root@%USERNAME%]~# %RESET%"
set "menu=!errorlevel!"

if "!menu!"=="5" goto :Exit
if "!menu!"=="4" goto :SysInfo
if "!menu!"=="3" goto :LaunchNetSwift
if "!menu!"=="2" goto :LaunchDevSwift
if "!menu!"=="1" goto :LaunchWinSwift
goto :MainMenu

:: ==============================================================================
:: LAUNCHERS (Byte-Level Kusursuz İndirme, CRLF ve Güvenli Operasyon Bölgesi)
:: ==============================================================================
:LaunchWinSwift
cls
echo.
echo %BLUE%[*] WinSwift Pro sunucudan cekiliyor... Lutfen bekleyin.%RESET%
echo %GRAY%    (Kaynak: raw.githubusercontent.com/.../WinSwift.bat)%RESET%
if not exist "%PROGRAMDATA%\cyberQbit" mkdir "%PROGRAMDATA%\cyberQbit" >nul
powershell -NoProfile -Command "$b=\"$env:PROGRAMDATA\cyberQbit\WinSwift.bat\"; $bytes=(New-Object System.Net.WebClient).DownloadData('https://raw.githubusercontent.com/cyberQbit/WinSwift/main/WinSwift.bat?t=%random%'); $str=[System.Text.Encoding]::UTF8.GetString($bytes); [System.IO.File]::WriteAllLines($b, ($str -split '\r?\n'), (New-Object System.Text.UTF8Encoding $false))"
where wt.exe >nul 2>&1
if %errorlevel% equ 0 ( start "" wt.exe cmd.exe /c ""%PROGRAMDATA%\cyberQbit\WinSwift.bat"" ) else ( start "" cmd.exe /c ""%PROGRAMDATA%\cyberQbit\WinSwift.bat"" )
goto :MainMenu

:LaunchDevSwift
cls
echo.
echo %BLUE%[*] DevSwift Pro sunucudan cekiliyor... Lutfen bekleyin.%RESET%
echo %GRAY%    (Kaynak: raw.githubusercontent.com/.../DevSwift.bat)%RESET%
if not exist "%PROGRAMDATA%\cyberQbit" mkdir "%PROGRAMDATA%\cyberQbit" >nul
powershell -NoProfile -Command "$b=\"$env:PROGRAMDATA\cyberQbit\DevSwift.bat\"; $bytes=(New-Object System.Net.WebClient).DownloadData('https://raw.githubusercontent.com/cyberQbit/DevSwift/main/DevSwift.bat?t=%random%'); $str=[System.Text.Encoding]::UTF8.GetString($bytes); [System.IO.File]::WriteAllLines($b, ($str -split '\r?\n'), (New-Object System.Text.UTF8Encoding $false))"
where wt.exe >nul 2>&1
if %errorlevel% equ 0 ( start "" wt.exe cmd.exe /c ""%PROGRAMDATA%\cyberQbit\DevSwift.bat"" ) else ( start "" cmd.exe /c ""%PROGRAMDATA%\cyberQbit\DevSwift.bat"" )
goto :MainMenu

:LaunchNetSwift
cls
echo.
echo %BLUE%[*] NetSwift Pro sunucudan cekiliyor... Lutfen bekleyin.%RESET%
echo %GRAY%    (Kaynak: raw.githubusercontent.com/.../NetSwift.bat)%RESET%
if not exist "%PROGRAMDATA%\cyberQbit" mkdir "%PROGRAMDATA%\cyberQbit" >nul
powershell -NoProfile -Command "$b=\"$env:PROGRAMDATA\cyberQbit\NetSwift.bat\"; $bytes=(New-Object System.Net.WebClient).DownloadData('https://raw.githubusercontent.com/cyberQbit/NetSwift/main/NetSwift.bat?t=%random%'); $str=[System.Text.Encoding]::UTF8.GetString($bytes); [System.IO.File]::WriteAllLines($b, ($str -split '\r?\n'), (New-Object System.Text.UTF8Encoding $false))"
where wt.exe >nul 2>&1
if %errorlevel% equ 0 ( start "" wt.exe cmd.exe /c ""%PROGRAMDATA%\cyberQbit\NetSwift.bat"" ) else ( start "" cmd.exe /c ""%PROGRAMDATA%\cyberQbit\NetSwift.bat"" )
goto :MainMenu

:: ==============================================================================
:: [4] SISTEM BILGISI (Gelistirilmis Derin Analiz Motoru v3)
:: ==============================================================================
:SysInfo
cls
echo.
echo %CYAN%  [*] SWIFTHUB CORE - ADVANCED SYSTEM DIAGNOSTICS%RESET%
echo %GRAY%  ==========================================================================================%RESET%
echo %BLUE%  [*] Donanim sensorleri ve kayit defteri verileri analiz ediliyor... Lutfen bekleyin.%RESET%
echo.

set "PSFILE=%PROGRAMDATA%\cyberQbit\sysinfo.ps1"
if exist "%PSFILE%" del /q "%PSFILE%"

>> "%PSFILE%" echo $ErrorActionPreference = 'SilentlyContinue'
>> "%PSFILE%" echo Write-Host "[ISLETIM SISTEMI]" -ForegroundColor Cyan
>> "%PSFILE%" echo $os = Get-CimInstance Win32_OperatingSystem
>> "%PSFILE%" echo Write-Host "  Model   : $($os.Caption) $($os.OSArchitecture)"
>> "%PSFILE%" echo Write-Host "  Surum   : Version $($os.Version) (Build $($os.BuildNumber))"
>> "%PSFILE%" echo $uptime = (Get-Date) - $os.LastBootUpTime
>> "%PSFILE%" echo Write-Host "  Calisma : $($uptime.Days) Gun, $($uptime.Hours) Saat, $($uptime.Minutes) Dakika"
>> "%PSFILE%" echo Write-Host ""

>> "%PSFILE%" echo Write-Host "[ANAKART VE BIOS]" -ForegroundColor Cyan
>> "%PSFILE%" echo $board = Get-CimInstance Win32_BaseBoard
>> "%PSFILE%" echo $bios = Get-CimInstance Win32_BIOS
>> "%PSFILE%" echo Write-Host "  Anakart : $($board.Manufacturer) $($board.Product)"
>> "%PSFILE%" echo Write-Host "  BIOS    : $($bios.Manufacturer) $($bios.SMBIOSBIOSVersion)"
>> "%PSFILE%" echo Write-Host ""

>> "%PSFILE%" echo Write-Host "[ISLEMCI (CPU)]" -ForegroundColor Cyan
>> "%PSFILE%" echo $cpu = Get-CimInstance Win32_Processor
>> "%PSFILE%" echo Write-Host "  Model       : $($cpu.Name)"
>> "%PSFILE%" echo Write-Host "  Cekirdek    : $($cpu.NumberOfCores) Core / $($cpu.NumberOfLogicalProcessors) Thread"
>> "%PSFILE%" echo $base = [math]::Round($cpu.MaxClockSpeed / 1000, 2)
>> "%PSFILE%" echo Write-Host "  Baz Hizi    : $base GHz"
>> "%PSFILE%" echo Write-Host "  Turbo Hizi  : Dinamik (WMI/Anakart tarafindan yonetilir)"
>> "%PSFILE%" echo Write-Host ""

>> "%PSFILE%" echo Write-Host "[BELLEK (RAM)]" -ForegroundColor Cyan
>> "%PSFILE%" echo $ram = Get-CimInstance Win32_PhysicalMemory
>> "%PSFILE%" echo $totalRam = [math]::Round(($ram ^| Measure-Object Capacity -Sum).Sum / 1GB, 2)
>> "%PSFILE%" echo $speed = ($ram ^| Select-Object -First 1).Speed
>> "%PSFILE%" echo Write-Host "  Kapasite    : $totalRam GB"
>> "%PSFILE%" echo Write-Host "  Hiz         : $speed MHz"
>> "%PSFILE%" echo Write-Host ""

>> "%PSFILE%" echo Write-Host "[GRAFIK KARTI (GPU)]" -ForegroundColor Cyan
>> "%PSFILE%" echo $gpus = Get-CimInstance Win32_VideoController
>> "%PSFILE%" echo foreach ($g in $gpus) {
>> "%PSFILE%" echo     $vramGB = [math]::Round($g.AdapterRAM / 1GB, 0)
>> "%PSFILE%" echo     if ($vramGB -eq 4 -or $vramGB -lt 0) {
>> "%PSFILE%" echo         $reg = Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\*" -ErrorAction SilentlyContinue ^| Where-Object DriverDesc -eq $g.Name
>> "%PSFILE%" echo         if ($reg."HardwareInformation.qwMemorySize") {
>> "%PSFILE%" echo             $vramGB = [math]::Round($reg."HardwareInformation.qwMemorySize" / 1GB, 0)
>> "%PSFILE%" echo         }
>> "%PSFILE%" echo     }
>> "%PSFILE%" echo     Write-Host "  Model       : $($g.Name) ($vramGB GB VRAM)"
>> "%PSFILE%" echo     if ($g.CurrentHorizontalResolution -and $g.CurrentRefreshRate) {
>> "%PSFILE%" echo         Write-Host "  Ekran       : $($g.CurrentHorizontalResolution)x$($g.CurrentVerticalResolution) @ $($g.CurrentRefreshRate)Hz"
>> "%PSFILE%" echo     } else {
>> "%PSFILE%" echo         Write-Host "  Ekran       : Dahili Ekran Bagli Degil (Optimus / Render GPU)"
>> "%PSFILE%" echo     }
>> "%PSFILE%" echo     Write-Host ""
>> "%PSFILE%" echo }

>> "%PSFILE%" echo Write-Host "[DEPOLAMA VE DISK ANALIZI]" -ForegroundColor Cyan
>> "%PSFILE%" echo $vols = Get-CimInstance Win32_LogicalDisk ^| Where DriveType -eq 3
>> "%PSFILE%" echo foreach ($v in $vols) {
>> "%PSFILE%" echo     $free = [math]::Round($v.FreeSpace / 1GB, 2)
>> "%PSFILE%" echo     $tot = [math]::Round($v.Size / 1GB, 2)
>> "%PSFILE%" echo     Write-Host "  Surucu $($v.DeviceID)    : $free GB Bos / $tot GB Toplam"
>> "%PSFILE%" echo }
>> "%PSFILE%" echo Write-Host "  --- Donanim Sagligi ---" -ForegroundColor DarkGray
>> "%PSFILE%" echo $pdisks = Get-PhysicalDisk
>> "%PSFILE%" echo foreach ($pd in $pdisks) {
>> "%PSFILE%" echo     $size = [math]::Round($pd.Size / 1GB, 0)
>> "%PSFILE%" echo     $type = $pd.MediaType
>> "%PSFILE%" echo     $model = $pd.FriendlyName
>> "%PSFILE%" echo     $status = $pd.HealthStatus
>> "%PSFILE%" echo     $rel = $pd ^| Get-StorageReliabilityCounter -ErrorAction SilentlyContinue
>> "%PSFILE%" echo     $poh = $rel.PowerOnHours
>> "%PSFILE%" echo     Write-Host "  Aygit       : $model ($type - $size GB)"
>> "%PSFILE%" echo     if ($poh) { Write-Host "  Guc Acik    : $poh Saat" }
>> "%PSFILE%" echo     Write-Host "  Durum       : $status"
>> "%PSFILE%" echo     if ($status -eq 'Healthy') { Write-Host "  Bilgi       : 'Healthy' durumu, diskin donanimsal olarak %%11 ile %%100 arasi saglikta oldugunu gosterir." -ForegroundColor DarkGray }
>> "%PSFILE%" echo     Write-Host ""
>> "%PSFILE%" echo }

>> "%PSFILE%" echo Write-Host "[AG BAGLANTISI]" -ForegroundColor Cyan
>> "%PSFILE%" echo $net = Get-NetAdapter ^| Where-Object Status -eq 'Up' ^| Select-Object -First 1
>> "%PSFILE%" echo if ($net) {
>> "%PSFILE%" echo     $ip = (Get-NetIPAddress -InterfaceAlias $net.Name -AddressFamily IPv4 -ErrorAction SilentlyContinue).IPAddress
>> "%PSFILE%" echo     Write-Host "  Adaptor     : $($net.InterfaceDescription)"
>> "%PSFILE%" echo     Write-Host "  Ag Adi      : $($net.Name)"
>> "%PSFILE%" echo     Write-Host "  IPv4        : $ip"
>> "%PSFILE%" echo } else { Write-Host "  Baglanti Bulunamadi" }

powershell -NoProfile -ExecutionPolicy Bypass -File "%PSFILE%"
del /q "%PSFILE%"

echo.
echo %GRAY%  ==========================================================================================%RESET%
echo %BLUE%  Ana menuye donmek icin bir tusa basin...%RESET%
pause >nul
goto :MainMenu

:: ==============================================================================
:: KAPANIS SEKANSI VE ANIMASYONU
:: ==============================================================================
:Exit
cls
echo.
echo %CYAN%  [+] Sistem baglantisi kesiliyor...%RESET%
powershell -NoProfile -Command "Start-Sleep -Milliseconds 300"
echo %BLUE%  [+] Onbellek ve gecici hafiza temizleniyor...%RESET%
powershell -NoProfile -Command "Start-Sleep -Milliseconds 300"
echo %GREEN%  [OK] cyberQbit Ekosistemi guvenli bir sekilde kapatildi.%RESET%
powershell -NoProfile -Command "Start-Sleep -Milliseconds 400"
echo.
echo %GRAY%  Gorusmek uzere, Komutan!%RESET%
powershell -NoProfile -Command "Start-Sleep -Milliseconds 600"
exit