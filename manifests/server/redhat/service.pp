class nfs::server::redhat::service {

  # FIXME Augeas['/etc/idmapd.conf']
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
        subscribe  => [ Concat['/etc/exports'], ],
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
