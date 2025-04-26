# A template specialized for web browsing.
# Based on Debian, to allow installing Firefox ESR, to allow configuring SearchEngines.

{% if grains['id'] == 'dom0' %}
# conflicts with debian.sls
#debian-12-xfce:
#  qvm.template_installed

debian-12-web-clone:
  qvm.clone:
    - name: debian-12-web
    - source: debian-12-xfce
    - require:
      - qvm: debian-12-xfce

debian-12-web:
  qvm.vm:
    - features:
      - set:
        - menu-items: firefox-esr.desktop
    - prefs:
      # enable networking on the template to pull from GitHub
      - netvm: sys-firewall
    - require:
      - qvm: debian-12-web-clone

{% elif grains['id'] == 'debian-12-web' %}
web-template-packages:
  pkg.installed:
    - pkgs:
      - make

'https://github.com/raffaeleflorio/qubes-url-redirector.git':
  git.latest:
    - rev: 5334e5d9cd6e9fabd2001fd90731ebf8c2c4be22
    - target: /root/qubes-url-redirector
    - user: root
    - force_fetch: true

'make firefox':
  cmd.run:
    - cwd: /root/qubes-url-redirector

# TODO update qubes-url-redirector Makefile to use this location
'/usr/lib/mozilla/native-messaging-hosts/qvm_open_in_vm.json':
  file.copy:
    - source: '/home/user/.mozilla/native-messaging-hosts/qvm_open_in_vm.json'
    - makedirs: true
    - force: true
{% endif %}
