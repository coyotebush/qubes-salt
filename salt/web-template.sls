# A template specialized for web browsing.
# Based on Debian, to allow installing Firefox ESR, to allow configuring SearchEngines.

{% if grains['id'] == 'dom0' %}
# conflicts with debian.sls
#debian-13-xfce:
#  qvm.template_installed

debian-13-web-clone:
  qvm.clone:
    - name: debian-13-web
    - source: debian-13-xfce

debian-13-web:
  qvm.vm:
    - features:
      - disable:
        - skip-update
      - set:
        - menu-items: firefox-esr.desktop
    - prefs:
      # enable networking on the template to pull from GitHub
      - netvm: sys-firewall
    - require:
      - qvm: debian-13-web-clone

{% elif grains['id'] == 'debian-13-web' %}
web-template-packages:
  pkg.installed:
    - pkgs:
      - make

'https://github.com/coyotebush/qubes-url-redirector.git':
  git.latest:
    - rev: 4858a5a30175444a8f55154bebb44fef500beb2e
    - target: /root/qubes-url-redirector
    - user: root
    - force_fetch: true

'make firefox':
  cmd.run:
    - cwd: /root/qubes-url-redirector
    - require:
      - file: '/usr/lib/mozilla/native-messaging-hosts/qvm_open_in_vm.json'

# TODO update qubes-url-redirector Makefile to use this location
'/usr/lib/mozilla/native-messaging-hosts/qvm_open_in_vm.json':
  file.absent
{% endif %}
