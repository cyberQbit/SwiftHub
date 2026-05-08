# ==============================================================================
# 🌌 SWIFTHUB CORE v7.5 - TITAN EDITION (GUIDE, BACKUP & UI FIXES)
# ==============================================================================
$ErrorActionPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# --- 1. DIL MOTORU (BILINGUAL DICTIONARY) ---
$global:CurrentLang = "TR"
$global:i18n = @{
    "TR" = @{
        "AppTitle" = "SWIFTHUB Core"; "AppSub" = "GOD TIER SISTEM MERKEZI";
        "MenuDash" = "🏠 Kontrol Paneli"; "MenuApps" = "📦 Uygulamalar"; "MenuTweaks" = "🛠️ Ince Ayarlar";
        "MenuFeatures" = "⚙️ Windows Ozellikleri"; "MenuNet" = "🌐 Ag ve Guvenlik"; "MenuFixes" = "⛑️ Sistem Onarimi";
        "MenuInfo" = "ℹ️ SwiftHub Rehberi"; "BtnLang" = "🌐 EN"; "StatusWait" = "Sistem hazir. Mimarinin keyfini cikarin...";
        "DashWelcome" = "SwiftHub v7.5'e Hos Geldiniz!"; "DashSub" = "Kusursuz hiz, sifir iz ve devasa ozellikler. Sol menuden operasyona baslayin.";
        "BtnInstall" = "Secili Uygulamalari Kur"; "BtnApply" = "Secili Ayarlari Enjekte Et";
        "BtnExport" = "💾 Profili Kaydet"; "BtnImport" = "📂 Profil Yukle";
        "BtnDebloat" = "☢️ Nükleer Debloat (Çöpleri Sil)"; "BtnRestore" = "🛡️ Geri Yukleme Noktasi Olustur";
        "TitleNet" = "🌐 AĞ VE SİBER GÜVENLİK"; "TitleFix" = "⛑️ SİSTEM ONARIMI & YEDEKLEME"; "TitleFeat" = "⚙️ WINDOWS ÖZELLİKLERİ";
        
        # Rehber Metinleri (TR)
        "InfoTitle" = "📖 SWIFTHUB KULLANIM REHBERİ";
        "InfoApps" = "📦 UYGULAMALAR: Saniyeler icinde dilediginiz programlari arka planda, reklamsiz ve sessizce kurar. 'Profili Kaydet' ile secimlerinizi yedekleyip formattan sonra hizlica tekrar yukleyebilirsiniz.";
        "InfoTweaks" = "🛠️ INCE AYARLAR: Sistemin hizini artiran, gizliliginizi koruyan (Telemetriyi kapatan) ve arayuzu duzenleyen derin Registry ayarlaridir. Uygulamadan once 'Sistem Onarimi' sekmesinden yedek almaniz onerilir.";
        "InfoDebloat" = "☢️ NÜKLEER DEBLOAT: Windows ile gelen ama silinemeyen (Xbox, Cortana, Haritalar vb.) gereksiz sistem uygulamalarini kokunden soker ve bilgisayari hafifletir.";
        "InfoNet" = "🌐 AĞ VE GÜVENLİK: DNS degistirerek yasakli sitelere girebilir, pinginizi dusurebilirsiniz. Internetiniz bozuldugunda 'Agi Sifirla' butonu ile baglantinizi fabrika ayarlarina dondurebilirsiniz.";
        "InfoFixes" = "⛑️ SİSTEM ONARIMI: Mavi ekran veya cokme sorunlarinda 'SFC & DISM' butonu bozulan Windows dosyalarini onarir. Ayrica buradan sisteminizin anlik yedegini alabilir ve Windows Kurtarma ekranina hizlica ulasabilirsiniz."
    };
    "EN" = @{
        "AppTitle" = "SWIFTHUB Core"; "AppSub" = "GOD TIER SYSTEM CENTER";
        "MenuDash" = "🏠 Dashboard"; "MenuApps" = "📦 Applications"; "MenuTweaks" = "🛠️ System Tweaks";
        "MenuFeatures" = "⚙️ Windows Features"; "MenuNet" = "🌐 Network & Security"; "MenuFixes" = "⛑️ System Repair";
        "MenuInfo" = "ℹ️ SwiftHub Guide"; "BtnLang" = "🌐 TR"; "StatusWait" = "System ready. Enjoy the architecture...";
        "DashWelcome" = "Welcome to SwiftHub v7.5!"; "DashSub" = "Flawless speed, zero footprint, massive features. Start from the sidebar.";
        "BtnInstall" = "Install Selected Apps"; "BtnApply" = "Apply Selected Tweaks";
        "BtnExport" = "💾 Export Profile"; "BtnImport" = "📂 Import Profile";
        "BtnDebloat" = "☢️ Nuclear Debloat (Remove Bloatware)"; "BtnRestore" = "🛡️ Create Restore Point";
        "TitleNet" = "🌐 NETWORK & SECURITY"; "TitleFix" = "⛑️ SYSTEM REPAIR & BACKUP"; "TitleFeat" = "⚙️ WINDOWS FEATURES";
        
        # Rehber Metinleri (EN)
        "InfoTitle" = "📖 SWIFTHUB USER GUIDE";
        "InfoApps" = "📦 APPLICATIONS: Installs your desired programs in the background, silently and ad-free. Use 'Export Profile' to back up your selections and quickly reinstall them after a format.";
        "InfoTweaks" = "🛠️ TWEAKS: Deep Registry settings that boost system speed, protect privacy (disable telemetry), and customize the UI. It is recommended to take a backup from the 'System Repair' tab before applying.";
        "InfoDebloat" = "☢️ NUCLEAR DEBLOAT: Completely eradicates undeletable system apps (Xbox, Cortana, Maps, etc.) that come with Windows, making your PC much lighter.";
        "InfoNet" = "🌐 NETWORK & SECURITY: Change your DNS to access restricted sites and lower your ping. If your internet breaks, use the 'Reset Network' button to revert to factory settings.";
        "InfoFixes" = "⛑️ SYSTEM REPAIR: For blue screens or crashes, the 'SFC & DISM' button repairs corrupted Windows files. You can also take an instant backup here and quickly access the Windows Recovery screen."
    }
}

