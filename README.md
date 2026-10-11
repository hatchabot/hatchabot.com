# hatchabot.com

The website — static HTML on GitHub Pages. Edit `index.html` / `style.css`, push to `main`; live in about a minute.

- `install` and `install.sh` (identical) are a shim that runs the installer from the [hatchabot/hatchabot](https://github.com/hatchabot/hatchabot) repository: the release `stable` names in `channels.json`, fetched by `refs/tags/<tag>`. It stops if no stable release can be read; only `dev` runs main's installer.
- `fonts/` self-hosts Bricolage Grotesque (SIL OFL 1.1, see `fonts/OFL.txt`) so visitors make no third-party requests.
