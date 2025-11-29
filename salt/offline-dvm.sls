{% set template = 'debian-13-custom' %}
{% if grains['id'] == 'dom0' %}
offline-dvm:
  qvm.vm:
    - present:
      - label: red
      - template: {{ template }}
    - prefs:
      - label: red
      - template: {{ template }}
      - template_for_dispvms: true
      - netvm: ''
    - features:
      - enable:
        - appmenus-dispvm
      - set:
        - menu-items: 'gmtp.desktop thunar.desktop xfce4-terminal.desktop'
{% elif grains['id'] == template %}
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
