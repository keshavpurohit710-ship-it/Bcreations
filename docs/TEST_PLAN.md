# Bcreations — Test Plan

The app exists to make your mother's work easier: know who owes what, never lose track of stock, see where the profit goes, keep family money separate, and spend *less* time on records, not more. Every test below checks one of those promises.

There are three layers:

| Layer | Who / when | What it proves |
|---|---|---|
| **A. Automated tests** | Run on every change (your PC: `flutter test`; GitHub runs them on every push) | The maths and the screens never silently break |
| **B. Your checklist** | You, on a phone, before every release to her | Each of her problems is actually solved, end to end |
| **C. Session with your mother** | Her, on her phone, with you watching | She can do it *without help*, in her words, faster than the notebook |

> ⚠️ **Before she enters real data:** automatic Google Drive backup is not built yet. Use sample data until it is, or accept that a lost phone loses the data.

---

## A. Automated tests (what already runs by itself)

| Her problem | Test file | What it checks (examples) |
|---|---|---|
| P1 Customers pay late | `test/goals/p1_payments_test.dart` | Dues list total and order (most-late first); lateness from due date; per-customer terms; part payments; undoing a duplicate payment; reminder text has name, amount, business and UPI in Hindi and English |
| P7 Advances forgotten | same file | Advance held → deducted on delivery; advance bigger than the bill becomes credit used next time; cancelled order keeps the advance as credit; refund clears it; editing keeps the advance |
| P9 Credit piles up | same file | Warns only when crossing the limit (exactly at limit is fine); warns on late payers within limit; no limit = no warning |
| P2 Lost track of stock | `test/goals/p2_stock_and_pricing_test.dart` | A full week (buy → make → sell → break → count) is right at every step; quotes don't take stock, delivery does, cancelling returns it; decimals never drift; "running low" appears and clears |
| P19 Runs out mid-order | same file | Shortage list says exactly what and how much; making is blocked until she buys; nothing is used up when blocked |
| P13 Custom requests | same file | Colour, size, name text and photos stay with the order through edits |
| P8 Undercharging | same file | Cost of one = materials + her time + overhead (₹209 worked example); red/amber/green margins; suggested prices; old orders keep their cost |
| P22 Material prices rise | same file | "Prices to review" only when cost rises > 10 % |
| P3 Profit not banked | `test/goals/p3_profit_test.dart` | Unpaid sales, stock bought, old dues collected and her time are each explained correctly in "Where did my profit go?" |
| P5 Family money mixed | same file | Money for home lowers cash, never profit, never counted as an expense |
| P10 Small expenses leak | same file | Every small expense in the month counts; deleted ones and other months don't |
| P4 Best sellers | same file | By quantity vs by profit; cancelled orders and quotes never count |
| **Everything at once** | `test/goals/money_audit_test.dart` | 10 random "lives" of the business, about 2,400 mixed actions over 4 months. Every month: profit bridge = real cash, every balance and stock level rebuilt from scratch matches, no payment used twice, no order over-paid |
| P6 Easy start, P26 search | `test/goals/journeys_test.dart` | Taps through the real app: Start fresh → checklist; add an item with just name + quantity; receive a payment in one tap; an expense in two taps; a new order with the price filled in; search; every word exists in Hindi |
| Screens don't break | `test/app_smoke_test.dart` | Every tab, detail screen and form opens with sample data in English and Hindi without layout errors |

Run them all:
```bash
flutter test
```

---

## B. Your checklist (before each release)

Install the latest build, then work through each section. Tick ✅ or note what went wrong.
```bash
flutter install --release
```

### B0 · Setup (P6)
| # | Do this | Expect | ✅ / note |
|---|---|---|---|
| 0.1 | Uninstall, reinstall, open | Welcome screen in Hindi, logo, "नई शुरुआत करें" and "नमूना डेटा से देखें" | |
| 0.2 | Switch to English, type a business name, tap **Start fresh** | Home with your business name and a 3-step "Finish setting up" card | |
| 0.3 | Tap **Add what you have in stock**: name "Silk potli", how many "12", Save | Back on Home; step 1 ticked. Took under 30 seconds | |
| 0.4 | Tap **Add customers who owe you**: name "Test shop", already owes ₹2,000, Save | Step 2 ticked; Home shows "Collect ₹2,000 from 1 customers" | |
| 0.5 | Tap **Add orders in progress**: pick Test shop, Custom item "Name plate", qty 1, price 500, advance 200, Save | Step 3 ticked; card disappears; "Advances held: ₹200" on Home | |

