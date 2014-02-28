# Shamefully stolen from https://github.com/frimik/puppet-nfs
# refactored a bit

class nfs::client::redhat::service {

  Service {
    require => Class['nfs::client::redhat::configure']
  }
  if $::operatingsystem == 'Fedora'
      and $nfs::client::redhat::osmajor == 20 {
    $nfslock = 'nfs-lock'
  } else {
    $nfslock = 'nfslock'
  }
  service {$nfslock:
    ensure     => running,
    enable    => true,
    hasstatus => true,
    require => $nfs::client::redhat::osmajor ? {
      20 => Service["rpcbind"],
      6  => Service["rpcbind"],
      5  => [Package["portmap"], Package["nfs-utils"]]
    },
  }

  if $::operatingsystem != 'Fedora'
      or $nfs::client::redhat::osmajor != 20 {
    service { "netfs":
      enable  => true,
      require => $nfs::client::redhat::osmajor ? {
        6 => Service[$nfslock],
        5 => [Service["portmap"], Service[$nfslock]],
      },
    }
  }

  if $nfs::client::redhat::osmajor == 20 {
    service {"rpcbind":
      ensure    => running,
      enable    => true,
      hasstatus => true,
      require => [Package["rpcbind"], Package["nfs-utils"]],
    }
  } elsif $nfs::client::redhat::osmajor == 6 {
    service {"rpcbind":
      ensure    => running,
      enable    => true,
      hasstatus => true,
      require => [Package["rpcbind"], Package["nfs-utils"]],
    }
  } elsif $nfs::client::redhat::osmajor == 5 {
    service { "portmap":
      ensure    => running,
      enable    => true,
      hasstatus => true,
      require => [Package["portmap"], Package["nfs-utils"]],
    }
  } else {
    fail("unsupported nfs::client::redhat::osmajor: '${nfs::client::redhat::osmajor}'")
  }
  
}
