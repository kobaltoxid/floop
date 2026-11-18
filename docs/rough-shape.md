# Product Scope and Decisions

## Product boundary

The supervisor owns the completion loop for a delegated task. A parent orchestrator may choose the worker and assign work; the supervisor resolves the acceptance criteria, checks the result, requests focused corrections, and reports the outcome to its caller.

The caller may be a person or a parent agent. The worker may run in Codex, Claude, or a local environment, but the first supported runtime has not been selected.

## Initial implementation

The first artifact is a supplementary Codex skill. It defines the acceptance loop and uses session controls available in the host environment.

The skill runs in the calling session by default. If the caller requests separate supervision, it may spawn exactly one dedicated supervisor session with the confirmed contract and a worker session reference. The dedicated session does not spawn another supervisor.

Live observation and continuation depend on the host exposing those capabilities. Without them, the skill can review a supplied result or transcript but must label the run review-only. Jira and additional runtime adapters can follow after this loop is proven.

## Initial policy

- Requirements may come from a selected file, invocation, or caller. The caller confirms the normalized criteria before monitoring starts.
- The skill allows up to two continuation requests by default. The caller may set another limit.
- Enforce time or cost limits only when the host exposes them. Otherwise report that those limits are not enforced.
- Return a run report in the caller's session. Durable run storage is not part of this first implementation.

## Decisions still open

- Which host APIs provide reliable session identity, completion signals, evidence access, and continuation across Codex, Claude, and local agents?
- Should a future standalone runtime use a CLI, service, or both?
- What durable run storage and issue-tracker integrations should follow the skill prototype?

The [system design](system-design.md) describes the control loop and its current capability limits.
