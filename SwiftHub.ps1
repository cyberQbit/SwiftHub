# ==============================================================================
# 🌌 SWIFTHUB CORE v6.0 - TITAN EDITION (BILINGUAL & MODERN SIDEBAR UI)
# ==============================================================================
$ErrorActionPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# 1. DIL MOTORU (BILINGUAL DICTIONARY)
$global:CurrentLang = "TR"
$global:i18n = @{
    "TR" = @{
        "AppTitle" = "SWIFTHUB TITAN CORE"; "AppSub" = "GELISMIS SISTEM YONETIMI";
        "MenuDash" = "🏠 Kontrol Paneli"; "MenuApps" = "📦 Uygulamalar";
        "MenuTweaks" = "🛠️ Ince Ayarlar"; "MenuFeatures" = "⚙️ Windows Ozellikleri";
        "MenuNet" = "🌐 Ag ve Guvenlik"; "MenuFixes" = "🩹 Sistem Onarimi";
        "BtnLang" = "🌐 EN"; "StatusWait" = "Sistem hazir. Bir islem secin...";
        "DashWelcome" = "SwiftHub'a Hos Geldiniz!"; "DashSub" = "Sisteminizi optimize etmek, program kurmak veya sorunlari cozmek icin soldaki menuyu kullanin.";
        "ComingSoon" = "Bu devasa modul yakinda buluttan (JSON) cekilecek..."
    };
    "EN" = @{
        "AppTitle" = "SWIFTHUB TITAN CORE"; "AppSub" = "ADVANCED SYSTEM MANAGEMENT";
        "MenuDash" = "🏠 Dashboard"; "MenuApps" = "📦 Applications";
        "MenuTweaks" = "🛠️ System Tweaks"; "MenuFeatures" = "⚙️ Windows Features";
        "MenuNet" = "🌐 Network & Security"; "MenuFixes" = "🩹 System Fixes";
        "BtnLang" = "🌐 TR"; "StatusWait" = "System ready. Select an operation...";
        "DashWelcome" = "Welcome to SwiftHub!"; "DashSub" = "Use the sidebar to optimize your system, install apps, or fix issues.";
        "ComingSoon" = "This massive module will be pulled from cloud (JSON) soon..."
    }
}

# 2. GEREKLI ARAYUZ (WPF) KUTUPHANELERI
Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase

