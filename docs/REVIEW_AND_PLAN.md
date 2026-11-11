# Bcreations — App Review & Rebuild Plan

_Reviewed: 2026-11-11 · Codebase: Flutter + Riverpod 2 + Isar 3 · ~8,600 hand-written lines, 6 tables, 5 tabs_

---

## 0. Decisions captured (from Q&A)

| Topic | Decision |
|---|---|
| Existing data | **Not in use yet** → free to redesign the database, no migration needed |
| Business | **Handmade / craft goods** (raw materials → finished pieces) |
| Quantities | **Decimals needed** (metres, kg, litres) |
| Delivery charge | **Customer pays** → stays on the bill |
| Invoices | **Simple PDF bill/quote now**, data model ready for **GST tax invoice later** |
| Supplier credit | **Sometimes** buys on credit → need simple payables |
| Data location | **One phone + automatic Google Drive backup now**, **cloud multi-device sync later** |
| Order flow | **Simplify** (Quote → Order → Delivered, payment status separate) |
| Display | **Hindi**, **larger text & buttons**, **light theme option** |
| Platform / next step | **Android only**, **plan then build** phase by phase |
| Pricing | **Decided:** wholesale + retail lists, cost-plus suggestions, editable per order, custom-item lines, bulk discounts — see §5.4 |
| Sales channels | **All:** shops/resellers, individuals, exhibitions/fairs, Instagram/online |

### 0.1 The problems this app must solve (confirmed with the user, 2026-11-12)

The app is a **force multiplier**: if a feature costs her more time than it saves, it's wrong.

| # | Real problem | What success looks like |
|---|---|---|
| P1 | **Customers pay late** (suppliers are paid on time) | She always knows who owes what and since when; reminding takes one tap |
| P2 | **Loses track of inventory** | Stock on the app matches the shelf; she's warned before running out |
| P3 | **Can't see profit — "nothing gets banked"** | A monthly "Where did my profit go?" answer in plain words |
| P4 | **Doesn't know her best-selling items** | Top sellers by quantity and profit, by month and season |
| P5 | **Family and business money get mixed** | Personal withdrawals recorded in one tap and shown separately |
| P6 | **Onboarding must not be a burden** | Usable on day one in ≈15 minutes; history is optional, never a blocker (§5.5) |

More candidate problems are awaiting her confirmation; confirmed ones will be added here.

---

## 1. What works well today (keep these ideas)

- Fully offline, fast, no login — right for a solo operator.
- Stock is a **ledger of movements**, not a single number → auditable history per item.
- **Bulk payment allocation** (oldest unpaid order first) and leftover advance — good accounting instinct.
- **Recipe / Bill of Materials** for finished goods — fits a craft business exactly.
- One-tap **Call / WhatsApp / Email** on contacts; **share quote** to WhatsApp.
- Duplicate guards on item name and SKU; transactions wrapped in DB transactions.
- Back-dating of payments and expenses.

---

## 2. Functional evaluation — bugs found (ranked by impact)

### 2.1 Critical — wrong numbers or lost data
1. **Search text leaks into other screens.** `inventoryItemsProvider` and `activeClientsProvider` are filtered by the search box, but Orders, Order detail, Add/Edit order, Payment and Finance reuse them.
   - Typing in Inventory search → order detail hides line items and **the invoice total and shared quote drop** (`order_detail_screen.dart:46-48`, `:184`).
   - Typing in CRM search → orders show "Unknown Client", payment client dropdown empties (`orders_screen.dart:88`, `add_payment_screen.dart:83`, `finance_screen.dart:202`).
2. **Mistakes cannot be fixed.** Payments, expenses and stock movements have no edit or delete. One typo is permanent; the only fix is a full restore.
3. **No selling price.** Items only have a cost price; new order lines pre-fill with **cost** (`add_order_screen.dart:207`) → easy to sell at zero margin.
4. **Profit is misleading.** "Revenue" = all cash received ever; "Expenses" includes raw-material purchases; manufactured goods carry no cost → no real margin per order or per month. Monthly "Total Billings" is actually collections.
5. **Backup is incomplete.** Export drops client `notes`/`createdAt`, inventory **recipes (BOM)**, and **product photos** (photos are temporary picker-cache paths that Android can delete) (`backup_service.dart:28-51`, `add_inventory_item_screen.dart:79`).
6. **Stock can go negative silently.** Delivering or manufacturing never checks availability. Recipe quantities are **rounded to whole numbers** (`inventory_service.dart:91`) — 0.5 m × 3 = 2 m deducted instead of 1.5 m.
7. **Stock cannot be reduced/corrected** (breakage, wastage, recount): the restock sheet rejects quantity ≤ 0 (`inventory_screen.dart:420`).

