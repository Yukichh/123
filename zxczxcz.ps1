Add-Type -AssemblyName System.Windows.Forms

$icon = "Pudge.ico" 

$form1 = New-Object System.Windows.Forms.Form
$form1.Size = New-Object System.Drawing.Size(300,300)
$form1.Text = "Pudge"
$form1.StartPosition = "CenterScreen"
$form1.BackColor = "Black"
$form1.Icon = New-Object System.Drawing.Icon($icon)

$form2 = New-Object System.Windows.Forms.Form
$form2.Size = New-Object System.Drawing.Size(300, 200)
$form2.Text = "Pudge"
$form2.StartPosition = "CenterScreen"
$form2.BackColor = "Black"
$form2.Icon = New-Object System.Drawing.Icon($icon)

$form3 = New-Object System.Windows.Forms.Form
$form3.Size = New-Object System.Drawing.Size(300, 200)
$form3.Text = "Pudge"
$form3.StartPosition = "CenterScreen"
$form3.BackColor = "Black"
$form3.Icon = New-Object System.Drawing.Icon($icon)

$label1 = New-Object System.Windows.Forms.Label
$label1.Location = New-Object System.Drawing.Point(20, 37)
$label1.Size = New-Object System.Drawing.Size(100, 20)
$label1.Font = New-Object System.Drawing.Font("Arial", 10)
$label1.ForeColor = "White"
$label1.Text = "IP:"

$label2 = New-Object System.Windows.Forms.Label
$label2.Location = New-Object System.Drawing.Point(20, 67)
$label2.Size = New-Object System.Drawing.Size(100, 20)
$label2.Font = New-Object System.Drawing.Font("Arial", 10)
$label2.ForeColor = "White"
$label2.Text = "Port:"

$label3 = New-Object System.Windows.Forms.Label
$label3.Location = New-Object System.Drawing.Point(10, 37)
$label3.Size = New-Object System.Drawing.Size(100, 20)
$label3.Font = New-Object System.Drawing.Font("Arial", 10)
$label3.ForeColor = "White"
$label3.Text = "Username:"

$label4 = New-Object System.Windows.Forms.Label
$label4.Location = New-Object System.Drawing.Point(10, 67)
$label4.Size = New-Object System.Drawing.Size(100, 20)
$label4.Font = New-Object System.Drawing.Font("Arial", 10)
$label4.ForeColor = "White"
$label4.Text = "Password:"

$textBox1 = New-Object System.Windows.Forms.TextBox
$textBox1.Location = New-Object System.Drawing.Point(50, 30)
$textBox1.Size = New-Object System.Drawing.Size(200, 20)
$form2.Controls.Add($textBox1)

$textBox2 = New-Object System.Windows.Forms.TextBox
$textBox2.Location = New-Object System.Drawing.Point(50, 60)
$textBox2.Size = New-Object System.Drawing.Size(200, 20)
$form2.Controls.Add($textBox2)

$textBox3 = New-Object System.Windows.Forms.TextBox
$textBox3.Location = New-Object System.Drawing.Point(100, 30)
$textBox3.Size = New-Object System.Drawing.Size(150, 20)
$form3.Controls.Add($textBox3)

$textBox4 = New-Object System.Windows.Forms.TextBox
$textBox4.Location = New-Object System.Drawing.Point(100, 60)
$textBox4.Size = New-Object System.Drawing.Size(150, 20)
$form3.Controls.Add($textBox4)

$buttonLeft = ($form1.Width - 95) / 2

$button1 = New-Object System.Windows.Forms.Button
$button1.Text = "Create User"
$button1.Location = New-Object System.Drawing.Point($buttonLeft,60)
$button1.Size = New-Object System.Drawing.Size(95,23)
$button1.ForeColor = "White"
$button1.BackColor = "Gray"
$button1.Add_Click({
    $form3.ShowDialog()
})

$button7 = New-Object System.Windows.Forms.Button
$button7.Text = "Create User"
$button7.Location = New-Object System.Drawing.Point(100, 100)
$button7.Size = New-Object System.Drawing.Size(100, 30)
$button7.ForeColor = "White"
$button7.BackColor = "Gray"
$button7.Add_Click({
    $localUser = $textBox3.Text
    $localPassword = $textBox4.Text
    New-LocalUser -Name $localUser -Password $localPassword -NoPasswordExpiration
    [System.Windows.Forms.MessageBox]::Show("New user created")
})

