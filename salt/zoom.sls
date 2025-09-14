{% set template = 'fedora-41-custom' %}
{% if grains['id'] == 'dom0' %}
zoom:
  qvm.vm:
    - present:
      - label: orange
      - template: {{ template }}
    - prefs:
      - label: orange
      - template: {{ template }}
    - features:
      - set:
        - menu-items: 'org.gnome.Cheese.desktop qubes-video-companion-screenshare.desktop qubes-video-companion-webcam.desktop org.pulseaudio.pavucontrol.desktop us.zoom.Zoom.desktop'
'qvm-volume resize zoom:private 10Gi':
  cmd.run:
    - require:
      - qvm: zoom
{% elif grains['id'] == template %}
zoom-installed:
  pkg.installed:
    - pkgs:
      - cheese
      - flatpak
{% elif grains['id'] == 'zoom' %}
'flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo':
  cmd.run:
    - runas: user
'flatpak install --user --noninteractive flathub us.zoom.Zoom':
  cmd.run:
    - runas: user
{% endif %}
