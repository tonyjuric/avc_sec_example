# @summary An example to check and set the registry value
# including paranmetrs for the spi timer setting
# class profile::avc_sec::spi_test
class profile::avc_sec::spi_test (
  String $spi_timer = '600',
){
#Check if the server group is a XenApp Memeber and execute the powershell command
if $::server_group == 'Citrix XenApp Member' {
case $::kernelmajversion {
  '10.0': {
    if $::spi == $spi_timer {
      notify {'Idle Time Matches ISCC Standards':}
    } else {
      registry_value { 'SpecialPollInterval':
        ensure => present,
        path   => 'HKLM:\SOFTWARE\Policies\Microsoft\W32time\TimeProviders\NtpClient\SpecialPollInterval',
        type   => dword,
        data   => Integer($spi_timer),
      } notify { 'Updated Idle Time as per ISCC Standards':}
    }
  }
  default: {
        notify{'Not a Windows / Citrix Server':}
      }
    }
  }
}
