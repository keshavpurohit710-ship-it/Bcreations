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
  String reminderText(String name, String business, String amount, String upiLine) {
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
  String get confirmCancelOrder => 'यह ऑर्डर रद्द करें? दिया गया एडवांस ग्राहक के खाते में जमा रहेगा।';

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
  String get itemUnit => 'इकाई';

  @override
  String get itemCategory => 'श्रेणी';

  @override
  String get itemRetail => 'खुदरा दाम (₹)';

  @override
  String get itemWholesale => 'थोक दाम (₹)';

  @override
  String get retailLabel => 'खुदरा';

  @override
  String get wholesaleLabel => 'थोक';

  @override
  String get itemMinStock => 'इससे कम हो तो बताएँ';

  @override
  String get itemOpeningQty => 'अभी कितना है?';

  @override
  String get itemOpeningCost => 'एक का दाम (₹)';

  @override
  String get itemRecipe => 'एक पीस में क्या लगता है?';

  @override
  String get itemAddMaterial => 'माल जोड़ें';

  @override
  String get itemPhoto => 'फ़ोटो';

  @override
  String get onHand => 'स्टॉक में';

  @override
  String get stockValue => 'स्टॉक की कीमत';

  @override
  String get costPerPiece => 'एक की लागत';

  @override
  String suggestedPrices(String retail, String wholesale) {
    return 'सुझाव: खुदरा $retail · थोक $wholesale';
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
  String get buyTotalCost => 'कुल दिए (₹)';

  @override
  String get buySupplier => 'सप्लायर';

  @override
  String get makeTitle => 'सामान बनाया';

  @override
  String get makeItem => 'क्या बनाया?';

  @override
  String get makeHowMany => 'कितने बनाए?';

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
  String get makeNoRecipe => 'पहले बताएँ कि एक पीस में क्या लगता है (सामान बदलें)।';

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
  String get withdrawalHint => 'परिवार या अपने काम के लिए निकाले पैसे। यह बिज़नेस का खर्च नहीं है।';

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
  String get settingsDemoConfirm => 'इससे ऐप का सारा डेटा हट जाएगा और नमूना डेटा आ जाएगा। आगे बढ़ें?';

  @override
  String get settingsReset => 'सारा डेटा हटाएँ';

  @override
  String get settingsResetConfirm => 'इससे ऐप का सारा डेटा हट जाएगा। यह वापस नहीं होगा। आगे बढ़ें?';

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
}
