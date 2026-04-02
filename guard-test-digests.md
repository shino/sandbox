# Guard Test Digests

Known digest pairs from the 44-day benchmark (2026-02-15 ~ 2026-03-29) for PASS/FAIL testing.

Source: `ghcr.io/vulsio/vuls-nightly-db`

## FAIL pair: SUSE breakage (2026-03-06 → 03-07)

| field | value |
|-------|-------|
| before (baseline) | `sha256:51b1269fc011481f2cb646f4fbc134307a83612fc9447b0d0336005ccf6dd64e` |
| after (target) | `sha256:94007f29d7f922ee497ec745cff03aecdaca3315645fb48464c1ff09f2c40844` |
| failing ecosystems | opensuse.leap:15.6 (12.3%), suse.linux.enterprise:16 (11.7%), suse.linux.micro:6 (16.1%) |

## FAIL pair: Red Hat VEX breakage (2026-03-03 → 03-04)

| field | value |
|-------|-------|
| before (baseline) | (not recorded — use oras to look up 03-03 nightly tag if needed) |
| after (target) | (not recorded) |
| failing ecosystems | redhat:6 (65.1%), redhat:7 (56.5%) |

## Notes

- These are full nightly DB images containing all ecosystems.
- Override digests bypass the normal build; `vuls db fetch` pulls the DB directly.
- The trimmed build (rocky + alpine + oracle) shows max 3.9% drift in normal 1-day pairs — always PASS at threshold 10%.
