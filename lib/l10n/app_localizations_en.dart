// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class SEn extends S {
  SEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Bcreations';

  @override
  String get navHome => 'Home';

  @override
  String get navOrders => 'Orders';

  @override
  String get navCustomers => 'Customers';

  @override
  String get navItems => 'Items';

  @override
  String get navMoney => 'Money';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get undo => 'Undo';

  @override
  String get done => 'Done';

  @override
  String get skip => 'Skip';

  @override
  String get search => 'Search';

  @override
  String get required => 'Required';

  @override
  String get amount => 'Amount (₹)';

  @override
  String get date => 'Date';

  @override
  String get note => 'Note';

  @override
  String get quantity => 'Quantity';

  @override
  String get price => 'Price (₹)';

  @override
  String get total => 'Total';

  @override
  String get paid => 'Paid';

  @override
  String get balance => 'Balance';

  @override
  String get deleted => 'Deleted';

  @override
  String get saved => 'Saved';

  @override
  String get paidWith => 'Paid by';

  @override
  String get methodCash => 'Cash';

  @override
  String get methodUpi => 'UPI';

  @override
  String get methodBank => 'Bank';

  @override
  String get methodCheque => 'Cheque';

  @override
  String get methodOther => 'Other';

  @override
  String get amountMustBePositive => 'Enter an amount';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get homeGreeting => 'Namaste 🙏';

  @override
  String get homeToDo => 'Needs your attention';

  @override
  String homeCollect(String amount, int count) {
    return 'Collect $amount from $count customers';
  }

  @override
  String get homeCollectNone => 'Nobody owes you money';

  @override
  String homeOverdue(int count) {
    return '$count late';
  }

  @override
  String homeToDeliver(int count) {
    return '$count orders to deliver';
  }

  @override
  String homeQuotes(int count) {
    return '$count quotes waiting';
  }

  @override
  String homeAdvances(String amount) {
    return 'Advances held: $amount';
  }

  @override
  String homeLowStock(int count) {
    return '$count items running low';
  }

  @override
  String homePriceReview(int count) {
    return '$count prices to review';
  }

  @override
  String get homeAllGood => 'All caught up 👍';

  @override
  String get homeMonth => 'This month so far';

  @override
  String get homeSetupTitle => 'Finish setting up';

  @override
  String get homeSetupItems => 'Add what you have in stock';

  @override
  String get homeSetupCustomers => 'Add customers who owe you';

  @override
  String get homeSetupOrders => 'Add orders in progress';

  @override
  String get quickAdd => 'Add';

  @override
  String get quickNewOrder => 'New order';

  @override
  String get quickPayment => 'Payment received';

  @override
  String get quickExpense => 'Expense';

  @override
  String get quickWithdrawal => 'Took money for home';

  @override
  String get quickMake => 'Made items';

  @override
  String get quickBuy => 'Bought materials';

  @override
  String get customersAll => 'All';

  @override
  String get customersOwe => 'Owe money';

  @override
  String get customersSuppliers => 'Suppliers';

  @override
  String get customersEmpty => 'No customers yet. Tap + to add one.';

  @override
  String get customerNew => 'New customer';

  @override
  String get customerEdit => 'Edit customer';

  @override
  String get customerName => 'Name';

  @override
  String get customerBusiness => 'Shop / business name';

  @override
  String get customerPhone => 'Phone';

  @override
  String get customerType => 'Who is this?';

  @override
  String get roleCustomer => 'Customer';

  @override
  String get roleSupplier => 'Supplier';

  @override
  String get roleBoth => 'Both';

  @override
  String get priceTypeLabel => 'Price list';

  @override
  String get priceRetail => 'Retail (individual)';

  @override
  String get priceWholesale => 'Wholesale (shop)';

  @override
  String get creditLimit => 'Credit limit (₹)';

  @override
  String get paymentTerms => 'Pays within (days)';

  @override
  String get openingOwes => 'Already owes you (₹)';

  @override
  String owes(String amount) {
    return 'Owes $amount';
  }

  @override
  String youHold(String amount) {
    return 'You hold $amount';
  }

  @override
  String get settled => 'Settled';

  @override
  String daysLate(int days) {
    return '$days days late';
  }

  @override
  String get call => 'Call';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get sendReminder => 'Send reminder';

  @override
  String reminderText(String name, String business, String amount, String upiLine) {
    return 'Namaste $name, a gentle reminder from $business: $amount is pending.$upiLine Thank you!';
  }

  @override
  String reminderUpiLine(String upi) {
    return ' You can pay by UPI to $upi.';
  }

  @override
  String get noPhone => 'Add a phone number first';

  @override
  String get receivePayment => 'Receive payment';

  @override
  String get archive => 'Archive';

  @override
  String get archived => 'Archived';

  @override
  String get ordersSection => 'Orders';

  @override
  String get paymentsSection => 'Payments';

  @override
  String get noOrders => 'No orders yet';

  @override
  String get noPayments => 'No payments yet';

  @override
  String creditWarnLimit(String name, String limit) {
    return 'This goes over $name\'s credit limit of $limit.';
  }

  @override
  String creditWarnOverdue(String name, String amount) {
    return '$name has late payments ($amount owed).';
  }

  @override
  String get ordersOpen => 'Open';

  @override
  String get ordersDelivered => 'Delivered';

  @override
  String get ordersAll => 'All';

  @override
  String get ordersEmpty => 'No orders here yet.';

  @override
  String get statusQuote => 'Quote';

  @override
  String get statusConfirmed => 'To deliver';

  @override
  String get statusDelivered => 'Delivered';

  @override
  String get statusCancelled => 'Cancelled';

  @override
  String get payUnpaid => 'Unpaid';

  @override
  String get payPartly => 'Part paid';

  @override
  String get payPaid => 'Paid';

  @override
  String payAdvance(String amount) {
    return 'Advance $amount';
  }

  @override
  String get orderNew => 'New order';

  @override
  String get orderEdit => 'Edit order';

  @override
  String get orderCustomer => 'Customer';

  @override
  String get orderPickCustomer => 'Choose customer';

  @override
  String get orderItems => 'Items';

  @override
  String get orderAddItem => 'Add item';

  @override
  String get orderAddCustom => 'Custom item';

  @override
  String get orderCustomName => 'What is it?';

  @override
  String get orderColour => 'Colour';

  @override
  String get orderSize => 'Size';

  @override
  String get orderNameText => 'Name / words on it';

  @override
  String get orderDelivery => 'Delivery charge (₹)';

  @override
  String get orderDiscount => 'Discount on bill (₹)';

  @override
  String get orderDiscountReason => 'Reason for discount';

  @override
  String get orderPromised => 'Deliver by';

  @override
  String get orderDate => 'Order date';

  @override
  String get orderChannel => 'Where did this order come from?';

  @override
  String get channelShop => 'Shop';

  @override
  String get channelIndividual => 'Individual';

  @override
  String get channelExhibition => 'Exhibition';

  @override
  String get channelOnline => 'Instagram / online';

  @override
  String get orderJustQuote => 'Just a quote for now';

  @override
  String get orderAdvance => 'Advance received now (₹)';

  @override
  String get takeAdvance => 'Take advance';

  @override
  String get orderPhotos => 'Reference photos';

  @override
  String get orderAddPhoto => 'Add photo';

  @override
  String get orderNotes => 'Notes';

  @override
  String get orderMore => 'More details';

  @override
  String get orderNeedsItem => 'Add at least one item';

  @override
  String get orderNeedsCustomer => 'Choose a customer';

  @override
  String get lineDiscount => 'Discount on this item (₹)';

  @override
  String get marginHealthy => 'Good margin';

  @override
  String get marginThin => 'Low margin';

  @override
  String get marginLoss => 'Below cost!';

  @override
  String listPriceWas(String price) {
    return 'List price $price';
  }

  @override
  String inStock(String qty) {
    return '$qty in stock';
  }

  @override
  String get actionConfirm => 'Confirm order';

  @override
  String get actionDeliver => 'Mark delivered';

  @override
  String get actionCancelOrder => 'Cancel order';

  @override
  String get confirmCancelOrder => 'Cancel this order? Any advance paid becomes credit for the customer.';

  @override
  String get actionShare => 'Share';

  @override
  String orderDue(String date) {
    return 'Payment due $date';
  }

  @override
  String orderDeliverBy(String date) {
    return 'Deliver by $date';
  }

  @override
  String get subtotal => 'Items total';

  @override
  String get stockWarnTitle => 'Not enough stock';

  @override
  String stockWarnBody(String have, String name, String need) {
    return 'Only $have of $name in stock; this order needs $need. Deliver anyway?';
  }

  @override
  String get deliverAnyway => 'Deliver anyway';

  @override
  String get customItem => 'Custom item';

  @override
  String quoteText(String business) {
    return 'Quote from $business';
  }

  @override
  String billText(String business) {
    return 'Bill from $business';
  }

  @override
  String get paymentTitle => 'Payment received';

  @override
  String paymentForOrder(String number) {
    return 'For order $number';
  }

  @override
  String get paymentAnyOrder => 'Clears oldest dues first';

  @override
  String get paymentReference => 'UPI ref / sender';

  @override
  String paymentSaved(String amount) {
    return '$amount received';
  }

  @override
  String get itemsAll => 'All';

  @override
  String get itemsLow => 'Running low';

  @override
  String get itemsMaterials => 'Materials';

  @override
  String get itemsProducts => 'Products';

  @override
  String get itemsEmpty => 'No items yet. Tap + to add what you have.';

  @override
  String get itemNew => 'New item';

  @override
  String get itemEdit => 'Edit item';

  @override
  String get itemName => 'Name';

  @override
  String get itemKind => 'What kind?';

  @override
  String get kindRaw => 'Raw material';

  @override
  String get kindMade => 'I make this';

  @override
  String get kindBought => 'I buy & resell';

  @override
  String get itemUnit => 'Unit';

  @override
  String get itemCategory => 'Category';

  @override
  String get itemRetail => 'Retail price (₹)';

  @override
  String get itemWholesale => 'Wholesale price (₹)';

  @override
  String get retailLabel => 'Retail';

  @override
  String get wholesaleLabel => 'Wholesale';

  @override
  String get itemMinStock => 'Warn me below';

  @override
  String get itemOpeningQty => 'How many do you have now?';

  @override
  String get itemOpeningCost => 'Cost of one (₹)';

  @override
  String get itemRecipe => 'What goes into one piece?';

  @override
  String get itemAddMaterial => 'Add material';

  @override
  String get itemPhoto => 'Photo';

  @override
  String get onHand => 'In stock';

  @override
  String get stockValue => 'Stock value';

  @override
  String get costPerPiece => 'Cost of one';

  @override
  String suggestedPrices(String retail, String wholesale) {
    return 'Suggested: retail $retail · wholesale $wholesale';
  }

  @override
  String get priceReview => 'Material cost has gone up — review the price';

  @override
  String get actionBuy => 'Buy';

  @override
  String get actionMake => 'Make';

  @override
  String get actionAdjust => 'Adjust';

  @override
  String get actionCount => 'Count';

  @override
  String get history => 'History';

  @override
  String get buyTitle => 'Bought materials';

  @override
  String get buyItem => 'What did you buy?';

  @override
  String get buyTotalCost => 'Total paid (₹)';

  @override
  String get buySupplier => 'Supplier';

  @override
  String get makeTitle => 'Made items';

  @override
  String get makeItem => 'What did you make?';

  @override
  String get makeHowMany => 'How many did you make?';

  @override
  String get makeHours => 'About how many hours did this batch take?';

  @override
  String get makeNeeds => 'Materials needed';

  @override
  String makeShort(String qty) {
    return 'short by $qty';
  }

  @override
  String get makeAnyway => 'Make anyway';

  @override
  String get makeShortConfirm => 'Some materials are short. Make anyway?';

  @override
  String get makeNoRecipe => 'First add what goes into one piece (edit the item).';

  @override
  String get adjustTitle => 'Adjust stock';

  @override
  String get adjustRemove => 'Remove';

  @override
  String get adjustAdd => 'Add';

  @override
  String get reasonDamaged => 'Damaged';

  @override
  String get reasonHome => 'Used at home';

  @override
  String get reasonFound => 'Found extra';

  @override
  String get reasonOther => 'Other';

  @override
  String get countTitle => 'Shelf count';

  @override
  String get countHowMany => 'How many are on the shelf?';

  @override
  String countResult(String qty) {
    return 'Difference recorded: $qty';
  }

  @override
  String get countMatched => 'Matches the app 👍';

  @override
  String get moveOpening => 'Opening stock';

  @override
  String get movePurchase => 'Bought';

  @override
  String get moveProductionIn => 'Made';

  @override
  String get moveProductionUse => 'Used in making';

  @override
  String get moveSale => 'Sold';

  @override
  String get moveSaleReversal => 'Order cancelled';

  @override
  String get moveAdjustment => 'Adjusted';

  @override
  String get moveCount => 'Count difference';

  @override
  String get photoCamera => 'Take a photo';

  @override
  String get photoGallery => 'Choose from gallery';

  @override
  String get pickProduct => 'Choose item';

  @override
  String get pickNone => 'No matching items';

  @override
  String get moneySales => 'Sales';

  @override
  String get moneyCostOfGoods => 'Material cost of what sold';

  @override
  String get moneyLosses => 'Stock lost / damaged';

  @override
  String get moneyExpenses => 'Expenses';

  @override
  String get moneyProfit => 'Profit';

  @override
  String get moneyBridgeTitle => 'Where did my profit go?';

  @override
  String get moneyBridgeCustomers => 'Still with customers';

  @override
  String get moneyBridgeCustomersBack => 'Collected from older dues';

  @override
  String get moneyBridgeStock => 'Spent on extra stock';

  @override
  String get moneyBridgeStockBack => 'Sold from older stock';

  @override
  String get moneyBridgeHome => 'Taken for home';

  @override
  String get moneyBridgeCash => 'Cash actually added';

  @override
  String get moneyTime => 'Value of your time';

  @override
  String moneyTimeHint(String rate) {
    return 'Your hours at $rate/hour. Not deducted from profit.';
  }

  @override
  String get moneyDiscounts => 'Discounts given';

  @override
  String get moneyBest => 'Best sellers';

  @override
  String get moneyByQty => 'By quantity';

  @override
  String get moneyByProfit => 'By profit';

  @override
  String get moneyNoSales => 'No sales this month yet';

  @override
  String get moneyEntries => 'Expenses & money for home';

  @override
  String get moneyNoEntries => 'Nothing recorded this month';

  @override
  String get expenseTitle => 'Expense';

  @override
  String get expenseCategory => 'What for?';

  @override
  String get withdrawalTitle => 'Took money for home';

  @override
  String get withdrawalHint => 'Money taken out for family or personal use. It is not a business expense.';

  @override
  String get toCollect => 'To collect';

  @override
  String get advancesHeld => 'Advances held';

  @override
  String get catPackaging => 'Packaging';

  @override
  String get catCourier => 'Courier';

  @override
  String get catTravel => 'Travel';

  @override
  String get catPhone => 'Phone';

  @override
  String get catRent => 'Rent';

  @override
  String get catElectricity => 'Electricity';

  @override
  String get catHelper => 'Helper';

  @override
  String get catOther => 'Other';

  @override
  String get settingsBusiness => 'Business name';

  @override
  String get settingsUpi => 'UPI ID';

  @override
  String get settingsPhone => 'Phone';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsTheme => 'Appearance';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'Like phone';

  @override
  String get settingsPricing => 'Pricing';

  @override
  String get settingsHourly => 'Your time, per hour (₹)';

  @override
  String get settingsOverhead => 'Overhead %';

  @override
  String get settingsRetailMarkup => 'Retail price = cost ×';

  @override
  String get settingsWholesaleMarkup => 'Wholesale price = cost ×';

  @override
  String get settingsTargetMargin => 'Target margin %';

  @override
  String get settingsTerms => 'Shops pay within (days)';

  @override
  String get settingsData => 'Data';

  @override
  String get settingsDemo => 'Load demo data';

  @override
  String get settingsDemoConfirm => 'This deletes everything in the app and loads sample data. Continue?';

  @override
  String get settingsReset => 'Delete all data';

  @override
  String get settingsResetConfirm => 'This deletes everything in the app. It cannot be undone. Continue?';

  @override
  String get demoLoaded => 'Demo data loaded';

  @override
  String get welcomeTitle => 'Welcome to Bcreations';

  @override
  String get welcomeSubtitle => 'Orders, stock and money — all in one place.';

  @override
  String get welcomeLanguage => 'Choose language';

  @override
  String get welcomeBusiness => 'Your business name';

  @override
  String get welcomeStart => 'Start fresh';

  @override
  String get welcomeDemo => 'Try with sample data';

  @override
  String get welcomeFreshHint =>
      'You only need what is true today: stock on the shelf, who owes you, and orders in progress. Old records are optional.';
}
