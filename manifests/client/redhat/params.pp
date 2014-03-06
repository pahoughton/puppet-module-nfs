# Shamefully stolen from https://github.com/frimik/puppet-nfs
# refactored a bit

class nfs::client::redhat::params {

  if versioncmp($::operatingsystemrelease, "20") == 0 {
    $osmajor = 20
  } elsif versioncmp($::operatingsystemrelease, "6.0") > 0 {
    $osmajor = 6
  } elsif versioncmp($::operatingsystemrelease, "5.0") > 0 {
    $osmajor = 5
  } else {
    fail("unsupported operatingsystemrelease $::operatingsystemrelease")
  }
}


