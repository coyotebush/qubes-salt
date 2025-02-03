# sys-audio provides virtualized audio and video to other qubes.
# It persists state including Bluetooth device pairings.

{% set template = 'fedora-40-xfce' %}
{% if grains['id'] == 'dom0' %}
sys-audio-create-qube:
  qvm.vm:
    - name: sys-audio
    - present:
      - label: red
      - template: {{ template }}
    - prefs:
      - label: red
      - template: {{ template }}
      - virt_mode: hvm
      - maxmem: 0
      - audiovm: ''
      - netvm: ''
      - default_dispvm: ''
      - pcidevs:
        - '00:14.0' # USB controller for Bluetooth and webcam
        - '00:1f.3' # Audio controller
      - pci_strictreset: false
      - autostart: true
    - features:
      - enable:
        - servicevm
        - service.audiovm
        - service.blueman
      - set:
        - menu-items: 'blueman-manager.desktop org.pulseaudio.pavucontrol.desktop'
{% elif grains['id'] == template %}
sys-audio-installed:
  pkg.installed:
    - pkgs:
      - alsa-utils
      - blueman
      - linux-firmware
      - pasystray
      - pavucontrol
      - pipewire-qubes
      - qubes-audio-daemon
      - qubes-core-admin-client
      - qubes-usb-proxy
      - qubes-video-companion
'/etc/xdg/autostart/pasystray.desktop':
  file.line:
    - content: 'Hidden=true' # disable autostart in other qubes based on the template
    - mode: insert
    - location: end
{% elif grains['id'] == 'sys-audio' %}
'/rw/config/qubes-bind-dirs.d/50_user.conf':
  file.managed:
    - makedirs: true
    - contents: |
        binds+=( '/var/lib/bluetooth' )
copy-pasystray-autostart:
  file.copy:
    - name: '/home/user/.config/autostart/pasystray.desktop'
    - source: '/etc/xdg/autostart/pasystray.desktop'
    - makedirs: true
    - force: true
'/home/user/.config/autostart/pasystray.desktop':
  file.line:
    - content: 'Hidden=true'
    - mode: delete
    - require:
      - file: copy-pasystray-autostart
{% endif %}
