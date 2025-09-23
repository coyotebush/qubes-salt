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
      - qubes-video-companion
      - task
      - viking
{% endif %}
