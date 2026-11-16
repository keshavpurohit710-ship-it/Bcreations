// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class SHi extends S {
  SHi([String locale = 'hi']) : super(locale);

  @override
  String get appName => 'Bcreations';

  @override
  String get navHome => 'होम';

  @override
  String get navOrders => 'ऑर्डर';

  @override
  String get navCustomers => 'ग्राहक';

  @override
  String get navItems => 'सामान';

  @override
  String get navMoney => 'हिसाब';

  @override
  String get save => 'सेव करें';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get delete => 'हटाएँ';

  @override
  String get edit => 'बदलें';

  @override
  String get undo => 'वापस लें';

  @override
  String get done => 'हो गया';

  @override
  String get skip => 'छोड़ें';

  @override
  String get search => 'खोजें';

  @override
  String get required => 'ज़रूरी है';

  @override
  String get amount => 'रकम (₹)';

  @override
  String get date => 'तारीख';

  @override
  String get note => 'नोट';

  @override
  String get quantity => 'मात्रा';

  @override
  String get price => 'दाम (₹)';

  @override
  String get total => 'कुल';

  @override
  String get paid => 'मिला';

  @override
  String get balance => 'बाकी';

  @override
  String get deleted => 'हटा दिया';

  @override
  String get saved => 'सेव हो गया';

  @override
  String get paidWith => 'भुगतान का तरीका';

  @override
  String get methodCash => 'नकद';

  @override
  String get methodUpi => 'UPI';

  @override
  String get methodBank => 'बैंक';

  @override
  String get methodCheque => 'चेक';

  @override
  String get methodOther => 'अन्य';

  @override
  String get amountMustBePositive => 'रकम लिखें';

  @override
  String get settingsTitle => 'सेटिंग्स';

  @override
  String get homeGreeting => 'नमस्ते 🙏';

  @override
  String get homeToDo => 'ध्यान देने वाले काम';

  @override
  String homeCollect(String amount, int count) {
    return '$count ग्राहकों से $amount लेने हैं';
  }

  @override
  String get homeCollectNone => 'किसी पर कोई बकाया नहीं';

  @override
  String homeOverdue(int count) {
    return '$count की तारीख निकल गई';
  }

  @override
  String homeToDeliver(int count) {
    return '$count ऑर्डर देने बाकी';
  }

  @override
  String homeQuotes(int count) {
    return '$count कोटेशन बाकी';
  }

  @override
  String homeAdvances(String amount) {
    return 'एडवांस जमा: $amount';
  }

  @override
  String homeLowStock(int count) {
    return '$count चीज़ें कम बची हैं';
  }

  @override
  String homePriceReview(int count) {
    return '$count दाम दोबारा देखें';
  }

  @override
  String get homeAllGood => 'सब काम पूरे 👍';

  @override
  String get homeMonth => 'इस महीने अब तक';

  @override
  String get homeSetupTitle => 'सेटअप पूरा करें';

  @override
  String get homeSetupItems => 'स्टॉक में जो है वो जोड़ें';

  @override
  String get homeSetupCustomers => 'जिन पर बकाया है उन्हें जोड़ें';

  @override
  String get homeSetupOrders => 'चल रहे ऑर्डर जोड़ें';

  @override
  String get quickAdd => 'जोड़ें';

  @override
  String get quickNewOrder => 'नया ऑर्डर';

  @override
  String get quickPayment => 'पैसे मिले';

  @override
  String get quickExpense => 'खर्च';

  @override
  String get quickWithdrawal => 'घर के लिए पैसे लिए';

  @override
  String get quickMake => 'सामान बनाया';

  @override
  String get quickBuy => 'माल खरीदा';

  @override
  String get customersAll => 'सभी';

  @override
  String get customersOwe => 'बकाया वाले';

  @override
  String get customersSuppliers => 'सप्लायर';

  @override
  String get customersEmpty => 'अभी कोई ग्राहक नहीं। जोड़ने के लिए + दबाएँ।';

  @override
  String get customerNew => 'नया ग्राहक';

  @override
  String get customerEdit => 'ग्राहक बदलें';

  @override
  String get customerName => 'नाम';

  @override
  String get customerBusiness => 'दुकान / बिज़नेस का नाम';

  @override
  String get customerPhone => 'फ़ोन';

  @override
  String get customerType => 'यह कौन है?';

  @override
  String get roleCustomer => 'ग्राहक';

  @override
  String get roleSupplier => 'सप्लायर';

  @override
  String get roleBoth => 'दोनों';

  @override
  String get priceTypeLabel => 'दाम की सूची';

  @override
  String get priceRetail => 'खुदरा (व्यक्ति)';

  @override
  String get priceWholesale => 'थोक (दुकान)';

  @override
  String get creditLimit => 'उधार की सीमा (₹)';

  @override
  String get paymentTerms => 'कितने दिन में भुगतान';

  @override
  String get openingOwes => 'पहले से बकाया (₹)';

  @override
  String owes(String amount) {
    return '$amount बकाया';
  }

  @override
  String youHold(String amount) {
    return 'आपके पास $amount जमा';
  }

  @override
  String get settled => 'हिसाब बराबर';

  @override
  String daysLate(int days) {
    return '$days दिन देर';
  }

  @override
  String get call => 'कॉल';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get sendReminder => 'याद दिलाएँ';

  @override
  String reminderText(
      String name, String business, String amount, String upiLine) {
    return 'नमस्ते $name, $business की ओर से याद दिलाना था: $amount बाकी हैं।$upiLine धन्यवाद!';
  }

  @override
  String reminderUpiLine(String upi) {
    return ' आप UPI $upi पर भुगतान कर सकते हैं।';
  }

  @override
  String get noPhone => 'पहले फ़ोन नंबर जोड़ें';

  @override
  String get receivePayment => 'पैसे लें';

  @override
  String get archive => 'आर्काइव करें';

  @override
  String get archived => 'आर्काइव किया';

  @override
  String get ordersSection => 'ऑर्डर';

  @override
  String get paymentsSection => 'भुगतान';

  @override
  String get noOrders => 'अभी कोई ऑर्डर नहीं';

  @override
  String get noPayments => 'अभी कोई भुगतान नहीं';

  @override
  String creditWarnLimit(String name, String limit) {
    return 'यह $name की उधार सीमा $limit से ज़्यादा है।';
  }

  @override
  String creditWarnOverdue(String name, String amount) {
    return '$name का भुगतान देर से है ($amount बकाया)।';
  }

  @override
  String get ordersOpen => 'चालू';

  @override
  String get ordersDelivered => 'दिए गए';

  @override
  String get ordersAll => 'सभी';

  @override
  String get ordersEmpty => 'यहाँ अभी कोई ऑर्डर नहीं।';

  @override
  String get statusQuote => 'कोटेशन';

  @override
  String get statusConfirmed => 'देना बाकी';

  @override
  String get statusDelivered => 'दे दिया';

  @override
  String get statusCancelled => 'रद्द';

  @override
  String get payUnpaid => 'बाकी';

  @override
  String get payPartly => 'थोड़ा मिला';

  @override
  String get payPaid => 'पूरा मिला';

  @override
  String payAdvance(String amount) {
    return 'एडवांस $amount';
  }

  @override
  String get orderNew => 'नया ऑर्डर';

  @override
  String get orderEdit => 'ऑर्डर बदलें';

  @override
  String get orderCustomer => 'ग्राहक';

  @override
  String get orderPickCustomer => 'ग्राहक चुनें';

  @override
  String get orderItems => 'सामान';

  @override
  String get orderAddItem => 'सामान जोड़ें';

  @override
  String get orderAddCustom => 'खास सामान';

  @override
  String get orderCustomName => 'क्या बनाना है?';

  @override
  String get orderColour => 'रंग';

  @override
  String get orderSize => 'साइज़';

  @override
  String get orderNameText => 'नाम / लिखावट';

  @override
  String get orderDelivery => 'डिलीवरी चार्ज (₹)';

  @override
  String get orderDiscount => 'बिल पर छूट (₹)';

  @override
  String get orderDiscountReason => 'छूट का कारण';

  @override
  String get orderPromised => 'कब तक देना है';

  @override
  String get orderDate => 'ऑर्डर की तारीख';

  @override
  String get orderChannel => 'ऑर्डर कहाँ से आया?';

  @override
  String get channelShop => 'दुकान';

  @override
  String get channelIndividual => 'व्यक्ति';

  @override
  String get channelExhibition => 'प्रदर्शनी';

  @override
  String get channelOnline => 'इंस्टाग्राम / ऑनलाइन';

  @override
  String get orderJustQuote => 'अभी सिर्फ़ कोटेशन';

  @override
  String get orderAdvance => 'अभी मिला एडवांस (₹)';

  @override
  String get takeAdvance => 'एडवांस लें';

  @override
  String get orderPhotos => 'नमूने की फ़ोटो';

  @override
  String get orderAddPhoto => 'फ़ोटो जोड़ें';

  @override
  String get orderNotes => 'नोट';

  @override
  String get orderMore => 'और जानकारी';

  @override
  String get orderNeedsItem => 'कम से कम एक सामान जोड़ें';

  @override
  String get orderNeedsCustomer => 'ग्राहक चुनें';

  @override
  String get lineDiscount => 'इस सामान पर छूट (₹)';

  @override
  String get marginHealthy => 'अच्छा मुनाफ़ा';

  @override
  String get marginThin => 'कम मुनाफ़ा';

  @override
  String get marginLoss => 'लागत से कम!';

  @override
  String listPriceWas(String price) {
    return 'सूची दाम $price';
  }

  @override
  String inStock(String qty) {
    return 'स्टॉक में $qty';
  }

  @override
  String get actionConfirm => 'ऑर्डर पक्का करें';

  @override
  String get actionDeliver => 'दे दिया';

  @override
  String get actionCancelOrder => 'ऑर्डर रद्द करें';

  @override
  String get confirmCancelOrder =>
      'यह ऑर्डर रद्द करें? दिया गया एडवांस ग्राहक के खाते में जमा रहेगा।';

  @override
  String get actionShare => 'शेयर करें';

  @override
  String orderDue(String date) {
    return 'भुगतान $date तक';
  }

  @override
  String orderDeliverBy(String date) {
    return '$date तक देना है';
  }

  @override
  String get subtotal => 'सामान का जोड़';

  @override
  String get stockWarnTitle => 'स्टॉक कम है';

  @override
  String stockWarnBody(String have, String name, String need) {
    return 'स्टॉक में $name सिर्फ़ $have है; ऑर्डर में $need चाहिए। फिर भी दें?';
  }

  @override
  String get deliverAnyway => 'फिर भी दें';

  @override
  String get customItem => 'खास सामान';

  @override
  String quoteText(String business) {
    return '$business की ओर से कोटेशन';
  }

  @override
  String billText(String business) {
    return '$business की ओर से बिल';
  }

  @override
  String get paymentTitle => 'पैसे मिले';

  @override
  String paymentForOrder(String number) {
    return 'ऑर्डर $number के लिए';
  }

  @override
  String get paymentAnyOrder => 'सबसे पुराना बकाया पहले कटेगा';

  @override
  String get paymentReference => 'UPI रेफ़ / भेजने वाला';

  @override
  String paymentSaved(String amount) {
    return '$amount मिले';
  }

  @override
  String get itemsAll => 'सभी';

  @override
  String get itemsLow => 'कम बचा';

  @override
  String get itemsMaterials => 'कच्चा माल';

  @override
  String get itemsProducts => 'तैयार सामान';

  @override
  String get itemsEmpty => 'अभी कोई सामान नहीं। जो है उसे + दबाकर जोड़ें।';

  @override
  String get itemNew => 'नया सामान';

  @override
  String get itemEdit => 'सामान बदलें';

  @override
  String get itemName => 'नाम';

  @override
  String get itemKind => 'किस तरह का?';

  @override
  String get kindRaw => 'कच्चा माल';

  @override
  String get kindMade => 'मैं बनाती हूँ';

  @override
  String get kindBought => 'खरीदकर बेचती हूँ';

  @override
  String get itemUnit => 'इकाई (कैसे गिनती है)';

  @override
  String get itemCategory => 'श्रेणी';

  @override
  String itemRetail(String unit) {
    return 'खुदरा दाम, प्रति $unit (₹)';
  }

  @override
  String itemWholesale(String unit) {
    return 'थोक दाम, प्रति $unit (₹)';
  }

  @override
  String retailLabel(String unit) {
    return 'खुदरा, प्रति $unit';
  }

  @override
  String wholesaleLabel(String unit) {
    return 'थोक, प्रति $unit';
  }

  @override
  String get itemMinStock => 'स्टॉक इससे कम हो तो बताएँ';

  @override
  String get itemOpeningQty => 'अभी स्टॉक में कितना है';

  @override
  String itemOpeningCost(String unit) {
    return 'प्रति $unit लागत (₹)';
  }

  @override
  String get itemRecipe => 'एक पीस में क्या लगता है?';

  @override
  String get itemAddMaterial => 'माल जोड़ें';

  @override
  String get itemPhoto => 'फ़ोटो';

  @override
  String get onHand => 'स्टॉक में';

  @override
  String get stockValue => 'इस सारे स्टॉक की कीमत';

  @override
  String costPerPiece(String unit) {
    return 'प्रति $unit लागत';
  }

  @override
  String suggestedPrices(String unit, String retail, String wholesale) {
    return 'सुझाव प्रति $unit: खुदरा $retail · थोक $wholesale';
  }

  @override
  String get priceReview => 'माल महँगा हुआ — दाम दोबारा देखें';

  @override
  String get actionBuy => 'खरीदें';

  @override
  String get actionMake => 'बनाएँ';

  @override
  String get actionAdjust => 'घटाएँ / बढ़ाएँ';

  @override
  String get actionCount => 'गिनती';

  @override
  String get history => 'इतिहास';

  @override
  String get buyTitle => 'माल खरीदा';

  @override
  String get buyItem => 'क्या खरीदा?';

  @override
  String get buyTotalCost => 'सब का कुल दाम (₹)';

  @override
  String get buySupplier => 'सप्लायर';

  @override
  String get makeTitle => 'सामान बनाया';

  @override
  String get makeItem => 'क्या बनाया?';

  @override
  String get makeHowMany => 'कितने पीस बनाए?';

  @override
  String get makeHours => 'इस बैच में लगभग कितने घंटे लगे?';

  @override
  String get makeNeeds => 'ज़रूरी माल';

  @override
  String makeShort(String qty) {
    return '$qty कम';
  }

  @override
  String get makeAnyway => 'फिर भी बनाएँ';

  @override
  String get makeShortConfirm => 'कुछ माल कम है। फिर भी बनाएँ?';

  @override
  String get makeNoRecipe =>
      'पहले बताएँ कि एक पीस में क्या लगता है (सामान बदलें)।';

  @override
  String get adjustTitle => 'स्टॉक घटाएँ / बढ़ाएँ';

  @override
  String get adjustRemove => 'घटाएँ';

  @override
  String get adjustAdd => 'बढ़ाएँ';

  @override
  String get reasonDamaged => 'खराब हो गया';

  @override
  String get reasonHome => 'घर में लिया';

  @override
  String get reasonFound => 'ज़्यादा मिला';

  @override
  String get reasonOther => 'अन्य';

  @override
  String get countTitle => 'गिनती';

  @override
  String get countHowMany => 'शेल्फ़ पर कितने हैं?';

  @override
  String countResult(String qty) {
    return 'अंतर दर्ज: $qty';
  }

  @override
  String get countMatched => 'ऐप से मेल खाता है 👍';

  @override
  String get moveOpening => 'शुरुआती स्टॉक';

  @override
  String get movePurchase => 'खरीदा';

  @override
  String get moveProductionIn => 'बनाया';

  @override
  String get moveProductionUse => 'बनाने में लगा';

  @override
  String get moveSale => 'बेचा';

  @override
  String get moveSaleReversal => 'ऑर्डर रद्द';

  @override
  String get moveAdjustment => 'बदलाव';

  @override
  String get moveCount => 'गिनती का अंतर';

  @override
  String get photoCamera => 'फ़ोटो खींचें';

  @override
  String get photoGallery => 'गैलरी से चुनें';

  @override
  String get pickProduct => 'सामान चुनें';

  @override
  String get pickNone => 'कोई सामान नहीं मिला';

  @override
  String get moneySales => 'बिक्री';

  @override
  String get moneyCostOfGoods => 'बिके सामान का माल खर्च';

  @override
  String get moneyLosses => 'खराब / कम हुआ स्टॉक';

  @override
  String get moneyExpenses => 'खर्चे';

  @override
  String get moneyProfit => 'मुनाफ़ा';

  @override
  String get moneyBridgeTitle => 'मेरा मुनाफ़ा कहाँ गया?';

  @override
  String get moneyBridgeCustomers => 'ग्राहकों के पास बाकी';

  @override
  String get moneyBridgeCustomersBack => 'पुराना बकाया वसूला';

  @override
  String get moneyBridgeStock => 'ज़्यादा माल में लगा';

  @override
  String get moneyBridgeStockBack => 'पुराने स्टॉक से बिका';

  @override
  String get moneyBridgeHome => 'घर के लिए लिया';

  @override
  String get moneyBridgeCash => 'असल में जमा हुए पैसे';

  @override
  String get moneyTime => 'आपके समय की कीमत';

  @override
  String moneyTimeHint(String rate) {
    return 'आपके घंटे, $rate/घंटा के हिसाब से। मुनाफ़े से नहीं घटाया।';
  }

  @override
  String get moneyDiscounts => 'दी गई छूट';

  @override
  String get moneyBest => 'सबसे ज़्यादा बिकने वाले';

  @override
  String get moneyByQty => 'मात्रा से';

  @override
  String get moneyByProfit => 'मुनाफ़े से';

  @override
  String get moneyNoSales => 'इस महीने अभी कोई बिक्री नहीं';

  @override
  String get moneyEntries => 'खर्च और घर के पैसे';

  @override
  String get moneyNoEntries => 'इस महीने कुछ दर्ज नहीं';

  @override
  String get expenseTitle => 'खर्च';

  @override
  String get expenseCategory => 'किस चीज़ का?';

  @override
  String get withdrawalTitle => 'घर के लिए पैसे लिए';

  @override
  String get withdrawalHint =>
      'परिवार या अपने काम के लिए निकाले पैसे। यह बिज़नेस का खर्च नहीं है।';

  @override
  String get toCollect => 'लेने हैं';

  @override
  String get advancesHeld => 'एडवांस जमा';

  @override
  String get catPackaging => 'पैकिंग';

  @override
  String get catCourier => 'कूरियर';

  @override
  String get catTravel => 'आना-जाना';

  @override
  String get catPhone => 'फ़ोन';

  @override
  String get catRent => 'किराया';

  @override
  String get catElectricity => 'बिजली';

  @override
  String get catHelper => 'कारीगर';

  @override
  String get catOther => 'अन्य';

  @override
  String get settingsBusiness => 'बिज़नेस का नाम';

  @override
  String get settingsUpi => 'UPI ID';

  @override
  String get settingsPhone => 'फ़ोन';

  @override
  String get settingsLanguage => 'भाषा';

  @override
  String get settingsTheme => 'रंग-रूप';

  @override
  String get themeLight => 'हल्का';

  @override
  String get themeDark => 'गहरा';

  @override
  String get themeSystem => 'फ़ोन जैसा';

  @override
  String get settingsPricing => 'दाम';

  @override
  String get settingsHourly => 'आपका समय, प्रति घंटा (₹)';

  @override
  String get settingsOverhead => 'ऊपरी खर्च %';

  @override
  String get settingsRetailMarkup => 'खुदरा दाम = लागत ×';

  @override
  String get settingsWholesaleMarkup => 'थोक दाम = लागत ×';

  @override
  String get settingsTargetMargin => 'लक्ष्य मुनाफ़ा %';

  @override
  String get settingsTerms => 'दुकानें कितने दिन में भुगतान करें';

  @override
  String get settingsData => 'डेटा';

  @override
  String get settingsDemo => 'डेमो डेटा लोड करें';

  @override
  String get settingsDemoConfirm =>
      'इससे ऐप का सारा डेटा हट जाएगा और नमूना डेटा आ जाएगा। आगे बढ़ें?';

  @override
  String get settingsReset => 'सारा डेटा हटाएँ';

  @override
  String get settingsResetConfirm =>
      'इससे ऐप का सारा डेटा हट जाएगा। यह वापस नहीं होगा। आगे बढ़ें?';

  @override
  String get demoLoaded => 'डेमो डेटा लोड हो गया';

  @override
  String get welcomeTitle => 'Bcreations में स्वागत है';

  @override
  String get welcomeSubtitle => 'ऑर्डर, स्टॉक और हिसाब — सब एक जगह।';

  @override
  String get welcomeLanguage => 'भाषा चुनें';

  @override
  String get welcomeBusiness => 'आपके बिज़नेस का नाम';

  @override
  String get welcomeStart => 'नई शुरुआत करें';

  @override
  String get welcomeDemo => 'नमूना डेटा से देखें';

  @override
  String get welcomeFreshHint =>
      'आज की जानकारी ही काफ़ी है: शेल्फ़ पर स्टॉक, किस पर बकाया है, और चल रहे ऑर्डर। पुराना हिसाब ज़रूरी नहीं।';

  @override
  String linePrice(String unit) {
    return 'दाम प्रति $unit (₹)';
  }

  @override
  String lineTotal(String amount) {
    return 'इस सामान का कुल: $amount';
  }

  @override
  String buyPerUnit(String price, String unit) {
    return 'यानी $price प्रति $unit';
  }

  @override
  String get recipePerPiece => 'एक पीस के लिए';

  @override
  String get itemsReview => 'दाम देखें';

  @override
  String get reviewPrice => 'दाम दोबारा देखें';

  @override
  String get ordersToDeliver => 'देने हैं';

  @override
  String get ordersQuotes => 'कोटेशन';

  @override
  String get ordersWithAdvance => 'एडवांस लिया';

  @override
  String get stockCheckTitle => 'स्टॉक जाँचें';

  @override
  String stockCheckMade(String qty, String name) {
    return 'ऐप में $qty $name कम होते हुए भी बनाया';
  }

  @override
  String stockCheckDelivered(String qty, String name) {
    return 'ऐप से $qty ज़्यादा $name दिया';
  }

  @override
  String get stockCheckHint =>
      'शेल्फ़ गिनें, या देखें कोई खरीद या बनाया माल दर्ज होना रह गया हो।';

  @override
  String get checkCountNow => 'अभी गिनें';

  @override
  String get checkFine => 'ठीक है';

  @override
  String get shortageTitle => 'ऐप में स्टॉक कम है';

  @override
  String shortageLine(String name, String need, String have) {
    return '$name: चाहिए $need, ऐप में $have';
  }

  @override
  String get shortageQuestion => 'क्या हुआ?';

  @override
  String get shortageCount => 'शेल्फ़ गिनें — शायद ऐप गलत है';

  @override
  String get shortageBuy => 'खरीदा था पर दर्ज नहीं किया';

  @override
  String get shortageMade => 'बनाया था पर दर्ज नहीं किया';

  @override
  String get shortageProceed => 'आगे बढ़ें — बाद में जाँचने को याद दिलाएँ';

  @override
  String overpayBody(String extra, String name) {
    return '$name के बकाये से $extra ज़्यादा। यह उनके अगले ऑर्डर के लिए जमा रहेगा।';
  }

  @override
  String get overpayKeep => 'जमा रखें';

  @override
  String get giveBack => 'पैसे लौटाएँ';

  @override
  String get giveBackTitle => 'लौटाए पैसे';

  @override
  String get welcomeLearn => '5 मिनट में सीखें — अभ्यास दुकान के साथ';

  @override
  String get welcomeLearnHint =>
      'नकली ग्राहकों और सामान से अभ्यास करें। आपका असली हिसाब नहीं बदलेगा।';

  @override
  String get welcomeSkip => 'छोड़ें — सीधे असली हिसाब शुरू करें';

  @override
  String get setupTitle => 'आपकी दुकान';

  @override
  String get setupUpi => 'UPI ID (वैकल्पिक) — भुगतान याद दिलाने में जुड़ेगा';

  @override
  String get setupStart => 'असली दुकान शुरू करें';

  @override
  String get setupPractiseFirst => 'पहले अभ्यास करें';

  @override
  String get practiceBanner => 'अभ्यास दुकान — यहाँ कुछ भी असली नहीं';

  @override
  String get practiceExit => 'असली दुकान पर जाएँ';

  @override
  String tutorialStepOf(int n, int total) {
    return 'चरण $n / $total';
  }

  @override
  String get tutorialShowMe => 'दिखाइए';

  @override
  String get tutorialSkipStep => 'यह चरण छोड़ें';

  @override
  String get tutorialSeen => 'देख लिया';

  @override
  String get tutorialAllDone => 'शाबाश! आपने बुनियादी काम सीख लिए।';

  @override
  String get tutorialTour => 'सारी सुविधाएँ देखें';

  @override
  String get tutorialStartReal => 'असली दुकान शुरू करें';

  @override
  String get t1Title => 'जो सामान बेचती हैं, जोड़ें';

  @override
  String get t1Prompt =>
      'नाम: राखी · खरीदकर बेचती हूँ · स्टॉक 20 · लागत ₹40 प्रति पीस · खुदरा ₹150 प्रति पीस';

  @override
  String get t2Title => 'ऐसा ग्राहक जोड़ें जिस पर पहले से बकाया है';

  @override
  String get t2Prompt => 'नाम: आशा · पहले से बकाया ₹500';

  @override
  String get t3Title => 'एडवांस के साथ ऑर्डर लें';

  @override
  String get t3Prompt => 'ग्राहक: आशा · सामान: 5 राखी · अभी मिला एडवांस: ₹200';

  @override
  String get t4Title => 'ऑर्डर दे दीजिए';

  @override
  String get t4Prompt => 'आशा का ऑर्डर खोलें और \"दे दिया\" दबाएँ';

  @override
  String get t5Title => 'आशा ने पैसे दिए';

  @override
  String get t5Prompt =>
      'आशा को खोलें और \"पैसे लें\" दबाएँ। बकाया रकम पहले से भरी है।';

  @override
  String get t6Title => 'छोटा खर्च लिखें';

  @override
  String get t6Prompt => '＋ जोड़ें → खर्च → कूरियर → ₹80';

  @override
  String get t7Title => 'देखें पैसा कहाँ गया';

  @override
  String get t7Prompt => '\"हिसाब\" खोलें और \"मेरा मुनाफ़ा कहाँ गया?\" पढ़ें';

  @override
  String get tourNext => 'आगे';

  @override
  String get tourHomeT => 'होम: आज के काम';

  @override
  String get tourHomeB =>
      'किससे पैसे लेने हैं, कौन से ऑर्डर देने हैं, कौन सा सामान कम है। किसी भी कार्ड को दबाएँ, सीधे वहीं पहुँचेंगी।';

  @override
  String get tourCollectT => 'पैसे समय पर लें';

  @override
  String get tourCollectB =>
      'हर ग्राहक का बकाया और कितने दिन देर हुई, दिखता है। हरा बटन WhatsApp पर विनम्र याद भेजता है।';

  @override
  String get tourOrdersT => 'ऑर्डर और एडवांस';

  @override
  String get tourOrdersB =>
      'फ़ोटो और रंग, साइज़, नाम जैसी बातों के साथ ऑर्डर लें। एडवांस लिखें; डिलीवरी पर बिल से कट जाएगा।';

  @override
  String get tourStockT => 'शेल्फ़ जैसा ही स्टॉक';

  @override
  String get tourStockB =>
      'देने या बनाने पर स्टॉक अपने आप घटता है। कभी भी शेल्फ़ गिनें, ऐप अंतर ठीक कर देगा।';

  @override
  String get tourMakeT => 'सामान बनाना';

  @override
  String get tourMakeB =>
      'बताइए एक पीस में क्या लगता है। बैच बनाने पर ऐप माल घटाता है और आपके समय सहित एक पीस की असली लागत बताता है।';

  @override
  String get tourPricesT => 'मुनाफ़े वाले दाम';

  @override
  String get tourPricesB =>
      'हर ऑर्डर लाइन पर हरा, पीला या लाल रंग मुनाफ़ा बताता है। माल महँगा होने पर ऐप दाम दोबारा देखने को कहता है।';

  @override
  String get tourMoneyT => 'मुनाफ़ा कहाँ गया?';

  @override
  String get tourMoneyB =>
      '\"हिसाब\" मुनाफ़ा दिखाता है और बताता है नकद अलग क्यों है: ग्राहकों के पास बाकी, ज़्यादा माल, और घर के लिए लिए पैसे।';

  @override
  String get tourFamilyT => 'घर और दुकान का पैसा अलग';

  @override
  String get tourFamilyB =>
      'जब भी पैसे निकालें, ＋ जोड़ें → \"घर के लिए पैसे लिए\" चुनें। यह दुकान का खर्च नहीं, पर नकद का हिसाब समझाता है।';

  @override
  String get tourUndoT => 'गलती ठीक करना आसान';

  @override
  String get tourUndoB =>
      'सेव करते ही \"वापस लें\" दबा सकती हैं। भुगतान और खर्च बाद में भी हटा सकती हैं।';

  @override
  String get notifDigestTitle => 'Bcreations · आज';

  @override
  String notifDeliverToday(String name, String number) {
    return 'आज देना है: $name · $number';
  }

  @override
  String get notifChannelDaily => 'रोज़ की याद';

  @override
  String get notifChannelDelivery => 'डिलीवरी की तारीख';

  @override
  String get settingsLearning => 'सीखना';

  @override
  String get settingsPractice => 'अभ्यास दुकान खोलें';

  @override
  String get settingsPracticeSample => 'नमूना डेटा वाली अभ्यास दुकान';

  @override
  String get settingsRestartTutorial => 'ट्यूटोरियल फिर से शुरू करें';

  @override
  String get settingsReminders => 'याद दिलाना';

  @override
  String get settingsRemindersOn => 'फ़ोन पर रोज़ याद दिलाएँ';

  @override
  String get settingsReminderTime => 'याद का समय';

  @override
  String get consentTitle => 'दूर से ही दिक्कतें ठीक करने में मदद करें';

  @override
  String get consentIntro =>
      'आपका परिवार देख सकेगा कि ऐप आपके लिए कैसा चल रहा है, और दूर से भी जल्दी दिक्कतें ठीक कर सकेगा। आप हाँ कहें तो ऐप भेजेगा:';

  @override
  String get consentTaps => 'आप कौन सी स्क्रीन और बटन इस्तेमाल करती हैं';

  @override
  String get consentErrors => 'कोई गड़बड़ी या ऐप बंद होना';

  @override
  String get consentData =>
      'दिन में एक बार, आपकी दुकान के हिसाब की कॉपी (ग्राहक, ऑर्डर, रकम, स्टॉक)';

  @override
  String get consentPhotos => 'फ़ोटो नहीं भेजी जातीं — वे इसी फ़ोन पर रहती हैं';

  @override
  String get consentWho => 'इसे सिर्फ़ वही देख सकता है जिसने यह ऐप सेट किया है';

  @override
  String get consentChange => 'आप इसे कभी भी सेटिंग्स में बंद कर सकती हैं';

  @override
  String get consentYes => 'हाँ, भेजें';

  @override
  String get consentNo => 'नहीं, सब इसी फ़ोन पर रहे';

  @override
  String get settingsHelp => 'दूर से मदद';

  @override
  String get settingsInsights => 'उपयोग और हिसाब की कॉपी भेजें';

  @override
  String get settingsInsightsHint =>
      'स्क्रीन, बटन, गड़बड़ी, और रोज़ हिसाब की कॉपी। फ़ोटो फ़ोन पर ही रहती हैं।';

  @override
  String get settingsSendReport => 'अभी रिपोर्ट भेजें';

  @override
  String get reportSent =>
      'रिपोर्ट भेज दी। इंटरनेट न हो तो मिलते ही चली जाएगी।';

  @override
  String get reportFailed => 'नहीं भेज पाए। इंटरनेट देखें और फिर कोशिश करें।';
}
