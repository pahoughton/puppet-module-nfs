class nfs::server::redhat::service {

  $service = $::operatingsystem ? {
    'Fedora' => 'nfs-server',
    default  => 'nfs',
  }
  if $nfs::server::redhat::nfs_v4 == true {
      service { $service :
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => true,
        require    => Package["nfs-utils"],
        subscribe  => [ Concat['/etc/exports'], Augeas['/etc/idmapd.conf'] ],
      }
    } else {
      service { $service :
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => true,
        require    => Package["nfs-utils"],
        subscribe  => Concat['/etc/exports'],
     }
  }
}