### 2.2 High — broken features
8. **Archive does nothing.** `isArchived` is saved but never filtered anywhere; there is no unarchive.
9. **Notifications unreliable.** `POST_NOTIFICATIONS` is not declared in `AndroidManifest.xml` (required on Android 13+); a payment alert fires **every time Home opens** (`dashboard_screen.dart:24-33`); background count includes partly-paid orders; two separate implementations.
10. **Profile screens don't refresh after editing** (`crm_provider.dart:13` doesn't watch the client table).
11. **Order detail uses stale data** for the Edit button and edit screen (`order_detail_screen.dart:64,81` use `order` instead of `liveOrder`).
12. **Removing a middle line in Add/Edit order shows wrong values** in the rows below (text fields without keys).
13. **Delivered date never stored** by the delivery path actually used (`order_service.dart:70`); overdue badge counts from the order date, not delivery date.
14. **Duplicate contacts allowed** — Add Contact bypasses the duplicate check (`add_client_screen.dart:70`); `createdAt` never set.
15. **Lead "Convert"** opens a blank new order instead of one pre-filled with that lead.

### 2.3 Safety — destructive actions with no confirmation
16. Delete contact, delete item, cancel order (detail screen), confirm/deliver (detail screen), wipe-and-restore result not verified.

### 2.4 Build & release hygiene
17. App shows as **"flutter_application_1"** with the default Flutter icon; `applicationId = com.example…`; release signed with the **debug key** → cannot be published or safely updated.
18. **Isar 3 is unmaintained** (no releases since 2023) and has known Android Gradle Plugin 8 build issues.
19. **Zero working tests** — `test/widget_test.dart` references a non-existent `MyApp` and the wrong package name, so `flutter test` fails.
20. Git history is 5 commits ("new update", "architechture update") — no way to bisect regressions.

---

## 3. Usability / UX evaluation

| Area | Problem | Effect on your mother |
|---|---|---|
| Language | "Command Center", "Market Dues", "Procurement Outlays", "Inventory Master", "RawMaterial/FinishedGood", "SKU" | Jargon; English-only |
| Readability | Dark-only, grey-on-dark text, 10–13 px badges, small icon buttons | Hard to read, especially outdoors |
| Numbers | ₹123456 without separators, raw dates `2026-11-11`, `intl` imported but unused | Easy to misread amounts |
| Order entry | Plain dropdowns listing every item (incl. raw materials), no search, no running total, no stock shown, FAB overlaps fields | Slow, error-prone |
| Order flow | 5 stages, 4 separate taps + dialogs per order | Too much ceremony for a solo seller |
| Home | All-time totals only, no "today / this month"; tiles open duplicate unfiltered screens | Doesn't answer "how am I doing this month?" |
| Discoverability | Stock history only via **long-press**; edit/delete hidden in ⋮ menus | Features effectively invisible |
| Editing | Contact edit in a cramped dialog; no undo anywhere | Fear of tapping things |
| Backup | Labelled "Backup to Drive" but just opens a share sheet | False sense of safety |
| First run | Empty screens with no guidance | Doesn't know where to start |

---

## 4. Redundancies to remove

- **Order-total maths duplicated in 8+ places** (finance service ×3, order providers ×3, dashboard, order detail, payment card) → one function/SQL view.
- **Two "deliver order" implementations** (`FulfillmentService` unused vs `OrderService`).
- **Unused `CrmService`**, and lead-promotion logic copied in 3 places.
- **Two notification engines** (`main.dart` background callback + `NotificationService`).
- **Add Order / Edit Order** screens ~95% identical → one form.
- **Client / Vendor profile screens** and their edit dialogs ~90% identical → one party screen.
- Overdue badge copied 3×, dispatch dialog copied 2×, dashboard and finance compute the same totals separately.
- "Lead" as a separate type with a manual Convert button when auto-promotion already exists → becomes a simple tag.
- Hundreds of `// THE FIX:` comments from AI iterations → remove.