$button2 = New-Object System.Windows.Forms.Button
$button2.Text = "Test"
$button2.Location = New-Object System.Drawing.Point($buttonLeft,90)
$button2.Size = New-Object System.Drawing.Size(95,23)
$button2.ForeColor = "White"
$button2.BackColor = "Gray"
$button2.Add_Click({
    $cpuInfo1 = Get-CimInstance -ClassName Win32_Processor | Select-Object Name, NumberOfCores | Out-String
    $cpuInfo2 = Get-CimInstance -ClassName Win32_Processor | Select-Object Manufacturer | Out-String
    $motherboardInfo = Get-CimInstance -ClassName Win32_BaseBoard | Select-Object Manufacturer, Product | Out-String
    $gpuInfo = Get-CimInstance -ClassName Win32_VideoController | Select-Object Name, @{Name="AdapterRAM (GB)"; Expression={[math]::Round($_.AdapterRAM / 1GB)}} | Out-String
    $ramInfo = Get-CimInstance -ClassName Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum | Select-Object @{Name="TotalRAM(GB)"; Expression={[math]::Round($_.Sum / 1GB, 2)}} | Out-String

    $hardwareInfo = $cpuInfo1, $cpuInfo2, $motherboardInfo, $gpuInfo, $ramInfo
    [System.Windows.Forms.MessageBox]::Show($hardwareInfo, "Hardware Information")
})

$button3 = New-Object System.Windows.Forms.Button
$button3.Text = "Status Service"
$button3.Location = New-Object System.Drawing.Point($buttonLeft,120)
$button3.Size = New-Object System.Drawing.Size(95,23)
$button3.ForeColor = "White"
$button3.BackColor = "Gray"
$button3.Add_Click({
    # Script
})

$button4 = New-Object System.Windows.Forms.Button
$button4.Text = "Scan Ports"
$button4.Location = New-Object System.Drawing.Point($buttonLeft,150)
$button4.Size = New-Object System.Drawing.Size(95,23)
$button4.ForeColor = "White"
$button4.BackColor = "Gray"
$button4.Add_Click({
    $form2.ShowDialog()
})

$button5 = New-Object System.Windows.Forms.Button
$button5.Location = New-Object System.Drawing.Point(100, 100)
$button5.Size = New-Object System.Drawing.Size(100, 30)
$button5.Text = "Scan"
$button5.ForeColor = "White"
$button5.BackColor = "Gray"
$button5.Add_Click({
    $ip = $textBox1.Text
    $port = $textBox2.Text
    $ErrorActionPreference= "silentlycontinue"

    $go = if (Test-Connection -BufferSize 32 -Count 1 -quiet -ComputerName $ip) {
        $socket = new-object System.Net.Sockets.TcpClient($ip, $port)
        if ($socket.Connected) {
            [System.Windows.Forms.MessageBox]::Show("TCP port $port at $ip is open")
            $socket.Close()
        } else {
            [System.Windows.Forms.MessageBox]::Show("TCP port $port at $ip is not open")
        }
    }
})

$button6 = New-Object System.Windows.Forms.Button
$button6.Text = "Firewall On/Off"
$button6.Location = New-Object System.Drawing.Point($buttonLeft,180)
$button6.Size = New-Object System.Drawing.Size(95,23)
$button6.ForeColor = "White"
$button6.BackColor = "Gray"
$button6.Add_Click({
    $isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    if (-not $isAdmin) {
        [System.Windows.Forms.MessageBox]::Show("Administrator rights are required to run this script.")
    }
    else {
        $firewall = Get-NetFirewallProfile | Select-Object -Property Enabled
        if ($firewall.Enabled -eq "True") {
            Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
            [System.Windows.Forms.MessageBox]::Show("Disabled")
        } else {
            Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True
            [System.Windows.Forms.MessageBox]::Show("Enabled")
        }
    }
})

$form1.Controls.Add($button1)
$form3.Controls.Add($label3)
$form3.Controls.Add($label4)
$form3.Controls.Add($button7)
$form1.Controls.Add($button2)
$form1.Controls.Add($button3)
$form1.Controls.Add($button4)
$form2.Controls.Add($label1)
$form2.Controls.Add($label2)
$form2.Controls.Add($button5)
$form1.Controls.Add($button6)

$form1.ShowDialog()