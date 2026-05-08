# ==============================================================================
# 🌌 SWIFTHUB CORE v6.2 - TITAN EDITION (FULL ARSENAL INTEGRATION)
# ==============================================================================
$ErrorActionPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# --- 1. DIL MOTORU (BILINGUAL DICTIONARY) ---
$global:CurrentLang = "TR"
$global:i18n = @{
    "TR" = @{
        "AppTitle" = "SWIFTHUB TITAN CORE"; "AppSub" = "GELISMIS SISTEM YONETIMI";
        "MenuDash" = "🏠 Kontrol Paneli"; "MenuApps" = "📦 Uygulamalar";
        "MenuTweaks" = "🛠️ Ince Ayarlar"; "MenuFeatures" = "⚙️ Windows Ozellikleri";
        "MenuNet" = "🌐 Ag ve Guvenlik"; "MenuFixes" = "🩹 Sistem Onarimi";
        "BtnLang" = "🌐 EN"; "StatusWait" = "Sistem hazir. Bir islem secin...";
        "DashWelcome" = "SwiftHub'a Hos Geldiniz!"; "DashSub" = "Sisteminizi optimize etmek, program kurmak veya sorunlari cozmek icin soldaki menuyu kullanin.";
        "BtnInstall" = "Secili Uygulamalari Kur"; "BtnApply" = "Secili Ayarlari Enjekte Et";
        "TitleNet" = "🌐 AĞ VE SİBER GÜVENLİK"; "TitleFix" = "🩹 SİSTEM ONARIMI"; "TitleFeat" = "⚙️ WINDOWS ÖZELLİKLERİ"
    };
    "EN" = @{
        "AppTitle" = "SWIFTHUB TITAN CORE"; "AppSub" = "ADVANCED SYSTEM MANAGEMENT";
        "MenuDash" = "🏠 Dashboard"; "MenuApps" = "📦 Applications";
        "MenuTweaks" = "🛠️ System Tweaks"; "MenuFeatures" = "⚙️ Windows Features";
        "MenuNet" = "🌐 Network & Security"; "MenuFixes" = "🩹 System Fixes";
        "BtnLang" = "🌐 TR"; "StatusWait" = "System ready. Select an operation...";
        "DashWelcome" = "Welcome to SwiftHub!"; "DashSub" = "Use the sidebar to optimize your system, install apps, or fix issues.";
        "BtnInstall" = "Install Selected Apps"; "BtnApply" = "Apply Selected Tweaks";
        "TitleNet" = "🌐 NETWORK & SECURITY"; "TitleFix" = "🩹 SYSTEM REPAIR"; "TitleFeat" = "⚙️ WINDOWS FEATURES"
    }
}

Add-Type -AssemblyName PresentationFramework; Add-Type -AssemblyName PresentationCore; Add-Type -AssemblyName WindowsBase

