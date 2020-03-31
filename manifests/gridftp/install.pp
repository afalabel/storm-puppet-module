# @summary StoRM GridFTP install class
#
class storm::gridftp::install (

) {

  # Based on storm-globus-gridftp-mp required rpms
  $required = [
    'fetch-crl',
    'edg-mkgridmap',
    'lcas',
    'lcas-plugins-basic',
    'lcas-plugins-voms',
    'lcmaps',
    'lcmaps-plugins-basic',
    'lcmaps-without-gsi',
    'lcmaps-plugins-voms',
    'lcas-lcmaps-gt4-interface',
    'lcg-expiregridmapdir',
    'cleanup-grid-accounts',
  ]
  package { $required:
    ensure => installed,
  }

  package { 'storm-globus-gridftp-server':
    ensure => installed,
  }

}
