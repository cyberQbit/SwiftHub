# ==============================================================================
# 🌌 SWIFTHUB CORE v8.4 - OMEGA EDITION (FULL ITEM LOCALIZATION ENGINE)
# ==============================================================================
$ErrorActionPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::InputEncoding = [System.Text.Encoding]::UTF8

# --- 1. DIL MOTORU (BILINGUAL DICTIONARY - EVRENSEL KARAKTERLER) ---
$global:CurrentLang = "TR"
$global:i18n = @{
    "TR" = @{
        "AppTitle" = "SWIFTHUB"; "AppSub" = "OMEGA CORE v8.4";
        "MenuDash" = "🏠 Kontrol Paneli"; "MenuApps" = "📦 Uygulamalar"; "MenuTweaks" = "🛠️ Ince Ayarlar";
        "MenuFeatures" = "⚙️ Windows Ozellikleri"; "MenuNet" = "🌐 Ag ve Guvenlik"; "MenuFixes" = "⛑️ Sistem Onarimi";
        "MenuInfo" = "ℹ️ SwiftHub Rehberi"; "BtnLang" = "🌐 EN"; "StatusWait" = "Omega Core hazir. Emrinizi bekliyor...";
        "DashWelcome" = "SwiftHub OMEGA'ya Hos Geldiniz!"; "DashSub" = "Efsanevi hiz, nukleer guc ve sifir iz. Sol menuden operasyona baslayin.";
        "BtnInstall" = "Secili Uygulamalari Kur"; "BtnApply" = "Secili Ayarlari Enjekte Et";
        "BtnExport" = "💾 Profili Kaydet"; "BtnImport" = "📂 Profil Yukle";
        "BtnDebloat" = "☢️ Nukleer Debloat"; "BtnRestore" = "🛡️ Geri Yukleme Noktasi";
        "BtnUpdateAll" = "🔄 Tum Programlari Guncelle"; "BtnDeepClean" = "☢️ Nukleer Disk Temizligi";
        "BtnWinUtil" = "🔑 Windows'unu ve Microsoft Office'i Lisansla!";
        "BtnAddContext" = "🖱️ Sag Tika SwiftHub Ekle"; "BtnRemContext" = "Kaldir";
        "TitleNet" = "🌐 AG VE SIBER GUVENLIK"; "TitleFix" = "⛑️ SISTEM ONARIMI & YEDEKLEME"; "TitleFeat" = "⚙️ WINDOWS OZELLIKLERI";
        
        "InfoTitle" = "📖 SWIFTHUB KULLANIM REHBERI";
        "InfoApps" = "📦 UYGULAMALAR: Saniyeler icinde program kurar. 'Tumunu Guncelle' butonu bilgisayarindaki tum eski programlari tek tikla en son surume gunceller.";
        "InfoTweaks" = "🛠️ INCE AYARLAR: Derin Registry ayarlaridir. 'Sag Tik' butonlari ile SwiftHub'i masaustunde farenin sag tusuna kalici olarak ekleyebilirsiniz.";
        "InfoDebloat" = "☢️ NUKLEER TEMIZLIK: Debloat butonu silinmeyen Windows coplerini; Disk Temizligi butonu ise Event loglari, prefetch ve update kalintilarini yok eder.";
        "InfoNet" = "🌐 AG VE GUVENLIK: DNS degistirerek yasakli sitelere girebilir, pinginizi dusurebilirsiniz. Ookla ile baglantinizi test edebilirsiniz.";
        "InfoFixes" = "⛑️ SISTEM ONARIMI: Mavi ekran sorunlarinda 'SFC & DISM' onarimi yapar. Ayrica anlik yedek alabilir ve OEM Lisansinizi 'God Mode' uzerinden bulabilirsiniz."
    };
    "EN" = @{
        "AppTitle" = "SWIFTHUB"; "AppSub" = "OMEGA CORE v8.4";
        "MenuDash" = "🏠 Dashboard"; "MenuApps" = "📦 Applications"; "MenuTweaks" = "🛠️ System Tweaks";
        "MenuFeatures" = "⚙️ Windows Features"; "MenuNet" = "🌐 Network & Security"; "MenuFixes" = "⛑️ System Repair";
        "MenuInfo" = "ℹ️ SwiftHub Guide"; "BtnLang" = "🌐 TR"; "StatusWait" = "Omega Core ready. Awaiting your command...";
        "DashWelcome" = "Welcome to SwiftHub OMEGA!"; "DashSub" = "Legendary speed, nuclear power, zero footprint. Start from the sidebar.";
        "BtnInstall" = "Install Selected Apps"; "BtnApply" = "Apply Selected Tweaks";
        "BtnExport" = "💾 Export Profile"; "BtnImport" = "📂 Import Profile";
        "BtnDebloat" = "☢️ Nuclear Debloat"; "BtnRestore" = "🛡️ Create Restore Point";
        "BtnUpdateAll" = "🔄 Update All Programs"; "BtnDeepClean" = "☢️ Nuclear Disk Clean";
        "BtnWinUtil" = "🔑 License your Windows and Microsoft Office!";
        "BtnAddContext" = "🖱️ Add SwiftHub to Context Menu"; "BtnRemContext" = "Remove";
        "TitleNet" = "🌐 NETWORK & SECURITY"; "TitleFix" = "⛑️ SYSTEM REPAIR & BACKUP"; "TitleFeat" = "⚙️ WINDOWS FEATURES";
        
        "InfoTitle" = "📖 SWIFTHUB USER GUIDE";
        "InfoApps" = "📦 APPLICATIONS: Installs programs silently. The 'Update All' button upgrades all outdated software on your PC to the latest version.";
        "InfoTweaks" = "🛠️ TWEAKS: Deep Registry settings. Use the 'Context Menu' buttons to add SwiftHub permanently to your desktop right-click menu.";
        "InfoDebloat" = "☢️ NUCLEAR CLEANUP: Debloat removes undeletable Windows apps; Disk Clean obliterates event logs, prefetch, and update leftovers.";
        "InfoNet" = "🌐 NETWORK & SECURITY: Change DNS to bypass restrictions and lower ping. Test your connection with the built-in Ookla engine.";
        "InfoFixes" = "⛑️ SYSTEM REPAIR: Fixes blue screens with SFC & DISM. You can also take backups and find your OEM License Key via 'God Mode'."
    }
}

Add-Type -AssemblyName PresentationFramework; Add-Type -AssemblyName PresentationCore; Add-Type -AssemblyName WindowsBase

