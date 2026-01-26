# Supabase CLI wrapper scripts

These scripts run the Supabase CLI inside Docker so you don’t have to type long `docker run` commands. They use the same image and options (volume mount, working directory, network mode, and Monocker label) every time.

## What’s included

| File              | Platform        |
|-------------------|-----------------|
| `supabase-cli`    | Linux / macOS (bash) |
| `supabase-cli.cmd` | Windows (Command Prompt) |

Both scripts do the same thing; only the shell syntax differs.

## How they work

1. **No parameters**  
   Run the script with no arguments to be dropped into an interactive terminal. No Docker network is attached, so the container is not connected to other containers’ networks. Use this when you want to run Supabase outside of Docker networks.

2. **With parameters: first is network mode (required)**  
   When you pass arguments, the first one is always the network mode (e.g. `container:supabase-db` to use another container’s network). All following arguments are the command to run inside the container (`sh`, `supabase`, or a supabase subcommand).

3. **Image and run options**  
   - Image: `jtdev0ps/supabase-cli:1.167.4`  
   - The container is run with: `--rm`, `-it`, `--label "monocker.enable=false"`, current directory mounted at `/workspace`, and working directory `/workspace`.  
   - If the image isn’t present locally, it’s pulled first.

## Usage

**Linux / macOS**

```bash
# Make executable once (if needed)
chmod +x supabase-cli

# No parameters → drop into a terminal (no network attached)
./supabase-cli

# Attach to a container’s network + drop into a terminal (e.g. supabase-db)
./supabase-cli container:supabase-db

# Attach to a container’s network + run a command (e.g. supabase-db)
./supabase-cli container:supabase-db status
./supabase-cli container:supabase-db sh
```

**Windows (Command Prompt)**

```
# No parameters → drop into a terminal (no network attached)
supabase-cli.cmd

# Attach to a container’s network + drop into a terminal (e.g. supabase-db)
supabase-cli.cmd container:supabase-db

# Attach to a container's network + run a command
supabase-cli.cmd container:supabase-db status
supabase-cli.cmd container:supabase-db sh
```

## Changing the image or version

Edit the `IMAGE` variable at the top of each script (e.g. to use a different tag or `ghcr.io/...` instead of Docker Hub).
