# supabase-cli

[supabase-cli](https://github.com/supabase/cli) is a terminal client for open-source database `supabase`.

This repository builds Docker images for the Supabase CLI and publishes them to GitHub Container Registry (ghcr.io) and optionally to Docker Hub.

## Quick start

Use the pre-built image from this repository. Copy and paste into your terminal (replace `jtdevops` with the GitHub username or org that hosts this repo if you use a different fork):

**Pull the image** – from GitHub Container Registry:
```bash
docker pull ghcr.io/jtdevops/supabase-cli:1.167.4
```

Or from Docker Hub:
```bash
docker pull jtdev0ps/supabase-cli:1.167.4
```

**Run a Supabase command** (e.g. from a project directory). Use the same image you pulled (ghcr.io or Docker Hub):

From GitHub Container Registry:
```bash
docker run --rm -it --label "monocker.enable=false" -v "$(pwd):/workspace" -w /workspace ghcr.io/jtdevops/supabase-cli:1.167.4 supabase status
```

From Docker Hub:
```bash
docker run --rm -it --label "monocker.enable=false" -v "$(pwd):/workspace" -w /workspace jtdev0ps/supabase-cli:1.167.4 supabase status
```

**Run with a container network** (e.g. to talk to another container named `supabase-db`):

From GitHub Container Registry:
```bash
docker run --rm -it --label "monocker.enable=false" -v "$(pwd):/workspace" -w /workspace --network container:supabase-db ghcr.io/jtdevops/supabase-cli:1.167.4 supabase status
```

From Docker Hub:
```bash
docker run --rm -it --label "monocker.enable=false" -v "$(pwd):/workspace" -w /workspace --network container:supabase-db jtdev0ps/supabase-cli:1.167.4 supabase status
```

**Open an interactive shell:**

From GitHub Container Registry:
```bash
docker run --rm -it --label "monocker.enable=false" -v "$(pwd):/workspace" -w /workspace ghcr.io/jtdevops/supabase-cli:1.167.4 sh
```

From Docker Hub:
```bash
docker run --rm -it --label "monocker.enable=false" -v "$(pwd):/workspace" -w /workspace jtdev0ps/supabase-cli:1.167.4 sh
```

**Interactive shell with network mode:**

From GitHub Container Registry:
```bash
docker run --rm -it --label "monocker.enable=false" -v "$(pwd):/workspace" -w /workspace --network container:supabase-db ghcr.io/jtdevops/supabase-cli:1.167.4 sh
```

From Docker Hub:
```bash
docker run --rm -it --label "monocker.enable=false" -v "$(pwd):/workspace" -w /workspace --network container:supabase-db jtdev0ps/supabase-cli:1.167.4 sh
```

---

## Wrapper scripts

This repo includes **wrapper scripts** in the [`scripts`](https://github.com/jtdevops/supabase-cli/tree/main/scripts) folder so you can run the Supabase CLI via Docker without typing long `docker run` commands. On GitHub, the scripts folder (<https://github.com/jtdevops/supabase-cli/tree/main/scripts>) shows the README in the bottom pane with what the scripts are and how they work. There are versions for Linux/macOS (`supabase-cli`) and Windows (`supabase-cli.cmd`).

---

## Want to use a different Supabase version?

If you need a specific Supabase CLI version that isn’t published here, you can fork this repo and build it yourself.

1. **Fork this repository** to your GitHub account.
2. **Build an image** for the version you want — see [Building Images](#building-images) below.
3. **Use your image** by pulling and running it with your GitHub username/org and the version you built.

**Pull from your fork** (GitHub Container Registry):
```bash
docker pull ghcr.io/YOUR_GITHUB_USERNAME_OR_ORG/supabase-cli:VERSION
```

**Or from Docker Hub** (if you configured it in your fork):
```bash
docker pull YOUR_DOCKERHUB_USERNAME/supabase-cli:VERSION
```

Replace `YOUR_GITHUB_USERNAME_OR_ORG` / `YOUR_DOCKERHUB_USERNAME` with your usernames and `VERSION` with the version you built (e.g. `1.167.4`).

**Example – run a Supabase command with network mode:**
```bash
docker run --rm -it --label "monocker.enable=false" -v "$(pwd):/workspace" -w /workspace --network container:supabase-db ghcr.io/YOUR_GITHUB_USERNAME_OR_ORG/supabase-cli:VERSION supabase status
```

**Example – interactive shell with network mode:**
```bash
docker run --rm -it --label "monocker.enable=false" -v "$(pwd):/workspace" -w /workspace --network container:supabase-db ghcr.io/YOUR_GITHUB_USERNAME_OR_ORG/supabase-cli:VERSION sh
```

## Building Images

Images are built manually using GitHub Actions:

1. Go to the **Actions** tab in this repository
2. Select the **"release"** workflow
3. Click **"Run workflow"**
4. Enter the Supabase CLI version you want to build (e.g., `1.167.4`)
5. Click **"Run workflow"** to start the build

The Docker image will be built and pushed to GitHub Container Registry (always) and Docker Hub (if configured), tagged only with the version you specify (no `latest` tag).

## Migrating Existing Images to Docker Hub

If you have existing images on GitHub Container Registry that you want to push to Docker Hub, use the **Push Existing Images to Docker Hub** workflow in the Actions tab. Run it and enter a comma-separated list of versions to push.

## Development

- Clone this repository
- The workflow uses GitHub's built-in `GITHUB_TOKEN` for GitHub Container Registry - no additional secrets required
- To also push to Docker Hub, add the following secrets in your repository settings:
  - `DOCKERHUB_USERNAME`: Your Docker Hub username
  - `DOCKERHUB_TOKEN`: Your Docker Hub access token (create one at https://hub.docker.com/settings/security)
- Images are published to GitHub Container Registry as private packages by default

## Credits

This project is a fork of [tensorchord/supabase-cli-image](https://github.com/tensorchord/supabase-cli-image), modified to use manual builds and GitHub Container Registry instead of automatic Docker Hub releases.