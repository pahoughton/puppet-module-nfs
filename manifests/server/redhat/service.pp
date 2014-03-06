class nfs::server::redhat::service {

  # FIXME Augeas['/etc/idmapd.conf']
  if $nfs::server::redhat::nfs_v4 == true {
      service {"nfs":
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => true,
        require    => Package["nfs-utils"],
        subscribe  => [ Concat['/etc/exports'], ],
      }
    } else {
      service {"nfs":
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => true,
        require    => Package["nfs-utils"],
        subscribe  => Concat['/etc/exports'],
     }
  }
}
