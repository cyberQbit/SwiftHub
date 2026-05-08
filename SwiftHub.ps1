# ==============================================================================
# 🌌 SWIFTHUB CORE v4.2 - DEVSWIFT & WINSWIFT GUI INTEGRATION
# ==============================================================================
$ErrorActionPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# 1. GEREKLI ARAYUZ (WPF) KUTUPHANELERI
Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase

# 2. XAML TASARIMI (DevSwift Sekmesi Guncellendi)
[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="SwiftHub Core - Advanced System Gateway" Height="650" Width="1000"
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
    </Window.Resources>
    
    <Grid Margin="15">
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
        </Grid.RowDefinitions>
        
        <StackPanel Grid.Row="0" Margin="5,0,0,20" Orientation="Horizontal">
            <TextBlock Text="🌌 SWIFTHUB" FontSize="32" FontWeight="Black" Foreground="#00CED1" VerticalAlignment="Center"/>
            <TextBlock Text=" ULTIMATE EDITION" FontSize="20" FontWeight="Light" Foreground="#7A7A7A" VerticalAlignment="Bottom" Margin="10,0,0,4"/>
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
                    <TextBlock Text="Ag ve Siber Guvenlik Motoru Yakinda Buraya Baglanacak..." Foreground="#505050" FontSize="24" HorizontalAlignment="Center" VerticalAlignment="Center" FontWeight="Light"/>
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

$global:winSwiftTweaks = @()
$global:devSwiftApps = @()

# ==============================================================================
# 🚀 1. WINSWIFT DINAMIK CHECKBOX OLUSTURUCU
# ==============================================================================
try {
    $jsonUrl = "https://raw.githubusercontent.com/cyberQbit/WinSwift/main/tweaks.json?t=$((Get-Date).Ticks)"
    $jsonResponse = (New-Object System.Net.WebClient).DownloadString($jsonUrl) | ConvertFrom-Json
    foreach ($cat in $jsonResponse.psobject.properties.name) {
        $header = New-Object System.Windows.Controls.TextBlock
        $header.Text = $cat.ToUpper()
        $header.Foreground = "#00CED1"
        $header.FontSize = 16
        $header.FontWeight = "Bold"
        $header.Margin = "0,15,0,10"
        $PanelWinSwift.Children.Add($header) | Out-Null
        
        foreach ($tweak in $jsonResponse."$cat") {
            $cb = New-Object System.Windows.Controls.CheckBox
            $cb.Content = $tweak.Name
            $cb.Foreground = "White"
            $cb.FontSize = 14
            $cb.Margin = "10,0,0,8"
            $global:winSwiftTweaks += [PSCustomObject]@{ CheckBox = $cb; Script = $tweak.Script; Name = $tweak.Name }
            $PanelWinSwift.Children.Add($cb) | Out-Null
        }
    }
} catch {
    $err = New-Object System.Windows.Controls.TextBlock
    $err.Text = "[X] Bulut baglantisi basarisiz veya tweaks.json hatali!"
    $err.Foreground = "Red"
    $PanelWinSwift.Children.Add($err) | Out-Null
}

# ==============================================================================
# 🚀 2. DEVSWIFT DINAMIK CHECKBOX OLUSTURUCU (YENI)
# ==============================================================================
try {
    $jsonUrlApps = "https://raw.githubusercontent.com/cyberQbit/DevSwift/main/apps.json?t=$((Get-Date).Ticks)"
    $jsonResponseApps = (New-Object System.Net.WebClient).DownloadString($jsonUrlApps) | ConvertFrom-Json
    foreach ($cat in $jsonResponseApps.psobject.properties.name) {
        $header = New-Object System.Windows.Controls.TextBlock
        $header.Text = $cat.ToUpper()
        $header.Foreground = "#00CED1"
        $header.FontSize = 16
        $header.FontWeight = "Bold"
        $header.Margin = "0,15,0,10"
        $PanelDevSwift.Children.Add($header) | Out-Null
        
        foreach ($app in $jsonResponseApps."$cat") {
            $cb = New-Object System.Windows.Controls.CheckBox
            $cb.Content = $app.Name
            $cb.Foreground = "White"
            $cb.FontSize = 14
            $cb.Margin = "10,0,0,8"
            $global:devSwiftApps += [PSCustomObject]@{ CheckBox = $cb; Id = $app.Id; Name = $app.Name }
            $PanelDevSwift.Children.Add($cb) | Out-Null
        }
    }
} catch {
    $err = New-Object System.Windows.Controls.TextBlock
    $err.Text = "[X] Bulut baglantisi basarisiz veya apps.json hatali!"
    $err.Foreground = "Red"
    $PanelDevSwift.Children.Add($err) | Out-Null
}

# ==============================================================================
# 🚀 3. EVENTLER (BUTON TIKLAMALARI)
# ==============================================================================

# WINSWIFT UYGULA
$BtnApplyTweaks.Add_Click({
    $BtnApplyTweaks.Content = "AYARLAR SISTEME ISLENIYOR... LUTFEN BEKLEYIN"
    $BtnApplyTweaks.IsEnabled = $false
    $window.Dispatcher.Invoke([Action]{}, [Windows.Threading.DispatcherPriority]::Render)
    
    $appliedCount = 0
    foreach ($item in $global:winSwiftTweaks) {
        if ($item.CheckBox.IsChecked) {
            try { Invoke-Expression $item.Script; $appliedCount++ } catch {}
        }
    }
    [System.Windows.MessageBox]::Show("$appliedCount adet ayar basariyla sisteme islendi!", "SwiftHub Operasyonu Tamamlandi", 0, 64)
    $BtnApplyTweaks.Content = "Secili Ayarlari Sisteme Enjekte Et"
    $BtnApplyTweaks.IsEnabled = $true
})

# DEVSWIFT KUR
$BtnInstallApps.Add_Click({
    $BtnInstallApps.Content = "PROGRAMLAR ARKA PLANDA KURULUYOR... LUTFEN BEKLEYIN"
    $BtnInstallApps.IsEnabled = $false
    $window.Dispatcher.Invoke([Action]{}, [Windows.Threading.DispatcherPriority]::Render)
    
    $installedCount = 0
    foreach ($item in $global:devSwiftApps) {
        if ($item.CheckBox.IsChecked) {
            try { 
                Start-Process -FilePath "winget" -ArgumentList "install --id $($item.Id) --accept-source-agreements --accept-package-agreements --silent" -Wait -NoNewWindow
                $installedCount++ 
            } catch {}
        }
    }
    [System.Windows.MessageBox]::Show("$installedCount adet program basariyla kuruldu!", "SwiftHub Operasyonu Tamamlandi", 0, 64)
    $BtnInstallApps.Content = "Secili Programlari Kur"
    $BtnInstallApps.IsEnabled = $true
})

# SYSINFO ANALIZ
$BtnAnalyze.Add_Click({
    $TxtSysInfo.Text = "Donanim sensorleri ve WMI verileri okunuyor... Lutfen bekleyin."
    $window.Dispatcher.Invoke([Action]{}, [Windows.Threading.DispatcherPriority]::Render)
    $info = ""
    $os = Get-CimInstance Win32_OperatingSystem -ErrorAction SilentlyContinue
    $info += "[ISLETIM SISTEMI]`nModel   : $($os.Caption) $($os.OSArchitecture)`nSurum   : Version $($os.Version) (Build $($os.BuildNumber))`n`n"
    $cpu = Get-CimInstance Win32_Processor -ErrorAction SilentlyContinue
    $cpuInfo = if ($cpu.Count -gt 1) { $cpu[0] } else { $cpu }
    $info += "[ISLEMCI (CPU)]`nModel   : $($cpuInfo.Name)`nCekirdek: $($cpuInfo.NumberOfCores) Core / $($cpuInfo.NumberOfLogicalProcessors) Thread`n`n"
    $ram = Get-CimInstance Win32_PhysicalMemory -ErrorAction SilentlyContinue
    $totalRam = [math]::Round(($ram | Measure-Object Capacity -Sum).Sum / 1GB, 2)
    $info += "[BELLEK (RAM)]`nKapasite: $totalRam GB`nHiz     : $(($ram | Select-Object -First 1).Speed) MHz`n`n"
    $gpus = Get-CimInstance Win32_VideoController -ErrorAction SilentlyContinue
    $info += "[GRAFIK KARTI (GPU)]`n"
    foreach ($g in $gpus) {
        $vramGB = [math]::Round($g.AdapterRAM / 1GB, 0)
        $info += "Model   : $($g.Name) ($vramGB GB VRAM)`n"
    }
    $info += "`n[DEPOLAMA TELEMETRISI]`n"
    $pdisks = Get-PhysicalDisk -ErrorAction SilentlyContinue
    if ($pdisks) {
        foreach ($pd in $pdisks) {
            $info += "Aygit   : $($pd.FriendlyName) ($([math]::Round($pd.Size/1GB,0)) GB)`nDurum   : $($pd.HealthStatus)`n"
            $rel = $pd | Get-StorageReliabilityCounter -ErrorAction SilentlyContinue
            if ($rel -and $rel.Temperature) { $info += "Sicaklik: $($rel.Temperature) Derece`n" }
            $info += "`n"
        }
    }
    $TxtSysInfo.Text = $info
})

$window.ShowDialog() | Out-Null