# Help from afar (Firebase insights)

Lets you see how the app is working for her and fix problems without being there.
Nothing is collected unless she taps **Yes, send it** on the one-time consent screen
(or turns on **Settings → Help from afar**). Photos never leave the phone.

## What is sent

| What | When | Where in Firebase |
|---|---|---|
| Crashes and errors | right away | Crashlytics |
| Screens opened, taps (screen + position as % of the screen), saves (which table changed) | every minute, and when the app goes to the background | Firestore `devices/{id}/sessions/{session}/events` |
| A full copy of both shops (real and practice), every table as stored | once a day when the app opens, and on **Send a report now** | Firestore `devices/{id}/snapshots/{time}` + `.../tables` |

Money is in **paise**, quantities in **thousandths** (1500 = 1.5), dates as Unix seconds —
the same as on the phone. A snapshot is complete when its summary document exists
(it is written last, with row counts).

Offline: events wait on the phone (newest 5,000 kept); Firestore sends queued writes when
the internet comes back.

## Looking at it

- Project: `bcreations-app-kp-b9aaf` (personal Google account) — https://console.firebase.google.com
- **Crashlytics** → crashes with stack traces. Her phone's id is set as the user id.
- **Firestore → Data → devices** → one document per phone (`lastSeen`, `appVersion`).
  - `sessions` → one per app launch → `events` → batches of up to 300 events
    (`t` time, `k` kind, `n` name, `s` screen, `d` details).
  - `snapshots` → open the newest → `tables` → rows per table (`real_orders_0`, …).

To reproduce a problem, export a snapshot's tables and load them into a local copy of the app.

## Security

`firestore.rules`: a phone signs in anonymously and can read and write only
`devices/{its own id}`; everything else is denied. Deploy changes with
`firebase deploy --only firestore:rules`.

## Cost

Free tier (Spark) covers one phone easily: a daily copy is a few hundred small writes.