# 3. MODERN SIDEBAR XAML TASARIMI
[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="SwiftHub Titan v6.0" Height="720" Width="1100"
        Background="#0B0C10" Foreground="White" WindowStartupLocation="CenterScreen"
        FontFamily="Segoe UI" WindowStyle="None" AllowsTransparency="True" ResizeMode="NoResize">
    
    <Window.Resources>
        <Style TargetType="Button" x:Key="SidebarBtn">
            <Setter Property="Background" Value="Transparent"/>
            <Setter Property="Foreground" Value="#8A8D93"/>
            <Setter Property="FontSize" Value="15"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
            <Setter Property="HorizontalContentAlignment" Value="Left"/>
            <Setter Property="Padding" Value="20,0,0,0"/>
            <Setter Property="Height" Value="50"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border Name="border" Background="{TemplateBinding Background}" CornerRadius="8">
                            <ContentPresenter HorizontalAlignment="{TemplateBinding HorizontalContentAlignment}" VerticalAlignment="Center" Margin="{TemplateBinding Padding}"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="border" Property="Background" Value="#1F222B"/>
                                <Setter Property="Foreground" Value="White"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
    </Window.Resources>

    <Border BorderBrush="#1F222B" BorderThickness="1" CornerRadius="10" Background="#0B0C10">
        <Grid>
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="260"/> <ColumnDefinition Width="*"/>   </Grid.ColumnDefinitions>
            
            <Border Grid.Column="0" Background="#13151A" CornerRadius="10,0,0,10">
                <Grid>
                    <Grid.RowDefinitions>
                        <RowDefinition Height="Auto"/>
                        <RowDefinition Height="*"/>
                        <RowDefinition Height="Auto"/>
                    </Grid.RowDefinitions>
                    
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
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="*"/>
                            <ColumnDefinition Width="Auto"/>
                        </Grid.ColumnDefinitions>
                        <Button Name="BtnExit" Content="Kapat (Exit)" Background="#FF3B30" Foreground="White" FontWeight="Bold" Height="40" BorderThickness="0" Cursor="Hand" Grid.Column="0" Margin="0,0,10,0">
                            <Button.Resources><Style TargetType="Border"><Setter Property="CornerRadius" Value="6"/></Style></Button.Resources>
                        </Button>
                        <Button Name="BtnLangToggle" Content="🌐 EN" Background="#1F222B" Foreground="White" FontWeight="Bold" Height="40" Width="60" BorderThickness="0" Cursor="Hand" Grid.Column="1">
                            <Button.Resources><Style TargetType="Border"><Setter Property="CornerRadius" Value="6"/></Style></Button.Resources>
                        </Button>
                    </Grid>
                </Grid>
            </Border>

            <Grid Grid.Column="1" Margin="30">
                <Grid.RowDefinitions>
                    <RowDefinition Height="*"/>
                    <RowDefinition Height="Auto"/>
                </Grid.RowDefinitions>

                <Grid Name="PageDash" Visibility="Visible">
                    <StackPanel VerticalAlignment="Center" HorizontalAlignment="Center">
                        <TextBlock Name="TxtDashWelcome" Text="SwiftHub'a Hos Geldiniz!" FontSize="36" FontWeight="Black" Foreground="White" TextAlignment="Center" Margin="0,0,0,10"/>
                        <TextBlock Name="TxtDashSub" Text="Sisteminizi optimize etmek, program kurmak veya sorunlari cozmek icin soldaki menuyu kullanin." FontSize="16" Foreground="#8A8D93" TextAlignment="Center"/>
                    </StackPanel>
                </Grid>

                <Grid Name="PageApps" Visibility="Hidden">
                    <Grid.RowDefinitions><RowDefinition Height="*"/><RowDefinition Height="Auto"/></Grid.RowDefinitions>
                    <TextBlock Name="TxtAppsTitle" Text="📦 UYGULAMALAR (APPS)" FontSize="24" FontWeight="Black" Foreground="White" Margin="0,0,0,15"/>
                    <Border Grid.Row="0" Background="#13151A" CornerRadius="8" Margin="0,40,0,0">
                        <TextBlock Name="TxtAppsComing" Text="Devasa App veritabani yakinda buraya dolacak..." Foreground="#666" FontSize="18" HorizontalAlignment="Center" VerticalAlignment="Center"/>
                    </Border>
                </Grid>

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
$PageDash = $window.FindName("PageDash"); $PageApps = $window.FindName("PageApps")
$BtnExit = $window.FindName("BtnExit"); $BtnLangToggle = $window.FindName("BtnLangToggle")

# METIN ELEMANLARI (CEVIRI ICIN)
$TxtTitle = $window.FindName("TxtTitle"); $TxtSub = $window.FindName("TxtSub")
$TxtDashWelcome = $window.FindName("TxtDashWelcome"); $TxtDashSub = $window.FindName("TxtDashSub")
$TxtAppsComing = $window.FindName("TxtAppsComing"); $TxtStatus = $window.FindName("TxtStatus")

# --- FONKSIYONLAR ---
function Update-Language {
    $dict = $global:i18n[$global:CurrentLang]
    $TxtTitle.Text = $dict["AppTitle"]; $TxtSub.Text = $dict["AppSub"]
    $NavDash.Content = $dict["MenuDash"]; $NavApps.Content = $dict["MenuApps"]
    $NavTweaks.Content = $dict["MenuTweaks"]; $NavFeatures.Content = $dict["MenuFeatures"]
    $NavNet.Content = $dict["MenuNet"]; $NavFixes.Content = $dict["MenuFixes"]
    $BtnLangToggle.Content = $dict["BtnLang"]; $TxtStatus.Text = $dict["StatusWait"]
    $TxtDashWelcome.Text = $dict["DashWelcome"]; $TxtDashSub.Text = $dict["DashSub"]
    $TxtAppsComing.Text = $dict["ComingSoon"]
}

function Reset-NavButtons {
    $NavDash.Background = "Transparent"; $NavDash.Foreground = "#8A8D93"
    $NavApps.Background = "Transparent"; $NavApps.Foreground = "#8A8D93"
    $NavTweaks.Background = "Transparent"; $NavTweaks.Foreground = "#8A8D93"
    $NavFeatures.Background = "Transparent"; $NavFeatures.Foreground = "#8A8D93"
    $NavNet.Background = "Transparent"; $NavNet.Foreground = "#8A8D93"
    $NavFixes.Background = "Transparent"; $NavFixes.Foreground = "#8A8D93"
    $PageDash.Visibility = "Hidden"; $PageApps.Visibility = "Hidden"
}

# --- EVENTLER ---
$BtnLangToggle.Add_Click({
    if ($global:CurrentLang -eq "TR") { $global:CurrentLang = "EN" } else { $global:CurrentLang = "TR" }
    Update-Language
})

$BtnExit.Add_Click({ $window.Close() })

$NavDash.Add_Click({ Reset-NavButtons; $NavDash.Background = "#1F222B"; $NavDash.Foreground = "White"; $PageDash.Visibility = "Visible" })
$NavApps.Add_Click({ Reset-NavButtons; $NavApps.Background = "#1F222B"; $NavApps.Foreground = "White"; $PageApps.Visibility = "Visible" })
# (Diger menuler eklendikce buraya yazilacak)

# Baslangic Dili Ayarla
Update-Language
$window.ShowDialog() | Out-Null