# --- 2. XAML TASARIMI (TÜM SAYFALAR DOLU) ---
[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" Title="SwiftHub Titan v6.2" Height="760" Width="1150" Background="#0B0C10" Foreground="White" WindowStartupLocation="CenterScreen" FontFamily="Segoe UI" WindowStyle="None" AllowsTransparency="True" ResizeMode="NoResize">
    <Window.Resources>
        <Style TargetType="Button" x:Key="SidebarBtn">
            <Setter Property="Background" Value="Transparent"/><Setter Property="Foreground" Value="#8A8D93"/><Setter Property="FontSize" Value="15"/><Setter Property="FontWeight" Value="SemiBold"/><Setter Property="HorizontalContentAlignment" Value="Left"/><Setter Property="Padding" Value="20,0,0,0"/><Setter Property="Height" Value="50"/><Setter Property="BorderThickness" Value="0"/><Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template"><Setter.Value><ControlTemplate TargetType="Button"><Border Name="border" Background="{TemplateBinding Background}" CornerRadius="8"><ContentPresenter HorizontalAlignment="{TemplateBinding HorizontalContentAlignment}" VerticalAlignment="Center" Margin="{TemplateBinding Padding}"/></Border><ControlTemplate.Triggers><Trigger Property="IsMouseOver" Value="True"><Setter TargetName="border" Property="Background" Value="#1F222B"/><Setter Property="Foreground" Value="White"/></Trigger></ControlTemplate.Triggers></ControlTemplate></Setter.Value></Setter>
        </Style>
        <Style TargetType="Button" x:Key="ActionBtn">
            <Setter Property="Background" Value="#1F222B"/><Setter Property="Foreground" Value="White"/><Setter Property="Height" Value="45"/><Setter Property="BorderThickness" Value="0"/><Setter Property="Cursor" Value="Hand"/><Setter Property="Margin" Value="0,0,0,10"/><Setter Property="FontWeight" Value="Bold"/>
            <Setter Property="Template"><Setter.Value><ControlTemplate TargetType="Button"><Border Background="{TemplateBinding Background}" CornerRadius="6"><ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/></Border></ControlTemplate></Setter.Value></Setter>
        </Style>
        <Style TargetType="CheckBox"><Setter Property="Foreground" Value="White"/><Setter Property="FontSize" Value="13"/><Setter Property="Margin" Value="0,5,15,5"/><Setter Property="Width" Value="200"/></Style>
    </Window.Resources>

    <Border BorderBrush="#1F222B" BorderThickness="1" CornerRadius="10" Background="#0B0C10">
        <Grid>
            <Grid.ColumnDefinitions><ColumnDefinition Width="260"/><ColumnDefinition Width="*"/></Grid.ColumnDefinitions>
            
            <Border Grid.Column="0" Background="#13151A" CornerRadius="10,0,0,10">
                <Grid>
                    <Grid.RowDefinitions><RowDefinition Height="Auto"/><RowDefinition Height="*"/><RowDefinition Height="Auto"/></Grid.RowDefinitions>
                    <StackPanel Grid.Row="0" Margin="20,30,20,40">
                        <TextBlock Name="TxtTitle" Text="SWIFTHUB TITAN" FontSize="22" FontWeight="Black" Foreground="#00CED1"/>
                        <TextBlock Name="TxtSub" Text="SISTEM YONETIMI" FontSize="11" FontWeight="Bold" Foreground="#666"/>
                    </StackPanel>
                    <StackPanel Grid.Row="1" Margin="10,0">
                        <Button Name="NavDash" Content="🏠 Kontrol Paneli" Style="{StaticResource SidebarBtn}" Foreground="White" Background="#1F222B"/>
                        <Button Name="NavApps" Content="📦 Uygulamalar" Style="{StaticResource SidebarBtn}"/>
                        <Button Name="NavTweaks" Content="🛠️ Ince Ayarlar" Style="{StaticResource SidebarBtn}"/>
                        <Button Name="NavFeatures" Content="⚙️ Windows Ozellikleri" Style="{StaticResource SidebarBtn}"/>
                        <Button Name="NavNet" Content="🌐 Ag ve Guvenlik" Style="{StaticResource SidebarBtn}"/>
                        <Button Name="NavFixes" Content="🩹 Sistem Onarimi" Style="{StaticResource SidebarBtn}"/>
                    </StackPanel>
                    <Grid Grid.Row="2" Margin="15,20,15,20">
                        <Grid.ColumnDefinitions><ColumnDefinition Width="*"/><ColumnDefinition Width="Auto"/></Grid.ColumnDefinitions>
                        <Button Name="BtnExit" Content="Kapat (Exit)" Background="#FF3B30" Foreground="White" FontWeight="Bold" Height="40" BorderThickness="0" Cursor="Hand" Grid.Column="0" Margin="0,0,10,0"><Button.Resources><Style TargetType="Border"><Setter Property="CornerRadius" Value="6"/></Style></Button.Resources></Button>
                        <Button Name="BtnLangToggle" Content="🌐 EN" Background="#1F222B" Foreground="White" FontWeight="Bold" Height="40" Width="60" BorderThickness="0" Cursor="Hand" Grid.Column="1"><Button.Resources><Style TargetType="Border"><Setter Property="CornerRadius" Value="6"/></Style></Button.Resources></Button>
                    </Grid>
                </Grid>
            </Border>

            <Grid Grid.Column="1" Margin="30">
                <Grid.RowDefinitions><RowDefinition Height="*"/><RowDefinition Height="Auto"/></Grid.RowDefinitions>

                <Grid Name="PageDash" Visibility="Visible">
                    <StackPanel VerticalAlignment="Center" HorizontalAlignment="Center">
                        <TextBlock Name="TxtDashWelcome" Text="SwiftHub'a Hos Geldiniz!" FontSize="36" FontWeight="Black" Foreground="White" TextAlignment="Center" Margin="0,0,0,10"/>
                        <TextBlock Name="TxtDashSub" Text="Sisteminizi optimize etmek, program kurmak veya sorunlari cozmek icin soldaki menuyu kullanin." FontSize="16" Foreground="#8A8D93" TextAlignment="Center" Margin="0,0,0,30"/>
                        <Button Name="BtnAnalyze" Content="Sistemi Analiz Et (God Mode)" Style="{StaticResource ActionBtn}" Width="300" Background="#00CED1" Foreground="#0B0C10"/>
                        <Border Background="#13151A" BorderBrush="#1F222B" BorderThickness="1" CornerRadius="6" Height="250" Width="600">
                            <ScrollViewer Margin="15"><TextBlock Name="TxtSysInfo" Text="Hazir..." Foreground="#00FF66" FontFamily="Consolas"/></ScrollViewer>
                        </Border>
                    </StackPanel>
                </Grid>

                <Grid Name="PageApps" Visibility="Hidden">
                    <Grid.RowDefinitions><RowDefinition Height="*"/><RowDefinition Height="Auto"/></Grid.RowDefinitions>
                    <Border Grid.Row="0" Background="#13151A" CornerRadius="8" Padding="20"><ScrollViewer VerticalScrollBarVisibility="Auto"><StackPanel Name="PanelAppsContainer"/></ScrollViewer></Border>
                    <Button Name="BtnInstallApps" Content="Secili Uygulamalari Kur" Style="{StaticResource ActionBtn}" Background="#00CED1" Foreground="#0B0C10" Grid.Row="1" Margin="0,15,0,0"/>
                </Grid>

                <Grid Name="PageTweaks" Visibility="Hidden">
                    <Grid.RowDefinitions><RowDefinition Height="*"/><RowDefinition Height="Auto"/></Grid.RowDefinitions>
                    <Border Grid.Row="0" Background="#13151A" CornerRadius="8" Padding="20"><ScrollViewer VerticalScrollBarVisibility="Auto"><StackPanel Name="PanelTweaksContainer"/></ScrollViewer></Border>
                    <Button Name="BtnApplyTweaks" Content="Secili Ayarlari Enjekte Et" Style="{StaticResource ActionBtn}" Background="#00CED1" Foreground="#0B0C10" Grid.Row="1" Margin="0,15,0,0"/>
                </Grid>

                <Grid Name="PageFeatures" Visibility="Hidden">
                    <StackPanel>
                        <TextBlock Name="TxtTitleFeat" Text="⚙️ WINDOWS ÖZELLİKLERİ" FontSize="24" FontWeight="Black" Foreground="White" Margin="0,0,0,20"/>
                        <Button Name="BtnFeatWSL" Content="Linux Alt Sistemini (WSL) Kur" Style="{StaticResource ActionBtn}"/>
                        <Button Name="BtnFeatHyperV" Content="Hyper-V Sanallastirmayi Aktif Et" Style="{StaticResource ActionBtn}"/>
                        <Button Name="BtnFeatSandbox" Content="Windows Sandbox'i Aktif Et" Style="{StaticResource ActionBtn}"/>
                        <TextBlock Text="Not: Bu ozelliklerin aktiflesmesi bilgisayarinizin yeniden baslamasini gerektirebilir." Foreground="#8A8D93" Margin="0,10,0,0"/>
                    </StackPanel>
                </Grid>

                <Grid Name="PageNet" Visibility="Hidden">
                    <StackPanel>
                        <TextBlock Name="TxtTitleNet" Text="🌐 AĞ VE SİBER GÜVENLİK" FontSize="24" FontWeight="Black" Foreground="White" Margin="0,0,0,20"/>
                        <Button Name="BtnSpeedTest" Content="Hiz Testi ve Analiz (Ookla)" Style="{StaticResource ActionBtn}"/>
                        <Grid Margin="0,0,0,10">
                            <Grid.ColumnDefinitions><ColumnDefinition Width="*"/><ColumnDefinition Width="10"/><ColumnDefinition Width="*"/><ColumnDefinition Width="10"/><ColumnDefinition Width="*"/></Grid.ColumnDefinitions>
                            <Button Name="BtnDnsCloudflare" Grid.Column="0" Content="Cloudflare DNS" Style="{StaticResource ActionBtn}" Margin="0"/>
                            <Button Name="BtnDnsGoogle" Grid.Column="2" Content="Google DNS" Style="{StaticResource ActionBtn}" Margin="0"/>
                            <Button Name="BtnDnsDefault" Grid.Column="4" Content="Varsayilan DNS" Style="{StaticResource ActionBtn}" Margin="0"/>
                        </Grid>
                        <Button Name="BtnNetReset" Content="Agi Tamamen Sifirla (Winsock / FlushDNS)" Style="{StaticResource ActionBtn}" Background="#4A0000"/>
                        <Border Background="#13151A" BorderBrush="#1F222B" BorderThickness="1" CornerRadius="6" Height="150" Margin="0,10,0,0">
                            <ScrollViewer Margin="15"><TextBlock Name="TxtNetLog" Text="Ag modulu hazir..." Foreground="#00FF66" FontFamily="Consolas"/></ScrollViewer>
                        </Border>
                    </StackPanel>
                </Grid>

                <Grid Name="PageFixes" Visibility="Hidden">
                    <StackPanel>
                        <TextBlock Name="TxtTitleFix" Text="🩹 SİSTEM ONARIMI" FontSize="24" FontWeight="Black" Foreground="White" Margin="0,0,0,20"/>
                        <Button Name="BtnFixSFC" Content="Sistem Dosyalarini Onar (SFC &amp; DISM)" Style="{StaticResource ActionBtn}"/>
                        <Button Name="BtnFixWU" Content="Windows Update Bilesenlerini Sifirla" Style="{StaticResource ActionBtn}"/>
                        <Button Name="BtnFixTemp" Content="Gereksiz Dosyalari ve Onbellegi Temizle" Style="{StaticResource ActionBtn}"/>
                        <Border Background="#13151A" BorderBrush="#1F222B" BorderThickness="1" CornerRadius="6" Height="150" Margin="0,10,0,0">
                            <ScrollViewer Margin="15"><TextBlock Name="TxtFixLog" Text="Onarim modulu hazir..." Foreground="#00FF66" FontFamily="Consolas"/></ScrollViewer>
                        </Border>
                    </StackPanel>
                </Grid>

                <Border Grid.Row="1" Background="#13151A" CornerRadius="6" Padding="15,10" Margin="0,20,0,0">
                    <TextBlock Name="TxtStatus" Text="Sistem hazir. Bir islem secin..." Foreground="#00FF66" FontFamily="Consolas" FontSize="13"/>
                </Border>
            </Grid>
        </Grid>
    </Border>
</Window>
"@

$reader = (New-Object System.Xml.XmlNodeReader $xaml); $window = [Windows.Markup.XamlReader]::Load($reader)

# --- ARAYUZ ELEMANLARI BINDING ---
$NavDash=$window.FindName("NavDash"); $NavApps=$window.FindName("NavApps"); $NavTweaks=$window.FindName("NavTweaks")
$NavFeatures=$window.FindName("NavFeatures"); $NavNet=$window.FindName("NavNet"); $NavFixes=$window.FindName("NavFixes")
$PageDash=$window.FindName("PageDash"); $PageApps=$window.FindName("PageApps"); $PageTweaks=$window.FindName("PageTweaks")
$PageFeatures=$window.FindName("PageFeatures"); $PageNet=$window.FindName("PageNet"); $PageFixes=$window.FindName("PageFixes")

$BtnExit=$window.FindName("BtnExit"); $BtnLangToggle=$window.FindName("BtnLangToggle"); $TxtStatus=$window.FindName("TxtStatus")

# Text Elemanları
$TxtTitle=$window.FindName("TxtTitle"); $TxtSub=$window.FindName("TxtSub")
$TxtDashWelcome=$window.FindName("TxtDashWelcome"); $TxtDashSub=$window.FindName("TxtDashSub")
$TxtTitleNet=$window.FindName("TxtTitleNet"); $TxtTitleFix=$window.FindName("TxtTitleFix"); $TxtTitleFeat=$window.FindName("TxtTitleFeat")
$TxtSysInfo=$window.FindName("TxtSysInfo"); $TxtNetLog=$window.FindName("TxtNetLog"); $TxtFixLog=$window.FindName("TxtFixLog")

# Aksiyon Butonları
$BtnAnalyze=$window.FindName("BtnAnalyze"); $BtnInstallApps=$window.FindName("BtnInstallApps"); $BtnApplyTweaks=$window.FindName("BtnApplyTweaks")
$BtnSpeedTest=$window.FindName("BtnSpeedTest"); $BtnDnsCloudflare=$window.FindName("BtnDnsCloudflare"); $BtnDnsGoogle=$window.FindName("BtnDnsGoogle"); $BtnDnsDefault=$window.FindName("BtnDnsDefault"); $BtnNetReset=$window.FindName("BtnNetReset")
$BtnFixSFC=$window.FindName("BtnFixSFC"); $BtnFixWU=$window.FindName("BtnFixWU"); $BtnFixTemp=$window.FindName("BtnFixTemp")
$BtnFeatWSL=$window.FindName("BtnFeatWSL"); $BtnFeatHyperV=$window.FindName("BtnFeatHyperV"); $BtnFeatSandbox=$window.FindName("BtnFeatSandbox")

$global:AppHeaders=@(); $global:AppItems=@(); $global:TweakHeaders=@(); $global:TweakItems=@()

# ==============================================================================
# 🚀 3. DINAMIK JSON MOTORU
# ==============================================================================
try {
    $jsonResponseApps = (New-Object System.Net.WebClient).DownloadString("https://raw.githubusercontent.com/cyberQbit/DevSwift/main/apps.json?t=$((Get-Date).Ticks)") | ConvertFrom-Json
    foreach ($cat in $jsonResponseApps.psobject.properties.name) {
        $header = New-Object System.Windows.Controls.TextBlock; $header.Foreground = "#00CED1"; $header.FontSize = 16; $header.FontWeight = "Bold"; $header.Margin = "0,15,0,10"
        $global:AppHeaders += [PSCustomObject]@{ UI=$header; TR=$jsonResponseApps."$cat".TR; EN=$jsonResponseApps."$cat".EN }; $window.FindName("PanelAppsContainer").Children.Add($header) | Out-Null
        $wp = New-Object System.Windows.Controls.WrapPanel; $wp.Margin = "0,0,0,10"
        foreach ($app in $jsonResponseApps."$cat".Items) {
            $cb = New-Object System.Windows.Controls.CheckBox; $cb.Content = $app.Name
            $global:AppItems += [PSCustomObject]@{ CheckBox=$cb; Id=$app.Id }; $wp.Children.Add($cb) | Out-Null
        }
        $window.FindName("PanelAppsContainer").Children.Add($wp) | Out-Null
    }
} catch {}

try {
    $jsonResponseTweaks = (New-Object System.Net.WebClient).DownloadString("https://raw.githubusercontent.com/cyberQbit/WinSwift/main/tweaks.json?t=$((Get-Date).Ticks)") | ConvertFrom-Json
    foreach ($cat in $jsonResponseTweaks.psobject.properties.name) {
        $header = New-Object System.Windows.Controls.TextBlock; $header.Foreground = "#FF3366"; $header.FontSize = 16; $header.FontWeight = "Bold"; $header.Margin = "0,15,0,10"
        $global:TweakHeaders += [PSCustomObject]@{ UI=$header; TR=$jsonResponseTweaks."$cat".TR; EN=$jsonResponseTweaks."$cat".EN }; $window.FindName("PanelTweaksContainer").Children.Add($header) | Out-Null
        $wp = New-Object System.Windows.Controls.WrapPanel; $wp.Margin = "0,0,0,10"
        foreach ($tweak in $jsonResponseTweaks."$cat".Items) {
            $cb = New-Object System.Windows.Controls.CheckBox; $cb.Content = $tweak.Name; $cb.Width = 350
            $global:TweakItems += [PSCustomObject]@{ CheckBox=$cb; Script=$tweak.Script }; $wp.Children.Add($cb) | Out-Null
        }
        $window.FindName("PanelTweaksContainer").Children.Add($wp) | Out-Null
    }
} catch {}

# --- 4. FONKSIYONLAR ---
function Update-Language {
    $d = $global:i18n[$global:CurrentLang]
    $TxtTitle.Text = $d["AppTitle"]; $TxtSub.Text = $d["AppSub"]; $NavDash.Content = $d["MenuDash"]; $NavApps.Content = $d["MenuApps"]
    $NavTweaks.Content = $d["MenuTweaks"]; $NavFeatures.Content = $d["MenuFeatures"]; $NavNet.Content = $d["MenuNet"]; $NavFixes.Content = $d["MenuFixes"]
    $BtnLangToggle.Content = $d["BtnLang"]; $TxtStatus.Text = $d["StatusWait"]; $TxtDashWelcome.Text = $d["DashWelcome"]; $TxtDashSub.Text = $d["DashSub"]
    $BtnInstallApps.Content = $d["BtnInstall"]; $BtnApplyTweaks.Content = $d["BtnApply"]
    $TxtTitleNet.Text = $d["TitleNet"]; $TxtTitleFix.Text = $d["TitleFix"]; $TxtTitleFeat.Text = $d["TitleFeat"]
    foreach ($h in $global:AppHeaders) { $h.UI.Text = $h."$($global:CurrentLang)" }
    foreach ($h in $global:TweakHeaders) { $h.UI.Text = $h."$($global:CurrentLang)" }
}
function Reset-Nav {
    $NavDash.Background="Transparent"; $NavDash.Foreground="#8A8D93"; $NavApps.Background="Transparent"; $NavApps.Foreground="#8A8D93"; $NavTweaks.Background="Transparent"; $NavTweaks.Foreground="#8A8D93"
    $NavFeatures.Background="Transparent"; $NavFeatures.Foreground="#8A8D93"; $NavNet.Background="Transparent"; $NavNet.Foreground="#8A8D93"; $NavFixes.Background="Transparent"; $NavFixes.Foreground="#8A8D93"
    $PageDash.Visibility="Hidden"; $PageApps.Visibility="Hidden"; $PageTweaks.Visibility="Hidden"; $PageFeatures.Visibility="Hidden"; $PageNet.Visibility="Hidden"; $PageFixes.Visibility="Hidden"
}

# --- 5. EVENTLER ---
$BtnLangToggle.Add_Click({ if ($global:CurrentLang -eq "TR") { $global:CurrentLang = "EN" } else { $global:CurrentLang = "TR" }; Update-Language })
$BtnExit.Add_Click({ $window.Close() })

$NavDash.Add_Click({ Reset-Nav; $NavDash.Background="#1F222B"; $NavDash.Foreground="White"; $PageDash.Visibility="Visible" })
$NavApps.Add_Click({ Reset-Nav; $NavApps.Background="#1F222B"; $NavApps.Foreground="White"; $PageApps.Visibility="Visible" })
$NavTweaks.Add_Click({ Reset-Nav; $NavTweaks.Background="#1F222B"; $NavTweaks.Foreground="White"; $PageTweaks.Visibility="Visible" })
$NavFeatures.Add_Click({ Reset-Nav; $NavFeatures.Background="#1F222B"; $NavFeatures.Foreground="White"; $PageFeatures.Visibility="Visible" })
$NavNet.Add_Click({ Reset-Nav; $NavNet.Background="#1F222B"; $NavNet.Foreground="White"; $PageNet.Visibility="Visible" })
$NavFixes.Add_Click({ Reset-Nav; $NavFixes.Background="#1F222B"; $NavFixes.Foreground="White"; $PageFixes.Visibility="Visible" })

# APP & TWEAKS
$BtnInstallApps.Add_Click({
    $TxtStatus.Text = "Programlar arka planda kuruluyor..."; $BtnInstallApps.IsEnabled = $false; $window.Dispatcher.Invoke([Action]{}, [Windows.Threading.DispatcherPriority]::Render)
    $c = 0; foreach ($i in $global:AppItems) { if ($i.CheckBox.IsChecked) { try { Start-Process "winget" -ArgumentList "install --id $($i.Id) --accept-source-agreements --accept-package-agreements --silent" -Wait -NoNewWindow; $c++ } catch {} } }
    $TxtStatus.Text = "[+] $c program kuruldu!"; $BtnInstallApps.IsEnabled = $true
})
$BtnApplyTweaks.Add_Click({
    $TxtStatus.Text = "Ayarlar enjekte ediliyor..."; $BtnApplyTweaks.IsEnabled = $false; $window.Dispatcher.Invoke([Action]{}, [Windows.Threading.DispatcherPriority]::Render)
    $c = 0; foreach ($i in $global:TweakItems) { if ($i.CheckBox.IsChecked) { try { Invoke-Expression $i.Script; $c++ } catch {} } }
    $TxtStatus.Text = "[+] $c ayar uygulandi!"; $BtnApplyTweaks.IsEnabled = $true
})

# SYSINFO
$BtnAnalyze.Add_Click({
    $TxtSysInfo.Text = "Telemetri Okunuyor..."; $window.Dispatcher.Invoke([Action]{}, [Windows.Threading.DispatcherPriority]::Render)
    $os = Get-CimInstance Win32_OperatingSystem -ErrorAction SilentlyContinue; $cpu = Get-CimInstance Win32_Processor -ErrorAction SilentlyContinue; $ram = Get-CimInstance Win32_PhysicalMemory -ErrorAction SilentlyContinue
    $TxtSysInfo.Text = "[OS] $($os.Caption)`n[CPU] $($cpu[0].Name)`n[RAM] $([math]::Round(($ram | Measure-Object Capacity -Sum).Sum / 1GB, 2)) GB`n`nHazir."
})

# NETWORK
$BtnSpeedTest.Add_Click({
    $TxtNetLog.Text = "[*] Ookla Motoru atesleniyor... (Arayuz 20sn kilitlenebilir, bekleyin)"; $window.Dispatcher.Invoke([Action]{}, [Windows.Threading.DispatcherPriority]::Render)
    try {
        $t = "$env:TEMP\Ookla"; if (Test-Path $t) { Remove-Item $t -Recurse -Force }; New-Item -Path $t -ItemType Directory | Out-Null
        $wc = New-Object System.Net.WebClient; $wc.DownloadFile("https://install.speedtest.net/app/cli/ookla-speedtest-1.2.0-win64.zip", "$t\s.zip")
        Expand-Archive "$t\s.zip" "$t" -Force; $o = & "$t\speedtest.exe" --accept-license --accept-gdpr --format=json | ConvertFrom-Json
        $TxtNetLog.Text = "[+] OOKLA SONUCU:`nPing: $($o.ping.latency) ms`nDown: $([math]::Round($o.download.bandwidth*8/1000000, 2)) Mbps`nUp: $([math]::Round($o.upload.bandwidth*8/1000000, 2)) Mbps"
    } catch { $TxtNetLog.Text = "[X] Hata: $($_.Exception.Message)" } finally { if (Test-Path $t) { Remove-Item $t -Recurse -Force -ErrorAction SilentlyContinue } }
})
$BtnDnsCloudflare.Add_Click({ $n=Get-NetAdapter|Where Status -eq 'Up'|Select -First 1; Set-DnsClientServerAddress -InterfaceIndex $n.ifIndex -ServerAddresses ("1.1.1.1","1.0.0.1"); $TxtNetLog.Text="[+] DNS -> Cloudflare" })
$BtnDnsGoogle.Add_Click({ $n=Get-NetAdapter|Where Status -eq 'Up'|Select -First 1; Set-DnsClientServerAddress -InterfaceIndex $n.ifIndex -ServerAddresses ("8.8.8.8","8.8.4.4"); $TxtNetLog.Text="[+] DNS -> Google" })
$BtnDnsDefault.Add_Click({ $n=Get-NetAdapter|Where Status -eq 'Up'|Select -First 1; Set-DnsClientServerAddress -InterfaceIndex $n.ifIndex -ResetServerAddresses; $TxtNetLog.Text="[+] DNS Sifirlandi." })
$BtnNetReset.Add_Click({ ipconfig /flushdns | Out-Null; netsh winsock reset | Out-Null; $TxtNetLog.Text="[+] Ag Onbellegi Sifirlandi (Yeniden baslatin)." })

# FIXES
$BtnFixSFC.Add_Click({
    $TxtFixLog.Text = "[*] DISM & SFC Tarama ve Onarimi baslatildi. Bu islem uzun surebilir..."; $window.Dispatcher.Invoke([Action]{}, [Windows.Threading.DispatcherPriority]::Render)
    Start-Process "cmd.exe" -ArgumentList "/c DISM /Online /Cleanup-Image /RestoreHealth & sfc /scannow" -Wait -NoNewWindow
    $TxtFixLog.Text = "[+] Sistem bilesen onarimi tamamlandi!"
})
$BtnFixWU.Add_Click({
    $TxtFixLog.Text = "[*] Windows Update onbellegi temizleniyor..."; $window.Dispatcher.Invoke([Action]{}, [Windows.Threading.DispatcherPriority]::Render)
    Stop-Service -Name wuauserv -Force -ErrorAction SilentlyContinue; Stop-Service -Name bits -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "$env:windir\SoftwareDistribution\Download\*" -Recurse -Force -ErrorAction SilentlyContinue
    Start-Service -Name wuauserv -ErrorAction SilentlyContinue; Start-Service -Name bits -ErrorAction SilentlyContinue
    $TxtFixLog.Text = "[+] Update onbellegi sifirlandi!"
})
$BtnFixTemp.Add_Click({
    $TxtFixLog.Text = "[*] Gereksiz dosyalar (Temp) siliniyor..."; $window.Dispatcher.Invoke([Action]{}, [Windows.Threading.DispatcherPriority]::Render)
    Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue; Remove-Item -Path "$env:windir\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
    $TxtFixLog.Text = "[+] Gecici dosyalar temizlendi!"
})

# FEATURES
$BtnFeatWSL.Add_Click({ Start-Process "dism.exe" -ArgumentList "/online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart" -Wait -NoNewWindow; $TxtStatus.Text="[+] WSL Kuruldu. Yeniden baslatin." })
$BtnFeatHyperV.Add_Click({ Start-Process "dism.exe" -ArgumentList "/online /enable-feature /featurename:Microsoft-Hyper-V-All /all /norestart" -Wait -NoNewWindow; $TxtStatus.Text="[+] Hyper-V Kuruldu. Yeniden baslatin." })
$BtnFeatSandbox.Add_Click({ Start-Process "dism.exe" -ArgumentList "/online /enable-feature /featurename:Containers-DisposableClientVM /all /norestart" -Wait -NoNewWindow; $TxtStatus.Text="[+] Sandbox Kuruldu. Yeniden baslatin." })

Update-Language; $window.ShowDialog() | Out-Null