# floop

floop is a supplementary Codex skill for closing the acceptance loop on delegated AI work. It helps a caller turn requirements into checkable criteria, review available evidence, request bounded corrections, and report whether the work is complete.

floop is an installable skill, not a standalone service. It does not include a runtime adapter, live-session monitor, command-line tool, or persistent run store. The host must provide any session controls and evidence that are available during a run.

## Install

Clone floop and link the skill into your user-level Codex skills directory:

```sh
mkdir -p ~/.local/share
git clone https://github.com/kobaltoxid/floop.git ~/.local/share/floop
~/.local/share/floop/scripts/install-user.sh
```

The installer creates `~/.agents/skills/floop` as a symlink to this checkout. It refuses to replace an existing file, directory, or symlink that points somewhere else. Start a new Codex session after installation.

To install into Claude Code's personal skills directory as well, opt in explicitly:

```sh
~/.local/share/floop/scripts/install-user.sh --claude
```

The Claude installation is only a compatible skill link; floop's documented workflow and primary target remain Codex.

## Use

Ask Codex to use the `floop` skill when you want to supervise one delegated task. Provide the task, its acceptance criteria (or a file containing them), and the worker result or session reference that the host exposes. The skill confirms the contract, evaluates each criterion as `pass`, `fail`, or `unknown`, and returns a concise disposition: `complete`, `needs-caller`, or `limit-reached`.

If the host cannot expose a worker session, floop can review artifacts supplied by the caller, but it labels the run `review-only` and never claims to have monitored or continued a live session.

## Completion loop

The caller confirms the acceptance criteria before floop evaluates the worker's result. floop records evidence for each criterion and can request focused corrections from the same worker when a required check fails.

![Sequence diagram showing the caller exchanging task criteria and outcomes with floop, and floop exchanging work, corrections, results, and evidence with the worker.](docs/diagrams/completion-loop.svg)

Figure 1. floop returns completion or blockers to the caller. See the [D2 source](docs/diagrams/completion-loop.d2) or [PNG preview](docs/diagrams/completion-loop.png).

## Project documents

- [System design](docs/system-design.md) — the proposed completion loop and capability limits.
- [Acceptance contract](docs/acceptance-contract.md) — requirement inputs, outcomes, and continuation policy.
- [Product scope and decisions](docs/rough-shape.md) — the product boundary and open runtime questions.
- [Skill definition](skills/floop/SKILL.md) — the workflow loaded by Codex.

## License

floop is licensed under the [Apache License, Version 2.0](LICENSE).
