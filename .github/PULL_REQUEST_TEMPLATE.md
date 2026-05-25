<!--
Thanks for contributing to SANDEVISTAN!
Please fill in the sections below. Anything that doesn't apply can be deleted.
-->

## Summary

<!-- 1-3 sentences describing the change. -->

## Type of change

- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New tool integration
- [ ] New module
- [ ] Refactor / cleanup (no behaviour change)
- [ ] Documentation only
- [ ] Other:

## If you added a new tool, confirm:

- [ ] The tool is added to the appropriate module under `lib/modules/`
- [ ] An `ensure_command` or `ensure_repo` call is used for installation
- [ ] The tool entry is added to the matching `*_menu` dispatcher
- [ ] README and `docs/MODULES.md` (if present) are updated
- [ ] The tool's upstream license is compatible with MIT

## Test plan

<!--
How did you verify the change locally?
Example:
- Ran `bash -n sandevistan.sh lib/**/*.sh`
- Ran `shellcheck` with no warnings
- Manually invoked the new menu entry and confirmed installation + execution
-->

- [ ] `bash -n` passes on changed files
- [ ] `shellcheck` passes on changed files
- [ ] Tested manually on a supported distro (please specify):

## Checklist

- [ ] My code follows the project style (see `CONTRIBUTING.md`)
- [ ] I have not introduced secrets, credentials or hard-coded targets
- [ ] I understand this project is for authorized security testing only
