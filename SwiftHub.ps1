# ============================================================================
# 📡 OMEGA HARDWARE ENGINE (V4 - CONCURRENT DICTIONARY & TRACER)
# ============================================================================
try {
    $TxtStatus.Text = "[*] Omega Motoru: C# Multi-Thread Köprüsü Kuruluyor..."
    $window.Dispatcher.Invoke([Action]{},[Windows.Threading.DispatcherPriority]::Render)
    
    # 1. KIRILMAZ ORTAK BELLEK (C# ConcurrentDictionary - Runspace ve UI ayni anda okuyabilir)
    $global:RadarData = New-Object System.Collections.Concurrent.ConcurrentDictionary[string, string]
    $keys = @("CpuName", "CpuLoad", "CpuTemp", "CpuPower", "CpuClock", "GpuName", "GpuLoad", "GpuTemp", "GpuVram", "GpuFan", "RamUsage", "DiskName", "DiskRead", "DiskWrite", "NetDown", "NetUp", "NetTotal")
    foreach ($k in $keys) { $global:RadarData[$k] = "Okunuyor..." }
    $global:RadarData["CpuName"] = "Adım 1: Motor Başlatılıyor..."

    # 2. ÖLÜMSÜZ DİZİN VE GÜVENLİK
    $engineDir = "$env:PROGRAMDATA\cyberQbit\Engine"
    if (!(Test-Path $engineDir)) { New-Item -ItemType Directory -Force -Path $engineDir | Out-Null }
    $dllPath = "$engineDir\LibreHardwareMonitorLib.dll"

    if (!(Test-Path $dllPath)) {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        $lhmUrl = "https://raw.githubusercontent.com/cyberQbit/SwiftHub/main/LibreHardwareMonitorLib.dll"
        (New-Object System.Net.WebClient).DownloadFile($lhmUrl, $dllPath)
    }
    Unblock-File -Path $dllPath -ErrorAction SilentlyContinue

    # 3. AĞ MAX KAPASİTESİ
    $activeNet = Get-NetAdapter -ErrorAction SilentlyContinue | Where-Object { $_.Status -eq 'Up' -and $_.Virtual -eq $false } | Select-Object -First 1
    if ($activeNet) {
        $TxtNetAdapter.Text = $activeNet.InterfaceDescription
        $TxtNetMax.Text = "$([math]::Round($activeNet.Speed / 1000000, 0)) Mbps"
    }

    # 4. HAYALET İŞ PARÇACIĞI (BACKGROUND RUNSPACE)
    $bgRunspace = [runspacefactory]::CreateRunspace()
    $bgRunspace.ApartmentState = "STA"
    $bgRunspace.Open()

    $bgScript = {
        param($Data, $dllPath) # Veriyi direkt parametre olarak içeri zorluyoruz
        try {
            $Data["CpuName"] = "Adım 2: Kütüphaneler Yükleniyor..."
            Add-Type -AssemblyName System.Management
            [System.Reflection.Assembly]::LoadFrom($dllPath) | Out-Null

            $Data["CpuName"] = "Adım 3: Sensör Motoru (LHM) Kuruluyor..."
            $computer = New-Object LibreHardwareMonitor.Hardware.Computer
            $computer.IsCpuEnabled = $true
            $computer.IsGpuEnabled = $true
            $computer.IsMemoryEnabled = $true
            $computer.IsNetworkEnabled = $true
            $computer.IsStorageEnabled = $true
            
            $Data["CpuName"] = "Adım 4: Donanımlara Bağlanılıyor (LHM.Open)..."
            $computer.Open()

            if ($computer.Hardware.Count -eq 0) {
                $Data["CpuName"] = "HATA: Anti-Virüs/Core Isolation Engelledi!"
                return
            }

            $Data["CpuName"] = "Adım 5: Bağlantı Başarılı. Veriler Çekiliyor..."
            
            while ($true) {
                try {
                    foreach ($hw in $computer.Hardware) {
                        $hw.Update()
                        
                        if ($hw.HardwareType -match "Cpu") {
                            $Data["CpuName"] = $hw.Name
                            foreach ($sensor in $hw.Sensors) {
                                if ($sensor.SensorType.ToString() -eq "Load" -and $sensor.Name -eq "CPU Total") { $Data["CpuLoad"] = [math]::Round($sensor.Value, 1).ToString() }
                                if ($sensor.SensorType.ToString() -eq "Temperature" -and $sensor.Name -match "Package|Core") { $Data["CpuTemp"] = [math]::Round($sensor.Value, 0).ToString() }
                                if ($sensor.SensorType.ToString() -eq "Power" -and $sensor.Name -match "Package") { $Data["CpuPower"] = [math]::Round($sensor.Value, 1).ToString() }
                                if ($sensor.SensorType.ToString() -eq "Clock" -and $sensor.Name -match "Core #1|Bus") { $Data["CpuClock"] = [math]::Round($sensor.Value, 0).ToString() }
                            }
                        }
                        
                        if ($hw.HardwareType -match "Gpu") {
                            $Data["GpuName"] = $hw.Name
                            $vUsed = 0; $vTot = 0
                            foreach ($sensor in $hw.Sensors) {
                                if ($sensor.SensorType.ToString() -eq "Load" -and $sensor.Name -eq "GPU Core") { $Data["GpuLoad"] = [math]::Round($sensor.Value, 1).ToString() }
                                if ($sensor.SensorType.ToString() -eq "Temperature" -and $sensor.Name -eq "GPU Core") { $Data["GpuTemp"] = [math]::Round($sensor.Value, 0).ToString() }
                                if ($sensor.SensorType.ToString() -eq "Fan" -and $sensor.Name -eq "GPU") { $Data["GpuFan"] = [math]::Round($sensor.Value, 0).ToString() }
                                if ($sensor.SensorType.ToString() -eq "SmallData" -and $sensor.Name -eq "GPU Memory Used") { $vUsed = [math]::Round($sensor.Value, 0) }
                                if ($sensor.SensorType.ToString() -eq "SmallData" -and $sensor.Name -eq "GPU Memory Total") { $vTot = [math]::Round($sensor.Value, 0) }
                            }
                            if ($vTot -gt 0) { $Data["GpuVram"] = "$vUsed / $vTot MB" }
                        }

                        if ($hw.HardwareType -match "Memory") {
                            $rUsed = 0; $rAvail = 0
                            foreach ($sensor in $hw.Sensors) {
                                if ($sensor.SensorType.ToString() -eq "Data" -and $sensor.Name -eq "Memory Used") { $rUsed = $sensor.Value }
                                if ($sensor.SensorType.ToString() -eq "Data" -and $sensor.Name -eq "Memory Available") { $rAvail = $sensor.Value }
                            }
                            $Data["RamUsage"] = "$([math]::Round($rUsed, 1)) / $([math]::Round($rUsed+$rAvail, 1)) GB"
                        }

                        if ($hw.HardwareType -match "Storage") {
                            $Data["DiskName"] = $hw.Name
                            foreach ($sensor in $hw.Sensors) {
                                if ($sensor.SensorType.ToString() -eq "Throughput" -and $sensor.Name -eq "Read Rate") { $Data["DiskRead"] = [math]::Round($sensor.Value / 1048576, 2).ToString() }
                                if ($sensor.SensorType.ToString() -eq "Throughput" -and $sensor.Name -eq "Write Rate") { $Data["DiskWrite"] = [math]::Round($sensor.Value / 1048576, 2).ToString() }
                            }
                        }

                        if ($hw.HardwareType -match "Network") {
                            foreach ($sensor in $hw.Sensors) {
                                if ($sensor.SensorType.ToString() -eq "Throughput" -and $sensor.Name -eq "Download Speed") { $Data["NetDown"] = [math]::Round($sensor.Value / 1048576, 2).ToString() }
                                if ($sensor.SensorType.ToString() -eq "Throughput" -and $sensor.Name -eq "Upload Speed") { $Data["NetUp"] = [math]::Round($sensor.Value / 1048576, 2).ToString() }
                                if ($sensor.SensorType.ToString() -eq "Data" -and $sensor.Name -eq "Data Downloaded") { $Data["NetTotal"] = [math]::Round($sensor.Value, 2).ToString() }
                            }
                        }
                    }
                } catch { }
                Start-Sleep -Milliseconds 1000
            }
        } catch {
            $Data["CpuName"] = "MOTOR ÇÖKTÜ: $($_.Exception.Message)"
        }
    }
    
    $bgPowerShell = [powershell]::Create().AddScript($bgScript).AddArgument($global:RadarData).AddArgument($dllPath)
    $bgPowerShell.Runspace = $bgRunspace
    $global:bgHandle = $bgPowerShell.BeginInvoke()

    # 5. WPF ARAYÜZ GÜNCELLEYİCİSİ (Sözlükten okur)
    $radarTimer = New-Object System.Windows.Threading.DispatcherTimer
    $radarTimer.Interval = [TimeSpan]::FromMilliseconds(1000)
    $radarTimer.Add_Tick({
        if ($PageRadar.Visibility -ne "Visible") { return }

        $TxtCpuName.Text = $global:RadarData["CpuName"]
        $TxtCpuLoad.Text = "% " + $global:RadarData["CpuLoad"]
        $TxtCpuTemp.Text = $global:RadarData["CpuTemp"] + " °C"
        $TxtCpuPower.Text = $global:RadarData["CpuPower"] + " W"
        $TxtCpuClock.Text = $global:RadarData["CpuClock"] + " MHz"

        $TxtGpuName.Text = $global:RadarData["GpuName"]
        $TxtGpuLoad.Text = "% " + $global:RadarData["GpuLoad"]
        $TxtGpuTemp.Text = $global:RadarData["GpuTemp"] + " °C"
        $TxtGpuFan.Text = $global:RadarData["GpuFan"] + " RPM"
        $TxtGpuVram.Text = $global:RadarData["GpuVram"]

        $TxtRamUsage.Text = $global:RadarData["RamUsage"]
        
        $TxtDiskName.Text = $global:RadarData["DiskName"]
        $TxtDiskRead.Text = $global:RadarData["DiskRead"] + " MB/s"
        $TxtDiskWrite.Text = $global:RadarData["DiskWrite"] + " MB/s"

        $TxtNetDown.Text = $global:RadarData["NetDown"] + " MB/s"
        $TxtNetUp.Text = $global:RadarData["NetUp"] + " MB/s"
        $TxtNetTotal.Text = $global:RadarData["NetTotal"] + " GB"
    })
    $radarTimer.Start()

    $TxtStatus.Text = "[+] Omega Telemetry: Kusursuz Kokpit Modu Aktif!"

} catch {
    $TxtStatus.Text = "[X] RADAR HATASI: $($_.Exception.Message)"
}
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

