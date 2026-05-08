# ==============================================================================
# 🌌 SWIFTHUB CORE v5.0 - THE ULTIMATE MASTERPIECE (FULL GUI)
# ==============================================================================
$ErrorActionPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# 1. GEREKLI ARAYUZ (WPF) KUTUPHANELERI
Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase

# 2. XAML TASARIMI (NetSwift Sekmesi Eklendi, TUMU AKTIF)
[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="SwiftHub Core - Advanced System Gateway" Height="680" Width="1050"
        Background="#0F1015" Foreground="White" WindowStartupLocation="CenterScreen"
        FontFamily="Segoe UI">
    <Window.Resources>
        <Style TargetType="TabItem">
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="TabItem">
                        <Border Name="Border" Padding="20,12" Margin="2,0,2,0" Background="#1A1C23" CornerRadius="6,6,0,0">
                            <ContentPresenter x:Name="ContentSite" VerticalAlignment="Center" HorizontalAlignment="Center" ContentSource="Header" Margin="10,2"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsSelected" Value="True">
                                <Setter TargetName="Border" Property="Background" Value="#00CED1"/>
                                <Setter Property="Foreground" Value="#0F1015"/>
                            </Trigger>
                            <Trigger Property="IsSelected" Value="False">
                                <Setter Property="Foreground" Value="#A0A0A0"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
            <Setter Property="FontSize" Value="15"/>
            <Setter Property="FontWeight" Value="Bold"/>
        </Style>
        <Style TargetType="Button" x:Key="NetButtonStyle">
            <Setter Property="Background" Value="#1A1C23"/>
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="Height" Value="40"/>
            <Setter Property="BorderBrush" Value="#2D303B"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border Background="{TemplateBinding Background}" BorderBrush="{TemplateBinding BorderBrush}" BorderThickness="{TemplateBinding BorderThickness}" CornerRadius="4">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
    </Window.Resources>
    
    <Grid Margin="15">
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
        </Grid.RowDefinitions>
        
        <StackPanel Grid.Row="0" Margin="5,0,0,20" Orientation="Horizontal">
            <TextBlock Text="🌌 SWIFTHUB" FontSize="32" FontWeight="Black" Foreground="#00CED1" VerticalAlignment="Center"/>
            <TextBlock Text=" TITANIUM CORE" FontSize="20" FontWeight="Light" Foreground="#7A7A7A" VerticalAlignment="Bottom" Margin="10,0,0,4"/>
        </StackPanel>
        
        <TabControl Grid.Row="1" Background="#1A1C23" BorderBrush="#2D303B" BorderThickness="1">
            
            <TabItem Header="🔧 WinSwift (Tweaks)">
                <Grid Margin="20">
                    <Grid.RowDefinitions>
                        <RowDefinition Height="*"/>
                        <RowDefinition Height="Auto"/>
                    </Grid.RowDefinitions>
                    <Border Grid.Row="0" Background="#0F1015" BorderBrush="#2D303B" BorderThickness="1" CornerRadius="4">
                        <ScrollViewer VerticalScrollBarVisibility="Auto" Margin="15">
                            <StackPanel Name="PanelWinSwift"/>
                        </ScrollViewer>
                    </Border>
                    <Button Name="BtnApplyTweaks" Content="Secili Ayarlari Sisteme Enjekte Et" Height="45" Background="#00CED1" Foreground="#0F1015" FontWeight="Bold" FontSize="14" BorderThickness="0" Grid.Row="1" Margin="0,15,0,0">
                        <Button.Resources><Style TargetType="Border"><Setter Property="CornerRadius" Value="4"/></Style></Button.Resources>
                    </Button>
                </Grid>
            </TabItem>
            
            <TabItem Header="⚡ DevSwift (Apps)">
                <Grid Margin="20">
                    <Grid.RowDefinitions>
                        <RowDefinition Height="*"/>
                        <RowDefinition Height="Auto"/>
                    </Grid.RowDefinitions>
                    <Border Grid.Row="0" Background="#0F1015" BorderBrush="#2D303B" BorderThickness="1" CornerRadius="4">
                        <ScrollViewer VerticalScrollBarVisibility="Auto" Margin="15">
                            <StackPanel Name="PanelDevSwift"/>
                        </ScrollViewer>
                    </Border>
                    <Button Name="BtnInstallApps" Content="Secili Programlari Kur" Height="45" Background="#00CED1" Foreground="#0F1015" FontWeight="Bold" FontSize="14" BorderThickness="0" Grid.Row="1" Margin="0,15,0,0">
                        <Button.Resources><Style TargetType="Border"><Setter Property="CornerRadius" Value="4"/></Style></Button.Resources>
                    </Button>
                </Grid>
            </TabItem>

            <TabItem Header="🌐 NetSwift (Network)">
                <Grid Margin="20">
                    <Grid.RowDefinitions>
                        <RowDefinition Height="Auto"/>
                        <RowDefinition Height="Auto"/>
                        <RowDefinition Height="*"/>
                    </Grid.RowDefinitions>

                    <StackPanel Grid.Row="0" Margin="0,0,0,25">
                        <TextBlock Text="INTERNET HIZ TESTI (OOKLA SPEEDTEST CLI - ZERO FOOTPRINT)" Foreground="#00CED1" FontSize="16" FontWeight="Bold" Margin="0,0,0,10"/>
                        <Button Name="BtnSpeedTest" Content="Baglanti Hizini Olc" Style="{StaticResource NetButtonStyle}"/>
                    </StackPanel>

                    <StackPanel Grid.Row="1" Margin="0,0,0,25">
                        <TextBlock Text="DNS YONETIMI &amp; SIFIRLAMA" Foreground="#00CED1" FontSize="16" FontWeight="Bold" Margin="0,0,0,10"/>
                        <Grid>
                            <Grid.ColumnDefinitions>
                                <ColumnDefinition Width="*"/>
                                <ColumnDefinition Width="10"/>
                                <ColumnDefinition Width="*"/>
                                <ColumnDefinition Width="10"/>
                                <ColumnDefinition Width="*"/>
                                <ColumnDefinition Width="10"/>
                                <ColumnDefinition Width="*"/>
                            </Grid.ColumnDefinitions>
                            <Button Name="BtnDnsCloudflare" Grid.Column="0" Content="Cloudflare DNS" Style="{StaticResource NetButtonStyle}"/>
                            <Button Name="BtnDnsGoogle" Grid.Column="2" Content="Google DNS" Style="{StaticResource NetButtonStyle}"/>
                            <Button Name="BtnDnsDefault" Grid.Column="4" Content="Varsayilan DNS" Style="{StaticResource NetButtonStyle}"/>
                            <Button Name="BtnNetReset" Grid.Column="6" Content="Agi Tamamen Onar" Background="#4A0000" Style="{StaticResource NetButtonStyle}"/>
                        </Grid>
                    </StackPanel>

                    <StackPanel Grid.Row="2">
                        <TextBlock Text="SISTEM CIKTISI (LOG)" Foreground="#7A7A7A" FontSize="14" FontWeight="Bold" Margin="0,0,0,10"/>
                        <Border Background="#0F1015" BorderBrush="#2D303B" BorderThickness="1" CornerRadius="4" Height="140">
                            <ScrollViewer Margin="20">
                                <TextBlock Name="TxtNetLog" Text="Ag modulu hazir..." FontFamily="Consolas" FontSize="14" Foreground="#00FF66" TextWrapping="Wrap"/>
                            </ScrollViewer>
                        </Border>
                    </StackPanel>
                </Grid>
            </TabItem>
            
            <TabItem Header="📊 Sistem Telemetrisi">
                <Grid Margin="20">
                    <Grid.RowDefinitions>
                        <RowDefinition Height="Auto"/>
                        <RowDefinition Height="*"/>
                    </Grid.RowDefinitions>
                    <Button Name="BtnAnalyze" Content="Sistemi Analiz Et (God Mode)" Width="250" Height="45" HorizontalAlignment="Left" Background="#00CED1" Foreground="#0F1015" FontWeight="Bold" FontSize="14" BorderThickness="0" Grid.Row="0" Margin="0,0,0,15">
                        <Button.Resources><Style TargetType="Border"><Setter Property="CornerRadius" Value="4"/></Style></Button.Resources>
                    </Button>
                    <Border Grid.Row="1" Background="#0F1015" BorderBrush="#2D303B" BorderThickness="1" CornerRadius="4">
                        <ScrollViewer Margin="15"><TextBlock Name="TxtSysInfo" Text="Analizi baslatmak icin yukaridaki butona basin..." FontFamily="Consolas" FontSize="14" Foreground="#00FF66" TextWrapping="Wrap"/></ScrollViewer>
                    </Border>
                </Grid>
            </TabItem>
        </TabControl>
    </Grid>
</Window>
"@

$reader = (New-Object System.Xml.XmlNodeReader $xaml)
$window = [Windows.Markup.XamlReader]::Load($reader)

# --- ARAYUZ ELEMANLARI ---
$PanelWinSwift = $window.FindName("PanelWinSwift")
$BtnApplyTweaks = $window.FindName("BtnApplyTweaks")
$PanelDevSwift = $window.FindName("PanelDevSwift")
$BtnInstallApps = $window.FindName("BtnInstallApps")
$BtnAnalyze = $window.FindName("BtnAnalyze")
$TxtSysInfo = $window.FindName("TxtSysInfo")

# NETSWIFT ELEMANLARI
$BtnSpeedTest = $window.FindName("BtnSpeedTest")
$BtnDnsCloudflare = $window.FindName("BtnDnsCloudflare")
$BtnDnsGoogle = $window.FindName("BtnDnsGoogle")
$BtnDnsDefault = $window.FindName("BtnDnsDefault")
$BtnNetReset = $window.FindName("BtnNetReset")
$TxtNetLog = $window.FindName("TxtNetLog")

$global:winSwiftTweaks = @()
$global:devSwiftApps = @()

# ==============================================================================
# 🚀 1. WINSWIFT & DEVSWIFT DINAMIK CHECKBOX OLUSTURUCULAR
# ==============================================================================
try {
    $jsonUrl = "https://raw.githubusercontent.com/cyberQbit/WinSwift/main/tweaks.json?t=$((Get-Date).Ticks)"
    $jsonResponse = (New-Object System.Net.WebClient).DownloadString($jsonUrl) | ConvertFrom-Json
    foreach ($cat in $jsonResponse.psobject.properties.name) {
        $header = New-Object System.Windows.Controls.TextBlock; $header.Text = $cat.ToUpper(); $header.Foreground = "#00CED1"; $header.FontSize = 16; $header.FontWeight = "Bold"; $header.Margin = "0,15,0,10"
        $PanelWinSwift.Children.Add($header) | Out-Null
        foreach ($tweak in $jsonResponse."$cat") {
            $cb = New-Object System.Windows.Controls.CheckBox; $cb.Content = $tweak.Name; $cb.Foreground = "White"; $cb.FontSize = 14; $cb.Margin = "10,0,0,8"
            $global:winSwiftTweaks += [PSCustomObject]@{ CheckBox = $cb; Script = $tweak.Script; Name = $tweak.Name }
            $PanelWinSwift.Children.Add($cb) | Out-Null
        }
    }
} catch {}

try {
    $jsonUrlApps = "https://raw.githubusercontent.com/cyberQbit/DevSwift/main/apps.json?t=$((Get-Date).Ticks)"
    $jsonResponseApps = (New-Object System.Net.WebClient).DownloadString($jsonUrlApps) | ConvertFrom-Json
    foreach ($cat in $jsonResponseApps.psobject.properties.name) {
        $header = New-Object System.Windows.Controls.TextBlock; $header.Text = $cat.ToUpper(); $header.Foreground = "#00CED1"; $header.FontSize = 16; $header.FontWeight = "Bold"; $header.Margin = "0,15,0,10"
        $PanelDevSwift.Children.Add($header) | Out-Null
        foreach ($app in $jsonResponseApps."$cat") {
            $cb = New-Object System.Windows.Controls.CheckBox; $cb.Content = $app.Name; $cb.Foreground = "White"; $cb.FontSize = 14; $cb.Margin = "10,0,0,8"
            $global:devSwiftApps += [PSCustomObject]@{ CheckBox = $cb; Id = $app.Id; Name = $app.Name }
            $PanelDevSwift.Children.Add($cb) | Out-Null
        }
    }
} catch {}

# ==============================================================================
# 🚀 2. EVENTLER (BUTON TIKLAMALARI)
# ==============================================================================

# WINSWIFT
$BtnApplyTweaks.Add_Click({
    $BtnApplyTweaks.Content = "AYARLAR SISTEME ISLENIYOR..."; $BtnApplyTweaks.IsEnabled = $false
    $window.Dispatcher.Invoke([Action]{}, [Windows.Threading.DispatcherPriority]::Render)
    $c = 0; foreach ($item in $global:winSwiftTweaks) { if ($item.CheckBox.IsChecked) { try { Invoke-Expression $item.Script; $c++ } catch {} } }
    [System.Windows.MessageBox]::Show("$c adet ayar basariyla sisteme islendi!", "SwiftHub", 0, 64); $BtnApplyTweaks.Content = "Secili Ayarlari Sisteme Enjekte Et"; $BtnApplyTweaks.IsEnabled = $true
})

# DEVSWIFT
$BtnInstallApps.Add_Click({
    $BtnInstallApps.Content = "PROGRAMLAR ARKA PLANDA KURULUYOR..."; $BtnInstallApps.IsEnabled = $false
    $window.Dispatcher.Invoke([Action]{}, [Windows.Threading.DispatcherPriority]::Render)
    $c = 0; foreach ($item in $global:devSwiftApps) { if ($item.CheckBox.IsChecked) { try { Start-Process -FilePath "winget" -ArgumentList "install --id $($item.Id) --accept-source-agreements --accept-package-agreements --silent" -Wait -NoNewWindow; $c++ } catch {} } }
    [System.Windows.MessageBox]::Show("$c adet program basariyla kuruldu!", "SwiftHub", 0, 64); $BtnInstallApps.Content = "Secili Programlari Kur"; $BtnInstallApps.IsEnabled = $true
})

# NETSWIFT - HIZ TESTI (OOKLA SPEEDTEST CLI - ZERO FOOTPRINT)
$BtnSpeedTest.Add_Click({
    $TxtNetLog.Text = "[*] Ookla Speedtest Motoru atesleniyor... Baglanti analiz ediliyor.`n(Bu islem sirasinda gercek ag testi yapildigi icin arayuz 20-30 saniye kilitlenecektir. Lutfen bekleyin...)"
    $window.Dispatcher.Invoke([Action]{}, [Windows.Threading.DispatcherPriority]::Render)
    
    try {
        # Sifir Iz Kurali: Her seyi Temp (Gecici) hafizada yapiyoruz
        $tempDir = "$env:TEMP\NetSwift_Ookla"
        if (Test-Path $tempDir) { Remove-Item $tempDir -Recurse -Force }
        New-Item -Path $tempDir -ItemType Directory | Out-Null
        
        # Ookla CLI Indir ve Cikart
        $zipPath = "$tempDir\speedtest.zip"
        $wc = New-Object System.Net.WebClient
        $wc.DownloadFile("https://install.speedtest.net/app/cli/ookla-speedtest-1.2.0-win64.zip", $zipPath)
        Expand-Archive -Path $zipPath -DestinationPath $tempDir -Force
        
        $exePath = "$tempDir\speedtest.exe"
        
        # Sihirli Dokunus: Ekrana yazi basmasini engelleyip, veriyi JSON formatinda arkadan cekiyoruz!
        $speedOutput = & $exePath --accept-license --accept-gdpr --format=json | ConvertFrom-Json
        
        # Ookla veriyi saniyedeki byte (Bytes/s) olarak verir. Biz onu Mbps'ye (Megabit) ceviriyoruz
        $downMbps = [math]::Round(($speedOutput.download.bandwidth * 8 / 1000000), 2)
        $upMbps = [math]::Round(($speedOutput.upload.bandwidth * 8 / 1000000), 2)
        $ping = [math]::Round($speedOutput.ping.latency, 0)
        $isp = $speedOutput.isp
        $serverName = $speedOutput.server.name
        
        $TxtNetLog.Text = "[+] KUSURSUZ AĞ ANALİZİ (OOKLA MOTORU)!`n`n🌐 Saglayici: $isp`n🖥️ Sunucu: $serverName`n⚡ Ping: $ping ms`n⬇️ Indirme (Download): $downMbps Mbps`n⬆️ Yukleme (Upload): $upMbps Mbps"
        
    } catch { 
        $TxtNetLog.Text = "[X] Hiz testi basarisiz oldu: $($_.Exception.Message)" 
    } finally { 
        # Islem bittiginde veya coktugunde izleri tamamen sil (Zero-Footprint)
        if (Test-Path $tempDir) { Remove-Item $tempDir -Recurse -Force -ErrorAction SilentlyContinue } 
    }
})

$BtnDnsCloudflare.Add_Click({
    $net = Get-NetAdapter | Where-Object Status -eq 'Up' | Select-Object -First 1
    if ($net) { Set-DnsClientServerAddress -InterfaceIndex $net.ifIndex -ServerAddresses ("1.1.1.1","1.0.0.1"); $TxtNetLog.Text = "[+] DNS adresi Cloudflare (1.1.1.1) olarak degistirildi." } else { $TxtNetLog.Text = "[X] Aktif bir ag bagdastiricisi bulunamadi!" }
})

$BtnDnsGoogle.Add_Click({
    $net = Get-NetAdapter | Where-Object Status -eq 'Up' | Select-Object -First 1
    if ($net) { Set-DnsClientServerAddress -InterfaceIndex $net.ifIndex -ServerAddresses ("8.8.8.8","8.8.4.4"); $TxtNetLog.Text = "[+] DNS adresi Google (8.8.8.8) olarak degistirildi." } else { $TxtNetLog.Text = "[X] Aktif bir ag bagdastiricisi bulunamadi!" }
})

$BtnDnsDefault.Add_Click({
    $net = Get-NetAdapter | Where-Object Status -eq 'Up' | Select-Object -First 1
    if ($net) { Set-DnsClientServerAddress -InterfaceIndex $net.ifIndex -ResetServerAddresses; $TxtNetLog.Text = "[+] DNS ayarlari varsayilana (Otomatik/DHCP) donduruldu." } else { $TxtNetLog.Text = "[X] Aktif bir ag bagdastiricisi bulunamadi!" }
})

$BtnNetReset.Add_Click({
    $TxtNetLog.Text = "[*] Ag onbellegi temizleniyor ve TCP/IP soketleri onariliyor..."
    $window.Dispatcher.Invoke([Action]{}, [Windows.Threading.DispatcherPriority]::Render)
    ipconfig /flushdns | Out-Null; netsh winsock reset | Out-Null; netsh int ip reset | Out-Null
    $TxtNetLog.Text = "[+] Ag protokolleri sifirlandi! (Degisikliklerin tam islemesi icin bilgisayari yeniden baslatmaniz onerilir.)"
})

# SYSINFO
$BtnAnalyze.Add_Click({
    $TxtSysInfo.Text = "Donanim sensorleri ve WMI verileri okunuyor... Lutfen bekleyin."
    $window.Dispatcher.Invoke([Action]{}, [Windows.Threading.DispatcherPriority]::Render)
    $info = "[ISLETIM SISTEMI]`nModel   : $((Get-CimInstance Win32_OperatingSystem).Caption)`n`n[ISLEMCI]`nModel   : $((Get-CimInstance Win32_Processor)[0].Name)`n`n[RAM]`nKapasite: $([math]::Round(((Get-CimInstance Win32_PhysicalMemory | Measure-Object Capacity -Sum).Sum / 1GB), 2)) GB`n`n"
    $info += "[GPU]`n"
    foreach ($g in Get-CimInstance Win32_VideoController) { $info += "Model   : $($g.Name) ($([math]::Round($g.AdapterRAM / 1GB, 0)) GB VRAM)`n" }
    $info += "`n[DEPOLAMA]`n"
    foreach ($pd in Get-PhysicalDisk) { $info += "Aygit   : $($pd.FriendlyName) ($([math]::Round($pd.Size/1GB,0)) GB) - $($pd.HealthStatus)`n" }
    $TxtSysInfo.Text = $info
})

$window.ShowDialog() | Out-Null