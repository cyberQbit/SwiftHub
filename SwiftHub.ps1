# ==============================================================================
# 🌌 SWIFTHUB CORE v6.1 - TITAN EDITION (APPS & TWEAKS INTEGRATION)
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
        "BtnInstall" = "Secili Uygulamalari Kur"; "BtnApply" = "Secili Ayarlari Enjekte Et"
    };
    "EN" = @{
        "AppTitle" = "SWIFTHUB TITAN CORE"; "AppSub" = "ADVANCED SYSTEM MANAGEMENT";
        "MenuDash" = "🏠 Dashboard"; "MenuApps" = "📦 Applications";
        "MenuTweaks" = "🛠️ System Tweaks"; "MenuFeatures" = "⚙️ Windows Features";
        "MenuNet" = "🌐 Network & Security"; "MenuFixes" = "🩹 System Fixes";
        "BtnLang" = "🌐 TR"; "StatusWait" = "System ready. Select an operation...";
        "DashWelcome" = "Welcome to SwiftHub!"; "DashSub" = "Use the sidebar to optimize your system, install apps, or fix issues.";
        "BtnInstall" = "Install Selected Apps"; "BtnApply" = "Apply Selected Tweaks"
    }
}

# --- 2. GEREKLI KUTUPHANELER ---
Add-Type -AssemblyName PresentationFramework; Add-Type -AssemblyName PresentationCore; Add-Type -AssemblyName WindowsBase