# ============================================================================
# 📡 OMEGA HARDWARE ENGINE (V4 - CONCURRENT DICTIONARY & TRACER)
# ============================================================================
try {
    $TxtStatus.Text = "[*] Omega Motoru: C# Multi-Thread Köprüsü Kuruluyor..."
    $window.Dispatcher.Invoke([Action]{},[Windows.Threading.DispatcherPriority]::Render)
    
    # 1. KIRILMAZ ORTAK BELLEK (C# ConcurrentDictionary - Runspace ve UI ayni anda okuyabilir)
    $global:RadarData = New-Object System.Collections.Concurrent.ConcurrentDictionary[string, string]
    $keys = @("CpuName", "CpuLoad", "CpuTemp", "CpuPower", "CpuClock", "GpuName", "GpuLoad", "GpuTemp", "GpuVram", "GpuFan", "RamUsage", "DiskName", "DiskRead", "DiskWrite", "NetDown", "NetUp", "NetTotal")
    foreach ($k in $keys) { $global:RadarData[$k] = "Okunuyor..." }
    $global:RadarData["CpuName"] = "Adım 1: Motor Başlatılıyor..."

    # 2. ÖLÜMSÜZ DİZİN VE GÜVENLİK
    $engineDir = "$env:PROGRAMDATA\cyberQbit\Engine"
    if (!(Test-Path $engineDir)) { New-Item -ItemType Directory -Force -Path $engineDir | Out-Null }
    $dllPath = "$engineDir\LibreHardwareMonitorLib.dll"

    if (!(Test-Path $dllPath)) {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        $lhmUrl = "https://raw.githubusercontent.com/cyberQbit/SwiftHub/main/LibreHardwareMonitorLib.dll"
        (New-Object System.Net.WebClient).DownloadFile($lhmUrl, $dllPath)
    }
    Unblock-File -Path $dllPath -ErrorAction SilentlyContinue

    # 3. AĞ MAX KAPASİTESİ
    $activeNet = Get-NetAdapter -ErrorAction SilentlyContinue | Where-Object { $_.Status -eq 'Up' -and $_.Virtual -eq $false } | Select-Object -First 1
    if ($activeNet) {
        $TxtNetAdapter.Text = $activeNet.InterfaceDescription
        $TxtNetMax.Text = "$([math]::Round($activeNet.Speed / 1000000, 0)) Mbps"
    }

    # 4. HAYALET İŞ PARÇACIĞI (BACKGROUND RUNSPACE)
    $bgRunspace = [runspacefactory]::CreateRunspace()
    $bgRunspace.ApartmentState = "STA"
    $bgRunspace.Open()

    $bgScript = {
        param($Data, $dllPath) # Veriyi direkt parametre olarak içeri zorluyoruz
        try {
            $Data["CpuName"] = "Adım 2: Kütüphaneler Yükleniyor..."
            Add-Type -AssemblyName System.Management
            [System.Reflection.Assembly]::LoadFrom($dllPath) | Out-Null

            $Data["CpuName"] = "Adım 3: Sensör Motoru (LHM) Kuruluyor..."
            $computer = New-Object LibreHardwareMonitor.Hardware.Computer
            $computer.IsCpuEnabled = $true
            $computer.IsGpuEnabled = $true
            $computer.IsMemoryEnabled = $true
            $computer.IsNetworkEnabled = $true
            $computer.IsStorageEnabled = $true
            
            $Data["CpuName"] = "Adım 4: Donanımlara Bağlanılıyor (LHM.Open)..."
            $computer.Open()

            if ($computer.Hardware.Count -eq 0) {
                $Data["CpuName"] = "HATA: Anti-Virüs/Core Isolation Engelledi!"
                return
            }

            $Data["CpuName"] = "Adım 5: Bağlantı Başarılı. Veriler Çekiliyor..."
            
            while ($true) {
                try {
                    foreach ($hw in $computer.Hardware) {
                        $hw.Update()
                        
                        if ($hw.HardwareType -match "Cpu") {
                            $Data["CpuName"] = $hw.Name
                            foreach ($sensor in $hw.Sensors) {
                                if ($sensor.SensorType.ToString() -eq "Load" -and $sensor.Name -eq "CPU Total") { $Data["CpuLoad"] = [math]::Round($sensor.Value, 1).ToString() }
                                if ($sensor.SensorType.ToString() -eq "Temperature" -and $sensor.Name -match "Package|Core") { $Data["CpuTemp"] = [math]::Round($sensor.Value, 0).ToString() }
                                if ($sensor.SensorType.ToString() -eq "Power" -and $sensor.Name -match "Package") { $Data["CpuPower"] = [math]::Round($sensor.Value, 1).ToString() }
                                if ($sensor.SensorType.ToString() -eq "Clock" -and $sensor.Name -match "Core #1|Bus") { $Data["CpuClock"] = [math]::Round($sensor.Value, 0).ToString() }
                            }
                        }
                        
                        if ($hw.HardwareType -match "Gpu") {
                            $Data["GpuName"] = $hw.Name
                            $vUsed = 0; $vTot = 0
                            foreach ($sensor in $hw.Sensors) {
                                if ($sensor.SensorType.ToString() -eq "Load" -and $sensor.Name -eq "GPU Core") { $Data["GpuLoad"] = [math]::Round($sensor.Value, 1).ToString() }
                                if ($sensor.SensorType.ToString() -eq "Temperature" -and $sensor.Name -eq "GPU Core") { $Data["GpuTemp"] = [math]::Round($sensor.Value, 0).ToString() }
                                if ($sensor.SensorType.ToString() -eq "Fan" -and $sensor.Name -eq "GPU") { $Data["GpuFan"] = [math]::Round($sensor.Value, 0).ToString() }
                                if ($sensor.SensorType.ToString() -eq "SmallData" -and $sensor.Name -eq "GPU Memory Used") { $vUsed = [math]::Round($sensor.Value, 0) }
                                if ($sensor.SensorType.ToString() -eq "SmallData" -and $sensor.Name -eq "GPU Memory Total") { $vTot = [math]::Round($sensor.Value, 0) }
                            }
                            if ($vTot -gt 0) { $Data["GpuVram"] = "$vUsed / $vTot MB" }
                        }

                        if ($hw.HardwareType -match "Memory") {
                            $rUsed = 0; $rAvail = 0
                            foreach ($sensor in $hw.Sensors) {
                                if ($sensor.SensorType.ToString() -eq "Data" -and $sensor.Name -eq "Memory Used") { $rUsed = $sensor.Value }
                                if ($sensor.SensorType.ToString() -eq "Data" -and $sensor.Name -eq "Memory Available") { $rAvail = $sensor.Value }
                            }
                            $Data["RamUsage"] = "$([math]::Round($rUsed, 1)) / $([math]::Round($rUsed+$rAvail, 1)) GB"
                        }

                        if ($hw.HardwareType -match "Storage") {
                            $Data["DiskName"] = $hw.Name
                            foreach ($sensor in $hw.Sensors) {
                                if ($sensor.SensorType.ToString() -eq "Throughput" -and $sensor.Name -eq "Read Rate") { $Data["DiskRead"] = [math]::Round($sensor.Value / 1048576, 2).ToString() }
                                if ($sensor.SensorType.ToString() -eq "Throughput" -and $sensor.Name -eq "Write Rate") { $Data["DiskWrite"] = [math]::Round($sensor.Value / 1048576, 2).ToString() }
                            }
                        }

                        if ($hw.HardwareType -match "Network") {
                            foreach ($sensor in $hw.Sensors) {
                                if ($sensor.SensorType.ToString() -eq "Throughput" -and $sensor.Name -eq "Download Speed") { $Data["NetDown"] = [math]::Round($sensor.Value / 1048576, 2).ToString() }
                                if ($sensor.SensorType.ToString() -eq "Throughput" -and $sensor.Name -eq "Upload Speed") { $Data["NetUp"] = [math]::Round($sensor.Value / 1048576, 2).ToString() }
                                if ($sensor.SensorType.ToString() -eq "Data" -and $sensor.Name -eq "Data Downloaded") { $Data["NetTotal"] = [math]::Round($sensor.Value, 2).ToString() }
                            }
                        }
                    }
                } catch { }
                Start-Sleep -Milliseconds 1000
            }
        } catch {
            $Data["CpuName"] = "MOTOR ÇÖKTÜ: $($_.Exception.Message)"
        }
    }
    
    $bgPowerShell = [powershell]::Create().AddScript($bgScript).AddArgument($global:RadarData).AddArgument($dllPath)
    $bgPowerShell.Runspace = $bgRunspace
    $global:bgHandle = $bgPowerShell.BeginInvoke()

    # 5. WPF ARAYÜZ GÜNCELLEYİCİSİ (Sözlükten okur)
    $radarTimer = New-Object System.Windows.Threading.DispatcherTimer
    $radarTimer.Interval = [TimeSpan]::FromMilliseconds(1000)
    $radarTimer.Add_Tick({
        if ($PageRadar.Visibility -ne "Visible") { return }

        $TxtCpuName.Text = $global:RadarData["CpuName"]
        $TxtCpuLoad.Text = "% " + $global:RadarData["CpuLoad"]
        $TxtCpuTemp.Text = $global:RadarData["CpuTemp"] + " °C"
        $TxtCpuPower.Text = $global:RadarData["CpuPower"] + " W"
        $TxtCpuClock.Text = $global:RadarData["CpuClock"] + " MHz"

        $TxtGpuName.Text = $global:RadarData["GpuName"]
        $TxtGpuLoad.Text = "% " + $global:RadarData["GpuLoad"]
        $TxtGpuTemp.Text = $global:RadarData["GpuTemp"] + " °C"
        $TxtGpuFan.Text = $global:RadarData["GpuFan"] + " RPM"
        $TxtGpuVram.Text = $global:RadarData["GpuVram"]

        $TxtRamUsage.Text = $global:RadarData["RamUsage"]
        
        $TxtDiskName.Text = $global:RadarData["DiskName"]
        $TxtDiskRead.Text = $global:RadarData["DiskRead"] + " MB/s"
        $TxtDiskWrite.Text = $global:RadarData["DiskWrite"] + " MB/s"

        $TxtNetDown.Text = $global:RadarData["NetDown"] + " MB/s"
        $TxtNetUp.Text = $global:RadarData["NetUp"] + " MB/s"
        $TxtNetTotal.Text = $global:RadarData["NetTotal"] + " GB"
    })
    $radarTimer.Start()

    $TxtStatus.Text = "[+] Omega Telemetry: Kusursuz Kokpit Modu Aktif!"

} catch {
    $TxtStatus.Text = "[X] RADAR HATASI: $($_.Exception.Message)"
}
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
# 📡 OMEGA HARDWARE ENGINE (V3 - UNBREAKABLE KERNEL DROP & ASYNC RUNSPACE)
# ==============================================================================
try {
    $TxtStatus.Text = "[*] Omega Motoru: Kernel (Çekirdek) Bağlantısı Kuruluyor..."
    $window.Dispatcher.Invoke([Action]{},[Windows.Threading.DispatcherPriority]::Render)
    
    # 1. ORTAK BELLEK ALANI (Arayüz ve Arka Plan arası köprü)
    $global:RadarData = [hashtable]::Synchronized(@{
        CpuName="Donanım Aranıyor..."; CpuLoad="0"; CpuTemp="0"; CpuPower="0"; CpuClock="0"
        GpuName="Donanım Aranıyor..."; GpuLoad="0"; GpuTemp="0"; GpuVram="0 / 0 MB"; GpuFan="0"
        RamUsage="0 / 0 GB"; DiskName="Donanım Aranıyor..."; DiskRead="0"; DiskWrite="0"
        NetDown="0"; NetUp="0"; NetTotal="0"
    })

    # 2. ÖLÜMSÜZ DİZİN (Kullanıcının Temp temizlemesinden etkilenmez)
    $engineDir = "$env:PROGRAMDATA\cyberQbit\Engine"
    if (!(Test-Path $engineDir)) { New-Item -ItemType Directory -Force -Path $engineDir | Out-Null }
    $dllPath = "$engineDir\LibreHardwareMonitorLib.dll"

    # DLL yoksa güvenli bir şekilde indir
    if (!(Test-Path $dllPath)) {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        $lhmUrl = "https://raw.githubusercontent.com/cyberQbit/SwiftHub/main/LibreHardwareMonitorLib.dll"
        (New-Object System.Net.WebClient).DownloadFile($lhmUrl, $dllPath)
    }

    # EN KRİTİK NOKTA: Windows'un internetten inen dosyalara koyduğu "Mark of the Web" kilidini kır.
    # Bu olmazsa PowerShell güvenlik sebebiyle DLL'i çalıştıramaz ve çöker.
    Unblock-File -Path $dllPath -ErrorAction SilentlyContinue

    # 3. AĞ MAX KAPASİTESİ
    $activeNet = Get-NetAdapter -ErrorAction SilentlyContinue | Where-Object { $_.Status -eq 'Up' -and $_.Virtual -eq $false } | Select-Object -First 1
    if ($activeNet) {
        $TxtNetAdapter.Text = $activeNet.InterfaceDescription
        $TxtNetMax.Text = "$([math]::Round($activeNet.Speed / 1000000, 0)) Mbps"
    }

    # 4. HAYALET İŞ PARÇACIĞI (BACKGROUND RUNSPACE)
    $bgRunspace = [runspacefactory]::CreateRunspace()
    $bgRunspace.ApartmentState = "STA"
    $bgRunspace.ThreadOptions = "ReuseThread" # Stabiliteyi artırır
    $bgRunspace.Open()
    $bgRunspace.SessionStateProxy.SetVariable("RadarData", $global:RadarData)
    $bgRunspace.SessionStateProxy.SetVariable("dllPath", $dllPath)

    $bgPowerShell = [PowerShell]::Create()
    $bgPowerShell.Runspace = $bgRunspace
    [void]$bgPowerShell.AddScript({
        try {
            # WMI Kütüphanesini ve Unblock edilmiş DLL'i Kernel seviyesinde yükle
            Add-Type -AssemblyName System.Management
            [System.Reflection.Assembly]::LoadFrom($dllPath) | Out-Null

            $computer = New-Object LibreHardwareMonitor.Hardware.Computer
            $computer.IsCpuEnabled = $true
            $computer.IsGpuEnabled = $true
            $computer.IsMemoryEnabled = $true
            $computer.IsNetworkEnabled = $true
            $computer.IsStorageEnabled = $true
            $computer.Open()

            if ($computer.Hardware.Count -eq 0) {
                $RadarData.CpuName = "HATA: Anti-Virüs veya Core Isolation Sürücüyü Engelledi!"
            }

            while ($true) {
                try {
                    foreach ($hw in $computer.Hardware) {
                        $hw.Update()
                        
                        if ($hw.HardwareType -match "Cpu") {
                            $RadarData.CpuName = $hw.Name
                            foreach ($sensor in $hw.Sensors) {
                                if ($sensor.SensorType.ToString() -eq "Load" -and $sensor.Name -eq "CPU Total") { $RadarData.CpuLoad = [math]::Round($sensor.Value, 1).ToString() }
                                if ($sensor.SensorType.ToString() -eq "Temperature" -and $sensor.Name -match "Package|Core") { $RadarData.CpuTemp = [math]::Round($sensor.Value, 0).ToString() }
                                if ($sensor.SensorType.ToString() -eq "Power" -and $sensor.Name -match "Package") { $RadarData.CpuPower = [math]::Round($sensor.Value, 1).ToString() }
                                if ($sensor.SensorType.ToString() -eq "Clock" -and $sensor.Name -match "Core #1|Bus") { $RadarData.CpuClock = [math]::Round($sensor.Value, 0).ToString() }
                            }
                        }
                        
                        if ($hw.HardwareType -match "Gpu") {
                            $RadarData.GpuName = $hw.Name
                            $vUsed = 0; $vTot = 0
                            foreach ($sensor in $hw.Sensors) {
                                if ($sensor.SensorType.ToString() -eq "Load" -and $sensor.Name -eq "GPU Core") { $RadarData.GpuLoad = [math]::Round($sensor.Value, 1).ToString() }
                                if ($sensor.SensorType.ToString() -eq "Temperature" -and $sensor.Name -eq "GPU Core") { $RadarData.GpuTemp = [math]::Round($sensor.Value, 0).ToString() }
                                if ($sensor.SensorType.ToString() -eq "Fan" -and $sensor.Name -eq "GPU") { $RadarData.GpuFan = [math]::Round($sensor.Value, 0).ToString() }
                                if ($sensor.SensorType.ToString() -eq "SmallData" -and $sensor.Name -eq "GPU Memory Used") { $vUsed = [math]::Round($sensor.Value, 0) }
                                if ($sensor.SensorType.ToString() -eq "SmallData" -and $sensor.Name -eq "GPU Memory Total") { $vTot = [math]::Round($sensor.Value, 0) }
                            }
                            if ($vTot -gt 0) { $RadarData.GpuVram = "$vUsed / $vTot MB" }
                        }

                        if ($hw.HardwareType -match "Memory") {
                            $rUsed = 0; $rAvail = 0
                            foreach ($sensor in $hw.Sensors) {
                                if ($sensor.SensorType.ToString() -eq "Data" -and $sensor.Name -eq "Memory Used") { $rUsed = $sensor.Value }
                                if ($sensor.SensorType.ToString() -eq "Data" -and $sensor.Name -eq "Memory Available") { $rAvail = $sensor.Value }
                            }
                            $RadarData.RamUsage = "$([math]::Round($rUsed, 1)) / $([math]::Round($rUsed+$rAvail, 1)) GB"
                        }

                        if ($hw.HardwareType -match "Storage") {
                            $RadarData.DiskName = $hw.Name
                            foreach ($sensor in $hw.Sensors) {
                                if ($sensor.SensorType.ToString() -eq "Throughput" -and $sensor.Name -eq "Read Rate") { $RadarData.DiskRead = [math]::Round($sensor.Value / 1048576, 2).ToString() }
                                if ($sensor.SensorType.ToString() -eq "Throughput" -and $sensor.Name -eq "Write Rate") { $RadarData.DiskWrite = [math]::Round($sensor.Value / 1048576, 2).ToString() }
                            }
                        }

                        if ($hw.HardwareType -match "Network") {
                            foreach ($sensor in $hw.Sensors) {
                                if ($sensor.SensorType.ToString() -eq "Throughput" -and $sensor.Name -eq "Download Speed") { $RadarData.NetDown = [math]::Round($sensor.Value / 1048576, 2).ToString() }
                                if ($sensor.SensorType.ToString() -eq "Throughput" -and $sensor.Name -eq "Upload Speed") { $RadarData.NetUp = [math]::Round($sensor.Value / 1048576, 2).ToString() }
                                if ($sensor.SensorType.ToString() -eq "Data" -and $sensor.Name -eq "Data Downloaded") { $RadarData.NetTotal = [math]::Round($sensor.Value, 2).ToString() }
                            }
                        }
                    }
                } catch { }
                Start-Sleep -Milliseconds 1000
            }
        } catch {
            $RadarData.CpuName = "MOTOR ÇÖKTÜ: $($_.Exception.Message)"
        }
    })
    
    $global:bgHandle = $bgPowerShell.BeginInvoke()

    # 5. WPF ARAYÜZ GÜNCELLEYİCİSİ 
    $radarTimer = New-Object System.Windows.Threading.DispatcherTimer
    $radarTimer.Interval = [TimeSpan]::FromMilliseconds(1000)
    $radarTimer.Add_Tick({
        if ($PageRadar.Visibility -ne "Visible") { return }

        $TxtCpuName.Text = $global:RadarData.CpuName
        $TxtCpuLoad.Text = "% " + $global:RadarData.CpuLoad
        $TxtCpuTemp.Text = $global:RadarData.CpuTemp + " °C"
        $TxtCpuPower.Text = $global:RadarData.CpuPower + " W"
        $TxtCpuClock.Text = $global:RadarData.CpuClock + " MHz"

        $TxtGpuName.Text = $global:RadarData.GpuName
        $TxtGpuLoad.Text = "% " + $global:RadarData.GpuLoad
        $TxtGpuTemp.Text = $global:RadarData.GpuTemp + " °C"
        $TxtGpuFan.Text = $global:RadarData.GpuFan + " RPM"
        $TxtGpuVram.Text = $global:RadarData.GpuVram

        $TxtRamUsage.Text = $global:RadarData.RamUsage
        
        $TxtDiskName.Text = $global:RadarData.DiskName
        $TxtDiskRead.Text = $global:RadarData.DiskRead + " MB/s"
        $TxtDiskWrite.Text = $global:RadarData.DiskWrite + " MB/s"

        $TxtNetDown.Text = $global:RadarData.NetDown + " MB/s"
        $TxtNetUp.Text = $global:RadarData.NetUp + " MB/s"
        $TxtNetTotal.Text = $global:RadarData.NetTotal + " GB"
    })
    $radarTimer.Start()

    $TxtStatus.Text = "[+] Omega Telemetry: Kusursuz Kokpit Modu Aktif!"

} catch {
    $TxtStatus.Text = "[X] RADAR HATASI: $($_.Exception.Message)"
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