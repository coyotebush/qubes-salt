{% if grains['id'] == 'dom0' %}
fedora-43-xfce:
  qvm.template_installed

fedora-xfce-skip-update:
  qvm.features:
    - name: fedora-43-xfce
    - enable:
      - skip-update

fedora-43-custom:
  qvm.clone:
    - source: fedora-43-xfce

fedora-custom-update:
  qvm.features:
    - name: fedora-43-custom
    - disable:
      - skip-update

{% elif grains['id'] == 'fedora-43-custom' %}
# Packages used in unmanaged qubes
fedora-packages:
  pkg.installed:
    - pkgs:
      - qubes-app-shutdown-idle
      - qubes-ctap
      - qubes-video-companion
      - task
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
