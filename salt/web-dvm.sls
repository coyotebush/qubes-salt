{% if grains['id'] == 'dom0' %}
web-dvm-create-qube:
  qvm.vm:
    - name: web-dvm
    - present:
      - label: red
      # only ESR supports SearchEngines, only Debian packages ESR
      - template: debian-12-xfce
    - prefs:
      - label: red
      - template: debian-12-xfce
      - template_for_dispvms: true
    - features:
      - enable:
        - appmenus-dispvm
      - set:
        - menu-items: firefox-esr.desktop
{% elif grains['id'] == 'web-dvm' %}
web-dvm-firefox-policy:
  file.managed:
    - name: /rw/config/firefox/policies/policies.json
    - makedirs: true
    - source: salt://{{ slspath }}/files/policies.json
web-dvm-firefox-rc:
  file.managed:
    - name: /rw/config/rc.local.d/firefox.rc
    - makedirs: true
    - contents: |
        mkdir -p /etc/firefox && ln -s /rw/config/firefox/policies /etc/firefox/policies
    - mode: 0755
{% endif %}