---

## 5. Target architecture (recommended)

### 5.1 Stack
- **Keep:** Flutter, Riverpod (upgrade to latest 2.x/3.x).
- **Replace Isar → Drift (SQLite).** Maintained, real joins/`SUM()` in SQL (kills the duplicated totals), typed schema migrations, and SQLite is the standard base for adding cloud sync later (e.g. PowerSync + Supabase).
- **Add:** `go_router` (navigation), `flutter_localizations` + ARB files (English/Hindi), `pdf` + `printing` (bills), `googleapis` + `google_sign_in` (Drive backup), keep `workmanager`, `flutter_local_notifications`, `share_plus`, `url_launcher`, `image_picker`.

### 5.2 Rules baked in from day one
- **Money in integer paise**, **quantities as fixed-point decimals** (e.g. milli-units) → no rounding drift.
- **Sync-ready rows:** UUID ids, `createdAt`, `updatedAt`, `deletedAt` (soft delete) on every table.
- **GST-ready (switched off):** business GSTIN/state, party GSTIN/state, product HSN + tax rate, invoice number series, tax-lines table.
- **Layers:** `data/` (tables, DAOs) → `domain/` (pure-Dart services, unit-tested) → `providers/` → `ui/`. Screens never query the DB directly; search state never lives in shared data providers.

### 5.3 New data model (draft)
| Table | Purpose |
|---|---|
| `business_profile` | Name, logo, address, phone, UPI ID, (GSTIN later) |
| `parties` | Customers & suppliers in one table; role flags; tags (wholesale/retail/lead); archived |
| `products` | Kind: *raw material / made by me / bought to resell*; unit; decimal flag; cost; selling price(s) **(TBD)**; min stock; photo (copied into app storage) |
| `recipe_lines` | Product ← raw material × quantity |
| `orders` + `order_lines` | Number, party, date, status (Quote / Confirmed / Delivered / Cancelled), delivery charge, discount, notes |
| `purchases` + `purchase_lines` | Supplier buys, on cash or credit |
| `production_runs` | Made X pieces → consumes raw materials, records cost per piece |
| `stock_moves` | Every in/out with type (purchase, production in/out, sale, adjustment, return) and unit cost |
| `payments` + `payment_allocations` | Money in/out, allocated to orders or purchases (supports partial, bulk, advance) |
| `expenses` | Category, amount, method, date, note, optional receipt photo |

Payment status (Unpaid / Partly paid / Paid / Overdue) is **derived**, never stored.

### 5.4 Pricing model (decided 2026-11-11)

**Goal:** the app teaches better practice by *recording* what is untracked today (real cost, discounts, channel, custom vs catalogue) and turning it into margin insight. It never forces a price; it suggests and warns.

**What we know:** she sells through every channel; shops get a lower price (amount unknown); she prices as "margin on cost" from experience but can't track profit; she can estimate time **per batch**, not per piece; custom and catalogue work both exist; discounts and bargaining happen; bulk buyers get lower prices; how fast material costs change is unknown (assume moderate, like most craft supplies).

**Model = B + C + D + custom line:**

| Piece | Design |
|---|---|
| **Cost per piece (C)** | Taken from **production runs**: (materials used + batch hours × her hourly rate + overhead %) ÷ pieces made. Labour is entered **once per batch**, not per product. Running weighted-average cost per product. |
| **Suggested prices (C)** | Retail = cost × retail markup; Wholesale = cost × wholesale markup. Starting defaults, all editable in Settings: **overhead 10 %, retail ×2.5, wholesale ×1.8**. Shown next to her own prices, never forced. |
| **Price lists (B)** | Each product has **Retail price** (required) and **Wholesale price** (optional; if blank, falls back to retail − default wholesale discount, starting at 30 %). |
| **Customer price type** | Each customer is **Retail** or **Wholesale**; it decides which price fills the order line. |
| **Sales channel** | Every order is tagged **Shop/Reseller · Individual · Exhibition/Fair · Instagram/Online** (default from the customer, changeable per order). |
| **Per-order override (D)** | Every line price is editable. A hint shows "Last charged to this customer: ₹X". Each line saves a **copy of list price and cost at the time** so later reports stay true. |
| **Margin indicator** | Each line and the order total show margin in colour: **green** at or above target, **amber** thin, **red** below cost (target margin configurable). |
| **Discounts** | Both **per line** and **whole order** (₹ or %), with an optional reason (bargaining, loyal customer, exhibition offer). Always stored separately from the list price so discounts can be measured. |
| **Bulk pricing** | Global rule in Settings (e.g. 10+ pieces → 5 % off, 25+ → 10 % off), applied automatically to wholesale orders; optional per-product override with its own breaks. |
| **Custom item line** | Free-text name, photo, quantity, price, optional estimated cost — for made-to-order pieces that aren't in the catalogue. Tagged so custom vs catalogue share can be reported. |
| **Cost changes** | When a product's average cost rises **more than 10 %** above the cost at which its price was last set, it appears in a **"Prices to review"** list on Home with the new suggested price. Prices never change automatically. |

