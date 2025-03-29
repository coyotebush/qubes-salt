{% set sites = pillar['web']['sites'] %}
{% if grains['id'] == 'dom0' %}
web-example:
  qvm.vm:
    - present:
      - label: yellow
      # only ESR supports SearchEngines, only Debian packages ESR
      - template: debian-12-xfce
    - prefs:
      - label: yellow
      - template: debian-12-xfce
    - features:
      - set:
        - menu-items: firefox-esr.desktop
    - tags:
      - add:
        - web
    - firewall:
      - set:
        {% for url in sites.values() %}
        - 'action=accept dsthost={{ url.split("/")[2] }}'
        {% endfor %}
        - 'action=accept specialtarget=dns'
        - 'action=drop'
{% elif grains['id'] == 'web-example' %}
web-example-firefox-policy:
  file.managed:
    - name: /rw/config/firefox/policies/policies.json
    - makedirs: true
    - source: salt://{{ slspath }}/files/policies.json.jinja
    - template: jinja
web-example-firefox-rc:
  file.managed:
    - name: /rw/config/rc.local.d/firefox.rc
    - makedirs: true
    - contents: |
        mkdir -p /etc/firefox && ln -s /rw/config/firefox/policies /etc/firefox/policies
    - mode: 0755
{% endif %}
