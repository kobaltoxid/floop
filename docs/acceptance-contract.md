# Acceptance Contract

floop uses the acceptance contract to decide whether a delegated task is complete. The contract should be understandable to the caller, actionable for the worker, and checkable by the verifier.

## Requirement resolution

Requirements can be supplied in three ways:

1. A caller-selected file in the working project or another explicit location.
2. Criteria included with the invocation by a parent agent or user.
3. A prompt to the caller when neither source gives a usable contract.

The supervisor resolves these inputs into one contract, shows the criteria and any assumptions to the caller, and waits for confirmation before starting the completion loop. If more than one source conflicts, surface the conflict for resolution. Record where the confirmed criteria came from; preserve a file revision or content digest when available.

## Supervision mode and continuation limit

The default mode runs supervision in the current session. If the caller requests a separate session, the invoking session may spawn one dedicated supervisor with the confirmed contract, worker session reference, available access, and continuation limit. The dedicated supervisor must not spawn another supervisor.

If the host cannot expose the worker session, the supervisor can review artifacts supplied by the caller but must label the run review-only. It must not claim to monitor or continue a live session it cannot access.

The initial skill permits up to two continuation requests unless the caller specifies another limit. It enforces time or cost limits only when the host exposes them.

## Criterion shape

Each requirement should have:

- A stable identifier.
- A clear statement of the expected result.
- A verification method or evidence expectation when known.
- A required/optional flag if not every criterion blocks completion.

Example:

```yaml
contract_version: 1
task: "Add export support to the report page"
criteria:
  - id: export-button
    statement: "A user can download the current report as CSV."
    required: true
    verify: "manual-review"
    evidence: "Demonstrate the export action and inspect the downloaded CSV."
  - id: existing-tests
    statement: "The report page's existing focused checks pass."
    required: true
    verify: "command"
    command: "<project-specific command supplied by the caller>"
```

The example is illustrative; the final file format and schema are open decisions.

## Verification outcome

For each criterion, the verifier records:

- `pass`, `fail`, or `unknown`.
- Evidence inspected or the check that was run.
- A concise explanation.
- A correction request when the outcome is `fail`.

`unknown` means the supervisor could not make a reliable decision, for example because evidence is inaccessible or a criterion is subjective and lacks a review rule. A required `unknown` blocks completion and goes to the caller for clarification or evidence. The caller may be a person or a parent agent.

## Run completion

A run is complete only when every required criterion is `pass`. Optional criteria are reported but do not block completion. Failed criteria can trigger a continuation to the same worker session. Each continuation is followed by a fresh evaluation of the affected criteria and any checks that may have been affected by the change.

The run record should retain the confirmed contract, outcomes, evidence references, continuation count, and final disposition (`complete`, `needs-caller`, or `limit-reached`). Exact state names and storage format remain to be designed.
