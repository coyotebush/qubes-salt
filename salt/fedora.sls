{% if grains['id'] == 'dom0' %}
fedora-42-xfce:
  qvm.template_installed

fedora-42-custom:
  qvm.clone:
    - source: fedora-42-xfce
    - require:
      - qvm: fedora-42-xfce

{% elif grains['id'] == 'fedora-42-custom' %}
# Packages used in unmanaged qubes
fedora-packages:
  pkg.installed:
    - pkgs:
      # https://github.com/QubesOS/qubes-issues/issues/9639
      - chromium
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
