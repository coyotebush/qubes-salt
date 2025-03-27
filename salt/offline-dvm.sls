{% if grains['id'] == 'dom0' %}
offline-dvm:
  qvm.vm:
    - present:
      - label: red
    - prefs:
      - label: red
      - template: fedora-41-custom
      - template_for_dispvms: true
      - netvm: ''
    - features:
      - enable:
        - appmenus-dispvm
      - set:
        - menu-items: 'thunar.desktop xfce4-terminal.desktop'
{% endif %}