For the rest, go to **Settings → Load demo data** (it replaces everything with two months of sample activity).

### B1 · Late payments (P1, P9)
| # | Do this | Expect | ✅ / note |
|---|---|---|---|
| 1.1 | Look at Home | "Collect ₹… from N customers", how many are late, top 3 names with amounts | |
| 1.2 | Tap the green chat icon next to a late customer | WhatsApp opens with a polite message: name, amount, business, UPI | |
| 1.3 | Customers → **Owe money** | Only people who owe; the latest payer at the top | |
| 1.4 | Open a customer who owes → **Receive payment** | Amount already filled with what they owe; Save → "Settled" | |
| 1.5 | Tap **Undo** on the message straight after | They owe again | |
| 1.6 | Give *Kala Gift Shop* a new big order that crosses ₹10,000 credit limit | Red warning on the order screen before saving | |

### B2 · Advances on custom orders (P7, P13)
| # | Do this | Expect | ✅ / note |
|---|---|---|---|
| 2.1 | Orders → open *Priya (Instagram)* custom order | "Advance ₹5,000" badge; colour "Maroon with gold" and "Riya weds Karan" visible | |
| 2.2 | Edit it: add a reference photo, change quantity, Save | Photo and specs still there; advance still shown | |
| 2.3 | **Mark delivered** | Balance = total − advance; she owes the rest | |
| 2.4 | New order for someone, take ₹500 advance, then cancel the order | Customer shows "You hold ₹500" (not lost) | |

### B3 · Stock (P2, P19, P20)
| # | Do this | Expect | ✅ / note |
|---|---|---|---|
| 3.1 | Items → **Running low** | Items below their warning level, in red | |
| 3.2 | Open *Silk potli bag* → **Make** 50 | Materials list shows what's short and by how much; **Make anyway** only if you choose | |
| 3.3 | **Buy** the missing silk, then **Make** again | Works; stock of bags goes up, silk goes down by exactly the recipe amount | |
| 3.4 | **Adjust** → Remove 1 → Damaged | Stock down by 1; shows in history and in Money as "stock lost" | |
| 3.5 | **Count** → type the real shelf number | "Matches the app 👍" or the difference recorded | |
| 3.6 | Deliver an order with more than in stock | Warning "Only X in stock… Deliver anyway?" | |

### B4 · Pricing (P8, P22)
| # | Do this | Expect | ✅ / note |
|---|---|---|---|
| 4.1 | Open a made item | "Cost of one" and "Suggested: retail … · wholesale …" | |
| 4.2 | New order, type a price below cost | Red "Below cost!" on that line | |
| 4.3 | Order for a wholesale shop | Wholesale price fills in, not retail | |
| 4.4 | Buy a material at a much higher price, then make a batch | "Prices to review" appears on Home and on the item | |

### B5 · Money (P3, P4, P5, P10)
| # | Do this | Expect | ✅ / note |
|---|---|---|---|
| 5.1 | Money tab | Sales, material cost, expenses, **Profit** | |
| 5.2 | "Where did my profit go?" | Profit → still with customers → extra stock → taken for home → **cash actually added**; reads like a story | |
| 5.3 | ＋ → **Took money for home** ₹2,000 | Profit unchanged; "Taken for home" and cash added change | |
| 5.4 | ＋ → **Expense** → Courier ₹80 | Shows in the list; profit down by ₹80. Delete it → Undo works | |
| 5.5 | Best sellers: switch **By quantity / By profit** | The order can differ (most sold ≠ most profitable) | |
| 5.6 | Go to last month with ◀ | Last month's numbers | |

### B6 · Everyday comfort
| # | Do this | Expect | ✅ / note |
|---|---|---|---|
| 6.1 | Settings → हिन्दी | Every screen is in Hindi; nothing cut off | |
| 6.2 | Phone font size to largest | Still readable, nothing overlaps | |
| 6.3 | Settings → Dark | Readable in dark | |
| 6.4 | Turn on airplane mode and use the app | Everything works (no internet needed) | |
| 6.5 | Search a customer and an item by part of the name | Found | |

---

## C. Session with your mother

**Goal:** find where she hesitates, not prove that the app works. Her confusion is a bug in the app, never her mistake.

### Before
- Her phone, Hindi, large text as she normally uses it. Load demo data.
- Have a notebook or your phone's timer ready. Plan about 30 minutes.

### What to say (once, then stay quiet)
> "मैं ऐप जाँच रहा हूँ, आपको नहीं। जो मन में आए बोलती रहिए। अगर कुछ समझ न आए तो वो ऐप की गलती है।"
> ("I'm testing the app, not you. Think aloud. If something is confusing, that's the app's fault.")

