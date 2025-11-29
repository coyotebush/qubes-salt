{% if grains['id'] == 'dom0' %}
debian-13-xfce:
  qvm.template_installed

debian-13-custom:
  qvm.clone:
    - source: debian-13-xfce
    - require:
      - qvm: debian-13-xfce

{% elif grains['id'] == 'debian-13-custom' %}
# Packages used in unmanaged qubes
debian-packages:
  pkg.installed:
    - pkgs:
      - exfat-fuse
      - galculator
      - gimp
      - git
      - gnucash
      - graphviz
      - hledger
      - jq
      - libdbd-sqlite3
      - libreoffice-calc
      - mpv
      - qubes-app-shutdown-idle
      - shotwell
      - viking
'/etc/apt/sources.list.d/backports.list':
  file.managed:
    - makedirs: true
    - contents: 'deb https://deb.debian.org/debian trixie-backports main'
josm:
  pkg.installed:
    - fromrepo: trixie-backports
    - require:
      - file: '/etc/apt/sources.list.d/backports.list'
{% endif %}