**Reports this unlocks (Phase 4):** profit by channel, by product and by customer type; total discounts given and their reasons; custom vs catalogue share and margin; average real wholesale discount (so the 30 % default can be replaced by her actual figure); products sold below target margin.

**Data model additions (pricing):** `settings` (hourly rate, overhead %, markups, default wholesale discount, target margin, bulk rules, review threshold); `products` (+ retail price, wholesale price, price-set cost, average cost, bulk-break override); `parties` (+ price type, default channel); `orders` (+ channel, order discount, discount reason); `order_lines` (+ product nullable for custom lines, description, photo, list-price snapshot, cost snapshot, line discount); `production_runs` (+ batch hours, labour cost, overhead cost, cost per piece).

**Data model additions (from P1–P5):** `orders` (+ due date, from payment terms per customer type, e.g. shops 15 days, individuals on delivery); `owner_withdrawals` (amount, date, note: "taken for home/personal use"); `opening_balances` (customer dues / supplier dues as of the start date); `stock_counts` (periodic shelf count and the differences found).

### 5.5 Onboarding & data entry (P6)

**Principles**
- **Start from today, not from history.** The app needs only what is true *right now*: what's on the shelf, who owes her, which orders are in progress. Past records are optional extras.
- **Only a name and a number are ever required.** Cost, photo, category, phone number, recipe: all "add later", with gentle nudges ("8 items have no cost — add it to see your profit").
- **Every step can be skipped and resumed.** A "Setup progress" card on Home, never a wall of forms.
- **Speed targets:** record a payment < 10 s, an order < 30 s, a stock item < 15 s.
- **Someone else can help:** you (her son) can fill a Google Sheet / Excel template on a computer and import it in one tap.

**Day-one setup (≈15 minutes, each step skippable)**
1. **Welcome:** language (हिन्दी / English), business name; logo and UPI ID optional.
2. **"What do you have right now?"** Fast stock entry: type a name (or tap a suggestion from common craft materials), quantity, unit. One screen, "＋ next item" keeps the keyboard open. Cost and photo optional.
3. **"Who owes you money?"** Pick customers from phone contacts and type the amount each owes. These become **opening balances**; there's no need to recreate old orders.
4. **"Orders in progress":** customer, a short description (free text is fine), amount, advance received, delivery date.
5. **"Do you owe any supplier?"** (optional) Same as step 3, for suppliers.
6. Done: Home shows her to-dos straight away.

**Past records (optional, never a blocker)**
- **Monthly totals only:** "Sales in October ≈ ₹40,000" for a few past months, so trends and comparisons work without entering every bill.
- **Spreadsheet import** if old records exist anywhere digital.
- **Back-fill in her own time:** older orders and payments can be added with a past date whenever she wants.
- *Future:* photograph a notebook page → app reads it (AI/OCR).

