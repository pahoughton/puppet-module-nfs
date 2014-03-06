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
      20 => Package["nfs-utils"],
      6  => Service["rpcbind"],
      5  => [Package["portmap"], Package["nfs-utils"]]
    },
  }

  service { "netfs":
    enable  => true,
    require => $nfs::client::redhat::osmajor ? {
      20 => Service[$nfslock],
      6 => Service[$nfslock],
      5 => [Service["portmap"], Service[$nfslock]],
    },
  }

  if $nfs::client::redhat::osmajor == 6 {
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
  }
}