# --- 2. XAML TASARIMI ---
[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" Title="SwiftHub Omega" Height="800" Width="1250" Background="#0B0C10" Foreground="White" WindowStartupLocation="CenterScreen" FontFamily="Segoe UI" WindowStyle="None" AllowsTransparency="True" ResizeMode="NoResize">
    <Window.Resources>
        <Style TargetType="ScrollBar"><Setter Property="Background" Value="#0B0C10"/><Setter Property="Width" Value="10"/><Setter Property="Template"><Setter.Value><ControlTemplate TargetType="ScrollBar"><Grid Background="{TemplateBinding Background}"><Track Name="PART_Track" IsDirectionReversed="true"><Track.Thumb><Thumb Background="#1F222B" BorderThickness="0"><Thumb.Template><ControlTemplate TargetType="Thumb"><Border Background="{TemplateBinding Background}" CornerRadius="4" Margin="2"/></ControlTemplate></Thumb.Template></Thumb></Track.Thumb></Track></Grid></ControlTemplate></Setter.Value></Setter></Style>
        <Style TargetType="Button" x:Key="SidebarBtn"><Setter Property="Background" Value="Transparent"/><Setter Property="Foreground" Value="#8A8D93"/><Setter Property="FontSize" Value="15"/><Setter Property="FontWeight" Value="SemiBold"/><Setter Property="HorizontalContentAlignment" Value="Left"/><Setter Property="Padding" Value="20,0,0,0"/><Setter Property="Height" Value="50"/><Setter Property="BorderThickness" Value="0"/><Setter Property="Cursor" Value="Hand"/><Setter Property="Template"><Setter.Value><ControlTemplate TargetType="Button"><Border Name="border" Background="{TemplateBinding Background}" CornerRadius="8"><ContentPresenter HorizontalAlignment="{TemplateBinding HorizontalContentAlignment}" VerticalAlignment="Center" Margin="{TemplateBinding Padding}"/></Border><ControlTemplate.Triggers><Trigger Property="IsMouseOver" Value="True"><Setter TargetName="border" Property="Background" Value="#1F222B"/><Setter Property="Foreground" Value="White"/></Trigger></ControlTemplate.Triggers></ControlTemplate></Setter.Value></Setter></Style>
        <Style TargetType="Button" x:Key="ActionBtn"><Setter Property="Background" Value="#1F222B"/><Setter Property="Foreground" Value="White"/><Setter Property="Height" Value="45"/><Setter Property="BorderThickness" Value="0"/><Setter Property="Cursor" Value="Hand"/><Setter Property="Margin" Value="5"/><Setter Property="FontWeight" Value="Bold"/><Setter Property="Template"><Setter.Value><ControlTemplate TargetType="Button"><Border Background="{TemplateBinding Background}" CornerRadius="6"><ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/></Border></ControlTemplate></Setter.Value></Setter></Style>
        <Style TargetType="CheckBox"><Setter Property="Foreground" Value="White"/><Setter Property="FontSize" Value="13"/><Setter Property="Margin" Value="0,5,15,5"/><Setter Property="Width" Value="220"/></Style>
    </Window.Resources>

    <Border BorderBrush="#00CED1" BorderThickness="1" CornerRadius="10" Background="#0B0C10">
        <Grid>
            <Grid.ColumnDefinitions><ColumnDefinition Width="260"/><ColumnDefinition Width="*"/></Grid.ColumnDefinitions>
            
            <Border Grid.Column="0" Background="#13151A" CornerRadius="10,0,0,10">
                <Grid>
                    <Grid.RowDefinitions><RowDefinition Height="Auto"/><RowDefinition Height="*"/><RowDefinition Height="Auto"/><RowDefinition Height="Auto"/></Grid.RowDefinitions>
                    
                    <StackPanel Grid.Row="0" Margin="20,30,20,20">
                        <TextBlock Name="TxtTitle" Text="SWIFTHUB" FontSize="28" FontWeight="Black" Foreground="#00CED1"/>
                        <TextBlock Name="TxtSub" Text="OMEGA CORE v8.4" FontSize="12" FontWeight="Bold" Foreground="#666"/>
                    </StackPanel>
                    
                    <StackPanel Grid.Row="1" Margin="10,0">
                        <Button Name="NavDash" Content="🏠 Kontrol Paneli" Style="{StaticResource SidebarBtn}" Foreground="White" Background="#1F222B"/>
                        <Button Name="NavApps" Content="📦 Uygulamalar" Style="{StaticResource SidebarBtn}"/>
                        <Button Name="NavTweaks" Content="🛠️ Ince Ayarlar" Style="{StaticResource SidebarBtn}"/>
                        <Button Name="NavFeatures" Content="⚙️ Windows Ozellikleri" Style="{StaticResource SidebarBtn}"/>
                        <Button Name="NavNet" Content="🌐 Ag ve Guvenlik" Style="{StaticResource SidebarBtn}"/>
                        <Button Name="NavFixes" Content="⛑️ Sistem Onarimi" Style="{StaticResource SidebarBtn}"/>
                        <Button Name="NavRadar" Content="📡 Derin Radar" Style="{StaticResource SidebarBtn}"/>
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
                        <TextBlock Name="TxtDashWelcome" Text="SwiftHub v8.4'e Hos Geldiniz!" FontSize="40" FontWeight="Black" Foreground="White" TextAlignment="Center" Margin="0,0,0,10"/>
                        <TextBlock Name="TxtDashSub" Text="Efsanevi hiz, nukleer guc ve sifir iz. Sol menuden operasyona baslayin." FontSize="16" Foreground="#8A8D93" TextAlignment="Center" Margin="0,0,0,30"/>
                        
                        <Grid Width="750" Margin="0,10,0,0">
                            <Grid.ColumnDefinitions>
                                <ColumnDefinition Width="1.5*"/>
                                <ColumnDefinition Width="1*"/> </Grid.ColumnDefinitions>

                            <Border Grid.Column="0" Background="#13151A" BorderBrush="#1F222B" BorderThickness="1" CornerRadius="6" Height="340" Margin="0,0,15,0">
                                <Grid>
                                    <Grid.RowDefinitions><RowDefinition Height="Auto"/><RowDefinition Height="*"/></Grid.RowDefinitions>
                                    <Button Name="BtnAnalyze" Content="Sistemi Analiz Et (God Mode)" Style="{StaticResource ActionBtn}" Background="#00CED1" Foreground="#0B0C10" Margin="10" Grid.Row="0"/>
                                    <ScrollViewer Grid.Row="1" Margin="15,0,15,15"><TextBlock Name="TxtSysInfo" Text="Hazir..." Foreground="#00FF66" FontFamily="Consolas"/></ScrollViewer>
                                </Grid>
                            </Border>

                            <Border Grid.Column="1" Background="#13151A" BorderBrush="#1F222B" BorderThickness="1" CornerRadius="6" Height="340">
                                <StackPanel Margin="20">
                                    <TextBlock Text="📡 CANLI RADAR" Foreground="#FF3366" FontWeight="Black" FontSize="16" Margin="0,0,0,15"/>
                                    
                                    <TextBlock Text="CPU Kullanimi:" Foreground="#8A8D93" FontSize="12"/>
                                    <TextBlock Name="TxtRadarCpu" Text="% 0" Foreground="White" FontWeight="Bold" FontSize="26" Margin="0,0,0,15"/>
                                    
                                    <TextBlock Text="Bos Bellek (RAM):" Foreground="#8A8D93" FontSize="12"/>
                                    <TextBlock Name="TxtRadarRam" Text="0 MB" Foreground="White" FontWeight="Bold" FontSize="26" Margin="0,0,0,20"/>

                                    <Border BorderBrush="#1F222B" BorderThickness="0,1,0,0" Margin="0,0,0,20"/>

                                    <TextBlock Text="LOKAL SERVIS DURUMU" Foreground="#00CED1" FontWeight="Bold" FontSize="12" Margin="0,0,0,10"/>
                                    <TextBlock Name="TxtPortSQL" Text="⚪ MSSQL (1433)" Foreground="White" FontSize="13" Margin="0,0,0,8"/>
                                    <TextBlock Name="TxtPortWeb" Text="⚪ .NET API (5000)" Foreground="White" FontSize="13" Margin="0,0,0,8"/>
                                    <TextBlock Name="TxtPortDocker" Text="⚪ Docker (2375)" Foreground="White" FontSize="13" Margin="0,0,0,8"/>
                                </StackPanel>
                            </Border>
                        </Grid>
                        <Button Name="BtnWinUtil" Content="🔑 Windows'unu ve Microsoft Office'i Lisansla!" Style="{StaticResource ActionBtn}" Background="#1E90FF" Foreground="White" Width="750" Margin="0,15,0,0"/>
                    </StackPanel>
                </Grid>

                <Grid Name="PageApps" Visibility="Hidden">
                    <Grid.RowDefinitions><RowDefinition Height="*"/><RowDefinition Height="Auto"/></Grid.RowDefinitions>
                    <Border Grid.Row="0" Background="#13151A" CornerRadius="8" Padding="20">
                        <ScrollViewer VerticalScrollBarVisibility="Auto"><StackPanel Name="PanelAppsContainer"/></ScrollViewer>
                    </Border>
                    <Grid Grid.Row="1" Margin="0,15,0,0">
                        <Grid.ColumnDefinitions><ColumnDefinition Width="2*"/><ColumnDefinition Width="1.5*"/><ColumnDefinition Width="*"/><ColumnDefinition Width="*"/><ColumnDefinition Width="1.5*"/></Grid.ColumnDefinitions>
                        <Button Name="BtnInstallApps" Content="Secili Uygulamalari Kur" Style="{StaticResource ActionBtn}" Background="#00CED1" Foreground="#0B0C10" Grid.Column="0"/>
                        <Button Name="BtnUpdateAll" Content="🔄 Tumunu Guncelle" Style="{StaticResource ActionBtn}" Background="#1E90FF" Grid.Column="1"/>
                        <Button Name="BtnAppExport" Content="💾 Profili Kaydet" Style="{StaticResource ActionBtn}" Grid.Column="2"/>
                        <Button Name="BtnAppImport" Content="📂 Profil Yukle" Style="{StaticResource ActionBtn}" Grid.Column="3"/>
                        <Button Name="BtnDebloat" Content="☢️ Nukleer Debloat" Style="{StaticResource ActionBtn}" Background="#FF3B30" Grid.Column="4"/>
                    </Grid>
                </Grid>

                <Grid Name="PageTweaks" Visibility="Hidden">
                    <Grid.RowDefinitions><RowDefinition Height="*"/><RowDefinition Height="Auto"/></Grid.RowDefinitions>
                    <Border Grid.Row="0" Background="#13151A" CornerRadius="8" Padding="20">
                        <ScrollViewer VerticalScrollBarVisibility="Auto"><StackPanel Name="PanelTweaksContainer"/></ScrollViewer>
                    </Border>
                    <Grid Grid.Row="1" Margin="0,15,0,0">
                        <Grid.ColumnDefinitions><ColumnDefinition Width="2*"/><ColumnDefinition Width="*"/><ColumnDefinition Width="*"/><ColumnDefinition Width="1.5*"/></Grid.ColumnDefinitions>
                        <Button Name="BtnApplyTweaks" Content="Secili Ayarlari Enjekte Et" Style="{StaticResource ActionBtn}" Background="#00CED1" Foreground="#0B0C10" Grid.Column="0"/>
                        <Button Name="BtnTweakExport" Content="💾 Profili Kaydet" Style="{StaticResource ActionBtn}" Grid.Column="1"/>
                        <Button Name="BtnTweakImport" Content="📂 Profil Yukle" Style="{StaticResource ActionBtn}" Grid.Column="2"/>
                        <Button Name="BtnRestore" Content="🛡️ Geri Yukleme Noktasi" Style="{StaticResource ActionBtn}" Background="#1E90FF" Grid.Column="3"/>
                    </Grid>
                </Grid>

                <Grid Name="PageFeatures" Visibility="Hidden">
                    <StackPanel>
                        <TextBlock Name="TxtTitleFeat" Text="⚙️ WINDOWS OZELLIKLERI" FontSize="26" FontWeight="Black" Foreground="White" Margin="0,0,0,20"/>
                        <Button Name="BtnFeatWSL" Content="Linux Alt Sistemini (WSL) Kur" Style="{StaticResource ActionBtn}"/>
                        <Button Name="BtnFeatHyperV" Content="Hyper-V Sanallastirmayi Aktif Et" Style="{StaticResource ActionBtn}"/>
                        <Button Name="BtnFeatSandbox" Content="Windows Sandbox'i Aktif Et" Style="{StaticResource ActionBtn}"/>
                        <Button Name="BtnFeatNet2" Content=".NET Framework 2.0 ve 3.5 Kur" Style="{StaticResource ActionBtn}"/>
                        
                        <Border Background="#13151A" BorderBrush="#1F222B" BorderThickness="1" CornerRadius="6" Padding="15" Margin="0,20,0,0">
                            <StackPanel>
                                <TextBlock Text="🖱️ SAG TIK (CONTEXT MENU) ENTEGRASYONU" FontSize="16" FontWeight="Bold" Foreground="#00CED1" Margin="0,0,0,10"/>
                                <TextBlock Text="Masaustunde sag tikladiginizda SwiftHub'in aninda acilmasi icin kalici olarak ekleyin." Foreground="#8A8D93" Margin="0,0,0,10"/>
                                <Grid>
                                    <Grid.ColumnDefinitions><ColumnDefinition/><ColumnDefinition/></Grid.ColumnDefinitions>
                                    <Button Name="BtnAddContext" Content="Sag Tika SwiftHub Ekle" Style="{StaticResource ActionBtn}" Background="#1E90FF" Grid.Column="0"/>
                                    <Button Name="BtnRemContext" Content="Kaldir" Style="{StaticResource ActionBtn}" Background="#4A0000" Grid.Column="1"/>
                                </Grid>
                            </StackPanel>
                        </Border>
                    </StackPanel>
                </Grid>

                <Grid Name="PageNet" Visibility="Hidden">
                    <StackPanel>
                        <TextBlock Name="TxtTitleNet" Text="🌐 AG VE SIBER GUVENLIK" FontSize="26" FontWeight="Black" Foreground="White" Margin="0,0,0,20"/>
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
                        <TextBlock Name="TxtTitleFix" Text="⛑️ SISTEM ONARIMI &amp; YEDEKLEME" FontSize="26" FontWeight="Black" Foreground="White" Margin="0,0,0,20"/>
                        <Grid Margin="0,0,0,15">
                            <Grid.ColumnDefinitions><ColumnDefinition Width="*"/><ColumnDefinition Width="*"/></Grid.ColumnDefinitions>
                            <Button Name="BtnQuickBackup" Content="🛡️ Sistem Yedegi Al (Hizli)" Style="{StaticResource ActionBtn}" Background="#1E90FF" Grid.Column="0"/>
                            <Button Name="BtnOpenRestore" Content="📂 Yedekleme Merkezini Ac (Geri Yukle)" Style="{StaticResource ActionBtn}" Background="#2D303B" Grid.Column="1"/>
                        </Grid>
                        <Button Name="BtnFixSFC" Content="Sistem Dosyalarini Onar (SFC &amp; DISM)" Style="{StaticResource ActionBtn}"/>
                        <Button Name="BtnFixWU" Content="Windows Update Bilesenlerini Sifirla" Style="{StaticResource ActionBtn}"/>
                        
                        <Grid Margin="0,0,0,0">
                            <Grid.ColumnDefinitions><ColumnDefinition Width="*"/><ColumnDefinition Width="*"/></Grid.ColumnDefinitions>
                            <Button Name="BtnFixTemp" Content="Temp ve Onbellegi Temizle" Style="{StaticResource ActionBtn}" Grid.Column="0"/>
                            <Button Name="BtnDeepClean" Content="☢️ Nukleer Disk Temizligi (Logs/Prefetch)" Style="{StaticResource ActionBtn}" Background="#FF3B30" Grid.Column="1"/>
                        </Grid>
                        
                        <Border Background="#13151A" BorderBrush="#1F222B" BorderThickness="1" CornerRadius="6" Height="130" Margin="5,10,5,0">
                            <ScrollViewer Margin="15"><TextBlock Name="TxtFixLog" Text="Onarim modulu hazir..." Foreground="#00FF66" FontFamily="Consolas"/></ScrollViewer>
                        </Border>
                    </StackPanel>
                </Grid>

                <Grid Name="PageRadar" Visibility="Hidden">
                    <StackPanel>
                        <TextBlock Text="📡 DERIN DONANIM RADARI (OMEGA TELEMETRY)" FontSize="26" FontWeight="Black" Foreground="#00CED1" Margin="0,0,0,15"/>
                        
                        <WrapPanel Orientation="Horizontal">
                            <Border Background="#13151A" BorderBrush="#1F222B" BorderThickness="1" CornerRadius="8" Width="340" Height="230" Margin="0,0,15,15" Padding="15">
                                <StackPanel>
                                    <TextBlock Text="İŞLEMCİ (CPU)" Foreground="#FF3366" FontWeight="Bold" FontSize="16" Margin="0,0,0,5"/>
                                    <TextBlock Name="TxtCpuName" Text="Okunuyor..." Foreground="#8A8D93" FontSize="12" Margin="0,0,0,15"/>
                                    
                                    <Grid Margin="0,0,0,8"><Grid.ColumnDefinitions><ColumnDefinition/><ColumnDefinition/></Grid.ColumnDefinitions>
                                        <TextBlock Text="Kullanım:" Foreground="White" Grid.Column="0"/><TextBlock Name="TxtCpuLoad" Text="% 0" Foreground="#00FF66" FontWeight="Bold" HorizontalAlignment="Right" Grid.Column="1"/>
                                    </Grid>
                                    <Grid Margin="0,0,0,8"><Grid.ColumnDefinitions><ColumnDefinition/><ColumnDefinition/></Grid.ColumnDefinitions>
                                        <TextBlock Text="Sıcaklık:" Foreground="White" Grid.Column="0"/><TextBlock Name="TxtCpuTemp" Text="0 °C" Foreground="#FF3B30" FontWeight="Bold" HorizontalAlignment="Right" Grid.Column="1"/>
                                    </Grid>
                                    <Grid Margin="0,0,0,8"><Grid.ColumnDefinitions><ColumnDefinition/><ColumnDefinition/></Grid.ColumnDefinitions>
                                        <TextBlock Text="Güç Tüketimi:" Foreground="White" Grid.Column="0"/><TextBlock Name="TxtCpuPower" Text="0 W" Foreground="#1E90FF" FontWeight="Bold" HorizontalAlignment="Right" Grid.Column="1"/>
                                    </Grid>
                                    <Grid><Grid.ColumnDefinitions><ColumnDefinition/><ColumnDefinition/></Grid.ColumnDefinitions>
                                        <TextBlock Text="Çekirdek Frekansı:" Foreground="White" Grid.Column="0"/><TextBlock Name="TxtCpuClock" Text="0 MHz" Foreground="White" FontWeight="Bold" HorizontalAlignment="Right" Grid.Column="1"/>
                                    </Grid>
                                </StackPanel>
                            </Border>

                            <Border Background="#13151A" BorderBrush="#1F222B" BorderThickness="1" CornerRadius="8" Width="340" Height="230" Margin="0,0,15,15" Padding="15">
                                <StackPanel>
                                    <TextBlock Text="EKRAN KARTI (GPU)" Foreground="#FF3366" FontWeight="Bold" FontSize="16" Margin="0,0,0,5"/>
                                    <TextBlock Name="TxtGpuName" Text="Okunuyor..." Foreground="#8A8D93" FontSize="12" Margin="0,0,0,15"/>
                                    
                                    <Grid Margin="0,0,0,8"><Grid.ColumnDefinitions><ColumnDefinition/><ColumnDefinition/></Grid.ColumnDefinitions>
                                        <TextBlock Text="Kullanım:" Foreground="White" Grid.Column="0"/><TextBlock Name="TxtGpuLoad" Text="% 0" Foreground="#00FF66" FontWeight="Bold" HorizontalAlignment="Right" Grid.Column="1"/>
                                    </Grid>
                                    <Grid Margin="0,0,0,8"><Grid.ColumnDefinitions><ColumnDefinition/><ColumnDefinition/></Grid.ColumnDefinitions>
                                        <TextBlock Text="Sıcaklık:" Foreground="White" Grid.Column="0"/><TextBlock Name="TxtGpuTemp" Text="0 °C" Foreground="#FF3B30" FontWeight="Bold" HorizontalAlignment="Right" Grid.Column="1"/>
                                    </Grid>
                                    <Grid Margin="0,0,0,8"><Grid.ColumnDefinitions><ColumnDefinition/><ColumnDefinition/></Grid.ColumnDefinitions>
                                        <TextBlock Text="VRAM Kullanımı:" Foreground="White" Grid.Column="0"/><TextBlock Name="TxtGpuVram" Text="0 / 0 MB" Foreground="#1E90FF" FontWeight="Bold" HorizontalAlignment="Right" Grid.Column="1"/>
                                    </Grid>
                                    <Grid><Grid.ColumnDefinitions><ColumnDefinition/><ColumnDefinition/></Grid.ColumnDefinitions>
                                        <TextBlock Text="Fan Hızı:" Foreground="White" Grid.Column="0"/><TextBlock Name="TxtGpuFan" Text="0 RPM" Foreground="White" FontWeight="Bold" HorizontalAlignment="Right" Grid.Column="1"/>
                                    </Grid>
                                </StackPanel>
                            </Border>

                            <Border Background="#13151A" BorderBrush="#1F222B" BorderThickness="1" CornerRadius="8" Width="340" Height="230" Margin="0,0,15,15" Padding="15">
                                <StackPanel>
                                    <TextBlock Text="BELLEK &amp; DEPOLAMA (I/O)" Foreground="#FF3366" FontWeight="Bold" FontSize="16" Margin="0,0,0,5"/>
                                    <TextBlock Text="RAM &amp; NVMe/SSD Durumu" Foreground="#8A8D93" FontSize="12" Margin="0,0,0,15"/>
                                    
                                    <Grid Margin="0,0,0,8"><Grid.ColumnDefinitions><ColumnDefinition/><ColumnDefinition/></Grid.ColumnDefinitions>
                                        <TextBlock Text="RAM Kullanımı:" Foreground="White" Grid.Column="0"/><TextBlock Name="TxtRamUsage" Text="0 / 0 GB" Foreground="#00FF66" FontWeight="Bold" HorizontalAlignment="Right" Grid.Column="1"/>
                                    </Grid>
                                    <Border BorderBrush="#1F222B" BorderThickness="0,1,0,0" Margin="0,5,0,10"/>
                                    <Grid Margin="0,0,0,8"><Grid.ColumnDefinitions><ColumnDefinition/><ColumnDefinition/></Grid.ColumnDefinitions>
                                        <TextBlock Text="Aktif Disk:" Foreground="White" Grid.Column="0"/><TextBlock Name="TxtDiskName" Text="Okunuyor..." Foreground="#8A8D93" FontWeight="Bold" HorizontalAlignment="Right" Grid.Column="1"/>
                                    </Grid>
                                    <Grid Margin="0,0,0,8"><Grid.ColumnDefinitions><ColumnDefinition/><ColumnDefinition/></Grid.ColumnDefinitions>
                                        <TextBlock Text="Disk Okuma Hızı:" Foreground="White" Grid.Column="0"/><TextBlock Name="TxtDiskRead" Text="0 MB/s" Foreground="#1E90FF" FontWeight="Bold" HorizontalAlignment="Right" Grid.Column="1"/>
                                    </Grid>
                                    <Grid><Grid.ColumnDefinitions><ColumnDefinition/><ColumnDefinition/></Grid.ColumnDefinitions>
                                        <TextBlock Text="Disk Yazma Hızı:" Foreground="White" Grid.Column="0"/><TextBlock Name="TxtDiskWrite" Text="0 MB/s" Foreground="#FF3B30" FontWeight="Bold" HorizontalAlignment="Right" Grid.Column="1"/>
                                    </Grid>
                                </StackPanel>
                            </Border>

                            <Border Background="#13151A" BorderBrush="#1F222B" BorderThickness="1" CornerRadius="8" Width="340" Height="230" Margin="0,0,15,15" Padding="15">
                                <StackPanel>
                                    <TextBlock Text="AĞ (NETWORK)" Foreground="#FF3366" FontWeight="Bold" FontSize="16" Margin="0,0,0,5"/>
                                    <TextBlock Name="TxtNetAdapter" Text="Bağdaştırıcı Aranıyor..." Foreground="#8A8D93" FontSize="12" Margin="0,0,0,15"/>
                                    
                                    <Grid Margin="0,0,0,8"><Grid.ColumnDefinitions><ColumnDefinition/><ColumnDefinition/></Grid.ColumnDefinitions>
                                        <TextBlock Text="Tahmini Max Hız:" Foreground="White" Grid.Column="0"/><TextBlock Name="TxtNetMax" Text="0 Mbps" Foreground="#00CED1" FontWeight="Bold" HorizontalAlignment="Right" Grid.Column="1"/>
                                    </Grid>
                                    <Border BorderBrush="#1F222B" BorderThickness="0,1,0,0" Margin="0,5,0,10"/>
                                    <Grid Margin="0,0,0,8"><Grid.ColumnDefinitions><ColumnDefinition/><ColumnDefinition/></Grid.ColumnDefinitions>
                                        <TextBlock Text="Anlık Download:" Foreground="White" Grid.Column="0"/><TextBlock Name="TxtNetDown" Text="0 KB/s" Foreground="#00FF66" FontWeight="Bold" HorizontalAlignment="Right" Grid.Column="1"/>
                                    </Grid>
                                    <Grid Margin="0,0,0,8"><Grid.ColumnDefinitions><ColumnDefinition/><ColumnDefinition/></Grid.ColumnDefinitions>
                                        <TextBlock Text="Anlık Upload:" Foreground="White" Grid.Column="0"/><TextBlock Name="TxtNetUp" Text="0 KB/s" Foreground="#1E90FF" FontWeight="Bold" HorizontalAlignment="Right" Grid.Column="1"/>
                                    </Grid>
                                    <Grid><Grid.ColumnDefinitions><ColumnDefinition/><ColumnDefinition/></Grid.ColumnDefinitions>
                                        <TextBlock Text="İndirilen Veri:" Foreground="White" Grid.Column="0"/><TextBlock Name="TxtNetTotal" Text="0 GB" Foreground="White" FontWeight="Bold" HorizontalAlignment="Right" Grid.Column="1"/>
                                    </Grid>
                                </StackPanel>
                            </Border>
                        </WrapPanel>
                    </StackPanel>
                </Grid>

                <Grid Name="PageInfo" Visibility="Hidden">
                    <Grid.RowDefinitions><RowDefinition Height="Auto"/><RowDefinition Height="*"/></Grid.RowDefinitions>
                    <TextBlock Name="TxtInfoTitle" Text="📖 SWIFTHUB KULLANIM REHBERI" FontSize="26" FontWeight="Black" Foreground="#00CED1" Margin="0,0,0,20" Grid.Row="0"/>
                    <Border Grid.Row="1" Background="#13151A" CornerRadius="8" Padding="20">
                        <ScrollViewer VerticalScrollBarVisibility="Auto">
                            <StackPanel>
                                <Border Background="#1F222B" CornerRadius="6" Padding="15" Margin="0,0,0,10"><TextBlock Name="TxtInfoApps" Text="..." Foreground="White" FontSize="15" TextWrapping="Wrap"/></Border>
                                <Border Background="#1F222B" CornerRadius="6" Padding="15" Margin="0,0,0,10"><TextBlock Name="TxtInfoTweaks" Text="..." Foreground="White" FontSize="15" TextWrapping="Wrap"/></Border>
                                <Border Background="#4A0000" CornerRadius="6" Padding="15" Margin="0,0,0,10"><TextBlock Name="TxtInfoDebloat" Text="..." Foreground="White" FontSize="15" TextWrapping="Wrap"/></Border>
                                <Border Background="#1F222B" CornerRadius="6" Padding="15" Margin="0,0,0,10"><TextBlock Name="TxtInfoNet" Text="..." Foreground="White" FontSize="15" TextWrapping="Wrap"/></Border>
                                <Border Background="#1F222B" CornerRadius="6" Padding="15" Margin="0,0,0,10"><TextBlock Name="TxtInfoFixes" Text="..." Foreground="White" FontSize="15" TextWrapping="Wrap"/></Border>
                            </StackPanel>
                        </ScrollViewer>
                    </Border>
                </Grid>

                <Border Grid.Row="1" Background="#13151A" CornerRadius="6" Padding="15,10" Margin="0,20,0,0">
                    <TextBlock Name="TxtStatus" Text="Omega Core hazir. Emrinizi bekliyor..." Foreground="#00CED1" FontFamily="Consolas" FontSize="13" FontWeight="Bold"/>
                </Border>
            </Grid>
        </Grid>
    </Border>
</Window>
"@

$reader = (New-Object System.Xml.XmlNodeReader $xaml); $window = [Windows.Markup.XamlReader]::Load($reader)

# --- ARAYUZ BINDING ---
$NavDash=$window.FindName("NavDash"); $NavApps=$window.FindName("NavApps"); $NavTweaks=$window.FindName("NavTweaks")
$NavFeatures=$window.FindName("NavFeatures"); $NavNet=$window.FindName("NavNet"); $NavFixes=$window.FindName("NavFixes"); $NavRadar=$window.FindName("NavRadar"); $NavInfo=$window.FindName("NavInfo")
$PageDash=$window.FindName("PageDash"); $PageApps=$window.FindName("PageApps"); $PageTweaks=$window.FindName("PageTweaks")
$PageFeatures=$window.FindName("PageFeatures"); $PageNet=$window.FindName("PageNet"); $PageFixes=$window.FindName("PageFixes"); $PageRadar=$window.FindName("PageRadar"); $PageInfo=$window.FindName("PageInfo")

$BtnExit=$window.FindName("BtnExit"); $BtnLangToggle=$window.FindName("BtnLangToggle"); $TxtStatus=$window.FindName("TxtStatus")
$TxtTitle=$window.FindName("TxtTitle"); $TxtSub=$window.FindName("TxtSub"); $TxtDashWelcome=$window.FindName("TxtDashWelcome"); $TxtDashSub=$window.FindName("TxtDashSub")
$TxtTitleNet=$window.FindName("TxtTitleNet"); $TxtTitleFix=$window.FindName("TxtTitleFix"); $TxtTitleFeat=$window.FindName("TxtTitleFeat")
$TxtSysInfo=$window.FindName("TxtSysInfo"); $TxtNetLog=$window.FindName("TxtNetLog"); $TxtFixLog=$window.FindName("TxtFixLog")
$TxtInfoTitle=$window.FindName("TxtInfoTitle"); $TxtInfoApps=$window.FindName("TxtInfoApps"); $TxtInfoTweaks=$window.FindName("TxtInfoTweaks")
$TxtInfoDebloat=$window.FindName("TxtInfoDebloat"); $TxtInfoNet=$window.FindName("TxtInfoNet"); $TxtInfoFixes=$window.FindName("TxtInfoFixes")

$BtnAnalyze=$window.FindName("BtnAnalyze"); $BtnWinUtil=$window.FindName("BtnWinUtil")
$TxtRadarCpu=$window.FindName("TxtRadarCpu"); $TxtRadarRam=$window.FindName("TxtRadarRam")
$TxtCpuName=$window.FindName("TxtCpuName"); $TxtCpuLoad=$window.FindName("TxtCpuLoad"); $TxtCpuTemp=$window.FindName("TxtCpuTemp"); $TxtCpuPower=$window.FindName("TxtCpuPower"); $TxtCpuClock=$window.FindName("TxtCpuClock")
$TxtGpuName=$window.FindName("TxtGpuName"); $TxtGpuLoad=$window.FindName("TxtGpuLoad"); $TxtGpuTemp=$window.FindName("TxtGpuTemp"); $TxtGpuVram=$window.FindName("TxtGpuVram"); $TxtGpuFan=$window.FindName("TxtGpuFan")
$TxtRamUsage=$window.FindName("TxtRamUsage"); $TxtDiskName=$window.FindName("TxtDiskName"); $TxtDiskRead=$window.FindName("TxtDiskRead"); $TxtDiskWrite=$window.FindName("TxtDiskWrite")
$TxtNetAdapter=$window.FindName("TxtNetAdapter"); $TxtNetMax=$window.FindName("TxtNetMax"); $TxtNetDown=$window.FindName("TxtNetDown"); $TxtNetUp=$window.FindName("TxtNetUp"); $TxtNetTotal=$window.FindName("TxtNetTotal")
$TxtPortSQL=$window.FindName("TxtPortSQL"); $TxtPortWeb=$window.FindName("TxtPortWeb"); $TxtPortDocker=$window.FindName("TxtPortDocker")
$BtnInstallApps=$window.FindName("BtnInstallApps"); $BtnApplyTweaks=$window.FindName("BtnApplyTweaks")
$BtnSpeedTest=$window.FindName("BtnSpeedTest"); $BtnDnsCloudflare=$window.FindName("BtnDnsCloudflare"); $BtnDnsGoogle=$window.FindName("BtnDnsGoogle"); $BtnDnsDefault=$window.FindName("BtnDnsDefault"); $BtnNetReset=$window.FindName("BtnNetReset")
$BtnFixSFC=$window.FindName("BtnFixSFC"); $BtnFixWU=$window.FindName("BtnFixWU"); $BtnFixTemp=$window.FindName("BtnFixTemp")
$BtnFeatWSL=$window.FindName("BtnFeatWSL"); $BtnFeatHyperV=$window.FindName("BtnFeatHyperV"); $BtnFeatSandbox=$window.FindName("BtnFeatSandbox"); $BtnFeatNet2=$window.FindName("BtnFeatNet2")
$BtnAppExport=$window.FindName("BtnAppExport"); $BtnAppImport=$window.FindName("BtnAppImport"); $BtnDebloat=$window.FindName("BtnDebloat")
$BtnTweakExport=$window.FindName("BtnTweakExport"); $BtnTweakImport=$window.FindName("BtnTweakImport")
$BtnQuickBackup=$window.FindName("BtnQuickBackup"); $BtnOpenRestore=$window.FindName("BtnOpenRestore")
$BtnUpdateAll=$window.FindName("BtnUpdateAll"); $BtnDeepClean=$window.FindName("BtnDeepClean")
$BtnAddContext=$window.FindName("BtnAddContext"); $BtnRemContext=$window.FindName("BtnRemContext")

$global:AppHeaders=@(); $global:AppItems=@(); $global:TweakHeaders=@(); $global:TweakItems=@()

# ==============================================================================
# 🚀 3. DINAMIK JSON MOTORU (GELISMIS YERELLESTIRME: NameTR / NameEN)
# ==============================================================================
try {
    $wcApps = New-Object System.Net.WebClient
    $wcApps.Encoding = [System.Text.Encoding]::UTF8
    $jsonResponseApps = $wcApps.DownloadString("https://raw.githubusercontent.com/cyberQbit/DevSwift/main/apps.json?t=$((Get-Date).Ticks)") | ConvertFrom-Json
    foreach ($cat in $jsonResponseApps.psobject.properties.name) {
        $header = New-Object System.Windows.Controls.TextBlock; $header.Foreground = "#00CED1"; $header.FontSize = 17; $header.FontWeight = "Bold"; $header.Margin = "0,15,0,10"
        $global:AppHeaders += [PSCustomObject]@{ UI=$header; TR=$jsonResponseApps."$cat".TR; EN=$jsonResponseApps."$cat".EN }; $window.FindName("PanelAppsContainer").Children.Add($header) | Out-Null
        $wp = New-Object System.Windows.Controls.WrapPanel; $wp.Margin = "0,0,0,10"
        
        foreach ($app in $jsonResponseApps."$cat".Items) {
            $cb = New-Object System.Windows.Controls.CheckBox
            # JSON'da NameTR varsa onu kullan, yoksa eski yapi (Name) uzerinden devam et
            $initialName = if ($app.NameTR) { $app.NameTR } else { $app.Name }
            $cb.Content = $initialName
            
            $global:AppItems += [PSCustomObject]@{ CheckBox=$cb; Id=$app.Id; TR=$app.NameTR; EN=$app.NameEN }
            $wp.Children.Add($cb) | Out-Null
        }
        $window.FindName("PanelAppsContainer").Children.Add($wp) | Out-Null
    }
} catch {}

try {
    $wcTweaks = New-Object System.Net.WebClient
    $wcTweaks.Encoding = [System.Text.Encoding]::UTF8
    $jsonResponseTweaks = $wcTweaks.DownloadString("https://raw.githubusercontent.com/cyberQbit/WinSwift/main/tweaks.json?t=$((Get-Date).Ticks)") | ConvertFrom-Json
    foreach ($cat in $jsonResponseTweaks.psobject.properties.name) {
        $header = New-Object System.Windows.Controls.TextBlock; $header.Foreground = "#FF3366"; $header.FontSize = 17; $header.FontWeight = "Bold"; $header.Margin = "0,15,0,10"
        $global:TweakHeaders += [PSCustomObject]@{ UI=$header; TR=$jsonResponseTweaks."$cat".TR; EN=$jsonResponseTweaks."$cat".EN }; $window.FindName("PanelTweaksContainer").Children.Add($header) | Out-Null
        $wp = New-Object System.Windows.Controls.WrapPanel; $wp.Margin = "0,0,0,10"
        
        foreach ($tweak in $jsonResponseTweaks."$cat".Items) {
            $cb = New-Object System.Windows.Controls.CheckBox
            # JSON'da NameTR varsa onu kullan, yoksa eski yapi (Name) uzerinden devam et
            $initialName = if ($tweak.NameTR) { $tweak.NameTR } else { $tweak.Name }
            $cb.Content = $initialName
            $cb.Width = 370
            
            $global:TweakItems += [PSCustomObject]@{ CheckBox=$cb; Script=$tweak.Script; TR=$tweak.NameTR; EN=$tweak.NameEN }
            $wp.Children.Add($cb) | Out-Null
        }
        $window.FindName("PanelTweaksContainer").Children.Add($wp) | Out-Null
    }
} catch {}

# --- 4. FONKSIYONLAR (Dinamik İsim Güncelleme) ---
function Update-Language {
    $d = $global:i18n[$global:CurrentLang]
    
    # Sabit Arayüz Metinleri
    $TxtTitle.Text=$d["AppTitle"]; $TxtSub.Text=$d["AppSub"]; $NavDash.Content=$d["MenuDash"]; $NavApps.Content=$d["MenuApps"]; $NavTweaks.Content=$d["MenuTweaks"]
    $NavFeatures.Content=$d["MenuFeatures"]; $NavNet.Content=$d["MenuNet"]; $NavFixes.Content=$d["MenuFixes"]; $NavInfo.Content=$d["MenuInfo"]
    $BtnLangToggle.Content=$d["BtnLang"]; $TxtStatus.Text=$d["StatusWait"]; $TxtDashWelcome.Text=$d["DashWelcome"]; $TxtDashSub.Text=$d["DashSub"]
    $BtnWinUtil.Content=$d["BtnWinUtil"]
    $BtnInstallApps.Content=$d["BtnInstall"]; $BtnApplyTweaks.Content=$d["BtnApply"]; $BtnAppExport.Content=$d["BtnExport"]; $BtnAppImport.Content=$d["BtnImport"]
    $BtnTweakExport.Content=$d["BtnExport"]; $BtnTweakImport.Content=$d["BtnImport"]; $BtnDebloat.Content=$d["BtnDebloat"]; $BtnRestore.Content=$d["BtnRestore"]
    $TxtTitleNet.Text=$d["TitleNet"]; $TxtTitleFix.Text=$d["TitleFix"]; $TxtTitleFeat.Text=$d["TitleFeat"]
    $BtnUpdateAll.Content=$d["BtnUpdateAll"]; $BtnDeepClean.Content=$d["BtnDeepClean"]; $BtnAddContext.Content=$d["BtnAddContext"]; $BtnRemContext.Content=$d["BtnRemContext"]
    $TxtInfoTitle.Text=$d["InfoTitle"]; $TxtInfoApps.Text=$d["InfoApps"]; $TxtInfoTweaks.Text=$d["InfoTweaks"]; $TxtInfoDebloat.Text=$d["InfoDebloat"]; $TxtInfoNet.Text=$d["InfoNet"]; $TxtInfoFixes.Text=$d["InfoFixes"]
    
    # JSON'dan Gelen Kategori Başlıklarını Çevir
    foreach ($h in $global:AppHeaders) { $h.UI.Text = $h."$($global:CurrentLang)" }
    foreach ($h in $global:TweakHeaders) { $h.UI.Text = $h."$($global:CurrentLang)" }
    
    # JSON'dan Gelen İçerikleri (CheckBox İsimlerini) Dinamik Çevir
    foreach ($i in $global:AppItems) { if ($i.TR -and $i.EN) { $i.CheckBox.Content = $i."$($global:CurrentLang)" } }
    foreach ($t in $global:TweakItems) { if ($t.TR -and $t.EN) { $t.CheckBox.Content = $t."$($global:CurrentLang)" } }
}

function Reset-Nav {
    $NavDash.Background="Transparent"; $NavDash.Foreground="#8A8D93"; $NavApps.Background="Transparent"; $NavApps.Foreground="#8A8D93"; $NavTweaks.Background="Transparent"; $NavTweaks.Foreground="#8A8D93"
    $NavFeatures.Background="Transparent"; $NavFeatures.Foreground="#8A8D93"; $NavNet.Background="Transparent"; $NavNet.Foreground="#8A8D93"; $NavFixes.Background="Transparent"; $NavFixes.Foreground="#8A8D93"; $NavRadar.Background="Transparent"; $NavRadar.Foreground="#8A8D93"; $NavInfo.Background="Transparent"; $NavInfo.Foreground="#00CED1"
    $PageDash.Visibility="Hidden"; $PageApps.Visibility="Hidden"; $PageTweaks.Visibility="Hidden"; $PageFeatures.Visibility="Hidden"; $PageNet.Visibility="Hidden"; $PageFixes.Visibility="Hidden"; $PageRadar.Visibility="Hidden"; $PageInfo.Visibility="Hidden"
}

# --- 5. EVENTLER ---
$BtnLangToggle.Add_Click({ if ($global:CurrentLang -eq "TR") { $global:CurrentLang = "EN" } else { $global:CurrentLang = "TR" }; Update-Language })
$BtnExit.Add_Click({ if ($global:computer) { $global:computer.Close() } $window.Close() })
$NavDash.Add_Click({ Reset-Nav; $NavDash.Background="#1F222B"; $NavDash.Foreground="White"; $PageDash.Visibility="Visible" })
$NavApps.Add_Click({ Reset-Nav; $NavApps.Background="#1F222B"; $NavApps.Foreground="White"; $PageApps.Visibility="Visible" })
$NavTweaks.Add_Click({ Reset-Nav; $NavTweaks.Background="#1F222B"; $NavTweaks.Foreground="White"; $PageTweaks.Visibility="Visible" })
$NavFeatures.Add_Click({ Reset-Nav; $NavFeatures.Background="#1F222B"; $NavFeatures.Foreground="White"; $PageFeatures.Visibility="Visible" })
$NavNet.Add_Click({ Reset-Nav; $NavNet.Background="#1F222B"; $NavNet.Foreground="White"; $PageNet.Visibility="Visible" })
$NavFixes.Add_Click({ Reset-Nav; $NavFixes.Background="#1F222B"; $NavFixes.Foreground="White"; $PageFixes.Visibility="Visible" })
$NavRadar.Add_Click({ Reset-Nav; $NavRadar.Background="#1F222B"; $NavRadar.Foreground="White"; $PageRadar.Visibility="Visible" })
$NavInfo.Add_Click({ Reset-Nav; $NavInfo.Background="#1F222B"; $NavInfo.Foreground="White"; $PageInfo.Visibility="Visible" })

# APP & UPDATE ALL
$BtnInstallApps.Add_Click({ $TxtStatus.Text="[*] Kurulum basladi..."; $window.Dispatcher.Invoke([Action]{},[Windows.Threading.DispatcherPriority]::Render); $c=0; foreach($i in $global:AppItems){if($i.CheckBox.IsChecked){try{Start-Process "winget" "-install --id $($i.Id) --accept-source-agreements --accept-package-agreements --silent" -Wait -NoNewWindow;$c++}catch{}}}; $TxtStatus.Text="[+] $c program kuruldu!" })
$BtnUpdateAll.Add_Click({ $TxtStatus.Text="[*] Bilgisayardaki tum programlar guncelleniyor. Bu islem uzun surebilir..."; $window.Dispatcher.Invoke([Action]{},[Windows.Threading.DispatcherPriority]::Render); Start-Process "winget" "upgrade --all --silent --accept-source-agreements --accept-package-agreements" -Wait -NoNewWindow; $TxtStatus.Text="[+] KUSURSUZ! Sistemdeki tum programlar son surume guncellendi." })
$BtnApplyTweaks.Add_Click({ $TxtStatus.Text="[*] Ayarlar enjekte ediliyor..."; $window.Dispatcher.Invoke([Action]{},[Windows.Threading.DispatcherPriority]::Render); $c=0; foreach($i in $global:TweakItems){if($i.CheckBox.IsChecked){try{Invoke-Expression $i.Script;$c++}catch{}}}; $TxtStatus.Text="[+] $c ayar uygulandi!" })
$BtnDebloat.Add_Click({ $TxtStatus.Text="[☢️] Nukleer Debloat basladi! (1-2 dk surebilir)..."; $window.Dispatcher.Invoke([Action]{},[Windows.Threading.DispatcherPriority]::Render); $bloatware=@("Microsoft.BingWeather","Microsoft.GetHelp","Microsoft.Getstarted","Microsoft.Microsoft3DViewer","Microsoft.MicrosoftOfficeHub","Microsoft.WindowsAlarms","Microsoft.WindowsCamera","microsoft.windowscommunicationsapps","Microsoft.WindowsFeedbackHub","Microsoft.WindowsMaps","Microsoft.WindowsSoundRecorder","Microsoft.XboxApp","Microsoft.XboxGamingOverlay","Microsoft.ZuneMusic","Microsoft.YourPhone"); $c=0; foreach($app in $bloatware){try{Get-AppxPackage -Name "*$app*" -AllUsers -ErrorAction SilentlyContinue|Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue;$c++}catch{}}; $TxtStatus.Text="[+] Debloat Bitti! $c cop paket silindi." })

# DERIN TELEMETRY (GENISLETILMIS GOD MODE)
$BtnAnalyze.Add_Click({
    $TxtSysInfo.Text="[!] Derin Donanim Telemetrisi Okunuyor... Lutfen Bekleyin..."; $window.Dispatcher.Invoke([Action]{},[Windows.Threading.DispatcherPriority]::Render);
    
    $os = Get-CimInstance Win32_OperatingSystem -ErrorAction SilentlyContinue
    $mb = Get-CimInstance Win32_BaseBoard -ErrorAction SilentlyContinue
    $bios = Get-CimInstance Win32_BIOS -ErrorAction SilentlyContinue
    $cpu = Get-CimInstance Win32_Processor -ErrorAction SilentlyContinue
    $rams = Get-CimInstance Win32_PhysicalMemory -ErrorAction SilentlyContinue
    $gpus = Get-CimInstance Win32_VideoController -ErrorAction SilentlyContinue
    $disks = Get-CimInstance Win32_DiskDrive -ErrorAction SilentlyContinue

    $info = "=========================================`n 🧬 DERIN SISTEM TELEMETRISI (GOD MODE) `n=========================================`n`n"
    
    $installDate = [management.managementDateTimeConverter]::ToDateTime($os.InstallDate).ToString("dd.MM.yyyy HH:mm")
    $uptime = [math]::Round(((Get-Date) - $os.LastBootUpTime).TotalHours, 1)

    $info += "[ISLETIM SISTEMI]`nModel           : $($os.Caption) $($os.OSArchitecture)`nSurum / Build   : Version $($os.Version) (Build $($os.BuildNumber))`nKurulum Tarihi  : $installDate`nSistem Calisma  : $uptime Saat`n`n"
    $info += "[ANAKART & BIOS]`nUretici & Model : $($mb.Manufacturer) $($mb.Product)`nSeri Numarasi   : $($mb.SerialNumber)`nBIOS Surumu     : $($bios.SMBIOSBIOSVersion) ($($bios.ReleaseDate.ToString('dd.MM.yyyy')))`n`n"
    $info += "[ISLEMCI (CPU)]`nModel           : $($cpu.Name)`nCekirdek / is   : $($cpu.NumberOfCores) Fiziksel / $($cpu.NumberOfLogicalProcessors) Mantiksal`nTaban Hizi      : $($cpu.MaxClockSpeed) MHz`nL2 / L3 Cache   : $($cpu.L2CacheSize) KB / $($cpu.L3CacheSize) KB`nSanallastirma   : $(if($cpu.VirtualizationFirmwareEnabled){'Aktif'}else{'Kapali'})`n`n"

    $ramGb = [math]::Round(($rams | Measure-Object Capacity -Sum).Sum / 1GB, 2)
    $info += "[BELLEK (RAM) - Toplam $ramGb GB]`n"
    foreach ($r in $rams) { $info += "Modul : $([math]::Round($r.Capacity/1GB,0)) GB | $($r.Speed) MHz | $($r.Manufacturer) | $($r.PartNumber)`n" }
    
    $info += "`n[GRAFIK KARTLARI (GPU)]`n"
    foreach ($g in $gpus) { $info += "Model         : $($g.Name)`nSurucu Surumu : $($g.DriverVersion)`nCozunurluk    : $($g.CurrentHorizontalResolution)x$($g.CurrentVerticalResolution) @ $($g.CurrentRefreshRate)Hz`n-" }
    
    $info += "`n`n[DEPOLAMA (DISK)]`n"
    foreach ($d in $disks) { $size = [math]::Round($d.Size / 1GB, 0); $info += "Surucu : $($d.Model) | $size GB | Partisyon: $($d.Partitions)`n" }

    $key=(Get-CimInstance -Query 'select * from SoftwareLicensingService' -ErrorAction SilentlyContinue).OA3xOriginalProductKey
    if([string]::IsNullOrWhiteSpace($key)){ $key="Bulunamadi (Dijital Lisans veya Retail)" }
    $info += "`n`n[🔑 GIZLI OEM LISANS AVI]`nAnakart Anahtari: $key`n"

    $TxtSysInfo.Text = $info
})

# CHRIS TITUS WINUTIL TETIKLEYICI
$BtnWinUtil.Add_Click({
    $TxtStatus.Text="[*] Aktivasyon aracı başlatılıyor... Lütfen açılan yeni terminal penceresini kontrol edin."; $window.Dispatcher.Invoke([Action]{},[Windows.Threading.DispatcherPriority]::Render);
    Start-Process "powershell.exe" -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"irm https://get.activated.win | iex`""
})

# CONTEXT MENU INTEGRATION
$BtnAddContext.Add_Click({ try { $reg = "HKCU:\Software\Classes\DesktopBackground\Shell\SwiftHub"; New-Item -Path $reg -Force | Out-Null; Set-ItemProperty -Path $reg -Name "Icon" -Value "powershell.exe"; Set-ItemProperty -Path $reg -Name "MUIVerb" -Value "🌌 SWIFTHUB CORE"; New-Item -Path "$reg\command" -Force | Out-Null; Set-ItemProperty -Path "$reg\command" -Name "(default)" -Value "powershell.exe -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -Command `"irm aydinaydmr.com.tr/core | iex`""; $TxtStatus.Text="[+] Sag Tika Eklendi! Masaustunde farenin sag tusuna basarak deneyin." } catch { $TxtStatus.Text="[X] Sag tik eklenemedi." } })
$BtnRemContext.Add_Click({ try { Remove-Item -Path "HKCU:\Software\Classes\DesktopBackground\Shell\SwiftHub" -Recurse -Force; $TxtStatus.Text="[+] Sag Tik menusunden kaldirildi." } catch {} })

# NUKLEER DEEP CLEAN (KUSURSUZ YAMA)
$BtnDeepClean.Add_Click({
    $TxtFixLog.Text = "[☢️] Nukleer Disk Temizligi devrede! Kilitli servisler durduruluyor...";
    $window.Dispatcher.Invoke([Action]{}, [Windows.Threading.DispatcherPriority]::Render)

    Stop-Service wuauserv -Force -ErrorAction SilentlyContinue
    Stop-Service bits -Force -ErrorAction SilentlyContinue
    Stop-Service SysMain -Force -ErrorAction SilentlyContinue

    wevtutil el | ForEach-Object { & wevtutil cl $_ 2>$null }

    Remove-Item "$env:windir\Prefetch\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item "$env:windir\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item "$env:windir\SoftwareDistribution\Download\*" -Recurse -Force -ErrorAction SilentlyContinue
    Clear-RecycleBin -Force -ErrorAction SilentlyContinue

    Start-Service wuauserv -ErrorAction SilentlyContinue
    Start-Service bits -ErrorAction SilentlyContinue
    Start-Service SysMain -ErrorAction SilentlyContinue

    $TxtFixLog.Text = "[+] NUKLEER TEMIZLIK BITTI! Kilitli dosyalar guvenle atlanip disk rahatlatildi."
})

# DIGER BUTONLAR
$BtnQuickBackup.Add_Click({ Enable-ComputerRestore -Drive "C:\" -ErrorAction SilentlyContinue; Checkpoint-Computer -Description "SwiftHub v8.4 Yedek" -RestorePointType "MODIFY_SETTINGS" -ErrorAction SilentlyContinue; $TxtStatus.Text="[+] Yedek alindi!" })
$BtnOpenRestore.Add_Click({ Start-Process "rstrui.exe" -ErrorAction SilentlyContinue })
$BtnAppExport.Add_Click({ $dlg=New-Object Microsoft.Win32.SaveFileDialog; $dlg.Filter="JSON Profile|*.json"; $dlg.FileName="SwiftHub_Apps.json"; if($dlg.ShowDialog() -eq $true){ $global:AppItems|Where{$_.CheckBox.IsChecked}|Select Id|ConvertTo-Json -Depth 10|Out-File $dlg.FileName -Encoding UTF8; $TxtStatus.Text="[+] Profil kaydedildi!" } })
$BtnAppImport.Add_Click({ $dlg=New-Object Microsoft.Win32.OpenFileDialog; $dlg.Filter="JSON Profile|*.json"; if($dlg.ShowDialog() -eq $true){ $j=Get-Content $dlg.FileName -Raw|ConvertFrom-Json; foreach($i in $global:AppItems){$i.CheckBox.IsChecked=$false; foreach($x in $j){if($i.Id -eq $x.Id){$i.CheckBox.IsChecked=$true}}}; $TxtStatus.Text="[+] Profil yuklendi!" } })
$BtnTweakExport.Add_Click({ $dlg=New-Object Microsoft.Win32.SaveFileDialog; $dlg.Filter="JSON Profile|*.json"; $dlg.FileName="SwiftHub_Tweaks.json"; if($dlg.ShowDialog() -eq $true){ $global:TweakItems|Where{$_.CheckBox.IsChecked}|Select Script|ConvertTo-Json -Depth 10|Out-File $dlg.FileName -Encoding UTF8; $TxtStatus.Text="[+] Profil kaydedildi!" } })
$BtnTweakImport.Add_Click({ $dlg=New-Object Microsoft.Win32.OpenFileDialog; $dlg.Filter="JSON Profile|*.json"; if($dlg.ShowDialog() -eq $true){ $j=Get-Content $dlg.FileName -Raw|ConvertFrom-Json; foreach($i in $global:TweakItems){$i.CheckBox.IsChecked=$false; foreach($x in $j){if($i.Script -eq $x.Script){$i.CheckBox.IsChecked=$true}}}; $TxtStatus.Text="[+] Profil yuklendi!" } })
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

# ==============================================================================
# 📡 HARDWARE MONITOR ENGINE (RAM INJECTION)
# ==============================================================================
$TxtStatus.Text = "[*] Donanim Radarlari (LHM) bellege yukleniyor..."

try {
    # DLL'i GitHub'dan Byte dizisi olarak al (Diske SIFIR temas)
    $lhmUrl = "https://raw.githubusercontent.com/cyberQbit/SwiftHub/main/LibreHardwareMonitorLib.dll"
    $dllBytes = (New-Object System.Net.WebClient).DownloadData($lhmUrl)
    
    # DLL'i dogrudan RAM uzerinden .NET Uygulama Alanina yukle (Reflection)
    [System.Reflection.Assembly]::Load($dllBytes) | Out-Null
    
    # Sensör bilgisayar objesini olustur ve aktif et
    $global:computer = New-Object LibreHardwareMonitor.Hardware.Computer
    $global:computer.IsCpuEnabled = $true
    $global:computer.IsGpuEnabled = $true
    $global:computer.IsMemoryEnabled = $true
    $global:computer.IsMotherboardEnabled = $true
    $global:computer.IsBatteryEnabled = $true
    $global:computer.Open()
    
    $global:RadarActive = $true
} catch {
    $TxtStatus.Text = "[X] Radar modulu yuklenemedi! Sadece arayuz acik kalacak."
    $global:RadarActive = $false
}

if ($global:RadarActive) {
    $lhmTimer = New-Object System.Windows.Threading.DispatcherTimer
    $lhmTimer.Interval = [TimeSpan]::FromSeconds(1.5)
    $lhmTimer.Add_Tick({
        if ($PageRadar.Visibility -ne "Visible") { return }

        foreach ($hardware in $global:computer.Hardware) {
            $hardware.Update()

            # --- CPU ---
            if ($hardware.HardwareType -match "Cpu") {
                $TxtCpuName.Text = $hardware.Name
                $cpuLoad = $null; $cpuTemp = $null; $cpuPwr = $null; $cpuClock = $null
                foreach ($sensor in $hardware.Sensors) {
                    if ($sensor.SensorType -eq "Load" -and $sensor.Name -eq "CPU Total") { $cpuLoad = $sensor.Value }
                    if ($sensor.SensorType -eq "Temperature" -and ($sensor.Name -match "Core \(Tctl/Tdie\)|Package")) { $cpuTemp = $sensor.Value }
                    if ($sensor.SensorType -eq "Power" -and $sensor.Name -eq "Package") { $cpuPwr = $sensor.Value }
                    if ($sensor.SensorType -eq "Clock" -and $sensor.Name -match "Core #1") { $cpuClock = $sensor.Value }
                }
                if ($cpuLoad -ne $null) { $TxtCpuLoad.Text = "% " + [math]::Round($cpuLoad, 1) }
                if ($cpuTemp -ne $null) { $TxtCpuTemp.Text = [math]::Round($cpuTemp, 0).ToString() + " °C" }
                if ($cpuPwr -ne $null)  { $TxtCpuPower.Text = [math]::Round($cpuPwr, 1).ToString() + " W" }
                if ($cpuClock -ne $null){ $TxtCpuClock.Text = [math]::Round($cpuClock, 0).ToString() + " MHz" }
            }

            # --- GPU ---
            if ($hardware.HardwareType -match "Gpu") {
                $TxtGpuName.Text = $hardware.Name
                $gpuLoad = $null; $gpuTemp = $null; $gpuFan = $null; $gpuVram = $null; $gpuVramTot = $null
                foreach ($sensor in $hardware.Sensors) {
                    if ($sensor.SensorType -eq "Load" -and $sensor.Name -eq "GPU Core") { $gpuLoad = $sensor.Value }
                    if ($sensor.SensorType -eq "Temperature" -and $sensor.Name -eq "GPU Core") { $gpuTemp = $sensor.Value }
                    if ($sensor.SensorType -eq "Fan" -and $sensor.Name -eq "GPU") { $gpuFan = $sensor.Value }
                    if ($sensor.SensorType -eq "SmallData" -and ($sensor.Name -match "GPU Memory Used|D3D Dedicated Memory Used")) { $gpuVram = $sensor.Value }
                    if ($sensor.SensorType -eq "SmallData" -and ($sensor.Name -match "GPU Memory Total")) { $gpuVramTot = $sensor.Value }
                }
                if ($gpuLoad -ne $null) { $TxtGpuLoad.Text = "% " + [math]::Round($gpuLoad, 1) }
                if ($gpuTemp -ne $null) { $TxtGpuTemp.Text = [math]::Round($gpuTemp, 0).ToString() + " °C" }
                if ($gpuFan -ne $null)  { $TxtGpuFan.Text = [math]::Round($gpuFan, 0).ToString() + " RPM" }
                
                # Eger ekran karti (dahili) RAM'i direkt paylasiyorsa ve VRAM sensoru yoksa:
                if ($gpuVram -ne $null) {
                    if ($gpuVramTot -ne $null) {
                        $TxtGpuVram.Text = ([math]::Round($gpuVram, 0).ToString() + " / " + [math]::Round($gpuVramTot, 0).ToString() + " MB")
                    } else {
                        $TxtGpuVram.Text = [math]::Round($gpuVram, 0).ToString() + " MB"
                    }
                } else { $TxtGpuVram.Text = "Paylasimli (N/A)" }
            }

            # --- RAM & STORAGE ---
            if ($hardware.HardwareType -match "Memory") {
                $ramUsed = $null; $ramAvail = $null
                foreach ($sensor in $hardware.Sensors) {
                    if ($sensor.SensorType -eq "Data" -and $sensor.Name -eq "Memory Used") { $ramUsed = $sensor.Value }
                    if ($sensor.SensorType -eq "Data" -and $sensor.Name -eq "Memory Available") { $ramAvail = $sensor.Value }
                }
                if ($ramUsed -ne $null -and $ramAvail -ne $null) {
                    $ramTotal = $ramUsed + $ramAvail
                    $TxtRamUsage.Text = ([math]::Round($ramUsed, 1).ToString() + " / " + [math]::Round($ramTotal, 1).ToString() + " GB")
                }
            }
            if ($hardware.HardwareType -match "Storage") {
                $TxtDiskName.Text = $hardware.Name
                $diskRead = 0; $diskWrite = 0
                foreach ($sensor in $hardware.Sensors) {
                    if ($sensor.SensorType -eq "Throughput" -and $sensor.Name -eq "Read Rate") { $diskRead = $sensor.Value }
                    if ($sensor.SensorType -eq "Throughput" -and $sensor.Name -eq "Write Rate") { $diskWrite = $sensor.Value }
                }
                $TxtDiskRead.Text = [math]::Round(($diskRead / 1MB), 2).ToString() + " MB/s"
                $TxtDiskWrite.Text = [math]::Round(($diskWrite / 1MB), 2).ToString() + " MB/s"
            }

            # --- NETWORK ---
            if ($hardware.HardwareType -match "Network") {
                $TxtNetAdapter.Text = $hardware.Name
                $netUp = 0; $netDown = 0; $netMax = $null; $netTotal = $null
                foreach ($sensor in $hardware.Sensors) {
                    if ($sensor.SensorType -eq "Throughput" -and $sensor.Name -eq "Upload Speed") { $netUp = $sensor.Value }
                    if ($sensor.SensorType -eq "Throughput" -and $sensor.Name -eq "Download Speed") { $netDown = $sensor.Value }
                    if ($sensor.SensorType -eq "Throughput" -and $sensor.Name -eq "Bandwidth") { $netMax = $sensor.Value }
                    if ($sensor.SensorType -eq "Data" -and $sensor.Name -eq "Data Downloaded") { $netTotal = $sensor.Value }
                }
                $TxtNetUp.Text = [math]::Round(($netUp / 1KB), 1).ToString() + " KB/s"
                $TxtNetDown.Text = [math]::Round(($netDown / 1KB), 1).ToString() + " KB/s"
                if ($netMax -ne $null) { $TxtNetMax.Text = [math]::Round(($netMax / 1MB), 0).ToString() + " Mbps" }
                if ($netTotal -ne $null) { $TxtNetTotal.Text = [math]::Round($netTotal, 2).ToString() + " GB" }
            }
        }
    })
    $lhmTimer.Start()
}

# ==============================================================================
# 📡 CANLI RADAR MOTORU (Zero-Footprint Telemetry)
# ==============================================================================

# WMI yerine sistemin en hizli sayaclari olan PerformanceCounter kullaniyoruz
$global:cpuCounter = New-Object System.Diagnostics.PerformanceCounter("Processor", "% Processor Time", "_Total")
$global:ramCounter = New-Object System.Diagnostics.PerformanceCounter("Memory", "Available MBytes")
$global:cpuCounter.NextValue() | Out-Null # Ilk degeri bosa okuyup onbellegi isitmak icin

# Asenkron Port Dinleyici Fonksiyon
function Check-LocalPort($port) {
    try {
        $tcp = New-Object System.Net.Sockets.TcpClient
        $result = $tcp.BeginConnect("127.0.0.1", $port, $null, $null)
        # Sadece 50 milisaniye bekle (Arayuzu kilitlememek icin ultra kisa timeout)
        $success = $result.AsyncWaitHandle.WaitOne([TimeSpan]::FromMilliseconds(50))
        if ($success) { $tcp.EndConnect($result); $tcp.Close(); return $true }
        return $false
    } catch { return $false }
}

$radarTimer = New-Object System.Windows.Threading.DispatcherTimer
$radarTimer.Interval = [TimeSpan]::FromSeconds(2)
$radarTimer.Add_Tick({
    # 1. CPU ve RAM Verilerini Cek
    $cpuVal = [math]::Round($global:cpuCounter.NextValue(), 0)
    $ramVal = [math]::Round($global:ramCounter.NextValue(), 0)
    
    $TxtRadarCpu.Text = "% $cpuVal"
    $TxtRadarRam.Text = "$ramVal MB"

    # Akilli Uyari: Eger CPU %85'i gecerse yaziyi Kirmizi yap!
    if ($cpuVal -gt 85) { $TxtRadarCpu.Foreground = "#FF3B30" } else { $TxtRadarCpu.Foreground = "White" }
    if ($ramVal -lt 1024) { $TxtRadarRam.Foreground = "#FF3B30" } else { $TxtRadarRam.Foreground = "White" }

    # 2. Kritik Portlari Dinle (Veritabani, API vb.)
    if (Check-LocalPort 1433) { $TxtPortSQL.Text = "🟢 MSSQL (1433)" } else { $TxtPortSQL.Text = "🔴 MSSQL (1433)" }
    if (Check-LocalPort 5000) { $TxtPortWeb.Text = "🟢 .NET API (5000)" } else { $TxtPortWeb.Text = "🔴 .NET API (5000)" }
    if (Check-LocalPort 2375) { $TxtPortDocker.Text = "🟢 Docker (2375)" } else { $TxtPortDocker.Text = "🔴 Docker (2375)" }
})
$radarTimer.Start()

Update-Language; $window.ShowDialog() | Out-Null