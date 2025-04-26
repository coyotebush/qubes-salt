
I created user state directories by running `qubesctl state.sls qubes.user-dirs`
per the community [Qubes Salt Beginner's Guide](https://forum.qubes-os.org/t/qubes-salt-beginners-guide/20126).

The correspondence between this repository and my dom0 filesystem is:

* **salt**: contents of `/srv/user_salt/`
* **pillar**: contents of `/srv/user_pillar/`
* **policy.d**: additions to `/etc/qubes/policy.d/`

I apply states by running commands like

```sh
qubesctl state.highstate  # configure everything in dom0
qubesctl state.highstate test=True  # only dry-run changes
qubesctl --targets=web-dvm state.highstate  # additionally configure inside web-dvm
qubesctl --targets=web-dvm --skip-dom0 state.highstate  # fix something in web-dvm without touching dom0
```