# --- 3. XAML TASARIMI ---
[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" Title="SwiftHub Titan v6.1" Height="760" Width="1150" Background="#0B0C10" Foreground="White" WindowStartupLocation="CenterScreen" FontFamily="Segoe UI" WindowStyle="None" AllowsTransparency="True" ResizeMode="NoResize">
    <Window.Resources>
        <Style TargetType="Button" x:Key="SidebarBtn">
            <Setter Property="Background" Value="Transparent"/><Setter Property="Foreground" Value="#8A8D93"/><Setter Property="FontSize" Value="15"/><Setter Property="FontWeight" Value="SemiBold"/><Setter Property="HorizontalContentAlignment" Value="Left"/><Setter Property="Padding" Value="20,0,0,0"/><Setter Property="Height" Value="50"/><Setter Property="BorderThickness" Value="0"/><Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template"><Setter.Value><ControlTemplate TargetType="Button"><Border Name="border" Background="{TemplateBinding Background}" CornerRadius="8"><ContentPresenter HorizontalAlignment="{TemplateBinding HorizontalContentAlignment}" VerticalAlignment="Center" Margin="{TemplateBinding Padding}"/></Border><ControlTemplate.Triggers><Trigger Property="IsMouseOver" Value="True"><Setter TargetName="border" Property="Background" Value="#1F222B"/><Setter Property="Foreground" Value="White"/></Trigger></ControlTemplate.Triggers></ControlTemplate></Setter.Value></Setter>
        </Style>
        <Style TargetType="CheckBox">
            <Setter Property="Foreground" Value="White"/><Setter Property="FontSize" Value="13"/><Setter Property="Margin" Value="0,5,15,5"/><Setter Property="Width" Value="200"/>
        </Style>
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
                        <TextBlock Name="TxtDashSub" Text="Sisteminizi optimize etmek, program kurmak veya sorunlari cozmek icin soldaki menuyu kullanin." FontSize="16" Foreground="#8A8D93" TextAlignment="Center"/>
                    </StackPanel>
                </Grid>

                <Grid Name="PageApps" Visibility="Hidden">
                    <Grid.RowDefinitions><RowDefinition Height="*"/><RowDefinition Height="Auto"/></Grid.RowDefinitions>
                    <Border Grid.Row="0" Background="#13151A" CornerRadius="8" Padding="20">
                        <ScrollViewer VerticalScrollBarVisibility="Auto">
                            <StackPanel Name="PanelAppsContainer"/>
                        </ScrollViewer>
                    </Border>
                    <Button Name="BtnInstallApps" Content="Secili Uygulamalari Kur" Background="#00CED1" Foreground="#0B0C10" FontWeight="Bold" FontSize="15" Height="45" BorderThickness="0" Cursor="Hand" Grid.Row="1" Margin="0,15,0,0"><Button.Resources><Style TargetType="Border"><Setter Property="CornerRadius" Value="6"/></Style></Button.Resources></Button>
                </Grid>

                <Grid Name="PageTweaks" Visibility="Hidden">
                    <Grid.RowDefinitions><RowDefinition Height="*"/><RowDefinition Height="Auto"/></Grid.RowDefinitions>
                    <Border Grid.Row="0" Background="#13151A" CornerRadius="8" Padding="20">
                        <ScrollViewer VerticalScrollBarVisibility="Auto">
                            <StackPanel Name="PanelTweaksContainer"/>
                        </ScrollViewer>
                    </Border>
                    <Button Name="BtnApplyTweaks" Content="Secili Ayarlari Enjekte Et" Background="#00CED1" Foreground="#0B0C10" FontWeight="Bold" FontSize="15" Height="45" BorderThickness="0" Cursor="Hand" Grid.Row="1" Margin="0,15,0,0"><Button.Resources><Style TargetType="Border"><Setter Property="CornerRadius" Value="6"/></Style></Button.Resources></Button>
                </Grid>

                <Grid Name="PageFeatures" Visibility="Hidden"><TextBlock Text="Windows Ozellikleri Cok Yakinda..." Foreground="#666" FontSize="24" HorizontalAlignment="Center" VerticalAlignment="Center"/></Grid>
                <Grid Name="PageNet" Visibility="Hidden"><TextBlock Text="Ag &amp; Siber Guvenlik Merkezi Cok Yakinda..." Foreground="#666" FontSize="24" HorizontalAlignment="Center" VerticalAlignment="Center"/></Grid>
                <Grid Name="PageFixes" Visibility="Hidden"><TextBlock Text="Sistem Onarimi &amp; Kurtarma Cok Yakinda..." Foreground="#666" FontSize="24" HorizontalAlignment="Center" VerticalAlignment="Center"/></Grid>

                <Border Grid.Row="1" Background="#13151A" CornerRadius="6" Padding="15,10" Margin="0,20,0,0">
                    <TextBlock Name="TxtStatus" Text="Sistem hazir. Bir islem secin..." Foreground="#00FF66" FontFamily="Consolas" FontSize="13"/>
                </Border>
            </Grid>
        </Grid>
    </Border>
</Window>
"@

$reader = (New-Object System.Xml.XmlNodeReader $xaml)
$window = [Windows.Markup.XamlReader]::Load($reader)

# --- ARAYUZ ELEMANLARI ---
$NavDash = $window.FindName("NavDash"); $NavApps = $window.FindName("NavApps"); $NavTweaks = $window.FindName("NavTweaks")
$NavFeatures = $window.FindName("NavFeatures"); $NavNet = $window.FindName("NavNet"); $NavFixes = $window.FindName("NavFixes")
$PageDash = $window.FindName("PageDash"); $PageApps = $window.FindName("PageApps"); $PageTweaks = $window.FindName("PageTweaks")
$PageFeatures = $window.FindName("PageFeatures"); $PageNet = $window.FindName("PageNet"); $PageFixes = $window.FindName("PageFixes")
$BtnExit = $window.FindName("BtnExit"); $BtnLangToggle = $window.FindName("BtnLangToggle")
$TxtTitle = $window.FindName("TxtTitle"); $TxtSub = $window.FindName("TxtSub")
$TxtDashWelcome = $window.FindName("TxtDashWelcome"); $TxtDashSub = $window.FindName("TxtDashSub")
$TxtStatus = $window.FindName("TxtStatus")

$PanelAppsContainer = $window.FindName("PanelAppsContainer"); $BtnInstallApps = $window.FindName("BtnInstallApps")
$PanelTweaksContainer = $window.FindName("PanelTweaksContainer"); $BtnApplyTweaks = $window.FindName("BtnApplyTweaks")

# --- KURESEL DEGISKENLER (Bellek) ---
$global:AppHeaders = @(); $global:AppItems = @()
$global:TweakHeaders = @(); $global:TweakItems = @()

# ==============================================================================
# 🚀 4. DINAMIK BULUT MOTORU (JSON ÇEKME VE ÇİZME)
# ==============================================================================

# -- A. UYGULAMALAR (APPS) --
try {
    $jsonUrlApps = "https://raw.githubusercontent.com/cyberQbit/DevSwift/main/apps.json?t=$((Get-Date).Ticks)"
    $jsonResponseApps = (New-Object System.Net.WebClient).DownloadString($jsonUrlApps) | ConvertFrom-Json
    foreach ($cat in $jsonResponseApps.psobject.properties.name) {
        $header = New-Object System.Windows.Controls.TextBlock
        $header.Foreground = "#00CED1"; $header.FontSize = 16; $header.FontWeight = "Bold"; $header.Margin = "0,15,0,10"
        $global:AppHeaders += [PSCustomObject]@{ UI = $header; TR = $jsonResponseApps."$cat".TR; EN = $jsonResponseApps."$cat".EN }
        $PanelAppsContainer.Children.Add($header) | Out-Null
        
        $wrapPanel = New-Object System.Windows.Controls.WrapPanel
        $wrapPanel.Margin = "0,0,0,10"
        foreach ($app in $jsonResponseApps."$cat".Items) {
            $cb = New-Object System.Windows.Controls.CheckBox
            $cb.Content = $app.Name
            $global:AppItems += [PSCustomObject]@{ CheckBox = $cb; Id = $app.Id; Name = $app.Name }
            $wrapPanel.Children.Add($cb) | Out-Null
        }
        $PanelAppsContainer.Children.Add($wrapPanel) | Out-Null
    }
} catch { $TxtStatus.Text = "[X] Apps veritabani cekilemedi!" }

# -- B. INCE AYARLAR (TWEAKS) --
try {
    $jsonUrlTweaks = "https://raw.githubusercontent.com/cyberQbit/WinSwift/main/tweaks.json?t=$((Get-Date).Ticks)"
    $jsonResponseTweaks = (New-Object System.Net.WebClient).DownloadString($jsonUrlTweaks) | ConvertFrom-Json
    foreach ($cat in $jsonResponseTweaks.psobject.properties.name) {
        $header = New-Object System.Windows.Controls.TextBlock
        $header.Foreground = "#FF3366"; $header.FontSize = 16; $header.FontWeight = "Bold"; $header.Margin = "0,15,0,10"
        $global:TweakHeaders += [PSCustomObject]@{ UI = $header; TR = $jsonResponseTweaks."$cat".TR; EN = $jsonResponseTweaks."$cat".EN }
        $PanelTweaksContainer.Children.Add($header) | Out-Null
        
        $wrapPanel = New-Object System.Windows.Controls.WrapPanel
        $wrapPanel.Margin = "0,0,0,10"
        foreach ($tweak in $jsonResponseTweaks."$cat".Items) {
            $cb = New-Object System.Windows.Controls.CheckBox
            $cb.Content = $tweak.Name; $cb.Width = 350 # Ayar isimleri uzun oldugu icin genislik arttirildi
            $global:TweakItems += [PSCustomObject]@{ CheckBox = $cb; Script = $tweak.Script; Name = $tweak.Name }
            $wrapPanel.Children.Add($cb) | Out-Null
        }
        $PanelTweaksContainer.Children.Add($wrapPanel) | Out-Null
    }
} catch { $TxtStatus.Text = "[X] Tweaks veritabani cekilemedi!" }


# --- 5. FONKSIYONLAR ---
function Update-Language {
    $dict = $global:i18n[$global:CurrentLang]
    $TxtTitle.Text = $dict["AppTitle"]; $TxtSub.Text = $dict["AppSub"]
    $NavDash.Content = $dict["MenuDash"]; $NavApps.Content = $dict["MenuApps"]
    $NavTweaks.Content = $dict["MenuTweaks"]; $NavFeatures.Content = $dict["MenuFeatures"]
    $NavNet.Content = $dict["MenuNet"]; $NavFixes.Content = $dict["MenuFixes"]
    $BtnLangToggle.Content = $dict["BtnLang"]; $TxtStatus.Text = $dict["StatusWait"]
    $TxtDashWelcome.Text = $dict["DashWelcome"]; $TxtDashSub.Text = $dict["DashSub"]
    $BtnInstallApps.Content = $dict["BtnInstall"]; $BtnApplyTweaks.Content = $dict["BtnApply"]
    
    # Kategori Basliklarini Dinamik Cevir (Sifir Iz, Yeniden Cizmeden!)
    foreach ($h in $global:AppHeaders) { $h.UI.Text = $h."$($global:CurrentLang)" }
    foreach ($h in $global:TweakHeaders) { $h.UI.Text = $h."$($global:CurrentLang)" }
}

function Reset-NavButtons {
    $NavDash.Background = "Transparent"; $NavDash.Foreground = "#8A8D93"
    $NavApps.Background = "Transparent"; $NavApps.Foreground = "#8A8D93"
    $NavTweaks.Background = "Transparent"; $NavTweaks.Foreground = "#8A8D93"
    $NavFeatures.Background = "Transparent"; $NavFeatures.Foreground = "#8A8D93"
    $NavNet.Background = "Transparent"; $NavNet.Foreground = "#8A8D93"
    $NavFixes.Background = "Transparent"; $NavFixes.Foreground = "#8A8D93"
    $PageDash.Visibility = "Hidden"; $PageApps.Visibility = "Hidden"; $PageTweaks.Visibility = "Hidden"
    $PageFeatures.Visibility = "Hidden"; $PageNet.Visibility = "Hidden"; $PageFixes.Visibility = "Hidden"
}

# --- 6. EVENTLER (TIKLAMALAR) ---
$BtnLangToggle.Add_Click({
    if ($global:CurrentLang -eq "TR") { $global:CurrentLang = "EN" } else { $global:CurrentLang = "TR" }
    Update-Language
})

$BtnExit.Add_Click({ $window.Close() })

$NavDash.Add_Click({ Reset-NavButtons; $NavDash.Background = "#1F222B"; $NavDash.Foreground = "White"; $PageDash.Visibility = "Visible" })
$NavApps.Add_Click({ Reset-NavButtons; $NavApps.Background = "#1F222B"; $NavApps.Foreground = "White"; $PageApps.Visibility = "Visible" })
$NavTweaks.Add_Click({ Reset-NavButtons; $NavTweaks.Background = "#1F222B"; $NavTweaks.Foreground = "White"; $PageTweaks.Visibility = "Visible" })
$NavFeatures.Add_Click({ Reset-NavButtons; $NavFeatures.Background = "#1F222B"; $NavFeatures.Foreground = "White"; $PageFeatures.Visibility = "Visible" })
$NavNet.Add_Click({ Reset-NavButtons; $NavNet.Background = "#1F222B"; $NavNet.Foreground = "White"; $PageNet.Visibility = "Visible" })
$NavFixes.Add_Click({ Reset-NavButtons; $NavFixes.Background = "#1F222B"; $NavFixes.Foreground = "White"; $PageFixes.Visibility = "Visible" })

# KURULUM MOTORLARI (Arka Plan Islevleri)
$BtnInstallApps.Add_Click({
    $TxtStatus.Text = "Programlar arka planda kuruluyor (Winget)... Lutfen bekleyin."
    $BtnInstallApps.IsEnabled = $false; $window.Dispatcher.Invoke([Action]{}, [Windows.Threading.DispatcherPriority]::Render)
    $c = 0; foreach ($item in $global:AppItems) { if ($item.CheckBox.IsChecked) { try { Start-Process -FilePath "winget" -ArgumentList "install --id $($item.Id) --accept-source-agreements --accept-package-agreements --silent" -Wait -NoNewWindow; $c++ } catch {} } }
    $TxtStatus.Text = "[+] $c adet program basariyla kuruldu!"; $BtnInstallApps.IsEnabled = $true
})

$BtnApplyTweaks.Add_Click({
    $TxtStatus.Text = "Ayarlar sisteme enjekte ediliyor (Registry & PowerShell)..."
    $BtnApplyTweaks.IsEnabled = $false; $window.Dispatcher.Invoke([Action]{}, [Windows.Threading.DispatcherPriority]::Render)
    $c = 0; foreach ($item in $global:TweakItems) { if ($item.CheckBox.IsChecked) { try { Invoke-Expression $item.Script; $c++ } catch {} } }
    $TxtStatus.Text = "[+] $c adet ayar basariyla enjekte edildi!"; $BtnApplyTweaks.IsEnabled = $true
})

# Baslangic Dili Ayarla
Update-Language
$window.ShowDialog() | Out-Null