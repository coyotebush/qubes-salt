{% if grains['id'] == 'dom0' %}
offline-dvm:
  qvm.vm:
    - present:
      - label: red
    - prefs:
      - label: red
      - template: debian-12-custom
      - template_for_dispvms: true
      - netvm: ''
    - features:
      - enable:
        - appmenus-dispvm
      - set:
        - menu-items: 'gmtp.desktop thunar.desktop xfce4-terminal.desktop'
{% elif grains['id'] == 'debian-12-custom' %}
offline-dvm-packages:
  pkg.installed:
    - pkgs:
      - gimp
      - gmtp
      - inkscape
      - libimage-exiftool-perl
      - mpv
      - viking
{% endif %}
