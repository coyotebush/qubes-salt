{% if grains['id'] == 'dom0' %}
debian-12-xfce:
  qvm.template_installed

debian-12-custom:
  qvm.clone:
    - source: debian-12-xfce
    - require:
      - qvm: debian-12-xfce

{% elif grains['id'] == 'debian-12-custom' %}
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
josm:
  pkg.installed:
    - fromrepo: bookworm-backports
{% endif %}
