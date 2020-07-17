# powershell script for loading external facts
$x = get-service Spooler
$status = "Spooler="+$x.Status
write-host $status
$spi = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\W32time\TimeProviders\NtpClient").SpecialPollInterval
$spi_status = "SPI="+$spi
write-host $spi_status
