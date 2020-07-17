# @summary An example to check and set the registry value
# class profile::avc_sec::reg_test
class profile::avc_sec::reg_test {
#Check if the server group is a XenApp Memeber and execute the powershell command
if $::server_group == 'Citrix XenApp Member' {
case $::kernelmajversion {
  '10.0': {
    if $::spi == '600' {
      notify {'Idle Time Matches ISCC Standards':}
    }   else {
          registry_value { 'SpecialPollInterval':
          ensure => present,
          path   => 'HKLM:\SOFTWARE\Policies\Microsoft\W32time\TimeProviders\NtpClient\SpecialPollInterval',
          type   => dword,
          data   => 600,
        } notify { 'Updated Idle Time as per ISCC Sandards':}
    }
  }
  default: {
        notify{'Not a Windows / Citrix Server':}
      }
    }
  }
}