**Everyday time-savers**
- Contacts imported from her phone; customers created on the fly while making an order.
- **Repeat last order**, recently used items first, smart defaults (today's date, last price, Cash/UPI).
- One big **＋** button on every screen: New order · Payment received · Expense · Took money for home · Made items.
- **Monthly 5-minute stock count:** walk the shelf, type what's there, the app records the differences.

---

## 6. Phased plan

Size key: **S** ≈ 1–2 days · **M** ≈ 3–5 days · **L** ≈ 1–2 weeks (solo developer with AI assistance)

### Phase 0 — Foundation & hygiene (S)
- Install Flutter SDK; pin version with `fvm`; run `flutter analyze` to capture baseline.
- Rename app: label **"Bcreations"**, `applicationId com.bcreations.app`, real launcher icon + splash.
- Create a release keystore (stored outside the repo) and signing config.
- Branching + conventional commits; GitHub Actions: analyze + test on every push.
- Delete broken default test; add test scaffolding.
- **Done when:** a signed release APK named Bcreations builds in CI.

### Phase 1 — Data layer rebuild on Drift (L)
- Implement tables in §5.3 with UUIDs, timestamps, soft delete, paise and decimal quantities.
- DAOs with SQL views for: order total, order paid, party balance, stock on hand, stock value.
- One `LedgerService` for all money maths; one `StockService` for all stock maths.
- Unit tests for every calculation (partial pay, bulk allocation, advance, overpayment, decimals, recipe consumption, cancellation reversal).
- Seed script with realistic craft-business demo data.
- **Done when:** all balances/stock come from one tested source; no screen does arithmetic.

### 🎯 First usable version (target right after Phase 1)
Deliver the slice that attacks P1–P6 first, so she starts using the app (and giving feedback) weeks earlier:
- Day-one onboarding (§5.5) and the Home to-do screen, in Hindi with large text.
- Orders with due dates, payments, **one-tap WhatsApp reminders**.
- Stock with production, adjustments and the monthly count.
- Owner withdrawals + the "Where did my profit go?" monthly screen + best sellers.
- **Automatic Drive backup** (pulled forward from Phase 7, because real data must never be lost).

PDF bills, supplier credit, detailed reports and pricing insight follow in later phases.

### ✅ Pricing model — decided (see §5.4)
The pricing tables and settings are built in Phase 1; the order-line pricing UX is built in Phase 2.

### Phase 2 — Core flows: Orders & Payments (L)
- **Simplified order flow:** Quote → Confirmed → Delivered (+ Cancelled). Payment status shown as a separate chip.
- **One order form** (create & edit): searchable product picker with photos, stock shown, live running total, delivery charge, notes, date (back-datable).
- **Pricing on the form (§5.4):** price filled from customer type (retail/wholesale), bulk breaks applied automatically, "last charged" hint, line and order discounts with reason, colour margin indicator, sales-channel chip, **＋ Custom item** line.
- **Quick actions** on each order card: Confirm, Mark delivered (+ optional delivery charge), Record payment, Share — one tap + bottom sheet, no nested dialogs.
- Stock check on Confirm/Deliver with clear warning ("Only 3 left — continue?").
- **Edit & delete with Undo** (snackbar) for orders, payments, expenses; cancel reverses stock.
- Record payment: amount pre-filled with balance, method chips (Cash/UPI/Bank), allocation preview (which orders it clears), advance shown.
- Lead convert → opens order pre-filled with that person.
- **Done when:** create → deliver → get paid takes ≤ 3 screens and every step is reversible.

### Phase 3 — Inventory & production for crafts (M)
- Product kinds in plain words: *Raw material / I make this / I buy & resell*.
- Recipe builder with decimal quantities and **cost per piece** auto-calculated from raw-material cost.
- **"Make items" (production run):** shows required vs available materials, blocks or warns on shortfall, asks **"About how many hours did this batch take?"**, and records cost per piece (materials + labour + overhead).
- **Pricing per product:** retail and wholesale price fields with the suggested prices beside them; **"Prices to review"** list when cost rises more than 10 %.
- **Stock adjust:** add/remove with reason (damaged, used personally, recount) — reversible.
- Stock history as a visible tab on the product screen (not long-press).
- Photos copied into app storage and included in backups.
- Units: pcs, m, cm, kg, g, L, ml, box, set + custom.
- **Low-stock list → share to supplier on WhatsApp** as a ready purchase list.
- **Done when:** stock is always correct to the decimal and every finished piece has a known cost.

### Phase 4 — Money: purchases, payables, expenses, reports (M)
- **Purchases** from suppliers: paid now or on credit → supplier balance ("You owe Sharma Traders ₹4,500"), pay later with allocation.
- **Expenses** with simple categories (Packaging, Transport, Rent, Phone, Other + custom) and optional receipt photo.
- **Reports** with period switcher (Today / This month / Last month / Financial year / Custom):
  - Sales, Collected, To collect, Expenses, **Gross profit (sales − cost of goods)**, **Net profit**.
  - Top products, top customers, slow-moving stock, stock value.
  - **Pricing insight:** profit by channel / product / customer type, discounts given and why, custom vs catalogue share, real average wholesale discount, items sold below target margin.
- **Customer statement** (ledger) shareable as PDF/WhatsApp.
- **Done when:** "How much did I earn this month?" has one clear, correct number.

### Phase 5 — UX redesign for your mother (M, runs alongside 2–4)
- **Bottom navigation (4 tabs):** Home · Orders · Items · Money; Contacts reachable from Home and pickers (or 5th tab if she prefers).
- **Home = today's to-do:** "Collect ₹X from 3 customers", "2 orders to deliver", "4 items running low", big **＋ New order** button; this-month summary card.
- **Hindi + English** (ARB localisation, in-app toggle), Indian number format (₹1,23,456), readable dates ("11 Nov").
- **Light theme default + dark option**; min 16 sp body text, 48 dp touch targets, respects phone font size; high-contrast status colours with icons (not colour alone).
- Plain-language labels; confirmation for destructive actions; **Undo** everywhere else.
- Empty states with a single clear next step; 3-screen first-run setup (business name, logo, UPI ID).
- **Usability test:** watch your mother do 5 real tasks without help; fix what trips her up.
- **Done when:** she can complete create-order, deliver, record payment, add stock, check monthly profit unaided.

### Phase 6 — Documents: PDF bill & quote, GST-ready (M)
- Branded PDF quote / bill: logo, address, items, delivery, discount, totals, paid/balance, **UPI QR code** for instant payment.
- Share to WhatsApp directly; auto bill numbering (e.g. `BC-2026-0001`).
- **Payment reminder** button: polite WhatsApp message (English/Hindi) with due amount + PDF statement.
- GST fields present in model but hidden behind a setting; GST invoice template designed but **off** (future).
- **Done when:** a customer receives a professional PDF bill on WhatsApp in 2 taps.

### Phase 7 — Reliability: auto backup & reminders (M)
- **Automatic daily backup** of the SQLite file + photos to her **Google Drive app folder**; keep last 30 backups.
- One-tap **Restore** with preview (date, counts of orders/customers) before replacing; local pre-restore snapshot.
- Backup health on Home ("Last backup: today 9:14 pm" / red warning if > 3 days).
- Fix notifications: declare permission, one daily digest at a time she chooses (e.g. 9 am), no alert on app open; reminders for overdue payments and low stock.
- Crash reporting (Firebase Crashlytics or Sentry) so you see errors on her phone.
- **Done when:** losing or changing the phone loses at most one day of data.

### Phase 8 — Release & rollout (S)
- Distribute via **Play Console internal testing** (easy updates) or signed APK.
- Load real catalogue (products, recipes, customers, suppliers) with her.
- 2-week shadow period alongside her current notebook; collect feedback; fix.
- **Done when:** she stops using the notebook.

### Future (after rollout)
- **Cloud sync & multi-device** (you + her): Supabase/PowerSync on top of the Drift schema; login; conflict handling — schema is already sync-ready.
- **Full GST tax invoice:** GSTIN, HSN, CGST/SGST/IGST, B2B/B2C, GSTR-1 export.
- Online catalogue link to share with customers; custom/made-to-order specs with photos; Hindi voice input for notes; home-screen widget ("To collect: ₹X").

---

## 7. New functionality summary (prioritised)

**Must have:** selling price (model TBD) · edit/delete/undo everywhere · stock adjust · decimal quantities · production runs with cost per piece · purchases on credit · real profit (COGS) · PDF bill with UPI QR · auto Drive backup · Hindi + large text + light theme.

**Should have:** customer statement PDF · WhatsApp payment reminders · period reports & top products/customers · low-stock purchase list to supplier · receipt photos · first-run setup.

**Could have / future:** cloud sync · GST invoices · catalogue sharing · voice notes · widget.

---

## 8. Open questions to close before building
1. ~~Pricing model~~ — decided (§5.4). Still to confirm with her: her hourly rate, and whether the starting markups (retail ×2.5, wholesale ×1.8, overhead 10 %) feel right.
2. Expense categories she actually uses.
3. Bill numbering format and business profile details (name on bill, address, logo, UPI ID).
4. Does she take **advance payments** on custom orders? (affects order screen; model already supports it)
5. Does she want **Contacts** as its own tab or reached via Home/pickers?
