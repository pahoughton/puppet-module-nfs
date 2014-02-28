# Shamefully stolen from https://github.com/frimik/puppet-nfs
# refactored a bit

class nfs::client::redhat::install {

  Package {
    before => Class['nfs::client::redhat::configure']
  }
  package { 'nfs-utils':
    ensure => present,
  }

  if $nfs::client::redhat::osmajor == 6
      or $nfs::client::redhat::osmajor == 20 {
    package {'rpcbind':
      ensure => present,
    }
  } elsif $nfs::client::redhat::osmajor == 5 {
    package { 'portmap':
      ensure => present,
    }
  } else {
    fail("unsupported nfs::client::redhat::osmajor: '${nfs::client::redhat::osmajor}'")
  }
}
