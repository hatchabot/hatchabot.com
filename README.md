# hatchabot.com

The website — static HTML on GitHub Pages. This repo receives one commit per release (`Release vYYYY.MM.N`) from a gated publisher; Pages rebuilds on each.

- `install` and `install.sh` (identical) are a shim that runs the installer from the [hatchabot/hatchabot](https://github.com/hatchabot/hatchabot) repository: the release `stable` names in `channels.json`, fetched by `refs/tags/<tag>`. It stops if no stable release can be read; only `dev` runs main's installer.
- `fonts/` self-hosts Bricolage Grotesque (SIL OFL 1.1, see `fonts/OFL.txt`) so visitors make no third-party requests.
- Privacy: each release is checked against Hatchabot's household privacy values before it is published, and again on GitHub by the `privacy` workflow (keyed fingerprints, `PRIVACY_FINGERPRINTS`, synced daily by the hatchabot clone's `scripts/privacy-sync.sh --install --also hatchabot/hatchabot.com`). `scripts/privacy-identity.txt` names the maintainer's identities that are already public as commit authors.
