# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
#
# 1) Intial Setup: sync any modules, etc
# --> qubesctl saltutil.sync_all
#
# 2) Initial Key Import:
# --> qubesctl state.sls salt.gnupg
#
# 3) Highstate will execute all states
# --> qubesctl state.highstate
#
# 4) Highstate test mode only.  Note note all states seem to conform to test
#    mode and may apply state anyway.  Needs more testing to confirm or not!
# --> qubesctl state.highstate test=True

# === User Defined Salt States ================================================
user:
  dom0 or web-dvm:
    - web-dvm
  dom0 or fedora-42-custom:
    - fedora
  dom0 or fedora-42-custom or sys-audio:
    - sys-audio
  dom0 or fedora-42-custom or zoom:
    - zoom
  dom0 or debian-13-custom:
    - debian
    - offline-dvm
#  '*':
#    - locale