Add-Type -AssemblyName PresentationFramework; Add-Type -AssemblyName PresentationCore; Add-Type -AssemblyName WindowsBase

# --- 2. XAML TASARIMI (REHBER & YEDEKLEME EKLENDI) ---
[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" Title="SwiftHub God Tier" Height="780" Width="1200" Background="#0B0C10" Foreground="White" WindowStartupLocation="CenterScreen" FontFamily="Segoe UI" WindowStyle="None" AllowsTransparency="True" ResizeMode="NoResize">
    <Window.Resources>
        <Style TargetType="ScrollBar">
            <Setter Property="Background" Value="#0B0C10"/><Setter Property="Width" Value="10"/>
            <Setter Property="Template"><Setter.Value><ControlTemplate TargetType="ScrollBar"><Grid Background="{TemplateBinding Background}"><Track Name="PART_Track" IsDirectionReversed="true"><Track.Thumb><Thumb Background="#1F222B" BorderThickness="0"><Thumb.Template><ControlTemplate TargetType="Thumb"><Border Background="{TemplateBinding Background}" CornerRadius="4" Margin="2"/></ControlTemplate></Thumb.Template></Thumb></Track.Thumb></Track></Grid></ControlTemplate></Setter.Value></Setter>
        </Style>
        <Style TargetType="Button" x:Key="SidebarBtn">
            <Setter Property="Background" Value="Transparent"/><Setter Property="Foreground" Value="#8A8D93"/><Setter Property="FontSize" Value="15"/><Setter Property="FontWeight" Value="SemiBold"/><Setter Property="HorizontalContentAlignment" Value="Left"/><Setter Property="Padding" Value="20,0,0,0"/><Setter Property="Height" Value="50"/><Setter Property="BorderThickness" Value="0"/><Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template"><Setter.Value><ControlTemplate TargetType="Button"><Border Name="border" Background="{TemplateBinding Background}" CornerRadius="8"><ContentPresenter HorizontalAlignment="{TemplateBinding HorizontalContentAlignment}" VerticalAlignment="Center" Margin="{TemplateBinding Padding}"/></Border><ControlTemplate.Triggers><Trigger Property="IsMouseOver" Value="True"><Setter TargetName="border" Property="Background" Value="#1F222B"/><Setter Property="Foreground" Value="White"/></Trigger></ControlTemplate.Triggers></ControlTemplate></Setter.Value></Setter>
        </Style>
        <Style TargetType="Button" x:Key="ActionBtn">
            <Setter Property="Background" Value="#1F222B"/><Setter Property="Foreground" Value="White"/><Setter Property="Height" Value="45"/><Setter Property="BorderThickness" Value="0"/><Setter Property="Cursor" Value="Hand"/><Setter Property="Margin" Value="5"/><Setter Property="FontWeight" Value="Bold"/>
            <Setter Property="Template"><Setter.Value><ControlTemplate TargetType="Button"><Border Background="{TemplateBinding Background}" CornerRadius="6"><ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/></Border></ControlTemplate></Setter.Value></Setter>
        </Style>
        <Style TargetType="CheckBox"><Setter Property="Foreground" Value="White"/><Setter Property="FontSize" Value="13"/><Setter Property="Margin" Value="0,5,15,5"/><Setter Property="Width" Value="220"/></Style>
    </Window.Resources>

    <Border BorderBrush="#00CED1" BorderThickness="1" CornerRadius="10" Background="#0B0C10">
        <Grid>
            <Grid.ColumnDefinitions><ColumnDefinition Width="260"/><ColumnDefinition Width="*"/></Grid.ColumnDefinitions>
            
            <Border Grid.Column="0" Background="#13151A" CornerRadius="10,0,0,10">
                <Grid>
                    <Grid.RowDefinitions><RowDefinition Height="Auto"/><RowDefinition Height="*"/><RowDefinition Height="Auto"/><RowDefinition Height="Auto"/></Grid.RowDefinitions>
                    <StackPanel Grid.Row="0" Margin="20,30,20,20">
                        <TextBlock Name="TxtTitle" Text="SWIFTHUB TITAN" FontSize="22" FontWeight="Black" Foreground="#00CED1"/>
                        <TextBlock Name="TxtSub" Text="GOD TIER SISTEM" FontSize="11" FontWeight="Bold" Foreground="#666"/>
                    </StackPanel>
                    
                    <StackPanel Grid.Row="1" Margin="10,0">
                        <Button Name="NavDash" Content="🏠 Kontrol Paneli" Style="{StaticResource SidebarBtn}" Foreground="White" Background="#1F222B"/>
                        <Button Name="NavApps" Content="📦 Uygulamalar" Style="{StaticResource SidebarBtn}"/>
                        <Button Name="NavTweaks" Content="🛠️ Ince Ayarlar" Style="{StaticResource SidebarBtn}"/>
                        <Button Name="NavFeatures" Content="⚙️ Windows Ozellikleri" Style="{StaticResource SidebarBtn}"/>
                        <Button Name="NavNet" Content="🌐 Ag ve Guvenlik" Style="{StaticResource SidebarBtn}"/>
                        <Button Name="NavFixes" Content="⛑️ Sistem Onarimi" Style="{StaticResource SidebarBtn}"/>
                    </StackPanel>

                    <StackPanel Grid.Row="2" Margin="10,10,10,0">
                        <Border BorderBrush="#1F222B" BorderThickness="0,1,0,0" Margin="10,0,10,10"/>
                        <Button Name="NavInfo" Content="ℹ️ SwiftHub Rehberi" Style="{StaticResource SidebarBtn}" Foreground="#00CED1"/>
                    </StackPanel>

                    <Grid Grid.Row="3" Margin="15,20,15,20">
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
                        <TextBlock Name="TxtDashWelcome" Text="SwiftHub v7.5'e Hos Geldiniz!" FontSize="38" FontWeight="Black" Foreground="White" TextAlignment="Center" Margin="0,0,0,10"/>
                        <TextBlock Name="TxtDashSub" Text="Kusursuz hiz, sifir iz ve devasa ozellikler. Sol menuden operasyona baslayin." FontSize="16" Foreground="#8A8D93" TextAlignment="Center" Margin="0,0,0,30"/>
                        <Button Name="BtnAnalyze" Content="Sistemi Analiz Et (God Mode)" Style="{StaticResource ActionBtn}" Width="300" Background="#00CED1" Foreground="#0B0C10"/>
                        <Border Background="#13151A" BorderBrush="#1F222B" BorderThickness="1" CornerRadius="6" Height="300" Width="650">
                            <ScrollViewer Margin="15"><TextBlock Name="TxtSysInfo" Text="Hazir..." Foreground="#00FF66" FontFamily="Consolas"/></ScrollViewer>
                        </Border>
                    </StackPanel>
                </Grid>

                <Grid Name="PageApps" Visibility="Hidden">
                    <Grid.RowDefinitions><RowDefinition Height="*"/><RowDefinition Height="Auto"/></Grid.RowDefinitions>
                    <Border Grid.Row="0" Background="#13151A" CornerRadius="8" Padding="20">
                        <ScrollViewer VerticalScrollBarVisibility="Auto"><StackPanel Name="PanelAppsContainer"/></ScrollViewer>
                    </Border>
                    <Grid Grid.Row="1" Margin="0,15,0,0">
                        <Grid.ColumnDefinitions><ColumnDefinition Width="2*"/><ColumnDefinition Width="*"/><ColumnDefinition Width="*"/><ColumnDefinition Width="1.5*"/></Grid.ColumnDefinitions>
                        <Button Name="BtnInstallApps" Content="Secili Uygulamalari Kur" Style="{StaticResource ActionBtn}" Background="#00CED1" Foreground="#0B0C10" Grid.Column="0"/>
                        <Button Name="BtnAppExport" Content="💾 Profili Kaydet" Style="{StaticResource ActionBtn}" Grid.Column="1"/>
                        <Button Name="BtnAppImport" Content="📂 Profil Yukle" Style="{StaticResource ActionBtn}" Grid.Column="2"/>
                        <Button Name="BtnDebloat" Content="☢️ Nükleer Debloat" Style="{StaticResource ActionBtn}" Background="#FF3B30" Grid.Column="3"/>
                    </Grid>
                </Grid>

                <Grid Name="PageTweaks" Visibility="Hidden">
                    <Grid.RowDefinitions><RowDefinition Height="*"/><RowDefinition Height="Auto"/></Grid.RowDefinitions>
                    <Border Grid.Row="0" Background="#13151A" CornerRadius="8" Padding="20">
                        <ScrollViewer VerticalScrollBarVisibility="Auto"><StackPanel Name="PanelTweaksContainer"/></ScrollViewer>
                    </Border>
                    <Grid Grid.Row="1" Margin="0,15,0,0">
                        <Grid.ColumnDefinitions><ColumnDefinition Width="2*"/><ColumnDefinition Width="*"/><ColumnDefinition Width="*"/></Grid.ColumnDefinitions>
                        <Button Name="BtnApplyTweaks" Content="Secili Ayarlari Enjekte Et" Style="{StaticResource ActionBtn}" Background="#00CED1" Foreground="#0B0C10" Grid.Column="0"/>
                        <Button Name="BtnTweakExport" Content="💾 Profili Kaydet" Style="{StaticResource ActionBtn}" Grid.Column="1"/>
                        <Button Name="BtnTweakImport" Content="📂 Profil Yukle" Style="{StaticResource ActionBtn}" Grid.Column="2"/>
                    </Grid>
                </Grid>

                <Grid Name="PageFeatures" Visibility="Hidden">
                    <StackPanel>
                        <TextBlock Name="TxtTitleFeat" Text="⚙️ WINDOWS ÖZELLİKLERİ" FontSize="26" FontWeight="Black" Foreground="White" Margin="0,0,0,20"/>
                        <Button Name="BtnFeatWSL" Content="Linux Alt Sistemini (WSL) Kur" Style="{StaticResource ActionBtn}"/>
                        <Button Name="BtnFeatHyperV" Content="Hyper-V Sanallastirmayi Aktif Et" Style="{StaticResource ActionBtn}"/>
                        <Button Name="BtnFeatSandbox" Content="Windows Sandbox'i Aktif Et" Style="{StaticResource ActionBtn}"/>
                        <Button Name="BtnFeatNet2" Content=".NET Framework 2.0 ve 3.5 Kur" Style="{StaticResource ActionBtn}"/>
                    </StackPanel>
                </Grid>

                <Grid Name="PageNet" Visibility="Hidden">
                    <StackPanel>
                        <TextBlock Name="TxtTitleNet" Text="🌐 AĞ VE SİBER GÜVENLİK" FontSize="26" FontWeight="Black" Foreground="White" Margin="0,0,0,20"/>
                        <Button Name="BtnSpeedTest" Content="Hiz Testi ve Analiz (Ookla Engine)" Style="{StaticResource ActionBtn}"/>
                        <Grid Margin="0,0,0,5">
                            <Grid.ColumnDefinitions><ColumnDefinition Width="*"/><ColumnDefinition Width="*"/><ColumnDefinition Width="*"/></Grid.ColumnDefinitions>
                            <Button Name="BtnDnsCloudflare" Grid.Column="0" Content="Cloudflare DNS" Style="{StaticResource ActionBtn}"/>
                            <Button Name="BtnDnsGoogle" Grid.Column="1" Content="Google DNS" Style="{StaticResource ActionBtn}"/>
                            <Button Name="BtnDnsDefault" Grid.Column="2" Content="Varsayilan DNS" Style="{StaticResource ActionBtn}"/>
                        </Grid>
                        <Button Name="BtnNetReset" Content="Agi Tamamen Sifirla (Winsock / FlushDNS)" Style="{StaticResource ActionBtn}" Background="#4A0000"/>
                        <Border Background="#13151A" BorderBrush="#1F222B" BorderThickness="1" CornerRadius="6" Height="180" Margin="5,10,5,0">
                            <ScrollViewer Margin="15"><TextBlock Name="TxtNetLog" Text="Ag modulu hazir..." Foreground="#00FF66" FontFamily="Consolas"/></ScrollViewer>
                        </Border>
                    </StackPanel>
                </Grid>

                <Grid Name="PageFixes" Visibility="Hidden">
                    <StackPanel>
                        <TextBlock Name="TxtTitleFix" Text="⛑️ SİSTEM ONARIMI &amp; YEDEKLEME" FontSize="26" FontWeight="Black" Foreground="White" Margin="0,0,0,20"/>
                        
                        <Grid Margin="0,0,0,15">
                            <Grid.ColumnDefinitions><ColumnDefinition Width="*"/><ColumnDefinition Width="*"/></Grid.ColumnDefinitions>
                            <Button Name="BtnQuickBackup" Content="🛡️ Sistem Yedeği Al (Hızlı)" Style="{StaticResource ActionBtn}" Background="#1E90FF" Grid.Column="0"/>
                            <Button Name="BtnOpenRestore" Content="📂 Yedekleme Merkezini Aç (Geri Yükle)" Style="{StaticResource ActionBtn}" Background="#2D303B" Grid.Column="1"/>
                        </Grid>

                        <Button Name="BtnFixSFC" Content="Sistem Dosyalarini Onar (SFC &amp; DISM)" Style="{StaticResource ActionBtn}"/>
                        <Button Name="BtnFixWU" Content="Windows Update Bilesenlerini Sifirla" Style="{StaticResource ActionBtn}"/>
                        <Button Name="BtnFixTemp" Content="Gereksiz Dosyalari ve Onbellegi Temizle" Style="{StaticResource ActionBtn}"/>
                        <Border Background="#13151A" BorderBrush="#1F222B" BorderThickness="1" CornerRadius="6" Height="130" Margin="5,10,5,0">
                            <ScrollViewer Margin="15"><TextBlock Name="TxtFixLog" Text="Onarim modulu hazir..." Foreground="#00FF66" FontFamily="Consolas"/></ScrollViewer>
                        </Border>
                    </StackPanel>
                </Grid>

                <Grid Name="PageInfo" Visibility="Hidden">
                    <Grid.RowDefinitions><RowDefinition Height="Auto"/><RowDefinition Height="*"/></Grid.RowDefinitions>
                    <TextBlock Name="TxtInfoTitle" Text="📖 SWIFTHUB KULLANIM REHBERİ" FontSize="26" FontWeight="Black" Foreground="#00CED1" Margin="0,0,0,20" Grid.Row="0"/>
                    <Border Grid.Row="1" Background="#13151A" CornerRadius="8" Padding="20">
                        <ScrollViewer VerticalScrollBarVisibility="Auto">
                            <StackPanel>
                                <Border Background="#1F222B" CornerRadius="6" Padding="15" Margin="0,0,0,10">
                                    <TextBlock Name="TxtInfoApps" Text="..." Foreground="White" FontSize="15" TextWrapping="Wrap"/>
                                </Border>
                                <Border Background="#1F222B" CornerRadius="6" Padding="15" Margin="0,0,0,10">
                                    <TextBlock Name="TxtInfoTweaks" Text="..." Foreground="White" FontSize="15" TextWrapping="Wrap"/>
                                </Border>
                                <Border Background="#4A0000" CornerRadius="6" Padding="15" Margin="0,0,0,10">
                                    <TextBlock Name="TxtInfoDebloat" Text="..." Foreground="White" FontSize="15" TextWrapping="Wrap"/>
                                </Border>
                                <Border Background="#1F222B" CornerRadius="6" Padding="15" Margin="0,0,0,10">
                                    <TextBlock Name="TxtInfoNet" Text="..." Foreground="White" FontSize="15" TextWrapping="Wrap"/>
                                </Border>
                                <Border Background="#1F222B" CornerRadius="6" Padding="15" Margin="0,0,0,10">
                                    <TextBlock Name="TxtInfoFixes" Text="..." Foreground="White" FontSize="15" TextWrapping="Wrap"/>
                                </Border>
                            </StackPanel>
                        </ScrollViewer>
                    </Border>
                </Grid>

                <Border Grid.Row="1" Background="#13151A" CornerRadius="6" Padding="15,10" Margin="0,20,0,0">
                    <TextBlock Name="TxtStatus" Text="Sistem hazir. Bir islem secin..." Foreground="#00CED1" FontFamily="Consolas" FontSize="13" FontWeight="Bold"/>
                </Border>
            </Grid>
        </Grid>
    </Border>
</Window>
"@

$reader = (New-Object System.Xml.XmlNodeReader $xaml); $window = [Windows.Markup.XamlReader]::Load($reader)

# --- ARAYUZ BINDING ---
$NavDash=$window.FindName("NavDash"); $NavApps=$window.FindName("NavApps"); $NavTweaks=$window.FindName("NavTweaks")
$NavFeatures=$window.FindName("NavFeatures"); $NavNet=$window.FindName("NavNet"); $NavFixes=$window.FindName("NavFixes"); $NavInfo=$window.FindName("NavInfo")
$PageDash=$window.FindName("PageDash"); $PageApps=$window.FindName("PageApps"); $PageTweaks=$window.FindName("PageTweaks")
$PageFeatures=$window.FindName("PageFeatures"); $PageNet=$window.FindName("PageNet"); $PageFixes=$window.FindName("PageFixes"); $PageInfo=$window.FindName("PageInfo")

$BtnExit=$window.FindName("BtnExit"); $BtnLangToggle=$window.FindName("BtnLangToggle"); $TxtStatus=$window.FindName("TxtStatus")
$TxtTitle=$window.FindName("TxtTitle"); $TxtSub=$window.FindName("TxtSub"); $TxtDashWelcome=$window.FindName("TxtDashWelcome"); $TxtDashSub=$window.FindName("TxtDashSub")
$TxtTitleNet=$window.FindName("TxtTitleNet"); $TxtTitleFix=$window.FindName("TxtTitleFix"); $TxtTitleFeat=$window.FindName("TxtTitleFeat")
$TxtSysInfo=$window.FindName("TxtSysInfo"); $TxtNetLog=$window.FindName("TxtNetLog"); $TxtFixLog=$window.FindName("TxtFixLog")

$TxtInfoTitle=$window.FindName("TxtInfoTitle"); $TxtInfoApps=$window.FindName("TxtInfoApps"); $TxtInfoTweaks=$window.FindName("TxtInfoTweaks")
$TxtInfoDebloat=$window.FindName("TxtInfoDebloat"); $TxtInfoNet=$window.FindName("TxtInfoNet"); $TxtInfoFixes=$window.FindName("TxtInfoFixes")

$BtnAnalyze=$window.FindName("BtnAnalyze"); $BtnInstallApps=$window.FindName("BtnInstallApps"); $BtnApplyTweaks=$window.FindName("BtnApplyTweaks")
$BtnSpeedTest=$window.FindName("BtnSpeedTest"); $BtnDnsCloudflare=$window.FindName("BtnDnsCloudflare"); $BtnDnsGoogle=$window.FindName("BtnDnsGoogle"); $BtnDnsDefault=$window.FindName("BtnDnsDefault"); $BtnNetReset=$window.FindName("BtnNetReset")
$BtnFixSFC=$window.FindName("BtnFixSFC"); $BtnFixWU=$window.FindName("BtnFixWU"); $BtnFixTemp=$window.FindName("BtnFixTemp")
$BtnFeatWSL=$window.FindName("BtnFeatWSL"); $BtnFeatHyperV=$window.FindName("BtnFeatHyperV"); $BtnFeatSandbox=$window.FindName("BtnFeatSandbox"); $BtnFeatNet2=$window.FindName("BtnFeatNet2")

$BtnAppExport=$window.FindName("BtnAppExport"); $BtnAppImport=$window.FindName("BtnAppImport"); $BtnDebloat=$window.FindName("BtnDebloat")
$BtnTweakExport=$window.FindName("BtnTweakExport"); $BtnTweakImport=$window.FindName("BtnTweakImport")
$BtnQuickBackup=$window.FindName("BtnQuickBackup"); $BtnOpenRestore=$window.FindName("BtnOpenRestore")

$global:AppHeaders=@(); $global:AppItems=@(); $global:TweakHeaders=@(); $global:TweakItems=@()

# ==============================================================================
# 🚀 3. DINAMIK JSON MOTORU
# ==============================================================================
try {
    $jsonResponseApps = (New-Object System.Net.WebClient).DownloadString("https://raw.githubusercontent.com/cyberQbit/DevSwift/main/apps.json?t=$((Get-Date).Ticks)") | ConvertFrom-Json
    foreach ($cat in $jsonResponseApps.psobject.properties.name) {
        $header = New-Object System.Windows.Controls.TextBlock; $header.Foreground = "#00CED1"; $header.FontSize = 17; $header.FontWeight = "Bold"; $header.Margin = "0,15,0,10"
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
        $header = New-Object System.Windows.Controls.TextBlock; $header.Foreground = "#FF3366"; $header.FontSize = 17; $header.FontWeight = "Bold"; $header.Margin = "0,15,0,10"
        $global:TweakHeaders += [PSCustomObject]@{ UI=$header; TR=$jsonResponseTweaks."$cat".TR; EN=$jsonResponseTweaks."$cat".EN }; $window.FindName("PanelTweaksContainer").Children.Add($header) | Out-Null
        $wp = New-Object System.Windows.Controls.WrapPanel; $wp.Margin = "0,0,0,10"
        foreach ($tweak in $jsonResponseTweaks."$cat".Items) {
            $cb = New-Object System.Windows.Controls.CheckBox; $cb.Content = $tweak.Name; $cb.Width = 370
            $global:TweakItems += [PSCustomObject]@{ CheckBox=$cb; Script=$tweak.Script }; $wp.Children.Add($cb) | Out-Null
        }
        $window.FindName("PanelTweaksContainer").Children.Add($wp) | Out-Null
    }
} catch {}

# --- 4. FONKSIYONLAR ---
function Update-Language {
    $d = $global:i18n[$global:CurrentLang]
    $TxtTitle.Text = $d["AppTitle"]; $TxtSub.Text = $d["AppSub"]; $NavDash.Content = $d["MenuDash"]; $NavApps.Content = $d["MenuApps"]
    $NavTweaks.Content = $d["MenuTweaks"]; $NavFeatures.Content = $d["MenuFeatures"]; $NavNet.Content = $d["MenuNet"]
    $NavFixes.Content = $d["MenuFixes"]; $NavInfo.Content = $d["MenuInfo"]
    $BtnLangToggle.Content = $d["BtnLang"]; $TxtStatus.Text = $d["StatusWait"]; $TxtDashWelcome.Text = $d["DashWelcome"]; $TxtDashSub.Text = $d["DashSub"]
    $BtnInstallApps.Content = $d["BtnInstall"]; $BtnApplyTweaks.Content = $d["BtnApply"]
    $BtnAppExport.Content = $d["BtnExport"]; $BtnAppImport.Content = $d["BtnImport"]
    $BtnTweakExport.Content = $d["BtnExport"]; $BtnTweakImport.Content = $d["BtnImport"]
    $BtnDebloat.Content = $d["BtnDebloat"]
    $TxtTitleNet.Text = $d["TitleNet"]; $TxtTitleFix.Text = $d["TitleFix"]; $TxtTitleFeat.Text = $d["TitleFeat"]
    
    # REHBER METINLERI BINDING
    $TxtInfoTitle.Text = $d["InfoTitle"]; $TxtInfoApps.Text = $d["InfoApps"]; $TxtInfoTweaks.Text = $d["InfoTweaks"]
    $TxtInfoDebloat.Text = $d["InfoDebloat"]; $TxtInfoNet.Text = $d["InfoNet"]; $TxtInfoFixes.Text = $d["InfoFixes"]
    
    foreach ($h in $global:AppHeaders) { $h.UI.Text = $h."$($global:CurrentLang)" }
    foreach ($h in $global:TweakHeaders) { $h.UI.Text = $h."$($global:CurrentLang)" }
}
function Reset-Nav {
    $NavDash.Background="Transparent"; $NavDash.Foreground="#8A8D93"; $NavApps.Background="Transparent"; $NavApps.Foreground="#8A8D93"; $NavTweaks.Background="Transparent"; $NavTweaks.Foreground="#8A8D93"
    $NavFeatures.Background="Transparent"; $NavFeatures.Foreground="#8A8D93"; $NavNet.Background="Transparent"; $NavNet.Foreground="#8A8D93"; $NavFixes.Background="Transparent"; $NavFixes.Foreground="#8A8D93"
    $NavInfo.Background="Transparent"; $NavInfo.Foreground="#00CED1"
    $PageDash.Visibility="Hidden"; $PageApps.Visibility="Hidden"; $PageTweaks.Visibility="Hidden"; $PageFeatures.Visibility="Hidden"; $PageNet.Visibility="Hidden"; $PageFixes.Visibility="Hidden"; $PageInfo.Visibility="Hidden"
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
$NavInfo.Add_Click({ Reset-Nav; $NavInfo.Background="#1F222B"; $NavInfo.Foreground="White"; $PageInfo.Visibility="Visible" })

# APP & TWEAKS (AYNI KALIYOR)
$BtnInstallApps.Add_Click({ $TxtStatus.Text="[*] Programlar kuruluyor..."; $window.Dispatcher.Invoke([Action]{},[Windows.Threading.DispatcherPriority]::Render); $c=0; foreach($i in $global:AppItems){if($i.CheckBox.IsChecked){try{Start-Process "winget" "-install --id $($i.Id) --accept-source-agreements --accept-package-agreements --silent" -Wait -NoNewWindow;$c++}catch{}}}; $TxtStatus.Text="[+] $c program kuruldu!" })
$BtnApplyTweaks.Add_Click({ $TxtStatus.Text="[*] Ayarlar enjekte ediliyor..."; $window.Dispatcher.Invoke([Action]{},[Windows.Threading.DispatcherPriority]::Render); $c=0; foreach($i in $global:TweakItems){if($i.CheckBox.IsChecked){try{Invoke-Expression $i.Script;$c++}catch{}}}; $TxtStatus.Text="[+] $c ayar uygulandi!" })
$BtnDebloat.Add_Click({ $TxtStatus.Text="[☢️] Nukleer Debloat basladi! (1-2 dk surebilir)..."; $window.Dispatcher.Invoke([Action]{},[Windows.Threading.DispatcherPriority]::Render); $bloatware=@("Microsoft.BingWeather","Microsoft.GetHelp","Microsoft.Getstarted","Microsoft.Microsoft3DViewer","Microsoft.MicrosoftOfficeHub","Microsoft.WindowsAlarms","Microsoft.WindowsCamera","microsoft.windowscommunicationsapps","Microsoft.WindowsFeedbackHub","Microsoft.WindowsMaps","Microsoft.WindowsSoundRecorder","Microsoft.XboxApp","Microsoft.XboxGamingOverlay","Microsoft.ZuneMusic","Microsoft.YourPhone"); $c=0; foreach($app in $bloatware){try{Get-AppxPackage -Name "*$app*" -AllUsers -ErrorAction SilentlyContinue|Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue;$c++}catch{}}; $TxtStatus.Text="[+] Debloat Bitti! $c çöp paket silindi." })

# YEDEKLEME EVENTLERI (YENI)
$BtnQuickBackup.Add_Click({
    $TxtStatus.Text = "[*] Sistem Geri Yukleme Noktasi olusturuluyor, lutfen bekleyin..."; $window.Dispatcher.Invoke([Action]{}, [Windows.Threading.DispatcherPriority]::Render)
    Enable-ComputerRestore -Drive "C:\" -ErrorAction SilentlyContinue | Out-Null
    Checkpoint-Computer -Description "SwiftHub v7.5 Hızlı Yedek" -RestorePointType "MODIFY_SETTINGS" -ErrorAction SilentlyContinue | Out-Null
    $TxtStatus.Text = "[+] KUSURSUZ! Sistem yedeğiniz başarıyla alındı."
})
$BtnOpenRestore.Add_Click({
    $TxtStatus.Text = "[*] Windows Yedekleme Merkezi (rstrui.exe) aciliyor...";
    Start-Process "rstrui.exe" -ErrorAction SilentlyContinue
})

# DIGER BUTONLAR (PROFIL, NET, FIX, ANALYZE) 
$BtnAppExport.Add_Click({ $dlg=New-Object Microsoft.Win32.SaveFileDialog; $dlg.Filter="JSON Profile|*.json"; $dlg.FileName="SwiftHub_Apps.json"; if($dlg.ShowDialog() -eq $true){ $global:AppItems|Where{$_.CheckBox.IsChecked}|Select Id|ConvertTo-Json -Depth 10|Out-File $dlg.FileName -Encoding UTF8; $TxtStatus.Text="[+] Profil kaydedildi!" } })
$BtnAppImport.Add_Click({ $dlg=New-Object Microsoft.Win32.OpenFileDialog; $dlg.Filter="JSON Profile|*.json"; if($dlg.ShowDialog() -eq $true){ $j=Get-Content $dlg.FileName -Raw|ConvertFrom-Json; foreach($i in $global:AppItems){$i.CheckBox.IsChecked=$false; foreach($x in $j){if($i.Id -eq $x.Id){$i.CheckBox.IsChecked=$true}}}; $TxtStatus.Text="[+] Profil yuklendi!" } })
$BtnTweakExport.Add_Click({ $dlg=New-Object Microsoft.Win32.SaveFileDialog; $dlg.Filter="JSON Profile|*.json"; $dlg.FileName="SwiftHub_Tweaks.json"; if($dlg.ShowDialog() -eq $true){ $global:TweakItems|Where{$_.CheckBox.IsChecked}|Select Script|ConvertTo-Json -Depth 10|Out-File $dlg.FileName -Encoding UTF8; $TxtStatus.Text="[+] Profil kaydedildi!" } })
$BtnTweakImport.Add_Click({ $dlg=New-Object Microsoft.Win32.OpenFileDialog; $dlg.Filter="JSON Profile|*.json"; if($dlg.ShowDialog() -eq $true){ $j=Get-Content $dlg.FileName -Raw|ConvertFrom-Json; foreach($i in $global:TweakItems){$i.CheckBox.IsChecked=$false; foreach($x in $j){if($i.Script -eq $x.Script){$i.CheckBox.IsChecked=$true}}}; $TxtStatus.Text="[+] Profil yuklendi!" } })
$BtnAnalyze.Add_Click({ $TxtSysInfo.Text="Okunuyor..."; $window.Dispatcher.Invoke([Action]{},[Windows.Threading.DispatcherPriority]::Render); $os=Get-CimInstance Win32_OperatingSystem; $cpu=Get-CimInstance Win32_Processor; $mb=Get-CimInstance Win32_BaseBoard; $ram=Get-CimInstance Win32_PhysicalMemory; $TxtSysInfo.Text="[OS] $($os.Caption)`n[Anakart] $($mb.Manufacturer) $($mb.Product)`n[CPU] $($cpu[0].Name)`n[RAM] $([math]::Round(($ram|Measure-Object Capacity -Sum).Sum/1GB,2)) GB`n`nHazir." })
$BtnSpeedTest.Add_Click({ $TxtNetLog.Text="[*] Ookla calisiyor (20sn)..."; $window.Dispatcher.Invoke([Action]{},[Windows.Threading.DispatcherPriority]::Render); try{$t="$env:TEMP\Ookla"; if(Test-Path $t){Remove-Item $t -Recurse -Force}; New-Item -Path $t -ItemType Directory|Out-Null; $wc=New-Object System.Net.WebClient; $wc.DownloadFile("https://install.speedtest.net/app/cli/ookla-speedtest-1.2.0-win64.zip","$t\s.zip"); Expand-Archive "$t\s.zip" "$t" -Force; $o=& "$t\speedtest.exe" --accept-license --accept-gdpr --format=json|ConvertFrom-Json; $TxtNetLog.Text="[+] OOKLA SONUCU:`nPing: $($o.ping.latency) ms`nDown: $([math]::Round($o.download.bandwidth*8/1000000, 2)) Mbps`nUp: $([math]::Round($o.upload.bandwidth*8/1000000, 2)) Mbps"}catch{$TxtNetLog.Text="[X] Hata"}finally{if(Test-Path $t){Remove-Item $t -Recurse -Force -ErrorAction SilentlyContinue}} })
$BtnDnsCloudflare.Add_Click({ $n=Get-NetAdapter|Where Status -eq 'Up'|Select -First 1; Set-DnsClientServerAddress -InterfaceIndex $n.ifIndex -ServerAddresses ("1.1.1.1","1.0.0.1"); $TxtNetLog.Text="[+] DNS -> Cloudflare" })
$BtnDnsGoogle.Add_Click({ $n=Get-NetAdapter|Where Status -eq 'Up'|Select -First 1; Set-DnsClientServerAddress -InterfaceIndex $n.ifIndex -ServerAddresses ("8.8.8.8","8.8.4.4"); $TxtNetLog.Text="[+] DNS -> Google" })
$BtnDnsDefault.Add_Click({ $n=Get-NetAdapter|Where Status -eq 'Up'|Select -First 1; Set-DnsClientServerAddress -InterfaceIndex $n.ifIndex -ResetServerAddresses; $TxtNetLog.Text="[+] DNS Sifirlandi." })
$BtnNetReset.Add_Click({ ipconfig /flushdns|Out-Null; netsh winsock reset|Out-Null; $TxtNetLog.Text="[+] Ag Sifirlandi." })
$BtnFixSFC.Add_Click({ $TxtFixLog.Text="[*] SFC Onarimi..."; $window.Dispatcher.Invoke([Action]{},[Windows.Threading.DispatcherPriority]::Render); Start-Process "cmd.exe" "/c DISM /Online /Cleanup-Image /RestoreHealth & sfc /scannow" -Wait -NoNewWindow; $TxtFixLog.Text="[+] Bitti!" })
$BtnFixWU.Add_Click({ $TxtFixLog.Text="[*] Update temizleniyor..."; $window.Dispatcher.Invoke([Action]{},[Windows.Threading.DispatcherPriority]::Render); Stop-Service wuauserv -Force -ErrorAction SilentlyContinue; Remove-Item "$env:windir\SoftwareDistribution\Download\*" -Recurse -Force -ErrorAction SilentlyContinue; Start-Service wuauserv -ErrorAction SilentlyContinue; $TxtFixLog.Text="[+] Bitti!" })
$BtnFixTemp.Add_Click({ $TxtFixLog.Text="[*] Temp siliniyor..."; $window.Dispatcher.Invoke([Action]{},[Windows.Threading.DispatcherPriority]::Render); Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue; $TxtFixLog.Text="[+] Bitti!" })
$BtnFeatWSL.Add_Click({ Start-Process "dism.exe" "/online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart" -Wait -NoNewWindow; $TxtStatus.Text="[+] WSL Kuruldu." })
$BtnFeatHyperV.Add_Click({ Start-Process "dism.exe" "/online /enable-feature /featurename:Microsoft-Hyper-V-All /all /norestart" -Wait -NoNewWindow; $TxtStatus.Text="[+] Hyper-V Kuruldu." })
$BtnFeatSandbox.Add_Click({ Start-Process "dism.exe" "/online /enable-feature /featurename:Containers-DisposableClientVM /all /norestart" -Wait -NoNewWindow; $TxtStatus.Text="[+] Sandbox Kuruldu." })
$BtnFeatNet2.Add_Click({ Start-Process "dism.exe" "/online /enable-feature /featurename:NetFx3 /all /norestart" -Wait -NoNewWindow; $TxtStatus.Text="[+] .NET 3.5 Kuruldu." })

Update-Language; $window.ShowDialog() | Out-Null