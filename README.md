# Agent Supervisor

**Working title.** Agent Supervisor is a control loop for checking an AI agent's completed work against caller-confirmed requirements. It lets a person or parent agent manage the goal while a worker agent handles the work and requested corrections.

The first implementation is a project-local supplementary skill at [skills/agent-supervisor/SKILL.md](skills/agent-supervisor/SKILL.md). It runs inline by default and can optionally spawn one dedicated supervisor session when the caller requests it and the host supports session control. It does not yet include runtime adapters or an executable monitor.

## How the skill runs

The supervisor resolves requirements from a file, invocation, or caller; confirms them with the caller; observes a connected worker session; and evaluates the result criterion by criterion. It reports completion when all required criteria pass. Failed checks can be sent to the same worker for up to two focused continuation requests by default. Unclear requirements, missing evidence, or exhausted limits return to the caller, which may be a person or another agent.

## Project documents

- [System design](docs/system-design.md) — proposed components, flow, and failure behavior.
- [Acceptance contract](docs/acceptance-contract.md) — requirement inputs, supervision modes, and pass/fail/unknown outcomes.
- [Product scope and decisions](docs/rough-shape.md) — initial policy and remaining runtime choices.

The skill can only monitor or continue sessions that the host exposes. When it cannot access a live session, it reports that limitation and can review artifacts supplied by the caller. Runtime adapters and executable monitoring remain future work.
