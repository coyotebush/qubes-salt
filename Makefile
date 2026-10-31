POLICY_FILES=$(wildcard policy.d/*.policy)
POLICY_DEST=/etc/qubes/policy.d/

.PHONY: install-policy lint-policy diff-policy import-policy

install-policy: lint-policy
	install -v -m 0664 -t $(POLICY_DEST) $(POLICY_FILES)

lint-policy:
	qubes-policy-lint $(POLICY_FILES)

diff-policy:
	! diff -r $(POLICY_DEST) policy.d/ | grep -Ev '^Only in $(POLICY_DEST)'

import-policy:
	for f in $(notdir $(POLICY_FILES)); do cp $(POLICY_DEST)$$f policy.d/; done
