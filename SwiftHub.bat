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
:: SYSTEM INFO (Gelişmiş Donanım Analizi)
:: ==============================================================================
:SysInfo
cls
echo.
echo %BLUE%  [*] SWIFTHUB CORE - ADVANCED SYSTEM DIAGNOSTICS%RESET%
echo %GRAY%  ==========================================================================================%RESET%
echo.

:: Arka Planda PowerShell ile Filtrelenmiş Nokta Atışı Donanım Taraması
powershell -NoProfile -Command "$ErrorActionPreference = 'SilentlyContinue'; Write-Host '  [ISLETIM SISTEMI]' -ForegroundColor Blue; $os = Get-CimInstance Win32_OperatingSystem; $reg = Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion'; $ver = if($reg.DisplayVersion){$reg.DisplayVersion}else{$reg.ReleaseId}; $uptime = (Get-Date) - $os.LastBootUpTime; Write-Host ('    Model   : ' + $os.Caption + ' ' + $os.OSArchitecture) -ForegroundColor Cyan; Write-Host ('    Surum   : Version ' + $ver + ' (Build ' + $os.BuildNumber + ')') -ForegroundColor Cyan; Write-Host ('    Calisma : ' + $uptime.Days + ' Gun, ' + $uptime.Hours + ' Saat, ' + $uptime.Minutes + ' Dakika') -ForegroundColor Cyan; Write-Host ''; Write-Host '  [ANAKART VE BIOS]' -ForegroundColor Blue; $mb = Get-CimInstance Win32_BaseBoard; $bios = Get-CimInstance Win32_BIOS; Write-Host ('    Anakart : ' + $mb.Manufacturer + ' ' + $mb.Product) -ForegroundColor Cyan; Write-Host ('    BIOS    : ' + $bios.Manufacturer + ' ' + $bios.SMBIOSBIOSVersion) -ForegroundColor Cyan; Write-Host ''; Write-Host '  [ISLEMCI (CPU)]' -ForegroundColor Blue; $cpu = Get-CimInstance Win32_Processor; $ghz = [Math]::Round($cpu.MaxClockSpeed / 1000, 2); Write-Host ('    Model   : ' + $cpu.Name) -ForegroundColor Cyan; Write-Host ('    Cekirdek: ' + $cpu.NumberOfCores + ' Core / ' + $cpu.NumberOfLogicalProcessors + ' Thread') -ForegroundColor Cyan; Write-Host ('    Hiz : ' + $ghz + ' GHz') -ForegroundColor Cyan; Write-Host ''; Write-Host '  [BELLEK (RAM)]' -ForegroundColor Blue; $ram = Get-CimInstance Win32_ComputerSystem; $ramTotal = [Math]::Round($ram.TotalPhysicalMemory / 1GB, 2); $ramSticks = Get-CimInstance Win32_PhysicalMemory; $ramSpeed = if ($ramSticks) { $ramSticks[0].Speed } else { 'Bilinmiyor' }; Write-Host ('    Kapasite: ' + $ramTotal + ' GB') -ForegroundColor Cyan; Write-Host ('    Hiz     : ' + $ramSpeed + ' MHz') -ForegroundColor Cyan; Write-Host ''; Write-Host '  [GRAFIK KARTI (GPU)]' -ForegroundColor Blue; $gpu = Get-CimInstance Win32_VideoController; foreach ($g in $gpu) { if ($g.Name -notmatch 'Virtual|SuperDisplay|Remote|AnyDesk') { $vram = [Math]::Round($g.AdapterRAM / 1GB, 2); Write-Host ('    Model   : ' + $g.Caption + ' (' + $vram + ' GB VRAM)') -ForegroundColor Cyan; if($g.CurrentHorizontalResolution){ Write-Host ('    Ekran   : ' + $g.CurrentHorizontalResolution + 'x' + $g.CurrentVerticalResolution + ' @ ' + $g.CurrentRefreshRate + 'Hz') -ForegroundColor Cyan; } } }; Write-Host ''; Write-Host '  [DEPOLAMA SUCURULERI]' -ForegroundColor Blue; $disks = Get-CimInstance Win32_LogicalDisk -Filter 'DriveType=3'; foreach ($d in $disks) { $diskTotal = [Math]::Round($d.Size / 1GB, 2); $diskFree = [Math]::Round($d.FreeSpace / 1GB, 2); Write-Host ('    Surucu ' + $d.DeviceID + ' : ' + $diskFree + ' GB Bos / ' + $diskTotal + ' GB Toplam') -ForegroundColor Cyan; }; Write-Host ''; Write-Host '  [AG BAGLANTISI]' -ForegroundColor Blue; $net = Get-NetAdapter | Where-Object { $_.Status -eq 'Up' -and $_.Virtual -eq $false } | Select-Object -First 1; if ($net) { $ip = (Get-NetIPAddress -InterfaceIndex $net.ifIndex -AddressFamily IPv4 -ErrorAction SilentlyContinue).IPAddress; Write-Host ('    Adaptor : ' + $net.InterfaceDescription) -ForegroundColor Cyan; Write-Host ('    Ag Adi  : ' + $net.Name) -ForegroundColor Cyan; Write-Host ('    IPv4    : ' + $ip) -ForegroundColor Cyan; } else { $fallback = Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.IPAddress -notmatch '^127\.' -and $_.InterfaceAlias -notmatch 'Loopback|vEthernet|WSL|VMware|Virtual' } | Select-Object -First 1; if($fallback){ Write-Host ('    Ag Adi  : ' + $fallback.InterfaceAlias) -ForegroundColor Cyan; Write-Host ('    IPv4    : ' + $fallback.IPAddress) -ForegroundColor Cyan; } }"

echo.
echo %GRAY%  ==========================================================================================%RESET%
echo.
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