Don't touch the phone or point. If she's stuck for over a minute, note it and help, then move on.

### Tasks (read one at a time, in her words)
| # | Task (say it like this) | Her problem | Target | Time taken | Where she hesitated / what she said |
|---|---|---|---|---|---|
| 1 | "आज किस-किस से पैसे लेने हैं? सबसे पुराना कौन है?" (Who do you need to collect from today? Who's the oldest?) | P1 | < 20 s | | |
| 2 | "आशा को याद दिलाने का मैसेज भेजिए।" (Send Asha a reminder.) | P1 | < 30 s | | |
| 3 | "प्रिया ने ₹2,000 एडवांस दिया, शादी के 10 पोटली, मरून रंग में, 'रिया वेड्स करण' लिखा हुआ। ऑर्डर लिखिए।" (Priya gave ₹2,000 advance for 10 wedding potlis, maroon, with 'Riya weds Karan'. Enter the order.) | P7, P13 | < 90 s | | |
| 4 | "कला गिफ्ट शॉप ने ₹3,000 दिए।" (Kala Gift Shop paid ₹3,000.) | P1 | < 30 s | | |
| 5 | "आज 20 राखी बनाईं, 3 घंटे लगे।" (You made 20 rakhis today, it took 3 hours.) | P2, P8 | < 45 s | | |
| 6 | "कूरियर के ₹80 दिए।" (Paid ₹80 for courier.) | P10 | < 20 s | | |
| 7 | "घर के लिए ₹2,000 निकाले।" (Took ₹2,000 for home.) | P5 | < 20 s | | |
| 8 | "इस महीने कितना मुनाफ़ा हुआ? और पैसा गया कहाँ?" (How much profit this month? Where did the money go?) | P3 | she can explain it back | | |
| 9 | "सबसे ज़्यादा क्या बिकता है?" (What sells the most?) | P4 | < 20 s | | |
| 10 | "लेस कितनी बची है?" (How much lace is left?) | P2 | < 20 s | | |

### After (ask, write her exact words)
1. "कौन सा काम सबसे आसान लगा? कौन सा सबसे मुश्किल?" (Easiest? Hardest?)
2. "कोई शब्द समझ नहीं आया?" (Any word you didn't understand?)
3. "क्या ये कॉपी से जल्दी है?" (Is this faster than the notebook?)
4. "1 से 5 में, रोज़ इस्तेमाल करेंगी?" (1–5, would you use it daily?)

### Pass for the session
- Tasks 1–7 done **without help**, each within about twice the target time.
- She can explain task 8 in her own words.
- Every word she didn't understand gets changed in `tool/strings.mjs`.

### Then: two weeks side by side
After automatic backup is ready, she uses the app **and** her notebook for two weeks.
- **Every evening (2 min):** do the dues on Home match the notebook? Fix any difference.
- **Each weekend:** shelf count for 5 random items. Any differences?
- **End of week 2:** month's profit and "Where did my profit go?" — does it match what she feels happened?
- **Done when** she stops writing in the notebook because she doesn't need it.

---

## Problem → test map

| # | Problem | Automated | Your checklist | Her session |
|---|---|---|---|---|
| P1 | Customers pay late | p1_payments, journeys | B1 | 1, 2, 4 |
| P2 | Loses track of stock | p2_stock_and_pricing, money_audit | B3 | 5, 10 |
| P3 | Profit not banked | p3_profit, money_audit | B5 | 8 |
| P4 | Best sellers unknown | p3_profit | B5.5 | 9 |
| P5 | Family money mixed | p3_profit | B5.3 | 7 |
| P6 | Onboarding is a burden | journeys | B0 | (first use) |
| P7 | Advances forgotten | p1_payments | B2 | 3 |
| P8 | Undercharging | p2_stock_and_pricing | B4 | 5 |
| P9 | Credit piles up | p1_payments | B1.6 | — |
| P10 | Small expenses leak | p3_profit, journeys | B5.4 | 6 |
| P13 | Custom requests misunderstood | p2_stock_and_pricing | B2 | 3 |
| P19 | Runs out mid-order | p2_stock_and_pricing | B3.2–3.3 | — |
| P22 | Material prices rise | p2_stock_and_pricing | B4.4 | — |
| P26 | Records hard to find | journeys | B6.5 | 10 |

Release 2 problems (returns, consignment, karigars, catalogue, PDF bills, production planner, slow stock) get tests here when they are built.
