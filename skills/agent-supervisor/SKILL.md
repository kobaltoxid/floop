---
name: agent-supervisor
description: "Supervise delegated AI work against caller-confirmed requirements. Review evidence, request bounded corrections, and report completion or unresolved issues. Use when monitoring or verifying another agent's task."
---

# Agent Supervisor

Close the acceptance loop for one delegated AI task. The caller may be a person or a parent agent. The worker may be a Codex, Claude, or local agent, but you can only control sessions the host exposes.

## Select a supervision mode

- Run inline in the current session by default.
- If the caller asks for a separate supervisor session, use the host's documented agent-spawn mechanism to start exactly one supervisor session. Give it the confirmed contract, worker session reference, available observation and continuation controls, and attempt limit. Do not let that session spawn another supervisor.
- If the host cannot start a separate session, say so and ask whether to continue inline. Do not silently change modes.

The parent agent still chooses and starts the worker. The supervisor does not launch or replace the worker unless the caller explicitly assigns that action.

## Confirm the acceptance contract

1. Resolve requirements from a caller-selected file, invocation text, or the caller's answer to a focused question.
2. Convert them into concise, checkable criteria. Preserve the source and note conflicts or assumptions.
3. Show the criteria and assumptions to the caller. Wait for confirmation before monitoring or reviewing the result.

If requirements conflict or remain unclear, return the conflict to the caller. Do not guess what counts as complete.

## Check session access

Before claiming to monitor a worker, identify the session and verify which host controls are available: completion status, result or evidence access, and continuation. Use only documented controls and permissions provided for this run.

When live observation is available, wait for an explicit worker completion signal before evaluating. Silence or inactivity is not completion. If the caller asks for an interim check, label it `in-progress` and do not close the run.

If live session access is unavailable, ask the caller for the final result, transcript, or relevant artifacts. Mark the run `review-only`; do not claim to have monitored or continued the live session. If the caller requests a separate session but it cannot reach the worker, report the limitation instead of pretending the separation worked.

## Evaluate and continue

For each required criterion, record `pass`, `fail`, or `unknown`, with the evidence inspected and a concise reason. Prefer explicit commands or observable evidence. Use model judgment only where the criterion needs it, and never treat an unsupported judgment as proof.

If a required criterion fails and session continuation is available, send the same worker a focused correction request that names the failed criterion and evidence. Stay within the confirmed scope. Recheck the affected criteria and relevant regression checks after the worker responds.

Allow up to two continuation requests by default. Honor a different limit set by the caller. Enforce time or cost limits only when the host exposes them. A required `unknown`, inaccessible evidence, unavailable control, or exhausted limit returns to the caller; it never counts as a pass.

## Report the result

Return one of these dispositions:

- `complete`: every required criterion passed.
- `needs-caller`: a requirement, evidence item, or control needs clarification.
- `limit-reached`: the continuation limit was reached before completion.

Include the supervision mode, each criterion's outcome and evidence, continuation count, and any host limitation. In separate-session mode, send this report to the invoking session. Keep the final report concise and actionable.
