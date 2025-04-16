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
      # allow increasing max memory if needed
      - memory: 1000
    - features:
      - enable:
        - appmenus-dispvm
      - set:
        - menu-items: firefox-esr.desktop
    - tags:
      - add:
        - web
{% elif grains['id'] == 'web-dvm' %}
web-dvm-firefox-policy:
  file.managed:
    - name: /rw/config/firefox/policies/policies.json
    - makedirs: true
    - source: salt://{{ tpldir }}/files/policies.json
web-dvm-firefox-rc:
  file.managed:
    - name: /rw/config/rc.local.d/firefox.rc
    - makedirs: true
    - contents: |
        mkdir -p /etc/firefox && ln -s /rw/config/firefox/policies /etc/firefox/policies
    - mode: 0755
{% endif %}
