{% if grains['id'] == 'dom0' %}
fedora-41-xfce:
  qvm.template_installed

fedora-41-custom:
  qvm.clone:
    - source: fedora-41-xfce
    - require:
      - qvm: fedora-41-xfce

{% elif grains['id'] == 'fedora-41-custom' %}
# Packages used in unmanaged qubes
fedora-packages:
  pkg.installed:
    - pkgs:
      # https://github.com/QubesOS/qubes-issues/issues/9639
      - chromium
      - qubes-app-shutdown-idle
      - qubes-video-companion
      # TODO upgrade once Taskwarrior 3 is packaged
      - task2
      - viking
{% endif %}
