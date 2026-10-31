{% if grains['id'] == 'dom0' %}
fedora-44-xfce:
  qvm.template_installed

fedora-xfce-skip-update-backup:
  qvm.vm:
    - name: fedora-44-xfce
    - prefs:
      - include_in_backups: false
    - features:
      - enable:
        - skip-update

fedora-44-custom:
  qvm.clone:
    - source: fedora-44-xfce

fedora-custom-update-backup:
  qvm.vm:
    - name: fedora-44-custom
    - prefs:
      - include_in_backups: true
    - features:
      - disable:
        - skip-update

{% elif grains['id'] == 'fedora-44-custom' %}
# Packages used in unmanaged qubes
fedora-packages:
  pkg.installed:
    - pkgs:
      - qubes-app-shutdown-idle
      - qubes-ctap
      - qubes-distro-keys
      - qubes-video-companion
      - task
      - tasksh
      - viking
'qubes-ctapproxy@sys-audio.service':
  service.enabled:
    - require:
      - pkg: fedora-packages
'qubes-ctapproxy@sys-usb.service':
  service.disabled:
    - require:
      - pkg: fedora-packages
{% endif %}
