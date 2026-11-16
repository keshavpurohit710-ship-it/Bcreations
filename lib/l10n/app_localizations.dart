import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of S
/// returned by `S.of(context)`.
///
/// Applications need to include `S.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: S.localizationsDelegates,
///   supportedLocales: S.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the S.supportedLocales
/// property.
abstract class S {
  S(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S)!;
  }

  static const LocalizationsDelegate<S> delegate = _SDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Bcreations'**
  String get appName;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navOrders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get navOrders;

  /// No description provided for @navCustomers.
  ///
  /// In en, this message translates to:
  /// **'Customers'**
  String get navCustomers;

  /// No description provided for @navItems.
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get navItems;

  /// No description provided for @navMoney.
  ///
  /// In en, this message translates to:
  /// **'Money'**
  String get navMoney;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount (₹)'**
  String get amount;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get note;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price (₹)'**
  String get price;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @paid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paid;

  /// No description provided for @balance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get balance;

  /// No description provided for @deleted.
  ///
  /// In en, this message translates to:
  /// **'Deleted'**
  String get deleted;

  /// No description provided for @saved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get saved;

  /// No description provided for @paidWith.
  ///
  /// In en, this message translates to:
  /// **'Paid by'**
  String get paidWith;

  /// No description provided for @methodCash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get methodCash;

  /// No description provided for @methodUpi.
  ///
  /// In en, this message translates to:
  /// **'UPI'**
  String get methodUpi;

  /// No description provided for @methodBank.
  ///
  /// In en, this message translates to:
  /// **'Bank'**
  String get methodBank;

  /// No description provided for @methodCheque.
  ///
  /// In en, this message translates to:
  /// **'Cheque'**
  String get methodCheque;

  /// No description provided for @methodOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get methodOther;

  /// No description provided for @amountMustBePositive.
  ///
  /// In en, this message translates to:
  /// **'Enter an amount'**
  String get amountMustBePositive;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @homeGreeting.
  ///
  /// In en, this message translates to:
  /// **'Namaste 🙏'**
  String get homeGreeting;

  /// No description provided for @homeToDo.
  ///
  /// In en, this message translates to:
  /// **'Needs your attention'**
  String get homeToDo;

  /// No description provided for @homeCollect.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Collect {amount} from 1 customer} other{Collect {amount} from {count} customers}}'**
  String homeCollect(String amount, int count);

  /// No description provided for @homeCollectNone.
  ///
  /// In en, this message translates to:
  /// **'Nobody owes you money'**
  String get homeCollectNone;

  /// No description provided for @homeOverdue.
  ///
  /// In en, this message translates to:
  /// **'{count} late'**
  String homeOverdue(int count);

  /// No description provided for @homeToDeliver.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 order to deliver} other{{count} orders to deliver}}'**
  String homeToDeliver(int count);

  /// No description provided for @homeQuotes.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 quote waiting} other{{count} quotes waiting}}'**
  String homeQuotes(int count);

  /// No description provided for @homeAdvances.
  ///
  /// In en, this message translates to:
  /// **'Advances held: {amount}'**
  String homeAdvances(String amount);

  /// No description provided for @homeLowStock.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 item running low} other{{count} items running low}}'**
  String homeLowStock(int count);

  /// No description provided for @homePriceReview.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 price to review} other{{count} prices to review}}'**
  String homePriceReview(int count);

  /// No description provided for @homeAllGood.
  ///
  /// In en, this message translates to:
  /// **'All caught up 👍'**
  String get homeAllGood;

  /// No description provided for @homeMonth.
  ///
  /// In en, this message translates to:
  /// **'This month so far'**
  String get homeMonth;

  /// No description provided for @homeSetupTitle.
  ///
  /// In en, this message translates to:
  /// **'Finish setting up'**
  String get homeSetupTitle;

  /// No description provided for @homeSetupItems.
  ///
  /// In en, this message translates to:
  /// **'Add what you have in stock'**
  String get homeSetupItems;

  /// No description provided for @homeSetupCustomers.
  ///
  /// In en, this message translates to:
  /// **'Add customers who owe you'**
  String get homeSetupCustomers;

  /// No description provided for @homeSetupOrders.
  ///
  /// In en, this message translates to:
  /// **'Add orders in progress'**
  String get homeSetupOrders;

  /// No description provided for @quickAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get quickAdd;

  /// No description provided for @quickNewOrder.
  ///
  /// In en, this message translates to:
  /// **'New order'**
  String get quickNewOrder;

  /// No description provided for @quickPayment.
  ///
  /// In en, this message translates to:
  /// **'Payment received'**
  String get quickPayment;

  /// No description provided for @quickExpense.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get quickExpense;

  /// No description provided for @quickWithdrawal.
  ///
  /// In en, this message translates to:
  /// **'Took money for home'**
  String get quickWithdrawal;

  /// No description provided for @quickMake.
  ///
  /// In en, this message translates to:
  /// **'Made items'**
  String get quickMake;

  /// No description provided for @quickBuy.
  ///
  /// In en, this message translates to:
  /// **'Bought materials'**
  String get quickBuy;

  /// No description provided for @customersAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get customersAll;

  /// No description provided for @customersOwe.
  ///
  /// In en, this message translates to:
  /// **'Owe money'**
  String get customersOwe;

  /// No description provided for @customersSuppliers.
  ///
  /// In en, this message translates to:
  /// **'Suppliers'**
  String get customersSuppliers;

  /// No description provided for @customersEmpty.
  ///
  /// In en, this message translates to:
  /// **'No customers yet. Tap + to add one.'**
  String get customersEmpty;

  /// No description provided for @customerNew.
  ///
  /// In en, this message translates to:
  /// **'New customer'**
  String get customerNew;

  /// No description provided for @customerEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit customer'**
  String get customerEdit;

  /// No description provided for @customerName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get customerName;

  /// No description provided for @customerBusiness.
  ///
  /// In en, this message translates to:
  /// **'Shop / business name'**
  String get customerBusiness;

  /// No description provided for @customerPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get customerPhone;

  /// No description provided for @customerType.
  ///
  /// In en, this message translates to:
  /// **'Who is this?'**
  String get customerType;

  /// No description provided for @roleCustomer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get roleCustomer;

  /// No description provided for @roleSupplier.
  ///
  /// In en, this message translates to:
  /// **'Supplier'**
  String get roleSupplier;

  /// No description provided for @roleBoth.
  ///
  /// In en, this message translates to:
  /// **'Both'**
  String get roleBoth;

  /// No description provided for @priceTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Price list'**
  String get priceTypeLabel;

  /// No description provided for @priceRetail.
  ///
  /// In en, this message translates to:
  /// **'Retail (individual)'**
  String get priceRetail;

  /// No description provided for @priceWholesale.
  ///
  /// In en, this message translates to:
  /// **'Wholesale (shop)'**
  String get priceWholesale;

  /// No description provided for @creditLimit.
  ///
  /// In en, this message translates to:
  /// **'Credit limit (₹)'**
  String get creditLimit;

  /// No description provided for @paymentTerms.
  ///
  /// In en, this message translates to:
  /// **'Pays within (days)'**
  String get paymentTerms;

  /// No description provided for @openingOwes.
  ///
  /// In en, this message translates to:
  /// **'Already owes you (₹)'**
  String get openingOwes;

  /// No description provided for @owes.
  ///
  /// In en, this message translates to:
  /// **'Owes {amount}'**
  String owes(String amount);

  /// No description provided for @youHold.
  ///
  /// In en, this message translates to:
  /// **'You hold {amount}'**
  String youHold(String amount);

  /// No description provided for @settled.
  ///
  /// In en, this message translates to:
  /// **'Settled'**
  String get settled;

  /// No description provided for @daysLate.
  ///
  /// In en, this message translates to:
  /// **'{days} days late'**
  String daysLate(int days);

  /// No description provided for @call.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get call;

  /// No description provided for @whatsapp.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp'**
  String get whatsapp;

  /// No description provided for @sendReminder.
  ///
  /// In en, this message translates to:
  /// **'Send reminder'**
  String get sendReminder;

  /// No description provided for @reminderText.
  ///
  /// In en, this message translates to:
  /// **'Namaste {name}, a gentle reminder from {business}: {amount} is pending.{upiLine} Thank you!'**
  String reminderText(
      String name, String business, String amount, String upiLine);

  /// No description provided for @reminderUpiLine.
  ///
  /// In en, this message translates to:
  /// **' You can pay by UPI to {upi}.'**
  String reminderUpiLine(String upi);

  /// No description provided for @noPhone.
  ///
  /// In en, this message translates to:
  /// **'Add a phone number first'**
  String get noPhone;

  /// No description provided for @receivePayment.
  ///
  /// In en, this message translates to:
  /// **'Receive payment'**
  String get receivePayment;

  /// No description provided for @archive.
  ///
  /// In en, this message translates to:
  /// **'Archive'**
  String get archive;

  /// No description provided for @archived.
  ///
  /// In en, this message translates to:
  /// **'Archived'**
  String get archived;

  /// No description provided for @ordersSection.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get ordersSection;

  /// No description provided for @paymentsSection.
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get paymentsSection;

  /// No description provided for @noOrders.
  ///
  /// In en, this message translates to:
  /// **'No orders yet'**
  String get noOrders;

  /// No description provided for @noPayments.
  ///
  /// In en, this message translates to:
  /// **'No payments yet'**
  String get noPayments;

  /// No description provided for @creditWarnLimit.
  ///
  /// In en, this message translates to:
  /// **'This goes over {name}\'s credit limit of {limit}.'**
  String creditWarnLimit(String name, String limit);

  /// No description provided for @creditWarnOverdue.
  ///
  /// In en, this message translates to:
  /// **'{name} has late payments ({amount} owed).'**
  String creditWarnOverdue(String name, String amount);

  /// No description provided for @ordersOpen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get ordersOpen;

  /// No description provided for @ordersDelivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get ordersDelivered;

  /// No description provided for @ordersAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get ordersAll;

  /// No description provided for @ordersEmpty.
  ///
  /// In en, this message translates to:
  /// **'No orders here yet.'**
  String get ordersEmpty;

  /// No description provided for @statusQuote.
  ///
  /// In en, this message translates to:
  /// **'Quote'**
  String get statusQuote;

  /// No description provided for @statusConfirmed.
  ///
  /// In en, this message translates to:
  /// **'To deliver'**
  String get statusConfirmed;

  /// No description provided for @statusDelivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get statusDelivered;

  /// No description provided for @statusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get statusCancelled;

  /// No description provided for @payUnpaid.
  ///
  /// In en, this message translates to:
  /// **'Unpaid'**
  String get payUnpaid;

  /// No description provided for @payPartly.
  ///
  /// In en, this message translates to:
  /// **'Part paid'**
  String get payPartly;

  /// No description provided for @payPaid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get payPaid;

  /// No description provided for @payAdvance.
  ///
  /// In en, this message translates to:
  /// **'Advance {amount}'**
  String payAdvance(String amount);

  /// No description provided for @orderNew.
  ///
  /// In en, this message translates to:
  /// **'New order'**
  String get orderNew;

  /// No description provided for @orderEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit order'**
  String get orderEdit;

  /// No description provided for @orderCustomer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get orderCustomer;

  /// No description provided for @orderPickCustomer.
  ///
  /// In en, this message translates to:
  /// **'Choose customer'**
  String get orderPickCustomer;

  /// No description provided for @orderItems.
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get orderItems;

  /// No description provided for @orderAddItem.
  ///
  /// In en, this message translates to:
  /// **'Add item'**
  String get orderAddItem;

  /// No description provided for @orderAddCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom item'**
  String get orderAddCustom;

  /// No description provided for @orderCustomName.
  ///
  /// In en, this message translates to:
  /// **'What is it?'**
  String get orderCustomName;

  /// No description provided for @orderColour.
  ///
  /// In en, this message translates to:
  /// **'Colour'**
  String get orderColour;

  /// No description provided for @orderSize.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get orderSize;

  /// No description provided for @orderNameText.
  ///
  /// In en, this message translates to:
  /// **'Name / words on it'**
  String get orderNameText;

  /// No description provided for @orderDelivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery charge (₹)'**
  String get orderDelivery;

  /// No description provided for @orderDiscount.
  ///
  /// In en, this message translates to:
  /// **'Discount on bill (₹)'**
  String get orderDiscount;

  /// No description provided for @orderDiscountReason.
  ///
  /// In en, this message translates to:
  /// **'Reason for discount'**
  String get orderDiscountReason;

  /// No description provided for @orderPromised.
  ///
  /// In en, this message translates to:
  /// **'Deliver by'**
  String get orderPromised;

  /// No description provided for @orderDate.
  ///
  /// In en, this message translates to:
  /// **'Order date'**
  String get orderDate;

  /// No description provided for @orderChannel.
  ///
  /// In en, this message translates to:
  /// **'Where did this order come from?'**
  String get orderChannel;

  /// No description provided for @channelShop.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get channelShop;

  /// No description provided for @channelIndividual.
  ///
  /// In en, this message translates to:
  /// **'Individual'**
  String get channelIndividual;

  /// No description provided for @channelExhibition.
  ///
  /// In en, this message translates to:
  /// **'Exhibition'**
  String get channelExhibition;

  /// No description provided for @channelOnline.
  ///
  /// In en, this message translates to:
  /// **'Instagram / online'**
  String get channelOnline;

  /// No description provided for @orderJustQuote.
  ///
  /// In en, this message translates to:
  /// **'Just a quote for now'**
  String get orderJustQuote;

  /// No description provided for @orderAdvance.
  ///
  /// In en, this message translates to:
  /// **'Advance received now (₹)'**
  String get orderAdvance;

  /// No description provided for @takeAdvance.
  ///
  /// In en, this message translates to:
  /// **'Take advance'**
  String get takeAdvance;

  /// No description provided for @orderPhotos.
  ///
  /// In en, this message translates to:
  /// **'Reference photos'**
  String get orderPhotos;

  /// No description provided for @orderAddPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add photo'**
  String get orderAddPhoto;

  /// No description provided for @orderNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get orderNotes;

  /// No description provided for @orderMore.
  ///
  /// In en, this message translates to:
  /// **'More details'**
  String get orderMore;

  /// No description provided for @orderNeedsItem.
  ///
  /// In en, this message translates to:
  /// **'Add at least one item'**
  String get orderNeedsItem;

  /// No description provided for @orderNeedsCustomer.
  ///
  /// In en, this message translates to:
  /// **'Choose a customer'**
  String get orderNeedsCustomer;

  /// No description provided for @lineDiscount.
  ///
  /// In en, this message translates to:
  /// **'Discount on this item (₹)'**
  String get lineDiscount;

  /// No description provided for @marginHealthy.
  ///
  /// In en, this message translates to:
  /// **'Good margin'**
  String get marginHealthy;

  /// No description provided for @marginThin.
  ///
  /// In en, this message translates to:
  /// **'Low margin'**
  String get marginThin;

  /// No description provided for @marginLoss.
  ///
  /// In en, this message translates to:
  /// **'Below cost!'**
  String get marginLoss;

  /// No description provided for @listPriceWas.
  ///
  /// In en, this message translates to:
  /// **'List price {price}'**
  String listPriceWas(String price);

  /// No description provided for @inStock.
  ///
  /// In en, this message translates to:
  /// **'{qty} in stock'**
  String inStock(String qty);

  /// No description provided for @actionConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm order'**
  String get actionConfirm;

  /// No description provided for @actionDeliver.
  ///
  /// In en, this message translates to:
  /// **'Mark delivered'**
  String get actionDeliver;

  /// No description provided for @actionCancelOrder.
  ///
  /// In en, this message translates to:
  /// **'Cancel order'**
  String get actionCancelOrder;

  /// No description provided for @confirmCancelOrder.
  ///
  /// In en, this message translates to:
  /// **'Cancel this order? Any advance paid becomes credit for the customer.'**
  String get confirmCancelOrder;

  /// No description provided for @actionShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get actionShare;

  /// No description provided for @orderDue.
  ///
  /// In en, this message translates to:
  /// **'Payment due {date}'**
  String orderDue(String date);

  /// No description provided for @orderDeliverBy.
  ///
  /// In en, this message translates to:
  /// **'Deliver by {date}'**
  String orderDeliverBy(String date);

  /// No description provided for @subtotal.
  ///
  /// In en, this message translates to:
  /// **'Items total'**
  String get subtotal;

  /// No description provided for @stockWarnTitle.
  ///
  /// In en, this message translates to:
  /// **'Not enough stock'**
  String get stockWarnTitle;

  /// No description provided for @stockWarnBody.
  ///
  /// In en, this message translates to:
  /// **'Only {have} of {name} in stock; this order needs {need}. Deliver anyway?'**
  String stockWarnBody(String have, String name, String need);

  /// No description provided for @deliverAnyway.
  ///
  /// In en, this message translates to:
  /// **'Deliver anyway'**
  String get deliverAnyway;

  /// No description provided for @customItem.
  ///
  /// In en, this message translates to:
  /// **'Custom item'**
  String get customItem;

  /// No description provided for @quoteText.
  ///
  /// In en, this message translates to:
  /// **'Quote from {business}'**
  String quoteText(String business);

  /// No description provided for @billText.
  ///
  /// In en, this message translates to:
  /// **'Bill from {business}'**
  String billText(String business);

  /// No description provided for @paymentTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment received'**
  String get paymentTitle;

  /// No description provided for @paymentForOrder.
  ///
  /// In en, this message translates to:
  /// **'For order {number}'**
  String paymentForOrder(String number);

  /// No description provided for @paymentAnyOrder.
  ///
  /// In en, this message translates to:
  /// **'Clears oldest dues first'**
  String get paymentAnyOrder;

  /// No description provided for @paymentReference.
  ///
  /// In en, this message translates to:
  /// **'UPI ref / sender'**
  String get paymentReference;

  /// No description provided for @paymentSaved.
  ///
  /// In en, this message translates to:
  /// **'{amount} received'**
  String paymentSaved(String amount);

  /// No description provided for @itemsAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get itemsAll;

  /// No description provided for @itemsLow.
  ///
  /// In en, this message translates to:
  /// **'Running low'**
  String get itemsLow;

  /// No description provided for @itemsMaterials.
  ///
  /// In en, this message translates to:
  /// **'Materials'**
  String get itemsMaterials;

  /// No description provided for @itemsProducts.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get itemsProducts;

  /// No description provided for @itemsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No items yet. Tap + to add what you have.'**
  String get itemsEmpty;

  /// No description provided for @itemNew.
  ///
  /// In en, this message translates to:
  /// **'New item'**
  String get itemNew;

  /// No description provided for @itemEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit item'**
  String get itemEdit;

  /// No description provided for @itemName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get itemName;

  /// No description provided for @itemKind.
  ///
  /// In en, this message translates to:
  /// **'What kind?'**
  String get itemKind;

  /// No description provided for @kindRaw.
  ///
  /// In en, this message translates to:
  /// **'Raw material'**
  String get kindRaw;

  /// No description provided for @kindMade.
  ///
  /// In en, this message translates to:
  /// **'I make this'**
  String get kindMade;

  /// No description provided for @kindBought.
  ///
  /// In en, this message translates to:
  /// **'I buy & resell'**
  String get kindBought;

  /// No description provided for @itemUnit.
  ///
  /// In en, this message translates to:
  /// **'Unit (how you count it)'**
  String get itemUnit;

  /// No description provided for @itemCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get itemCategory;

  /// No description provided for @itemRetail.
  ///
  /// In en, this message translates to:
  /// **'Retail price per {unit} (₹)'**
  String itemRetail(String unit);

  /// No description provided for @itemWholesale.
  ///
  /// In en, this message translates to:
  /// **'Wholesale price per {unit} (₹)'**
  String itemWholesale(String unit);

  /// No description provided for @retailLabel.
  ///
  /// In en, this message translates to:
  /// **'Retail per {unit}'**
  String retailLabel(String unit);

  /// No description provided for @wholesaleLabel.
  ///
  /// In en, this message translates to:
  /// **'Wholesale per {unit}'**
  String wholesaleLabel(String unit);

  /// No description provided for @itemMinStock.
  ///
  /// In en, this message translates to:
  /// **'Warn me when stock is below'**
  String get itemMinStock;

  /// No description provided for @itemOpeningQty.
  ///
  /// In en, this message translates to:
  /// **'Stock you have now'**
  String get itemOpeningQty;

  /// No description provided for @itemOpeningCost.
  ///
  /// In en, this message translates to:
  /// **'Cost per {unit} (₹)'**
  String itemOpeningCost(String unit);

  /// No description provided for @itemRecipe.
  ///
  /// In en, this message translates to:
  /// **'What goes into one piece?'**
  String get itemRecipe;

  /// No description provided for @itemAddMaterial.
  ///
  /// In en, this message translates to:
  /// **'Add material'**
  String get itemAddMaterial;

  /// No description provided for @itemPhoto.
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get itemPhoto;

  /// No description provided for @onHand.
  ///
  /// In en, this message translates to:
  /// **'In stock'**
  String get onHand;

  /// No description provided for @stockValue.
  ///
  /// In en, this message translates to:
  /// **'Value of all this stock'**
  String get stockValue;

  /// No description provided for @costPerPiece.
  ///
  /// In en, this message translates to:
  /// **'Cost per {unit}'**
  String costPerPiece(String unit);

  /// No description provided for @suggestedPrices.
  ///
  /// In en, this message translates to:
  /// **'Suggested per {unit}: retail {retail} · wholesale {wholesale}'**
  String suggestedPrices(String unit, String retail, String wholesale);

  /// No description provided for @priceReview.
  ///
  /// In en, this message translates to:
  /// **'Material cost has gone up — review the price'**
  String get priceReview;

  /// No description provided for @actionBuy.
  ///
  /// In en, this message translates to:
  /// **'Buy'**
  String get actionBuy;

  /// No description provided for @actionMake.
  ///
  /// In en, this message translates to:
  /// **'Make'**
  String get actionMake;

  /// No description provided for @actionAdjust.
  ///
  /// In en, this message translates to:
  /// **'Adjust'**
  String get actionAdjust;

  /// No description provided for @actionCount.
  ///
  /// In en, this message translates to:
  /// **'Count'**
  String get actionCount;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @buyTitle.
  ///
  /// In en, this message translates to:
  /// **'Bought materials'**
  String get buyTitle;

  /// No description provided for @buyItem.
  ///
  /// In en, this message translates to:
  /// **'What did you buy?'**
  String get buyItem;

  /// No description provided for @buyTotalCost.
  ///
  /// In en, this message translates to:
  /// **'Total paid for all (₹)'**
  String get buyTotalCost;

  /// No description provided for @buySupplier.
  ///
  /// In en, this message translates to:
  /// **'Supplier'**
  String get buySupplier;

  /// No description provided for @makeTitle.
  ///
  /// In en, this message translates to:
  /// **'Made items'**
  String get makeTitle;

  /// No description provided for @makeItem.
  ///
  /// In en, this message translates to:
  /// **'What did you make?'**
  String get makeItem;

  /// No description provided for @makeHowMany.
  ///
  /// In en, this message translates to:
  /// **'How many pieces did you make?'**
  String get makeHowMany;

  /// No description provided for @makeHours.
  ///
  /// In en, this message translates to:
  /// **'About how many hours did this batch take?'**
  String get makeHours;

  /// No description provided for @makeNeeds.
  ///
  /// In en, this message translates to:
  /// **'Materials needed'**
  String get makeNeeds;

  /// No description provided for @makeShort.
  ///
  /// In en, this message translates to:
  /// **'short by {qty}'**
  String makeShort(String qty);

  /// No description provided for @makeAnyway.
  ///
  /// In en, this message translates to:
  /// **'Make anyway'**
  String get makeAnyway;

  /// No description provided for @makeShortConfirm.
  ///
  /// In en, this message translates to:
  /// **'Some materials are short. Make anyway?'**
  String get makeShortConfirm;

  /// No description provided for @makeNoRecipe.
  ///
  /// In en, this message translates to:
  /// **'First add what goes into one piece (edit the item).'**
  String get makeNoRecipe;

  /// No description provided for @adjustTitle.
  ///
  /// In en, this message translates to:
  /// **'Adjust stock'**
  String get adjustTitle;

  /// No description provided for @adjustRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get adjustRemove;

  /// No description provided for @adjustAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get adjustAdd;

  /// No description provided for @reasonDamaged.
  ///
  /// In en, this message translates to:
  /// **'Damaged'**
  String get reasonDamaged;

  /// No description provided for @reasonHome.
  ///
  /// In en, this message translates to:
  /// **'Used at home'**
  String get reasonHome;

  /// No description provided for @reasonFound.
  ///
  /// In en, this message translates to:
  /// **'Found extra'**
  String get reasonFound;

  /// No description provided for @reasonOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get reasonOther;

  /// No description provided for @countTitle.
  ///
  /// In en, this message translates to:
  /// **'Shelf count'**
  String get countTitle;

  /// No description provided for @countHowMany.
  ///
  /// In en, this message translates to:
  /// **'How many are on the shelf?'**
  String get countHowMany;

  /// No description provided for @countResult.
  ///
  /// In en, this message translates to:
  /// **'Difference recorded: {qty}'**
  String countResult(String qty);

  /// No description provided for @countMatched.
  ///
  /// In en, this message translates to:
  /// **'Matches the app 👍'**
  String get countMatched;

  /// No description provided for @moveOpening.
  ///
  /// In en, this message translates to:
  /// **'Opening stock'**
  String get moveOpening;

  /// No description provided for @movePurchase.
  ///
  /// In en, this message translates to:
  /// **'Bought'**
  String get movePurchase;

  /// No description provided for @moveProductionIn.
  ///
  /// In en, this message translates to:
  /// **'Made'**
  String get moveProductionIn;

  /// No description provided for @moveProductionUse.
  ///
  /// In en, this message translates to:
  /// **'Used in making'**
  String get moveProductionUse;

  /// No description provided for @moveSale.
  ///
  /// In en, this message translates to:
  /// **'Sold'**
  String get moveSale;

  /// No description provided for @moveSaleReversal.
  ///
  /// In en, this message translates to:
  /// **'Order cancelled'**
  String get moveSaleReversal;

  /// No description provided for @moveAdjustment.
  ///
  /// In en, this message translates to:
  /// **'Adjusted'**
  String get moveAdjustment;

  /// No description provided for @moveCount.
  ///
  /// In en, this message translates to:
  /// **'Count difference'**
  String get moveCount;

  /// No description provided for @photoCamera.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get photoCamera;

  /// No description provided for @photoGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get photoGallery;

  /// No description provided for @pickProduct.
  ///
  /// In en, this message translates to:
  /// **'Choose item'**
  String get pickProduct;

  /// No description provided for @pickNone.
  ///
  /// In en, this message translates to:
  /// **'No matching items'**
  String get pickNone;

  /// No description provided for @moneySales.
  ///
  /// In en, this message translates to:
  /// **'Sales'**
  String get moneySales;

  /// No description provided for @moneyCostOfGoods.
  ///
  /// In en, this message translates to:
  /// **'Material cost of what sold'**
  String get moneyCostOfGoods;

  /// No description provided for @moneyLosses.
  ///
  /// In en, this message translates to:
  /// **'Stock lost / damaged'**
  String get moneyLosses;

  /// No description provided for @moneyExpenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get moneyExpenses;

  /// No description provided for @moneyProfit.
  ///
  /// In en, this message translates to:
  /// **'Profit'**
  String get moneyProfit;

  /// No description provided for @moneyBridgeTitle.
  ///
  /// In en, this message translates to:
  /// **'Where did my profit go?'**
  String get moneyBridgeTitle;

  /// No description provided for @moneyBridgeCustomers.
  ///
  /// In en, this message translates to:
  /// **'Still with customers'**
  String get moneyBridgeCustomers;

  /// No description provided for @moneyBridgeCustomersBack.
  ///
  /// In en, this message translates to:
  /// **'Collected from older dues'**
  String get moneyBridgeCustomersBack;

  /// No description provided for @moneyBridgeStock.
  ///
  /// In en, this message translates to:
  /// **'Spent on extra stock'**
  String get moneyBridgeStock;

  /// No description provided for @moneyBridgeStockBack.
  ///
  /// In en, this message translates to:
  /// **'Sold from older stock'**
  String get moneyBridgeStockBack;

  /// No description provided for @moneyBridgeHome.
  ///
  /// In en, this message translates to:
  /// **'Taken for home'**
  String get moneyBridgeHome;

  /// No description provided for @moneyBridgeCash.
  ///
  /// In en, this message translates to:
  /// **'Cash actually added'**
  String get moneyBridgeCash;

  /// No description provided for @moneyTime.
  ///
  /// In en, this message translates to:
  /// **'Value of your time'**
  String get moneyTime;

  /// No description provided for @moneyTimeHint.
  ///
  /// In en, this message translates to:
  /// **'Your hours at {rate}/hour. Not deducted from profit.'**
  String moneyTimeHint(String rate);

  /// No description provided for @moneyDiscounts.
  ///
  /// In en, this message translates to:
  /// **'Discounts given'**
  String get moneyDiscounts;

  /// No description provided for @moneyBest.
  ///
  /// In en, this message translates to:
  /// **'Best sellers'**
  String get moneyBest;

  /// No description provided for @moneyByQty.
  ///
  /// In en, this message translates to:
  /// **'By quantity'**
  String get moneyByQty;

  /// No description provided for @moneyByProfit.
  ///
  /// In en, this message translates to:
  /// **'By profit'**
  String get moneyByProfit;

  /// No description provided for @moneyNoSales.
  ///
  /// In en, this message translates to:
  /// **'No sales this month yet'**
  String get moneyNoSales;

  /// No description provided for @moneyEntries.
  ///
  /// In en, this message translates to:
  /// **'Expenses & money for home'**
  String get moneyEntries;

  /// No description provided for @moneyNoEntries.
  ///
  /// In en, this message translates to:
  /// **'Nothing recorded this month'**
  String get moneyNoEntries;

  /// No description provided for @expenseTitle.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get expenseTitle;

  /// No description provided for @expenseCategory.
  ///
  /// In en, this message translates to:
  /// **'What for?'**
  String get expenseCategory;

  /// No description provided for @withdrawalTitle.
  ///
  /// In en, this message translates to:
  /// **'Took money for home'**
  String get withdrawalTitle;

  /// No description provided for @withdrawalHint.
  ///
  /// In en, this message translates to:
  /// **'Money taken out for family or personal use. It is not a business expense.'**
  String get withdrawalHint;

  /// No description provided for @toCollect.
  ///
  /// In en, this message translates to:
  /// **'To collect'**
  String get toCollect;

  /// No description provided for @advancesHeld.
  ///
  /// In en, this message translates to:
  /// **'Advances held'**
  String get advancesHeld;

  /// No description provided for @catPackaging.
  ///
  /// In en, this message translates to:
  /// **'Packaging'**
  String get catPackaging;

  /// No description provided for @catCourier.
  ///
  /// In en, this message translates to:
  /// **'Courier'**
  String get catCourier;

  /// No description provided for @catTravel.
  ///
  /// In en, this message translates to:
  /// **'Travel'**
  String get catTravel;

  /// No description provided for @catPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get catPhone;

  /// No description provided for @catRent.
  ///
  /// In en, this message translates to:
  /// **'Rent'**
  String get catRent;

  /// No description provided for @catElectricity.
  ///
  /// In en, this message translates to:
  /// **'Electricity'**
  String get catElectricity;

  /// No description provided for @catHelper.
  ///
  /// In en, this message translates to:
  /// **'Helper'**
  String get catHelper;

  /// No description provided for @catOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get catOther;

  /// No description provided for @settingsBusiness.
  ///
  /// In en, this message translates to:
  /// **'Business name'**
  String get settingsBusiness;

  /// No description provided for @settingsUpi.
  ///
  /// In en, this message translates to:
  /// **'UPI ID'**
  String get settingsUpi;

  /// No description provided for @settingsPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get settingsPhone;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsTheme;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'Like phone'**
  String get themeSystem;

  /// No description provided for @settingsPricing.
  ///
  /// In en, this message translates to:
  /// **'Pricing'**
  String get settingsPricing;

  /// No description provided for @settingsHourly.
  ///
  /// In en, this message translates to:
  /// **'Your time, per hour (₹)'**
  String get settingsHourly;

  /// No description provided for @settingsOverhead.
  ///
  /// In en, this message translates to:
  /// **'Overhead %'**
  String get settingsOverhead;

  /// No description provided for @settingsRetailMarkup.
  ///
  /// In en, this message translates to:
  /// **'Retail price = cost ×'**
  String get settingsRetailMarkup;

  /// No description provided for @settingsWholesaleMarkup.
  ///
  /// In en, this message translates to:
  /// **'Wholesale price = cost ×'**
  String get settingsWholesaleMarkup;

  /// No description provided for @settingsTargetMargin.
  ///
  /// In en, this message translates to:
  /// **'Target margin %'**
  String get settingsTargetMargin;

  /// No description provided for @settingsTerms.
  ///
  /// In en, this message translates to:
  /// **'Shops pay within (days)'**
  String get settingsTerms;

  /// No description provided for @settingsData.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get settingsData;

  /// No description provided for @settingsDemo.
  ///
  /// In en, this message translates to:
  /// **'Load demo data'**
  String get settingsDemo;

  /// No description provided for @settingsDemoConfirm.
  ///
  /// In en, this message translates to:
  /// **'This deletes everything in the app and loads sample data. Continue?'**
  String get settingsDemoConfirm;

  /// No description provided for @settingsReset.
  ///
  /// In en, this message translates to:
  /// **'Delete all data'**
  String get settingsReset;

  /// No description provided for @settingsResetConfirm.
  ///
  /// In en, this message translates to:
  /// **'This deletes everything in the app. It cannot be undone. Continue?'**
  String get settingsResetConfirm;

  /// No description provided for @demoLoaded.
  ///
  /// In en, this message translates to:
  /// **'Demo data loaded'**
  String get demoLoaded;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Bcreations'**
  String get welcomeTitle;

  /// No description provided for @welcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Orders, stock and money — all in one place.'**
  String get welcomeSubtitle;

  /// No description provided for @welcomeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose language'**
  String get welcomeLanguage;

  /// No description provided for @welcomeBusiness.
  ///
  /// In en, this message translates to:
  /// **'Your business name'**
  String get welcomeBusiness;

  /// No description provided for @welcomeStart.
  ///
  /// In en, this message translates to:
  /// **'Start fresh'**
  String get welcomeStart;

  /// No description provided for @welcomeDemo.
  ///
  /// In en, this message translates to:
  /// **'Try with sample data'**
  String get welcomeDemo;

  /// No description provided for @welcomeFreshHint.
  ///
  /// In en, this message translates to:
  /// **'You only need what is true today: stock on the shelf, who owes you, and orders in progress. Old records are optional.'**
  String get welcomeFreshHint;

  /// No description provided for @linePrice.
  ///
  /// In en, this message translates to:
  /// **'Price per {unit} (₹)'**
  String linePrice(String unit);

  /// No description provided for @lineTotal.
  ///
  /// In en, this message translates to:
  /// **'Total for this item: {amount}'**
  String lineTotal(String amount);

  /// No description provided for @buyPerUnit.
  ///
  /// In en, this message translates to:
  /// **'That is {price} per {unit}'**
  String buyPerUnit(String price, String unit);

  /// No description provided for @recipePerPiece.
  ///
  /// In en, this message translates to:
  /// **'For one piece'**
  String get recipePerPiece;

  /// No description provided for @itemsReview.
  ///
  /// In en, this message translates to:
  /// **'Prices to review'**
  String get itemsReview;

  /// No description provided for @reviewPrice.
  ///
  /// In en, this message translates to:
  /// **'Review price'**
  String get reviewPrice;

  /// No description provided for @ordersToDeliver.
  ///
  /// In en, this message translates to:
  /// **'To deliver'**
  String get ordersToDeliver;

  /// No description provided for @ordersQuotes.
  ///
  /// In en, this message translates to:
  /// **'Quotes'**
  String get ordersQuotes;

  /// No description provided for @ordersWithAdvance.
  ///
  /// In en, this message translates to:
  /// **'Advance taken'**
  String get ordersWithAdvance;

  /// No description provided for @stockCheckTitle.
  ///
  /// In en, this message translates to:
  /// **'Stock to check'**
  String get stockCheckTitle;

  /// No description provided for @stockCheckMade.
  ///
  /// In en, this message translates to:
  /// **'Made with {qty} {name} missing on the app'**
  String stockCheckMade(String qty, String name);

  /// No description provided for @stockCheckDelivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered {qty} more {name} than the app showed'**
  String stockCheckDelivered(String qty, String name);

  /// No description provided for @stockCheckHint.
  ///
  /// In en, this message translates to:
  /// **'Count the shelf, or look for a purchase or batch that was not entered.'**
  String get stockCheckHint;

  /// No description provided for @checkCountNow.
  ///
  /// In en, this message translates to:
  /// **'Count now'**
  String get checkCountNow;

  /// No description provided for @checkFine.
  ///
  /// In en, this message translates to:
  /// **'It\'s fine'**
  String get checkFine;

  /// No description provided for @shortageTitle.
  ///
  /// In en, this message translates to:
  /// **'Not enough on the app'**
  String get shortageTitle;

  /// No description provided for @shortageLine.
  ///
  /// In en, this message translates to:
  /// **'{name}: need {need}, app shows {have}'**
  String shortageLine(String name, String need, String have);

  /// No description provided for @shortageQuestion.
  ///
  /// In en, this message translates to:
  /// **'What happened?'**
  String get shortageQuestion;

  /// No description provided for @shortageCount.
  ///
  /// In en, this message translates to:
  /// **'Count the shelf — the app may be wrong'**
  String get shortageCount;

  /// No description provided for @shortageBuy.
  ///
  /// In en, this message translates to:
  /// **'I bought more but did not enter it'**
  String get shortageBuy;

  /// No description provided for @shortageMade.
  ///
  /// In en, this message translates to:
  /// **'I made more but did not enter it'**
  String get shortageMade;

  /// No description provided for @shortageProceed.
  ///
  /// In en, this message translates to:
  /// **'Continue — remind me to check'**
  String get shortageProceed;

  /// No description provided for @overpayBody.
  ///
  /// In en, this message translates to:
  /// **'{extra} more than {name} owes. It will be kept as credit for their next order.'**
  String overpayBody(String extra, String name);

  /// No description provided for @overpayKeep.
  ///
  /// In en, this message translates to:
  /// **'Keep as credit'**
  String get overpayKeep;

  /// No description provided for @giveBack.
  ///
  /// In en, this message translates to:
  /// **'Give money back'**
  String get giveBack;

  /// No description provided for @giveBackTitle.
  ///
  /// In en, this message translates to:
  /// **'Money given back'**
  String get giveBackTitle;

  /// No description provided for @welcomeLearn.
  ///
  /// In en, this message translates to:
  /// **'Learn in 5 minutes with a practice shop'**
  String get welcomeLearn;

  /// No description provided for @welcomeLearnHint.
  ///
  /// In en, this message translates to:
  /// **'Practise with made-up customers and items. Nothing touches your real records.'**
  String get welcomeLearnHint;

  /// No description provided for @welcomeSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip — start with my real data'**
  String get welcomeSkip;

  /// No description provided for @setupTitle.
  ///
  /// In en, this message translates to:
  /// **'Your shop'**
  String get setupTitle;

  /// No description provided for @setupUpi.
  ///
  /// In en, this message translates to:
  /// **'UPI ID (optional) — added to payment reminders'**
  String get setupUpi;

  /// No description provided for @setupStart.
  ///
  /// In en, this message translates to:
  /// **'Start my real shop'**
  String get setupStart;

  /// No description provided for @setupPractiseFirst.
  ///
  /// In en, this message translates to:
  /// **'Practise first'**
  String get setupPractiseFirst;

  /// No description provided for @practiceBanner.
  ///
  /// In en, this message translates to:
  /// **'Practice shop — nothing here is real'**
  String get practiceBanner;

  /// No description provided for @practiceExit.
  ///
  /// In en, this message translates to:
  /// **'Go to my real shop'**
  String get practiceExit;

  /// No description provided for @tutorialStepOf.
  ///
  /// In en, this message translates to:
  /// **'Step {n} of {total}'**
  String tutorialStepOf(int n, int total);

  /// No description provided for @tutorialShowMe.
  ///
  /// In en, this message translates to:
  /// **'Show me'**
  String get tutorialShowMe;

  /// No description provided for @tutorialSkipStep.
  ///
  /// In en, this message translates to:
  /// **'Skip step'**
  String get tutorialSkipStep;

  /// No description provided for @tutorialSeen.
  ///
  /// In en, this message translates to:
  /// **'I have seen it'**
  String get tutorialSeen;

  /// No description provided for @tutorialAllDone.
  ///
  /// In en, this message translates to:
  /// **'Well done! You know the basics.'**
  String get tutorialAllDone;

  /// No description provided for @tutorialTour.
  ///
  /// In en, this message translates to:
  /// **'See all features'**
  String get tutorialTour;

  /// No description provided for @tutorialStartReal.
  ///
  /// In en, this message translates to:
  /// **'Start my real shop'**
  String get tutorialStartReal;

  /// No description provided for @t1Title.
  ///
  /// In en, this message translates to:
  /// **'Add an item you sell'**
  String get t1Title;

  /// No description provided for @t1Prompt.
  ///
  /// In en, this message translates to:
  /// **'Name: Rakhi · I buy & resell · Stock 20 · Cost ₹40 per piece · Retail ₹150 per piece'**
  String get t1Prompt;

  /// No description provided for @t2Title.
  ///
  /// In en, this message translates to:
  /// **'Add a customer who already owes you'**
  String get t2Title;

  /// No description provided for @t2Prompt.
  ///
  /// In en, this message translates to:
  /// **'Name: Asha · Already owes you ₹500'**
  String get t2Prompt;

  /// No description provided for @t3Title.
  ///
  /// In en, this message translates to:
  /// **'Take an order with an advance'**
  String get t3Title;

  /// No description provided for @t3Prompt.
  ///
  /// In en, this message translates to:
  /// **'Customer: Asha · Add item: 5 Rakhi · Advance received now: ₹200'**
  String get t3Prompt;

  /// No description provided for @t4Title.
  ///
  /// In en, this message translates to:
  /// **'Deliver the order'**
  String get t4Title;

  /// No description provided for @t4Prompt.
  ///
  /// In en, this message translates to:
  /// **'Open Asha\'s order and tap \"Mark delivered\"'**
  String get t4Prompt;

  /// No description provided for @t5Title.
  ///
  /// In en, this message translates to:
  /// **'Asha pays you'**
  String get t5Title;

  /// No description provided for @t5Prompt.
  ///
  /// In en, this message translates to:
  /// **'Open Asha and tap \"Receive payment\". What she owes is already filled in.'**
  String get t5Prompt;

  /// No description provided for @t6Title.
  ///
  /// In en, this message translates to:
  /// **'Note a small expense'**
  String get t6Title;

  /// No description provided for @t6Prompt.
  ///
  /// In en, this message translates to:
  /// **'Tap ＋ Add → Expense → Courier → ₹80'**
  String get t6Prompt;

  /// No description provided for @t7Title.
  ///
  /// In en, this message translates to:
  /// **'See where your money went'**
  String get t7Title;

  /// No description provided for @t7Prompt.
  ///
  /// In en, this message translates to:
  /// **'Open Money and read \"Where did my profit go?\"'**
  String get t7Prompt;

  /// No description provided for @tourNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get tourNext;

  /// No description provided for @tourHomeT.
  ///
  /// In en, this message translates to:
  /// **'Home: what needs you today'**
  String get tourHomeT;

  /// No description provided for @tourHomeB.
  ///
  /// In en, this message translates to:
  /// **'Who to collect from, orders to deliver, low stock and stock to check. Tap any card to go straight there.'**
  String get tourHomeB;

  /// No description provided for @tourCollectT.
  ///
  /// In en, this message translates to:
  /// **'Collect money on time'**
  String get tourCollectT;

  /// No description provided for @tourCollectB.
  ///
  /// In en, this message translates to:
  /// **'Each customer shows how much they owe and how many days late. The green chat button sends a polite WhatsApp reminder.'**
  String get tourCollectB;

  /// No description provided for @tourOrdersT.
  ///
  /// In en, this message translates to:
  /// **'Orders and advances'**
  String get tourOrdersT;

  /// No description provided for @tourOrdersB.
  ///
  /// In en, this message translates to:
  /// **'Take an order with photos and details like colour, size or a name. Record the advance; it comes off the bill when you deliver.'**
  String get tourOrdersB;

  /// No description provided for @tourStockT.
  ///
  /// In en, this message translates to:
  /// **'Stock that matches the shelf'**
  String get tourStockT;

  /// No description provided for @tourStockB.
  ///
  /// In en, this message translates to:
  /// **'Stock goes down when you deliver or make things. Count the shelf any time and the app fixes the difference.'**
  String get tourStockB;

  /// No description provided for @tourMakeT.
  ///
  /// In en, this message translates to:
  /// **'Making items'**
  String get tourMakeT;

  /// No description provided for @tourMakeB.
  ///
  /// In en, this message translates to:
  /// **'Tell the app what goes into one piece. When you make a batch it uses the materials and shows the real cost of one piece, including your time.'**
  String get tourMakeB;

  /// No description provided for @tourPricesT.
  ///
  /// In en, this message translates to:
  /// **'Prices that make money'**
  String get tourPricesT;

  /// No description provided for @tourPricesB.
  ///
  /// In en, this message translates to:
  /// **'Each order line shows green, amber or red for your margin. If materials get dearer, the app reminds you to review your price.'**
  String get tourPricesB;

  /// No description provided for @tourMoneyT.
  ///
  /// In en, this message translates to:
  /// **'Where did the profit go?'**
  String get tourMoneyT;

  /// No description provided for @tourMoneyB.
  ///
  /// In en, this message translates to:
  /// **'Money shows your profit and explains why cash is different: money still with customers, extra stock, and money taken for home.'**
  String get tourMoneyB;

  /// No description provided for @tourFamilyT.
  ///
  /// In en, this message translates to:
  /// **'Family money, kept separate'**
  String get tourFamilyT;

  /// No description provided for @tourFamilyB.
  ///
  /// In en, this message translates to:
  /// **'Use ＋ Add → \"Took money for home\" whenever you take money out. It is not a business expense, but it explains your cash.'**
  String get tourFamilyB;

  /// No description provided for @tourUndoT.
  ///
  /// In en, this message translates to:
  /// **'Mistakes are easy to fix'**
  String get tourUndoT;

  /// No description provided for @tourUndoB.
  ///
  /// In en, this message translates to:
  /// **'Right after saving you can tap Undo. Payments and expenses can also be deleted later.'**
  String get tourUndoB;

  /// No description provided for @notifDigestTitle.
  ///
  /// In en, this message translates to:
  /// **'Bcreations · today'**
  String get notifDigestTitle;

  /// No description provided for @notifDeliverToday.
  ///
  /// In en, this message translates to:
  /// **'Deliver today: {name} · {number}'**
  String notifDeliverToday(String name, String number);

  /// No description provided for @notifChannelDaily.
  ///
  /// In en, this message translates to:
  /// **'Daily reminder'**
  String get notifChannelDaily;

  /// No description provided for @notifChannelDelivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery dates'**
  String get notifChannelDelivery;

  /// No description provided for @settingsLearning.
  ///
  /// In en, this message translates to:
  /// **'Learning'**
  String get settingsLearning;

  /// No description provided for @settingsPractice.
  ///
  /// In en, this message translates to:
  /// **'Open practice shop'**
  String get settingsPractice;

  /// No description provided for @settingsPracticeSample.
  ///
  /// In en, this message translates to:
  /// **'Practice shop with sample data'**
  String get settingsPracticeSample;

  /// No description provided for @settingsRestartTutorial.
  ///
  /// In en, this message translates to:
  /// **'Start the tutorial again'**
  String get settingsRestartTutorial;

  /// No description provided for @settingsReminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get settingsReminders;

  /// No description provided for @settingsRemindersOn.
  ///
  /// In en, this message translates to:
  /// **'Daily reminder on the phone'**
  String get settingsRemindersOn;

  /// No description provided for @settingsReminderTime.
  ///
  /// In en, this message translates to:
  /// **'Reminder time'**
  String get settingsReminderTime;
}

class _SDelegate extends LocalizationsDelegate<S> {
  const _SDelegate();

  @override
  Future<S> load(Locale locale) {
    return SynchronousFuture<S>(lookupS(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi'].contains(locale.languageCode);

  @override
  bool shouldReload(_SDelegate old) => false;
}

S lookupS(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return SEn();
    case 'hi':
      return SHi();
  }

  throw FlutterError(
      'S.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
