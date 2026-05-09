import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../theme/app_theme.dart';

// ══════════════════════════════════════════════════════════════════════════════
// SEGMENT 1 — Color Palette
// ══════════════════════════════════════════════════════════════════════════════
class _C {
  static const bg        = Color(0xFFF4F6F9);
  static const surface   = Colors.white;
  static const primary   = Color(0xFF1B8A3E);
  static const primaryDk = Color(0xFF136B2F);
  static const primaryLt = Color(0xFFE8F5ED);
  static const textDark  = Color(0xFF1A1E2C);
  static const textMid   = Color(0xFF6B7280);
  static const textLight = Color(0xFFB0B8C5);
  static const red       = Color(0xFFEF4444);
  static const gold      = Color(0xFFF59E0B);
  static const border    = Color(0xFFE2E8F0);
  static const blue      = Color(0xFF1565C0);
}

// ══════════════════════════════════════════════════════════════════════════════
// SEGMENT 2 — Enums
// ══════════════════════════════════════════════════════════════════════════════
enum TaxType         { inclusive, exclusive }
enum OrderType       { delivery, returnOrder }
enum GstType         { cgstSgst, igst }
enum TcsType         { noTcs, tcs01, tcs1 }
enum PaymentMode     { credit, cash, upi, cheque, neft }
enum DeliveryOn      { immediate, scheduled, onDemand }
enum GodownLocation  { main, branch, warehouse }
enum PettyCashMode   { cash, petty }

// ══════════════════════════════════════════════════════════════════════════════
// SEGMENT 3 — Product Info & Catalogue
// ══════════════════════════════════════════════════════════════════════════════
class _ProductInfo {
  final double oldPrice;
  final int    currentStock;
  const _ProductInfo({required this.oldPrice, required this.currentStock});
}

class AgroProducts {
  static const List<String> all = [
    'AACHI HYBRID TOMATO SEEDS 10G','AADHI PADDY SEEDS 5 KGS','AADHI PADDY SEEDS 10 KGS',
    'AARTHY HYBRID CHILLI SEEDS 10G','AARTHY HYBRID CHILLI SEEDS 25G',
    'ADITYA HYBRID MAIZE SEEDS 1 KGS','ADITYA HYBRID MAIZE SEEDS 5 KGS',
    'AGNI HYBRID COTTON SEEDS 450G','AGNI HYBRID COTTON SEEDS 900G',
    'AGRI GOLD PADDY SEEDS 5 KGS','AGRI GOLD PADDY SEEDS 26 KGS',
    'HYBRID TOMATO SEEDS 10G','HYBRID TOMATO SEEDS 50G',
    'HYBRID CHILLI SEEDS 10G','HYBRID CHILLI SEEDS 25G',
    'HYBRID MAIZE SEEDS 1 KGS','HYBRID MAIZE SEEDS 5 KGS',
    'HYBRID PADDY SEEDS 5 KGS','HYBRID PADDY SEEDS 26 KGS',
    'HYBRID ONION SEEDS 100G','HYBRID ONION SEEDS 500G',
    'UREA 45 KGS','UREA 50 KGS','UREA COATED NEEM 50 KGS',
    'DAP 50 KGS','NPK 19-19-19 1 KGS','NPK 19-19-19 5 KGS',
    'NPK 20-20-20 1 KGS','NPK 20-20-20 5 KGS',
    'MANCOZEB 75% WP 500G','MANCOZEB 75% WP 1 KGS','MANCOZEB 75% WP 5 KGS',
    'IMIDACLOPRID 17.8% SL 100 MLS','IMIDACLOPRID 17.8% SL 250 MLS',
    'IMIDACLOPRID 17.8% SL 500 MLS','IMIDACLOPRID 17.8% SL 1 LTR',
    'BAJRA SEEDS 1 KGS','BAJRA SEEDS 5 KGS','BAJRA SEEDS 25 KGS',
    'BHINDI SEEDS 500G','BHINDI SEEDS 1 KGS','BHINDI SEEDS 5 KGS',
    'BITTER GOURD SEEDS 50G','BITTER GOURD SEEDS 100G','BITTER GOURD SEEDS 500G',
    'BOTTLE GOURD SEEDS 50G','BOTTLE GOURD SEEDS 100G',
    'BRINJAL SEEDS 10G','BRINJAL SEEDS 50G','BRINJAL SEEDS 100G',
    'CABBAGE SEEDS 10G','CABBAGE SEEDS 50G','CABBAGE SEEDS 100G',
    'CAPSICUM SEEDS 10G','CAPSICUM SEEDS 50G',
    'CAULIFLOWER SEEDS 10G','CAULIFLOWER SEEDS 50G',
    'CHILLI SEEDS 10G','CHILLI SEEDS 25G','CHILLI SEEDS 50G','CHILLI SEEDS 100G',
    'CORIANDER SEEDS 100G','CORIANDER SEEDS 500G','CORIANDER SEEDS 1 KGS',
    'CUCUMBER SEEDS 10G','CUCUMBER SEEDS 50G','CUCUMBER SEEDS 100G',
    'GROUNDNUT SEEDS 1 KGS','GROUNDNUT SEEDS 5 KGS','GROUNDNUT SEEDS 25 KGS',
    'MAIZE SEEDS 1 KGS','MAIZE SEEDS 5 KGS','MAIZE SEEDS 25 KGS',
    'OKRA SEEDS 500G','OKRA SEEDS 1 KGS','OKRA SEEDS 5 KGS',
    'ONION SEEDS 100G','ONION SEEDS 500G','ONION SEEDS 1 KGS',
    'PADDY SEEDS 5 KGS','PADDY SEEDS 10 KGS','PADDY SEEDS 26 KGS',
    'RAGI SEEDS 1 KGS','RAGI SEEDS 5 KGS','RAGI SEEDS 25 KGS',
    'ROUNDUP 500 MLS','ROUNDUP 1 LTR','ROUNDUP 5 LTR',
    'SOYABEAN SEEDS 1 KGS','SOYABEAN SEEDS 5 KGS','SOYABEAN SEEDS 25 KGS',
    'SUNFLOWER SEEDS 1 KGS','SUNFLOWER SEEDS 5 KGS',
    'TOMATO SEEDS 10G','TOMATO SEEDS 50G','TOMATO SEEDS 100G',
    'VERMICOMPOST 5 KGS','VERMICOMPOST 10 KGS','VERMICOMPOST 25 KGS',
    'WATERMELON SEEDS 50G','WATERMELON SEEDS 100G','WATERMELON SEEDS 500G',
    'WHEAT SEEDS 5 KGS','WHEAT SEEDS 10 KGS','WHEAT SEEDS 25 KGS',
    'ZINC SULPHATE 21% 500G','ZINC SULPHATE 21% 1 KGS','ZINC SULPHATE 21% 5 KGS',
    'BAVISTIN 100G','BAVISTIN 250G','BAVISTIN 500G','BAVISTIN 1 KGS',
    'CORAGEN 60 MLS','CORAGEN 150 MLS','CORAGEN 300 MLS',
    'KARATE 100 MLS','KARATE 250 MLS','KARATE 500 MLS',
    'REGENT 100 MLS','REGENT 250 MLS','REGENT 500 MLS',
    'RIDOMIL GOLD 100G','RIDOMIL GOLD 250G','RIDOMIL GOLD 500G',
    'SCORE 100 MLS','SCORE 250 MLS','SCORE 500 MLS',
    'SULPHUR 80% WP 500G','SULPHUR 80% WP 1 KGS',
    'THIAMETHOXAM 25% WG 100G','THIAMETHOXAM 25% WG 250G',
    'CALCIUM NITRATE 1 KGS','CALCIUM NITRATE 5 KGS',
    'HUMIC ACID 500G','HUMIC ACID 1 KGS','HUMIC ACID 5 KGS',
    'SEAWEED EXTRACT 500 MLS','SEAWEED EXTRACT 1 LTR',
    'SINGLE SUPER PHOSPHATE 25 KGS','SINGLE SUPER PHOSPHATE 50 KGS',
    'TRIPLE SUPER PHOSPHATE 25 KGS','TRIPLE SUPER PHOSPHATE 50 KGS',
  ];

  static final Map<String, _ProductInfo> _info = {
    for (var i = 0; i < all.length; i++)
      all[i]: _ProductInfo(
        oldPrice:     50.0 + (i * 37.5) % 500,
        currentStock: 10   + (i * 13) % 150,
      ),
  };
  static _ProductInfo? getInfo(String name) => _info[name];
  static List<String> search(String query) {
    if (query.trim().isEmpty) return [];
    final q = query.toUpperCase().trim();
    return all.where((p) => p.contains(q)).take(30).toList();
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// SEGMENT 4 — Customer Names Autocomplete
// ══════════════════════════════════════════════════════════════════════════════
class CustomerNames {
  static const List<String> all = [
    'AACHI AGRO TRADERS','AADHI FARM DISTRIBUTORS','ABINAYA SEEDS AND FERTILIZERS',
    'AGRI FRESH SUPPLIERS','AGRI GOLD TRADERS PVT LTD','AGRO BHARAT DISTRIBUTORS',
    'AGRO INDIA ENTERPRISE','AGRO KRISHNA TRADERS','AGRO WORLD SUPPLIERS',
    'AGROVET SOLUTIONS','AMUDHA AGRO FARM','ANAND AGRICULTURAL STORE',
    'ANNAI AGRO TRADERS','ARJUN SEED COMPANY','ARTHI AGRO SUPPLIERS',
    'BALAJI AGRO DISTRIBUTORS','BASKAR FARM SUPPLIES','BHARATH AGRO TRADERS',
    'BHAVANI SEEDS PVT LTD','BHOOMI AGRO ENTERPRISE','CAUVERY AGRO SUPPLIERS',
    'CHANDRA AGRO TRADERS','CHITHRA FARM DISTRIBUTORS','COIMBATORE AGRO CENTER',
    'CROP CARE INDIA PVT LTD','DHANAM AGRO SUPPLIERS','DIVYA AGRO TRADERS',
    'DURGA FARM DISTRIBUTORS','EASWARI AGRO ENTERPRISE','ECO FARM SUPPLIES',
    'ERODE AGRO TRADERS','ETHIRAJ SEEDS AND CHEMICALS','FARM FRESH DISTRIBUTORS',
    'FARMTECH INDIA PVT LTD','FERTCO INDIA','GANGA AGRO TRADERS',
    'GAYATHRI FARM SUPPLIES','GOMATHI AGRO DISTRIBUTORS','GOPAL SEEDS COMPANY',
    'GREEN EARTH SUPPLIERS','GREEN LAND AGRO TRADERS','GREEN VALLEY FARM',
    'HARISH AGRO ENTERPRISE','HARVEST INDIA DISTRIBUTORS','IFFCO AGRO LTD',
    'INDIRA AGRO TRADERS','INDU FARM SUPPLIES','JAGADEESWARI AGRO CENTER',
    'JAI BHARATH TRADERS','JAI DURGA AGRO SUPPLIERS','JAYA AGRO DISTRIBUTORS',
    'JAYALAKSHMI FARM TRADERS','KAMATCHI AGRO SUPPLIERS','KANNAN FARM ENTERPRISE',
    'KARPAGAM AGRO TRADERS','KARUR AGRO CENTER','KAVITHA SEEDS PVT LTD',
    'KAVYA AGRO DISTRIBUTORS','KISAN AGRO TRADERS','KRISHNA AGRO ENTERPRISE',
    'KRISHNA FARM SUPPLIERS','KUMARASAMY AGRO CENTER','LAKSHMI AGRO TRADERS',
    'LAKSHMI FARM SUPPLIES','LALITHA AGRO DISTRIBUTORS','MADURAI AGRO TRADERS',
    'MAHALAKSHMI AGRO SUPPLIERS','MAHESH FARM ENTERPRISE','MALLIGA AGRO TRADERS',
    'MANGALAM AGRO CENTER','MANOJ AGRO SUPPLIERS','MEENAKSHI AGRO DISTRIBUTORS',
    'MUTHUKUMAR FARM TRADERS','NALLASIVAM AGRO CENTER','NANDHINI SEEDS AND CHEMICALS',
    'NATIONAL AGRO SUPPLIERS','NATURE FRESH TRADERS','NITHYA AGRO DISTRIBUTORS',
    'PALANI AGRO TRADERS','PALANISAMY FARM CENTER','PARVATHY AGRO ENTERPRISE',
    'POOJA SEEDS COMPANY','PRIYA AGRO DISTRIBUTORS','PRIYA FARM SUPPLIERS',
    'RAJA AGRO TRADERS','RAJAGOPALAN FARM CENTER','RAJALAKSHMI AGRO ENTERPRISE',
    'RAJAN FARM DISTRIBUTORS','RAJESH AGRO SUPPLIERS','RAMU AGRO TRADERS',
    'RAVI AGRO CENTER','SABARISH FARM ENTERPRISE','SARASWATHI AGRO TRADERS',
    'SELVAM SEEDS PVT LTD','SENTHIL AGRO DISTRIBUTORS','SHAKTHI AGRO TRADERS',
    'SHANMUGA FARM ENTERPRISE','SIVA AGRO SUPPLIERS','SIVAKAMI FARM DISTRIBUTORS',
    'SIVAM AGRO TRADERS','SREE AGRO CENTER','SRI AGRO ENTERPRISE',
    'SRI KRISHNA AGRO TRADERS','SRI LAKSHMI DISTRIBUTORS','SUBRAMANI AGRO SUPPLIERS',
    'SUGUNA FARM CENTER','SURESH AGRO TRADERS','TAMIL AGRO ENTERPRISE',
    'TAMILNADU AGRO CENTER','THIRUMURUGAN AGRO TRADERS','THIRUVENGADAM FARM SUPPLIES',
    'UMA AGRO DISTRIBUTORS','UMAYAL FARM ENTERPRISE','VALLI AGRO TRADERS',
    'VANITHA FARM SUPPLIES','VASANTHAM AGRO CENTER','VELAN AGRO TRADERS',
    'VELMURUGAN FARM ENTERPRISE','VIJAY AGRO DISTRIBUTORS','VIJAYALAKSHMI AGRO CENTER',
    'VINAYAGA AGRO TRADERS','YUVAN FARM ENTERPRISE','ZONAL AGRO SUPPLIERS',
  ];
  static List<String> search(String query) {
    if (query.trim().isEmpty) return [];
    final q = query.toUpperCase().trim();
    return all.where((s) => s.contains(q)).take(20).toList();
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// SEGMENT 5 — Inline Item Form Model
// ══════════════════════════════════════════════════════════════════════════════
class _InlineItemForm {
  final TextEditingController productCtrl = TextEditingController();
  final TextEditingController batchCtrl   = TextEditingController();
  final TextEditingController priceCtrl   = TextEditingController();
  final TextEditingController qtyCtrl     = TextEditingController(text: '1');
  final TextEditingController discCtrl    = TextEditingController();
  final TextEditingController taxCtrl     = TextEditingController();
  bool           discIsPercent   = true;
  double         previewTotal    = 0;
  _ProductInfo?  selectedProduct;
  List<String>   suggestions     = [];

  void dispose() {
    productCtrl.dispose(); batchCtrl.dispose(); priceCtrl.dispose();
    qtyCtrl.dispose(); discCtrl.dispose(); taxCtrl.dispose();
  }

  void recalc(TaxType taxType) {
    final p     = double.tryParse(priceCtrl.text) ?? 0;
    final q     = int.tryParse(qtyCtrl.text) ?? 0;
    final dv    = double.tryParse(discCtrl.text) ?? 0;
    final t     = double.tryParse(taxCtrl.text) ?? 0;
    final sub   = p * q;
    final disc  = discIsPercent ? sub * dv / 100 : dv;
    final after = sub - disc;
    previewTotal = taxType == TaxType.inclusive
        ? after
        : after + after * t / 100;
  }

  OrderItem toOrderItem(TaxType taxType) => OrderItem(
    product:           productCtrl.text.trim(),
    batch:             batchCtrl.text.trim(),
    price:             double.tryParse(priceCtrl.text) ?? 0,
    quantity:          int.tryParse(qtyCtrl.text) ?? 1,
    discountValue:     double.tryParse(discCtrl.text) ?? 0,
    discountIsPercent: discIsPercent,
    taxRate:           double.tryParse(taxCtrl.text) ?? 0,
    taxType:           taxType,
  );
}

// ══════════════════════════════════════════════════════════════════════════════
// SEGMENT 6 — Data Models
// ══════════════════════════════════════════════════════════════════════════════
class OrderItem {
  String  product;
  String  batch;
  double  price;
  int     quantity;
  double  discountValue;
  bool    discountIsPercent;
  double  taxRate;
  TaxType taxType;

  OrderItem({
    required this.product,
    this.batch = '',
    required this.price,
    required this.quantity,
    this.discountValue     = 0,
    this.discountIsPercent = true,
    required this.taxRate,
    required this.taxType,
  });

  double get subtotal       => price * quantity;
  double get discountAmount => discountIsPercent
      ? subtotal * discountValue / 100
      : discountValue;
  double get afterDiscount  => subtotal - discountAmount;
  double get taxAmount {
    if (taxType == TaxType.inclusive) {
      return afterDiscount - afterDiscount / (1 + taxRate / 100);
    }
    return afterDiscount * taxRate / 100;
  }
  double get grandTotal =>
      afterDiscount + (taxType == TaxType.exclusive ? taxAmount : 0);
}

class SavedOrder {
  final String          id;
  final String          customerName;
  final String          customerPhone;
  final String          customerAddress;
  final String          customerAadhaar;
  final String          reference;
  final DateTime        date;
  final DateTime        dueDate;
  final List<OrderItem> items;
  final OrderType       orderType;
  final GstType         gstType;
  final TaxType         globalTaxType;
  final TcsType         tcsType;
  final PaymentMode     paymentMode;
  final double          freightCharge;
  final double          adjustment;
  final double          addLess;
  final double          amountPaid;
  final DeliveryOn      deliveryOn;
  final GodownLocation  godown;
  final PettyCashMode   pettyCashMode;

  SavedOrder({
    required this.id,
    required this.customerName,
    required this.customerPhone,
    required this.customerAddress,
    required this.customerAadhaar,
    required this.reference,
    required this.date,
    required this.dueDate,
    required this.items,
    required this.orderType,
    required this.gstType,
    required this.globalTaxType,
    required this.tcsType,
    required this.paymentMode,
    this.freightCharge = 0,
    this.adjustment    = 0,
    this.addLess       = 0,
    this.amountPaid    = 0,
    this.deliveryOn    = DeliveryOn.immediate,
    this.godown        = GodownLocation.main,
    this.pettyCashMode = PettyCashMode.cash,
  });

  double get subTotal   => items.fold(0, (s, i) => s + i.subtotal);
  double get discTotal  => items.fold(0, (s, i) => s + i.discountAmount);
  double get taxTotal   => items.fold(0, (s, i) => s + i.taxAmount);
  double get grandTotal => items.fold(0, (s, i) => s + i.grandTotal);
  double get tcsAmount {
    if (tcsType == TcsType.tcs01) return grandTotal * 0.001;
    if (tcsType == TcsType.tcs1)  return grandTotal * 0.01;
    return 0;
  }
  double get netTotal {
    final base = grandTotal + tcsAmount + freightCharge + adjustment + addLess;
    return (base / 1).roundToDouble();
  }
  double get roundOff => netTotal - (grandTotal + tcsAmount + freightCharge + adjustment + addLess);
  double get dueAmount => netTotal - amountPaid;
}

// ══════════════════════════════════════════════════════════════════════════════
// SEGMENT 7 — Section Keys & Card Colors
// ══════════════════════════════════════════════════════════════════════════════
const _kTypes      = 'Types';
const _kCustomer   = 'Customer Details';
const _kDateRef    = 'Date & Reference';
const _kOrderItems = 'OrderItems';
const _kPayment    = 'PaymentDetails';

const List<Color> _cardBorderColors = [
  Color(0xFF1565C0), Color(0xFF2E7D32), Color(0xFF6A1B9A),
  Color(0xFFE65100), Color(0xFFC62828), Color(0xFF00838F),
];

// ══════════════════════════════════════════════════════════════════════════════
// SEGMENT 8 — Main Screen
// ══════════════════════════════════════════════════════════════════════════════
class SalesInvoiceScreen extends StatefulWidget {
  const SalesInvoiceScreen({super.key});
  @override
  State<SalesInvoiceScreen> createState() => _SalesInvoiceScreenState();
}

class _SalesInvoiceScreenState extends State<SalesInvoiceScreen>
    with TickerProviderStateMixin {

  bool _showViewOrders = false;
  final List<SavedOrder> _savedOrders = [];
  final _searchCtrl = TextEditingController();
  String _searchQuery = '';

  final _customerNameCtrl    = TextEditingController();
  final _customerPhoneCtrl   = TextEditingController();
  final _customerAddressCtrl = TextEditingController();
  final _customerAadhaarCtrl = TextEditingController();
  final _referenceCtrl       = TextEditingController();
  final _freightChargeCtrl   = TextEditingController();
  final _adjustmentCtrl      = TextEditingController();
  final _addLessCtrl         = TextEditingController();
  final _amountPaidCtrl      = TextEditingController();
  final _customerFocus       = FocusNode();

  String? _phoneError;
  String? _aadhaarError;

  OrderType       _orderType      = OrderType.delivery;
  GstType         _gstType        = GstType.cgstSgst;
  TaxType         _globalTaxType  = TaxType.exclusive;
  TcsType         _tcsType        = TcsType.noTcs;
  PaymentMode     _paymentMode    = PaymentMode.credit;
  DeliveryOn      _deliveryOn     = DeliveryOn.immediate;
  GodownLocation  _godown         = GodownLocation.main;
  PettyCashMode   _pettyCashMode  = PettyCashMode.cash;

  DateTime     _selectedDate        = DateTime.now();
  DateTime     _dueDate             = DateTime.now().add(const Duration(days: 30));
  List<String> _customerSuggestions = [];
  String?      _openSection         = _kTypes;

  final List<_InlineItemForm> _forms = [];

  @override
  void initState() {
    super.initState();
    _addNewForm();
    _amountPaidCtrl.addListener(_rebuildForDue);
    _freightChargeCtrl.addListener(_rebuildForDue);
    _adjustmentCtrl.addListener(_rebuildForDue);
    _addLessCtrl.addListener(_rebuildForDue);
  }

  void _rebuildForDue() => setState(() {});

  @override
  void dispose() {
    _customerNameCtrl.dispose(); _customerPhoneCtrl.dispose();
    _customerAddressCtrl.dispose(); _customerAadhaarCtrl.dispose();
    _referenceCtrl.dispose(); _searchCtrl.dispose(); _customerFocus.dispose();
    _freightChargeCtrl.dispose(); _adjustmentCtrl.dispose();
    _addLessCtrl.dispose(); _amountPaidCtrl.dispose();
    for (final f in _forms) f.dispose();
    super.dispose();
  }

  void _addNewForm() => _forms.add(_InlineItemForm());

  void _removeForm(int index) {
    _forms[index].dispose();
    _forms.removeAt(index);
    if (_forms.isEmpty) _addNewForm();
  }

  void _toggleSection(String key) {
    HapticFeedback.lightImpact();
    setState(() => _openSection = _openSection == key ? null : key);
  }

  Future<void> _pickDate({bool isDue = false}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isDue ? _dueDate : _selectedDate,
      firstDate: DateTime(2020), lastDate: DateTime(2035),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.light(
              primary: _C.primary, onPrimary: Colors.white,
              surface: Colors.white),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => isDue ? _dueDate = picked : _selectedDate = picked);
  }

  bool _validatePhone(String val) {
    if (val.isEmpty) return true;
    final digits = val.replaceAll(RegExp(r'\D'), '');
    return digits.length == 10;
  }

  bool _validateAadhaar(String val) {
    if (val.isEmpty) return true;
    final digits = val.replaceAll(RegExp(r'\D'), '');
    return digits.length == 12;
  }

  double get _grandTotal {
    double total = 0;
    for (final f in _forms) { f.recalc(_globalTaxType); total += f.previewTotal; }
    return total;
  }
  double get _tcsAmount {
    if (_tcsType == TcsType.tcs01) return _grandTotal * 0.001;
    if (_tcsType == TcsType.tcs1)  return _grandTotal * 0.01;
    return 0;
  }
  double get _freightVal  => double.tryParse(_freightChargeCtrl.text) ?? 0;
  double get _adjustVal   => double.tryParse(_adjustmentCtrl.text) ?? 0;
  double get _addLessVal  => double.tryParse(_addLessCtrl.text) ?? 0;
  double get _amountPaid  => double.tryParse(_amountPaidCtrl.text) ?? 0;

  double get _preNetTotal => _grandTotal + _tcsAmount + _freightVal + _adjustVal + _addLessVal;
  double get _roundOff    => _preNetTotal.roundToDouble() - _preNetTotal;
  double get _netTotal    => _preNetTotal.roundToDouble();
  double get _dueAmount   => _netTotal - _amountPaid;

  void _showSnack(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg), backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ));
  }

  void _save() {
    if (!_validatePhone(_customerPhoneCtrl.text.trim())) {
      setState(() => _phoneError = 'Enter a valid 10-digit phone number');
      _showSnack('Invalid phone number', _C.red); return;
    }
    if (!_validateAadhaar(_customerAadhaarCtrl.text.trim())) {
      setState(() => _aadhaarError = 'Enter a valid 12-digit Aadhaar number');
      _showSnack('Invalid Aadhaar number', _C.red); return;
    }
    if (_customerNameCtrl.text.trim().isEmpty) {
      _showSnack('Please enter Customer Name', _C.gold); return;
    }
    final validForms = _forms.where((f) => f.productCtrl.text.trim().isNotEmpty).toList();
    if (validForms.isEmpty) {
      _showSnack('Please add at least one item', _C.gold); return;
    }
    HapticFeedback.mediumImpact();

    final items = validForms.map((f) => f.toOrderItem(_globalTaxType)).toList();
    final order = SavedOrder(
      id:              'SI-${DateTime.now().millisecondsSinceEpoch}',
      customerName:    _customerNameCtrl.text.trim(),
      customerPhone:   _customerPhoneCtrl.text.trim(),
      customerAddress: _customerAddressCtrl.text.trim(),
      customerAadhaar: _customerAadhaarCtrl.text.trim(),
      reference:       _referenceCtrl.text.trim(),
      date:            _selectedDate,
      dueDate:         _dueDate,
      items:           items,
      orderType:       _orderType,
      gstType:         _gstType,
      globalTaxType:   _globalTaxType,
      tcsType:         _tcsType,
      paymentMode:     _paymentMode,
      freightCharge:   _freightVal,
      adjustment:      _adjustVal,
      addLess:         _addLessVal,
      amountPaid:      _amountPaid,
      deliveryOn:      _deliveryOn,
      godown:          _godown,
      pettyCashMode:   _pettyCashMode,
    );

    for (final f in _forms) f.dispose();
    _forms.clear();

    setState(() {
      _savedOrders.insert(0, order);
      _customerNameCtrl.clear(); _customerPhoneCtrl.clear();
      _customerAddressCtrl.clear(); _customerAadhaarCtrl.clear();
      _referenceCtrl.clear(); _freightChargeCtrl.clear();
      _adjustmentCtrl.clear(); _addLessCtrl.clear(); _amountPaidCtrl.clear();
      _customerSuggestions = [];
      _phoneError = null; _aadhaarError = null;
      _selectedDate   = DateTime.now();
      _dueDate        = DateTime.now().add(const Duration(days: 30));
      _orderType      = OrderType.delivery; _gstType = GstType.cgstSgst;
      _globalTaxType  = TaxType.exclusive;  _tcsType = TcsType.noTcs;
      _paymentMode    = PaymentMode.credit;
      _deliveryOn     = DeliveryOn.immediate;
      _godown         = GodownLocation.main;
      _pettyCashMode  = PettyCashMode.cash;
      _openSection    = _kTypes;
      _showViewOrders = true;
      _addNewForm();
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(children: [
        const Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
        const SizedBox(width: 10),
        Flexible(child: Text('Invoice saved! Total ₹${order.netTotal.toStringAsFixed(2)}')),
      ]),
      backgroundColor: _C.primary, behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ));
  }

  List<SavedOrder> get _filteredOrders {
    if (_searchQuery.trim().isEmpty) return _savedOrders;
    final q = _searchQuery.toLowerCase();
    return _savedOrders.where((o) {
      final num = 'SI-${(_savedOrders.indexOf(o) + 1).toString().padLeft(4, '0')}';
      return o.customerName.toLowerCase().contains(q) ||
          o.customerPhone.contains(q) ||
          o.reference.toLowerCase().contains(q) ||
          num.toLowerCase().contains(q);
    }).toList();
  }

// ══════════════════════════════════════════════════════════════════════════════
// SEGMENT 9 — Build Root
// ══════════════════════════════════════════════════════════════════════════════
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _showViewOrders ? _buildViewOrders() : _buildOrderForm(),
            ),
          ),
        ],
      ),
    );
  }

// ══════════════════════════════════════════════════════════════════════════════
// SEGMENT 10 — Header
// ══════════════════════════════════════════════════════════════════════════════
  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.appBarGradStart, AppTheme.appBarGradEnd],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
        boxShadow: [BoxShadow(color: Color(0x441B8A3E), blurRadius: 16, offset: Offset(0, 6))],
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 4, 12, 0),
              child: Row(children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
                  onPressed: () => Navigator.pop(context),
                  constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                  padding: const EdgeInsets.all(8),
                ),
                const Expanded(
                  child: Text('Sales Invoice',
                      style: TextStyle(color: Colors.white, fontSize: 19,
                          fontWeight: FontWeight.w800, letterSpacing: 0.3)),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 12),
              child: Container(
                height: 48, padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Row(children: [
                  _tab(label: 'VIEW INVOICES', icon: Icons.list_alt_rounded,
                      active: _showViewOrders,
                      onTap: () => setState(() => _showViewOrders = true)),
                  _tab(label: 'NEW INVOICE', icon: Icons.add_circle_outline_rounded,
                      active: !_showViewOrders,
                      onTap: () => setState(() => _showViewOrders = false)),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tab({required String label, required IconData icon,
    required bool active, required VoidCallback onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeInOut,
          height: double.infinity,
          decoration: BoxDecoration(
            color: active ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            boxShadow: active
                ? [BoxShadow(color: Colors.black.withOpacity(0.10),
                blurRadius: 8, offset: const Offset(0, 2))]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: active ? _C.primary : Colors.white),
              const SizedBox(width: 5),
              Text(label, style: TextStyle(
                fontSize: active ? 13 : 12,
                fontWeight: active ? FontWeight.w800 : FontWeight.w600,
                color: active ? _C.primary : Colors.white,
              )),
            ],
          ),
        ),
      ),
    );
  }

// ══════════════════════════════════════════════════════════════════════════════
// SEGMENT 11 — New Order Form
// ══════════════════════════════════════════════════════════════════════════════
  Widget _buildOrderForm() {
    return SingleChildScrollView(
      key: const ValueKey('form'),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _accordionCard(sectionKey: _kTypes, icon: Icons.tune_rounded,
              title: 'Order Types', child: _buildTypesContent()),
          const SizedBox(height: 14),
          _accordionCard(sectionKey: _kCustomer, icon: Icons.person_rounded,
              title: 'Customer Details', child: _buildCustomerContent()),
          const SizedBox(height: 14),
          _accordionCard(sectionKey: _kDateRef, icon: Icons.calendar_month_rounded,
              title: 'Date & Reference', child: _buildDateRefContent()),
          const SizedBox(height: 14),
          _accordionCard(sectionKey: _kOrderItems, icon: Icons.shopping_cart_rounded,
              title: 'Order Items', child: _buildInlineItemsBody()),
          const SizedBox(height: 14),
          _accordionCard(sectionKey: _kPayment, icon: Icons.payment_rounded,
              title: 'Payment Details', child: _buildPaymentDetailsContent()),
          const SizedBox(height: 16),
          _buildSaveButton(),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

// ══════════════════════════════════════════════════════════════════════════════
// SEGMENT 12 — Accordion Card
// ══════════════════════════════════════════════════════════════════════════════
  Widget _accordionCard({required String sectionKey, required IconData icon,
    required String title, required Widget child}) {
    final isExpanded = _openSection == sectionKey;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: _C.surface, borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06),
            blurRadius: 16, offset: const Offset(0, 4))],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => _toggleSection(sectionKey),
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isExpanded ? _C.primary : _C.primaryLt,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon,
                      color: isExpanded ? Colors.white : _C.primary, size: 18),
                ),
                const SizedBox(width: 10),
                Expanded(child: Text(title,
                    style: const TextStyle(color: _C.textDark, fontSize: 15,
                        fontWeight: FontWeight.w700))),
                AnimatedRotation(
                  turns: isExpanded ? 0.5 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: _C.primaryLt, borderRadius: BorderRadius.circular(8)),
                    child: const Icon(Icons.keyboard_arrow_down_rounded,
                        color: _C.primary, size: 20),
                  ),
                ),
              ]),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity, height: 0),
            secondChild: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(height: 1, color: _C.border.withOpacity(0.7)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
                  child: child,
                ),
              ],
            ),
            crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
            sizeCurve: Curves.easeInOut,
          ),
        ],
      ),
    );
  }

// ══════════════════════════════════════════════════════════════════════════════
// SEGMENT 13 — Types Content
// ══════════════════════════════════════════════════════════════════════════════
  Widget _buildTypesContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(children: [
          Expanded(child: _TypeDropdown<OrderType>(
            label: 'Type', value: _orderType,
            items: const [
              DropdownMenuItem(value: OrderType.delivery,    child: Text('Delivery')),
              DropdownMenuItem(value: OrderType.returnOrder, child: Text('Return')),
            ],
            onChanged: (v) { if (v != null) setState(() => _orderType = v); },
          )),
          const SizedBox(width: 12),
          Expanded(child: _TypeDropdown<GstType>(
            label: 'GST Type', value: _gstType,
            items: const [
              DropdownMenuItem(value: GstType.cgstSgst, child: Text('CGST/SGST')),
              DropdownMenuItem(value: GstType.igst,     child: Text('IGST')),
            ],
            onChanged: (v) { if (v != null) setState(() => _gstType = v); },
          )),
        ]),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: _TypeDropdown<TaxType>(
            label: 'Tax Inclusion', value: _globalTaxType,
            items: const [
              DropdownMenuItem(value: TaxType.exclusive, child: Text('Exclude Tax')),
              DropdownMenuItem(value: TaxType.inclusive, child: Text('Include Tax')),
            ],
            onChanged: (v) { if (v != null) setState(() => _globalTaxType = v); },
          )),
          const SizedBox(width: 12),
          Expanded(child: _TypeDropdown<TcsType>(
            label: 'TCS', value: _tcsType,
            items: const [
              DropdownMenuItem(value: TcsType.noTcs, child: Text('No TCS')),
              DropdownMenuItem(value: TcsType.tcs01, child: Text('TCS 0.1%')),
              DropdownMenuItem(value: TcsType.tcs1,  child: Text('TCS 1%')),
            ],
            onChanged: (v) { if (v != null) setState(() => _tcsType = v); },
          )),
        ]),
        const SizedBox(height: 12),
        _TypeDropdown<PaymentMode>(
          label: 'Payment Mode', value: _paymentMode,
          items: const [
            DropdownMenuItem(value: PaymentMode.credit, child: Text('Credit')),
            DropdownMenuItem(value: PaymentMode.cash,   child: Text('Cash')),
            DropdownMenuItem(value: PaymentMode.upi,    child: Text('UPI')),
            DropdownMenuItem(value: PaymentMode.cheque, child: Text('Cheque')),
            DropdownMenuItem(value: PaymentMode.neft,   child: Text('NEFT / Bank Transfer')),
          ],
          onChanged: (v) { if (v != null) setState(() => _paymentMode = v); },
        ),
      ],
    );
  }

// ══════════════════════════════════════════════════════════════════════════════
// SEGMENT 14 — Customer Content
// ══════════════════════════════════════════════════════════════════════════════
  Widget _buildCustomerContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _FieldLabel(label: 'Customer Name'),
        const SizedBox(height: 6),
        TextField(
          controller: _customerNameCtrl,
          focusNode: _customerFocus,
          textCapitalization: TextCapitalization.characters,
          style: const TextStyle(color: _C.textDark, fontSize: 15, fontWeight: FontWeight.w500),
          onChanged: (val) => setState(() => _customerSuggestions = CustomerNames.search(val)),
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.person_rounded, color: _C.primary, size: 20),
            hintText: 'Search or enter customer name',
            hintStyle: const TextStyle(color: _C.textLight, fontSize: 14),
            filled: true, fillColor: _C.bg,
            suffixIcon: _customerNameCtrl.text.isNotEmpty
                ? IconButton(
              icon: const Icon(Icons.clear, color: _C.textLight, size: 18),
              onPressed: () => setState(() {
                _customerNameCtrl.clear(); _customerSuggestions = [];
              }),
            )
                : null,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: _C.border)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: _C.border)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: _C.primary, width: 1.5)),
          ),
        ),
        if (_customerSuggestions.isNotEmpty) ...[
          const SizedBox(height: 4),
          Container(
            constraints: const BoxConstraints(maxHeight: 180),
            decoration: BoxDecoration(
              color: _C.primaryLt,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _C.primary, width: 1.5),
              boxShadow: [BoxShadow(color: _C.primary.withOpacity(0.15),
                  blurRadius: 12, offset: const Offset(0, 4))],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: ListView.separated(
                shrinkWrap: true, padding: EdgeInsets.zero,
                itemCount: _customerSuggestions.length,
                separatorBuilder: (_, __) =>
                    Divider(height: 1, color: _C.primary.withOpacity(0.2)),
                itemBuilder: (_, i) {
                  final s     = _customerSuggestions[i];
                  final query = _customerNameCtrl.text.toUpperCase().trim();
                  final idx   = s.indexOf(query);
                  return InkWell(
                    onTap: () => setState(() {
                      _customerNameCtrl.text = s;
                      _customerNameCtrl.selection =
                          TextSelection.fromPosition(TextPosition(offset: s.length));
                      _customerSuggestions = [];
                      _customerFocus.unfocus();
                    }),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                      child: Row(children: [
                        const Icon(Icons.person_rounded, color: _C.primary, size: 14),
                        const SizedBox(width: 8),
                        Expanded(
                          child: idx >= 0 && query.isNotEmpty
                              ? RichText(text: TextSpan(children: [
                            TextSpan(text: s.substring(0, idx),
                                style: const TextStyle(color: _C.primaryDk,
                                    fontSize: 13, fontWeight: FontWeight.w500)),
                            TextSpan(text: s.substring(idx, idx + query.length),
                                style: const TextStyle(color: _C.primary,
                                    fontSize: 13, fontWeight: FontWeight.w800,
                                    backgroundColor: Color(0xFFBEEDD1))),
                            TextSpan(text: s.substring(idx + query.length),
                                style: const TextStyle(color: _C.primaryDk,
                                    fontSize: 13, fontWeight: FontWeight.w500)),
                          ]))
                              : Text(s, style: const TextStyle(color: _C.primaryDk,
                              fontSize: 13, fontWeight: FontWeight.w600)),
                        ),
                      ]),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
        const SizedBox(height: 14),
        const _FieldLabel(label: 'Phone'),
        const SizedBox(height: 6),
        _ValidatedField(
          controller: _customerPhoneCtrl,
          hint: 'Enter 10-digit mobile number',
          icon: Icons.phone_rounded,
          keyboardType: TextInputType.phone,
          errorText: _phoneError,
          maxLength: 10,
          onChanged: (val) {
            setState(() {
              _phoneError = _validatePhone(val.trim())
                  ? null : 'Enter a valid 10-digit phone number';
            });
          },
        ),
        const SizedBox(height: 14),
        const _FieldLabel(label: 'Address'),
        const SizedBox(height: 6),
        _InputField(controller: _customerAddressCtrl, hint: 'Enter address',
            icon: Icons.location_on_rounded, maxLines: 2),
        const SizedBox(height: 14),
        const _FieldLabel(label: 'Aadhaar'),
        const SizedBox(height: 6),
        _ValidatedField(
          controller: _customerAadhaarCtrl,
          hint: 'Enter 12-digit Aadhaar number',
          icon: Icons.credit_card_rounded,
          keyboardType: TextInputType.number,
          errorText: _aadhaarError,
          maxLength: 12,
          onChanged: (val) {
            setState(() {
              _aadhaarError = _validateAadhaar(val.trim())
                  ? null : 'Enter a valid 12-digit Aadhaar number';
            });
          },
        ),
      ],
    );
  }

// ══════════════════════════════════════════════════════════════════════════════
// SEGMENT 15 — Date & Reference Content
// ══════════════════════════════════════════════════════════════════════════════
  Widget _buildDateRefContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _FieldLabel(label: 'Date'),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: () => _pickDate(),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  decoration: BoxDecoration(color: _C.bg,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: _C.border)),
                  child: Row(children: [
                    const Icon(Icons.calendar_month_rounded, color: _C.primary, size: 14),
                    const SizedBox(width: 8),
                    Text(DateFormat('dd-MM-yyyy').format(_selectedDate),
                        style: const TextStyle(color: _C.textDark, fontSize: 12,
                            fontWeight: FontWeight.w600)),
                    const Spacer(),
                    const Icon(Icons.keyboard_arrow_down_rounded, color: _C.textMid, size: 10),
                  ]),
                ),
              ),
            ],
          )),
          const SizedBox(width: 12),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _FieldLabel(label: 'Reference No'),
              const SizedBox(height: 6),
              _InputField(controller: _referenceCtrl, hint: 'Enter reference no',
                  icon: Icons.tag_rounded),
            ],
          )),
        ]),
        const SizedBox(height: 14),
        Row(children: [
          const _FieldLabel(label: 'Due Date'),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: () => _pickDate(isDue: true),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                decoration: BoxDecoration(color: _C.bg,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: _C.border)),
                child: Row(children: [
                  const Icon(Icons.event_rounded, color: _C.gold, size: 18),
                  const SizedBox(width: 8),
                  Text(DateFormat('dd-MM-yyyy').format(_dueDate),
                      style: const TextStyle(color: _C.textDark, fontSize: 13,
                          fontWeight: FontWeight.w600)),
                  const Spacer(),
                  const Icon(Icons.keyboard_arrow_down_rounded, color: _C.textMid, size: 18),
                ]),
              ),
            ),
          ),
        ]),
      ],
    );
  }

// ══════════════════════════════════════════════════════════════════════════════
// SEGMENT 16 — Inline Items Body
// ══════════════════════════════════════════════════════════════════════════════
  Widget _buildInlineItemsBody() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(_forms.length, (i) => _buildSingleItemForm(i)),
        GestureDetector(
          onTap: () => setState(() => _addNewForm()),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: _C.surface, borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _C.primary, width: 1.5),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_rounded, color: _C.primary, size: 20),
                SizedBox(width: 8),
                Text('Add Item', style: TextStyle(color: _C.primary,
                    fontSize: 14, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSingleItemForm(int index) {
    final form = _forms[index];
    return StatefulBuilder(
      builder: (ctx, ss) {
        void recalc() => ss(() => form.recalc(_globalTaxType));

        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: _C.bg, borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _C.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: const BoxDecoration(
                  color: _C.primaryLt,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Row(children: [
                  Text('Item ${index + 1}',
                      style: const TextStyle(color: _C.primary, fontSize: 13,
                          fontWeight: FontWeight.w700)),
                  const Spacer(),
                  if (_forms.length > 1)
                    GestureDetector(
                      onTap: () => setState(() => _removeForm(index)),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: _C.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8)),
                        child: const Icon(Icons.close_rounded, color: _C.red, size: 16),
                      ),
                    ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Description',
                        style: TextStyle(color: _C.textMid, fontSize: 12,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    TextField(
                      controller: form.productCtrl,
                      textCapitalization: TextCapitalization.characters,
                      style: const TextStyle(color: _C.textDark, fontSize: 14,
                          fontWeight: FontWeight.w500),
                      onChanged: (val) {
                        ss(() => form.suggestions = AgroProducts.search(val));
                        recalc();
                      },
                      decoration: InputDecoration(
                        hintText: 'Type to search product…',
                        hintStyle: const TextStyle(color: _C.textLight, fontSize: 13),
                        filled: true, fillColor: _C.surface,
                        suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded,
                            color: _C.textMid, size: 20),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: _C.border)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: _C.border)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: _C.primary, width: 1.5)),
                      ),
                    ),
                    if (form.suggestions.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Container(
                        constraints: const BoxConstraints(maxHeight: 150),
                        decoration: BoxDecoration(
                          color: _C.primaryLt,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _C.primary, width: 1.5),
                          boxShadow: [BoxShadow(color: _C.primary.withOpacity(0.12),
                              blurRadius: 12, offset: const Offset(0, 4))],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: ListView.separated(
                            shrinkWrap: true, padding: EdgeInsets.zero,
                            itemCount: form.suggestions.length,
                            separatorBuilder: (_, __) =>
                                Divider(height: 1, color: _C.primary.withOpacity(0.2)),
                            itemBuilder: (_, si) {
                              final s     = form.suggestions[si];
                              final query = form.productCtrl.text.toUpperCase().trim();
                              final idx   = s.indexOf(query);
                              return InkWell(
                                onTap: () {
                                  form.productCtrl.text = s;
                                  form.productCtrl.selection =
                                      TextSelection.fromPosition(TextPosition(offset: s.length));
                                  ss(() {
                                    form.suggestions     = [];
                                    form.selectedProduct = AgroProducts.getInfo(s);
                                  });
                                  recalc();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                  child: Row(children: [
                                    const Icon(Icons.eco_rounded, color: _C.primary, size: 14),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: idx >= 0 && query.isNotEmpty
                                          ? RichText(text: TextSpan(children: [
                                        TextSpan(text: s.substring(0, idx),
                                            style: const TextStyle(color: _C.primaryDk,
                                                fontSize: 13, fontWeight: FontWeight.w500)),
                                        TextSpan(text: s.substring(idx, idx + query.length),
                                            style: const TextStyle(color: _C.primary,
                                                fontSize: 13, fontWeight: FontWeight.w800,
                                                backgroundColor: Color(0xFFBEEDD1))),
                                        TextSpan(text: s.substring(idx + query.length),
                                            style: const TextStyle(color: _C.primaryDk,
                                                fontSize: 13, fontWeight: FontWeight.w600)),
                                      ]))
                                          : Text(s, style: const TextStyle(color: _C.primaryDk,
                                          fontSize: 13, fontWeight: FontWeight.w600)),
                                    ),
                                  ]),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 12),
                    const Text('Batch No',
                        style: TextStyle(color: _C.textMid, fontSize: 12,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    TextField(
                      controller: form.batchCtrl,
                      style: const TextStyle(color: _C.textDark, fontSize: 14,
                          fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        hintText: 'Enter batch number (optional)',
                        hintStyle: const TextStyle(color: _C.textLight, fontSize: 13),
                        filled: true, fillColor: _C.surface,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: _C.border)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: _C.border)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: _C.primary, width: 1.5)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(children: [
                      const Text('Price (₹)',
                          style: TextStyle(color: _C.textMid, fontSize: 12,
                              fontWeight: FontWeight.w600)),
                      if (form.selectedProduct != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF3CD),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: _C.gold.withOpacity(0.5)),
                          ),
                          child: Text(
                            'Old: ₹${form.selectedProduct!.oldPrice.toStringAsFixed(0)}',
                            style: const TextStyle(color: _C.gold, fontSize: 10,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ]),
                    const SizedBox(height: 6),
                    TextField(
                      controller: form.priceCtrl,
                      keyboardType: TextInputType.number,
                      onChanged: (_) => recalc(),
                      style: const TextStyle(color: _C.textDark, fontSize: 14,
                          fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        hintText: '0.00',
                        hintStyle: const TextStyle(color: _C.textLight, fontSize: 13),
                        filled: true, fillColor: _C.surface,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: _C.border)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: _C.border)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: _C.primary, width: 1.5)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(children: [
                      const Text('Quantity',
                          style: TextStyle(color: _C.textMid, fontSize: 12,
                              fontWeight: FontWeight.w600)),
                      if (form.selectedProduct != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                            color: _C.primaryLt,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: _C.primary.withOpacity(0.35)),
                          ),
                          child: Text(
                            'Stock: ${form.selectedProduct!.currentStock}',
                            style: const TextStyle(color: _C.primary, fontSize: 10,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ]),
                    const SizedBox(height: 6),
                    TextField(
                      controller: form.qtyCtrl,
                      keyboardType: TextInputType.number,
                      onChanged: (_) => recalc(),
                      style: const TextStyle(color: _C.textDark, fontSize: 14,
                          fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        hintText: '1',
                        hintStyle: const TextStyle(color: _C.textLight, fontSize: 13),
                        filled: true, fillColor: _C.surface,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: _C.border)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: _C.border)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: _C.primary, width: 1.5)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Discount (%)',
                                style: TextStyle(color: _C.textMid, fontSize: 12,
                                    fontWeight: FontWeight.w600)),
                            const SizedBox(height: 6),
                            TextField(
                              controller: form.discCtrl,
                              keyboardType: TextInputType.number,
                              onChanged: (_) => recalc(),
                              style: const TextStyle(color: _C.textDark, fontSize: 14,
                                  fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                hintText: '0',
                                hintStyle: const TextStyle(color: _C.textLight, fontSize: 13),
                                filled: true, fillColor: _C.surface,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: _C.border)),
                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: _C.border)),
                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: _C.primary, width: 1.5)),
                              ),
                            ),
                          ],
                        )),
                        const SizedBox(width: 12),
                        Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Tax (%)',
                                style: TextStyle(color: _C.textMid, fontSize: 12,
                                    fontWeight: FontWeight.w600)),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                              decoration: BoxDecoration(
                                color: _C.surface, borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: _C.border),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: form.taxCtrl.text.isEmpty ? '0%' : '${form.taxCtrl.text}%',
                                  isExpanded: true,
                                  icon: const Icon(Icons.keyboard_arrow_down_rounded,
                                      color: _C.primary, size: 18),
                                  dropdownColor: _C.surface,
                                  style: const TextStyle(color: _C.textDark, fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  items: ['0%', '5%', '12%', '18%', '28%']
                                      .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                                      .toList(),
                                  onChanged: (val) {
                                    if (val != null) {
                                      form.taxCtrl.text = val.replaceAll('%', '');
                                      recalc();
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        )),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: _C.primaryLt, borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: _C.primary.withOpacity(0.2)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Item Total', style: TextStyle(color: _C.primary,
                              fontWeight: FontWeight.w600, fontSize: 13)),
                          Text('₹${form.previewTotal.toStringAsFixed(2)}',
                              style: const TextStyle(color: _C.primary,
                                  fontWeight: FontWeight.w800, fontSize: 16)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

// ══════════════════════════════════════════════════════════════════════════════
// SEGMENT 17 — Payment Details (REDESIGNED per sketch)
// ══════════════════════════════════════════════════════════════════════════════
  Widget _buildPaymentDetailsContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // ── CARD 1: Freight & Delivery ────────────────────────────────────
        _paymentCard(
          icon: Icons.local_shipping_rounded,
          iconColor: const Color(0xFF1565C0),
          title: 'Freight & Delivery',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _FieldLabel(label: 'Freight Charges'),
              const SizedBox(height: 6),
              _PaymentNumField(
                controller: _freightChargeCtrl,
                hint: '0.00',
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 14),
              const _FieldLabel(label: 'Items Delivery Type'),
              const SizedBox(height: 6),
              _TypeDropdown<DeliveryOn>(
                label: '',
                value: _deliveryOn,
                items: const [
                  DropdownMenuItem(value: DeliveryOn.immediate, child: Text('Items delivery on')),
                  DropdownMenuItem(value: DeliveryOn.onDemand,  child: Text('Items delivery off')),
                ],
                onChanged: (v) { if (v != null) setState(() => _deliveryOn = v); },
              ),
              const SizedBox(height: 14),
              const _FieldLabel(label: 'District / Godown'),
              const SizedBox(height: 6),
              _TypeDropdown<GodownLocation>(
                label: '',
                value: _godown,
                items: const [
                  DropdownMenuItem(value: GodownLocation.main,      child: Text('Main Godown')),
                  DropdownMenuItem(value: GodownLocation.branch,    child: Text('Branch Godown')),
                  DropdownMenuItem(value: GodownLocation.warehouse, child: Text('Warehouse')),
                ],
                onChanged: (v) { if (v != null) setState(() => _godown = v); },
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── CARD 2: Adjustment & Payment ──────────────────────────────────
        _paymentCard(
          icon: Icons.tune_rounded,
          iconColor: const Color(0xFF2E7D32),
          title: 'Adjustment & Payment',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _FieldLabel(label: 'Adjustment'),
              const SizedBox(height: 6),
              _PaymentNumField(
                controller: _adjustmentCtrl,
                hint: '0.00',
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 14),
              Row(children: [
                Expanded(child: _TypeDropdown<PaymentMode>(
                  label: 'Cash',
                  value: _paymentMode,
                  items: const [
                    DropdownMenuItem(value: PaymentMode.cash,   child: Text('CASH')),
                    DropdownMenuItem(value: PaymentMode.credit, child: Text('CREDIT')),
                    DropdownMenuItem(value: PaymentMode.upi,    child: Text('UPI')),
                    DropdownMenuItem(value: PaymentMode.cheque, child: Text('CHEQUE')),
                    DropdownMenuItem(value: PaymentMode.neft,   child: Text('NEFT')),
                  ],
                  onChanged: (v) { if (v != null) setState(() => _paymentMode = v); },
                )),
                const SizedBox(width: 12),
                Expanded(child: _TypeDropdown<PettyCashMode>(
                  label: 'Petty Cash',
                  value: _pettyCashMode,
                  items: const [
                    DropdownMenuItem(value: PettyCashMode.cash,  child: Text('CASH')),
                    DropdownMenuItem(value: PettyCashMode.petty, child: Text('PETTY')),
                  ],
                  onChanged: (v) { if (v != null) setState(() => _pettyCashMode = v); },
                )),
              ]),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ══════════════════════════════════════════════════════════════════
        // CARD 3 — ADDITIONAL CHARGES  (matches sketch: top card)
        //   ┌─────────────────────────────────────┐
        //   │  Additional Charges                  │
        //   │  Add / Less Amount                   │
        //   │  [ _______________________________ ] │
        //   │                                      │
        //   │  Paid              Due               │
        //   │  [ _________ ]  [ ______________ ]   │
        //   └─────────────────────────────────────┘
        // ══════════════════════════════════════════════════════════════════
        _paymentCard(
          icon: Icons.calculate_rounded,
          iconColor: const Color(0xFF6A1B9A),
          title: 'Additional Charges',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Add / Less Amount — full width
              const _FieldLabel(label: 'Add / Less Amount'),
              const SizedBox(height: 6),
              _PaymentNumField(
                controller: _addLessCtrl,
                hint: '0.00',
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 16),

              // Paid + Due — side by side
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Paid (editable)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _FieldLabel(label: 'Paid'),
                        const SizedBox(height: 6),
                        _PaymentNumField(
                          controller: _amountPaidCtrl,
                          hint: '0.00',
                          onChanged: (_) => setState(() {}),
                          highlight: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Due (auto-calculated, read-only display)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _FieldLabel(label: 'Due'),
                        const SizedBox(height: 6),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 14),
                          decoration: BoxDecoration(
                            color: _dueAmount > 0
                                ? _C.red.withOpacity(0.07)
                                : _C.primary.withOpacity(0.07),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: _dueAmount > 0
                                  ? _C.red.withOpacity(0.35)
                                  : _C.primary.withOpacity(0.25),
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            '₹${_dueAmount.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: _dueAmount > 0 ? _C.red : _C.primary,
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ══════════════════════════════════════════════════════════════════
        // CARD 4 — TCS AMOUNT  (matches sketch: bottom card)
        //   ┌─────────────────────────────────────┐
        //   │  TCS Amount                          │
        //   │                                      │
        //   │  TCS    [ ________________________ ] │
        //   │                                      │
        //   │  Round  [ ________________________ ] │
        //   └─────────────────────────────────────┘
        // ══════════════════════════════════════════════════════════════════
        _paymentCard(
          icon: Icons.percent_rounded,
          iconColor: const Color(0xFFE65100),
          title: 'TCS Amount',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TCS row
              Row(
                children: [
                  SizedBox(
                    width: 60,
                    child: Text(
                      'TCS',
                      style: TextStyle(
                        color: _C.textMid,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE65100).withOpacity(0.06),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFE65100).withOpacity(0.25),
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        '₹${_tcsAmount.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Color(0xFFE65100),
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Round row
              Row(
                children: [
                  SizedBox(
                    width: 60,
                    child: Text(
                      'Round',
                      style: TextStyle(
                        color: _C.textMid,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 14),
                      decoration: BoxDecoration(
                        color: _C.primaryLt,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _C.primary.withOpacity(0.25),
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        '${_roundOff >= 0 ? '+' : ''}₹${_roundOff.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: _C.primary,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

      ],
    );
  }

  /// Reusable payment section card wrapper
  Widget _paymentCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _C.border),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05),
            blurRadius: 12, offset: const Offset(0, 2))],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 18),
            ),
            const SizedBox(width: 10),
            Text(title, style: const TextStyle(color: _C.textDark,
                fontSize: 15, fontWeight: FontWeight.w700)),
          ]),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

// ══════════════════════════════════════════════════════════════════════════════
// SEGMENT 18 — Save Button
// ══════════════════════════════════════════════════════════════════════════════
  Widget _buildSaveButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [_C.primary, _C.primaryDk],
            begin: Alignment.centerLeft, end: Alignment.centerRight),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: _C.primary.withOpacity(0.4),
            blurRadius: 16, offset: const Offset(0, 6))],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _save, borderRadius: BorderRadius.circular(18),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.save_rounded, color: Colors.white, size: 20),
              SizedBox(width: 12),
              Text('SAVE ORDER', style: TextStyle(color: Colors.white, fontSize: 14,
                  fontWeight: FontWeight.w800, letterSpacing: 0.5)),
            ]),
          ),
        ),
      ),
    );
  }

// ══════════════════════════════════════════════════════════════════════════════
// SEGMENT 19 — View Orders Tab
// ══════════════════════════════════════════════════════════════════════════════
  Widget _buildViewOrders() {
    if (_savedOrders.isEmpty) {
      return Center(
        key: const ValueKey('empty'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90, height: 90,
              decoration: const BoxDecoration(color: _C.primaryLt, shape: BoxShape.circle),
              child: const Icon(Icons.receipt_long_rounded, color: _C.primary, size: 44),
            ),
            const SizedBox(height: 20),
            const Text('No Invoices Yet',
                style: TextStyle(color: _C.textDark, fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            const Text('Save an invoice to see it here',
                style: TextStyle(color: _C.textMid, fontSize: 14)),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => setState(() => _showViewOrders = false),
              icon: const Icon(Icons.add_rounded, color: Colors.white, size: 18),
              label: const Text('Create Invoice',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
              style: ElevatedButton.styleFrom(
                backgroundColor: _C.primary,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ],
        ),
      );
    }

    final filtered   = _filteredOrders;
    final totalCount = _savedOrders.length;

    return Column(
      key: const ValueKey('list'),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: _C.surface, borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _C.border),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04),
                  blurRadius: 8, offset: const Offset(0, 2))],
            ),
            child: Row(children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Icon(Icons.search_rounded, color: _C.textMid, size: 20),
              ),
              Expanded(
                child: TextField(
                  controller: _searchCtrl,
                  onChanged: (v) => setState(() => _searchQuery = v),
                  style: const TextStyle(color: _C.textDark, fontSize: 14,
                      fontWeight: FontWeight.w500),
                  decoration: const InputDecoration(
                    hintText: 'Search name, invoice no, phone...',
                    hintStyle: TextStyle(color: _C.textLight, fontSize: 13),
                    border: InputBorder.none, isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              if (_searchQuery.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.close_rounded, color: _C.textMid, size: 18),
                  onPressed: () { _searchCtrl.clear(); setState(() => _searchQuery = ''); },
                  padding: const EdgeInsets.all(8),
                  constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                ),
            ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
          child: Row(children: [
            Text(
              _searchQuery.isEmpty
                  ? '$totalCount invoice${totalCount != 1 ? 's' : ''}'
                  : '${filtered.length} result${filtered.length != 1 ? 's' : ''}',
              style: const TextStyle(color: _C.textMid, fontSize: 13,
                  fontWeight: FontWeight.w500),
            ),
          ]),
        ),
        Expanded(
          child: filtered.isEmpty
              ? Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.search_off_rounded, color: _C.textLight, size: 48),
              const SizedBox(height: 12),
              Text('No results for "$_searchQuery"',
                  style: const TextStyle(color: _C.textMid, fontSize: 14)),
            ],
          ))
              : ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
            physics: const BouncingScrollPhysics(),
            itemCount: filtered.length,
            itemBuilder: (_, i) {
              final o             = filtered[i];
              final originalIndex = _savedOrders.indexOf(o);
              final siNumber      = (_savedOrders.length - originalIndex)
                  .toString().padLeft(4, '0');
              final borderColor   =
              _cardBorderColors[originalIndex % _cardBorderColors.length];
              return _buildListCard(o, siNumber, borderColor);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildListCard(SavedOrder o, String siNumber, Color borderColor) {
    return GestureDetector(
      onTap: () => _showDetailSheet(o, siNumber),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: _C.surface, borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05),
              blurRadius: 10, offset: const Offset(0, 3))],
        ),
        child: IntrinsicHeight(
          child: Row(children: [
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: borderColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(14), bottomLeft: Radius.circular(14)),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                child: Row(children: [
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Expanded(
                          child: Text(o.customerName,
                              style: const TextStyle(color: _C.textDark, fontSize: 15,
                                  fontWeight: FontWeight.w700),
                              overflow: TextOverflow.ellipsis),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: _C.primaryLt, borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text('SI-$siNumber',
                              style: const TextStyle(color: _C.primary, fontSize: 11,
                                  fontWeight: FontWeight.w700)),
                        ),
                      ]),
                      if (o.reference.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text('Ref: ${o.reference}',
                            style: const TextStyle(color: _C.textMid, fontSize: 12,
                                fontWeight: FontWeight.w500)),
                      ],
                      const SizedBox(height: 4),
                      Row(children: [
                        Text(DateFormat('dd MMM yyyy').format(o.date),
                            style: const TextStyle(color: _C.textLight, fontSize: 11,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: _C.primaryLt, borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(o.paymentMode.name.toUpperCase(),
                              style: const TextStyle(color: _C.primary, fontSize: 10,
                                  fontWeight: FontWeight.w700)),
                        ),
                        if (o.dueAmount > 0) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: _C.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text('Due: ₹${o.dueAmount.toStringAsFixed(0)}',
                                style: const TextStyle(color: _C.red, fontSize: 10,
                                    fontWeight: FontWeight.w700)),
                          ),
                        ],
                      ]),
                    ],
                  )),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Rs. ${_formatAmount(o.netTotal)}',
                          style: const TextStyle(color: _C.textDark, fontSize: 15,
                              fontWeight: FontWeight.w800)),
                      const SizedBox(height: 6),
                      GestureDetector(
                        onTap: () => _showDetailSheet(o, siNumber),
                        child: const Text('View Details >',
                            style: TextStyle(color: _C.primary, fontSize: 12,
                                fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  String _formatAmount(double amount) =>
      NumberFormat('#,##,##0.00', 'en_IN').format(amount);

  void _showDetailSheet(SavedOrder o, String siNumber) {
    final originalIndex = _savedOrders.indexOf(o);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _InvoiceDetailSheet(
        order: o, siNumber: siNumber, cardIndex: originalIndex + 1,
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// SEGMENT 20 — Invoice Detail Bottom Sheet
// ══════════════════════════════════════════════════════════════════════════════
class _InvoiceDetailSheet extends StatelessWidget {
  final SavedOrder order;
  final String     siNumber;
  final int        cardIndex;

  const _InvoiceDetailSheet({
    required this.order, required this.siNumber, required this.cardIndex,
  });

  String _fmt(double v) => NumberFormat('#,##,##0.00', 'en_IN').format(v);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.88, minChildSize: 0.5, maxChildSize: 0.95,
      builder: (_, scrollCtrl) {
        return Container(
          decoration: const BoxDecoration(
            color: _C.bg,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(children: [
            const SizedBox(height: 10),
            Container(
              width: 40, height: 4,
              decoration: BoxDecoration(color: _C.border, borderRadius: BorderRadius.circular(4)),
            ),
            const SizedBox(height: 6),
            Container(
              margin: const EdgeInsets.fromLTRB(16, 6, 16, 0),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF7ECBAA), Color(0xFF4BAD7A)],
                  begin: Alignment.centerLeft, end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text('#$cardIndex',
                      style: const TextStyle(color: Colors.white, fontSize: 15,
                          fontWeight: FontWeight.w900)),
                ),
                const SizedBox(width: 12),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(order.customerName,
                        style: const TextStyle(color: Colors.white, fontSize: 16,
                            fontWeight: FontWeight.w800)),
                    const SizedBox(height: 2),
                    Text('SI-$siNumber',
                        style: const TextStyle(color: Colors.white70, fontSize: 13)),
                  ],
                )),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text('Rs. ${_fmt(order.netTotal)}',
                      style: const TextStyle(color: Colors.white, fontSize: 16,
                          fontWeight: FontWeight.w900)),
                  if (order.dueAmount > 0)
                    Text('Due: ₹${_fmt(order.dueAmount)}',
                        style: const TextStyle(color: Color(0xFFFFCDD2), fontSize: 12,
                            fontWeight: FontWeight.w700)),
                ]),
              ]),
            ),

            Expanded(
              child: ListView(
                controller: scrollCtrl,
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                children: [
                  _sectionLabel('CUSTOMER DETAILS'),
                  const SizedBox(height: 8),
                  _infoCard([
                    _DetailRow(label: 'Customer ID', value: '#$cardIndex', valueColor: _C.primary),
                    _DetailRow(label: 'Customer Name', value: order.customerName, bold: true),
                    if (order.customerPhone.isNotEmpty)
                      _DetailRow(label: 'Phone', value: order.customerPhone, valueColor: _C.primary),
                    if (order.customerAddress.isNotEmpty)
                      _DetailRow(label: 'Address', value: order.customerAddress, bold: true),
                    if (order.customerAadhaar.isNotEmpty)
                      _DetailRow(label: 'Aadhaar', value: order.customerAadhaar, bold: true),
                  ]),
                  const SizedBox(height: 14),

                  _sectionLabel('INVOICE INFO'),
                  const SizedBox(height: 8),
                  _infoCard([
                    _DetailRow(label: 'Invoice No', value: 'SI-$siNumber', valueColor: _C.primary),
                    _DetailRow(label: 'Type',
                        value: order.orderType == OrderType.delivery ? 'Delivery' : 'Return',
                        bold: true),
                    _DetailRow(label: 'Date',
                        value: DateFormat('dd-MM-yyyy').format(order.date), bold: true),
                    if (order.reference.isNotEmpty)
                      _DetailRow(label: 'Reference', value: order.reference, bold: true),
                    _DetailRow(label: 'Due Date',
                        value: DateFormat('dd-MM-yyyy').format(order.dueDate), bold: true),

                    _DetailRow(label: 'GST Type',
                        value: order.gstType == GstType.cgstSgst ? 'CGST/SGST' : 'IGST',
                        bold: true),
                    _DetailRow(label: 'Tax',
                        value: order.globalTaxType == TaxType.exclusive ? 'Excluded' : 'Included',
                        bold: true),
                    _DetailRow(label: 'TCS',
                        value: order.tcsType == TcsType.noTcs ? 'No TCS'
                            : order.tcsType == TcsType.tcs01 ? 'TCS 0.1%' : 'TCS 1%',
                        bold: true),
                    _DetailRow(label: 'Payment Mode',
                        value: order.paymentMode.name.toUpperCase(), bold: true),
                    _DetailRow(label: 'Godown',
                        value: order.godown == GodownLocation.main
                            ? 'Main Godown'
                            : order.godown == GodownLocation.branch
                            ? 'Branch Godown'
                            : 'Warehouse',
                        bold: true),
                  ]),
                  const SizedBox(height: 14),

                  _sectionLabel('ITEMS (${order.items.length})'),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: _C.surface, borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: _C.border),
                    ),
                    child: Column(children: [
                      for (int i = 0; i < order.items.length; i++) ...[
                        if (i > 0) const Divider(height: 1, color: _C.border),
                        _buildItemRow(order.items[i], i + 1),
                      ],
                    ]),
                  ),
                  const SizedBox(height: 14),

                  _sectionLabel('TOTAL'),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: _C.surface, borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: _C.border),
                    ),
                    child: Column(children: [
                      if (order.discTotal > 0)
                        _DetailRow(label: 'Discount',
                            value: '- Rs. ${_fmt(order.discTotal)}',
                            valueColor: _C.red).withPadding(),
                      if (order.taxTotal > 0)
                        _DetailRow(label: 'Tax',
                            value: '+ Rs. ${_fmt(order.taxTotal)}',
                            valueColor: _C.textMid).withPadding(),
                      if (order.tcsAmount > 0)
                        _DetailRow(
                          label: order.tcsType == TcsType.tcs01 ? 'TCS @0.1%' : 'TCS @1%',
                          value: '+ Rs. ${_fmt(order.tcsAmount)}',
                          valueColor: const Color(0xFFE65100),
                        ).withPadding(),
                      if (order.freightCharge > 0)
                        _DetailRow(label: 'Freight',
                            value: '+ Rs. ${_fmt(order.freightCharge)}',
                            valueColor: _C.textMid).withPadding(),
                      if (order.adjustment != 0)
                        _DetailRow(label: 'Adjustment',
                            value: '${order.adjustment >= 0 ? '+' : '-'} Rs. ${_fmt(order.adjustment.abs())}',
                            valueColor: _C.textMid).withPadding(),
                      if (order.addLess != 0)
                        _DetailRow(label: 'Add/Less',
                            value: '${order.addLess >= 0 ? '+' : '-'} Rs. ${_fmt(order.addLess.abs())}',
                            valueColor: _C.textMid).withPadding(),
                      if (order.roundOff != 0)
                        _DetailRow(label: 'Round Off',
                            value: '${order.roundOff >= 0 ? '+' : '-'} Rs. ${_fmt(order.roundOff.abs())}',
                            valueColor: _C.primary).withPadding(),
                      const Divider(height: 1, color: _C.border),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Net Total',
                                style: TextStyle(color: _C.textMid, fontSize: 14,
                                    fontWeight: FontWeight.w600)),
                            Text('Rs. ${_fmt(order.netTotal)}',
                                style: const TextStyle(color: _C.textDark, fontSize: 22,
                                    fontWeight: FontWeight.w900)),
                          ],
                        ),
                      ),
                      if (order.amountPaid > 0) ...[
                        const Divider(height: 1, color: _C.border),
                        _DetailRow(label: 'Amount Paid',
                            value: 'Rs. ${_fmt(order.amountPaid)}',
                            valueColor: _C.primary).withPadding(),
                        _DetailRow(label: 'Due Amount',
                            value: 'Rs. ${_fmt(order.dueAmount)}',
                            valueColor: order.dueAmount > 0 ? _C.red : _C.primary).withPadding(),
                      ],
                    ]),
                  ),
                  const SizedBox(height: 20),

                  Row(children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Download feature coming soon'),
                            behavior: SnackBarBehavior.floating,
                          ));
                        },
                        icon: const Icon(Icons.download_rounded, size: 18),
                        label: const Text('Download',
                            style: TextStyle(fontWeight: FontWeight.w700)),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF2E7D55),
                          side: const BorderSide(color: _C.primary),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Share feature coming soon'),
                            behavior: SnackBarBehavior.floating,
                          ));
                        },
                        icon: const Icon(Icons.share_rounded, color: Colors.white, size: 18),
                        label: const Text('Share',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2E7D55),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 0,
                        ),
                      ),
                    ),
                  ]),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ]),
        );
      },
    );
  }

  Widget _sectionLabel(String label) => Text(label,
      style: const TextStyle(color: _C.textMid, fontSize: 11,
          fontWeight: FontWeight.w700, letterSpacing: 1.0));

  Widget _infoCard(List<_DetailRow> rows) {
    return Container(
      decoration: BoxDecoration(
        color: _C.surface, borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _C.border),
      ),
      child: Column(children: [
        for (int i = 0; i < rows.length; i++) ...[
          if (i > 0) const Divider(height: 1, color: _C.border),
          rows[i].withPadding(),
        ],
      ]),
    );
  }

  Widget _buildItemRow(OrderItem item, int idx) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(
            width: 22, height: 22, alignment: Alignment.center,
            decoration: const BoxDecoration(color: _C.primaryLt, shape: BoxShape.circle),
            child: Text('$idx', style: const TextStyle(color: _C.primary, fontSize: 11,
                fontWeight: FontWeight.w800)),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(item.product,
              style: const TextStyle(color: _C.textDark, fontSize: 13,
                  fontWeight: FontWeight.w600))),
          Text('Rs. ${NumberFormat('#,##,##0.00', 'en_IN').format(item.grandTotal)}',
              style: const TextStyle(color: _C.textDark, fontSize: 13,
                  fontWeight: FontWeight.w800)),
        ]),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Qty: ${item.quantity}  ×  Rs. ${item.price.toStringAsFixed(2)}'
                  '${item.discountAmount > 0 ? '  |  Disc: Rs. ${item.discountAmount.toStringAsFixed(2)}' : ''}'
                  '${item.taxAmount > 0 ? '  |  Tax: Rs. ${item.taxAmount.toStringAsFixed(2)}' : ''}',
              style: const TextStyle(color: _C.textMid, fontSize: 11,
                  fontWeight: FontWeight.w500),
            ),
            if (item.batch.isNotEmpty) ...[
              const SizedBox(height: 2),
              Text('Batch: ${item.batch}',
                  style: const TextStyle(color: _C.textLight, fontSize: 10,
                      fontWeight: FontWeight.w500)),
            ],
          ]),
        ),
      ]),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// SEGMENT 21 — Detail Row Helper
// ══════════════════════════════════════════════════════════════════════════════
class _DetailRow {
  final String label;
  final String value;
  final bool   bold;
  final Color? valueColor;

  const _DetailRow({required this.label, required this.value,
    this.bold = false, this.valueColor});

  Widget withPadding() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: _C.textMid, fontSize: 13,
            fontWeight: FontWeight.w500)),
        const SizedBox(width: 16),
        Flexible(child: Text(value,
            style: TextStyle(
              color: valueColor ?? _C.textDark, fontSize: 13,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w600,
            ),
            textAlign: TextAlign.right)),
      ],
    ),
  );
}

// ══════════════════════════════════════════════════════════════════════════════
// SEGMENT 22 — Reusable Widgets
// ══════════════════════════════════════════════════════════════════════════════
class _FieldLabel extends StatelessWidget {
  final String label;
  const _FieldLabel({required this.label});
  @override
  Widget build(BuildContext context) => Text(label,
      style: const TextStyle(color: _C.textMid, fontSize: 13,
          fontWeight: FontWeight.w600, letterSpacing: 0.2));
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String                 hint;
  final IconData?              icon;
  final TextInputType          keyboardType;
  final ValueChanged<String>?  onChanged;
  final int                    maxLines;

  const _InputField({
    required this.controller, required this.hint,
    this.icon, this.keyboardType = TextInputType.text,
    this.onChanged, this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) => TextField(
    controller: controller, keyboardType: keyboardType,
    onChanged: onChanged, maxLines: maxLines,
    style: const TextStyle(color: _C.textDark, fontSize: 15, fontWeight: FontWeight.w500),
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: _C.textLight, fontSize: 14),
      prefixIcon: icon != null ? Icon(icon, color: _C.primary, size: 20) : null,
      filled: true, fillColor: _C.bg,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: _C.border)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: _C.border)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: _C.primary, width: 1.5)),
    ),
  );
}

class _ValidatedField extends StatelessWidget {
  final TextEditingController controller;
  final String                 hint;
  final IconData?              icon;
  final TextInputType          keyboardType;
  final ValueChanged<String>?  onChanged;
  final String?                errorText;
  final int?                   maxLength;

  const _ValidatedField({
    required this.controller, required this.hint,
    this.icon, this.keyboardType = TextInputType.text,
    this.onChanged, this.errorText, this.maxLength,
  });

  @override
  Widget build(BuildContext context) => TextField(
    controller: controller,
    keyboardType: keyboardType,
    onChanged: onChanged,
    maxLength: maxLength,
    inputFormatters: keyboardType == TextInputType.phone ||
        keyboardType == TextInputType.number
        ? [FilteringTextInputFormatter.digitsOnly]
        : null,
    style: const TextStyle(color: _C.textDark, fontSize: 15, fontWeight: FontWeight.w500),
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: _C.textLight, fontSize: 14),
      prefixIcon: icon != null ? Icon(icon, color: _C.primary, size: 20) : null,
      errorText: errorText,
      errorStyle: const TextStyle(color: _C.red, fontSize: 11),
      counterText: '',
      filled: true,
      fillColor: errorText != null ? _C.red.withOpacity(0.04) : _C.bg,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: _C.border)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: errorText != null ? _C.red : _C.border)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
              color: errorText != null ? _C.red : _C.primary, width: 1.5)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: _C.red)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: _C.red, width: 1.5)),
    ),
  );
}

class _PaymentNumField extends StatelessWidget {
  final TextEditingController controller;
  final String                hint;
  final ValueChanged<String>  onChanged;
  final bool                  highlight;

  const _PaymentNumField({
    required this.controller,
    required this.hint,
    required this.onChanged,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) => TextField(
    controller: controller,
    keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
    onChanged: onChanged,
    style: TextStyle(
      color: highlight ? _C.primary : _C.textDark,
      fontSize: 14, fontWeight: FontWeight.w600,
    ),
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: _C.textLight, fontSize: 13),
      filled: true,
      fillColor: highlight ? _C.primaryLt : _C.bg,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
              color: highlight ? _C.primary.withOpacity(0.4) : _C.border)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
              color: highlight ? _C.primary.withOpacity(0.4) : _C.border)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _C.primary, width: 1.5)),
    ),
  );
}

class _TypeDropdown<T> extends StatelessWidget {
  final String                    label;
  final T                         value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>          onChanged;

  const _TypeDropdown({
    required this.label, required this.value,
    required this.items, required this.onChanged,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (label.isNotEmpty) ...[
        Text(label, style: const TextStyle(color: _C.textMid, fontSize: 12,
            fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
      ],
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        decoration: BoxDecoration(color: _C.bg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _C.border)),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            value: value, isExpanded: true,
            icon: const Icon(Icons.keyboard_arrow_down_rounded,
                color: _C.primary, size: 18),
            dropdownColor: _C.surface,
            style: const TextStyle(color: _C.textDark, fontSize: 13,
                fontWeight: FontWeight.w600),
            items: items, onChanged: onChanged,
          ),
        ),
      ),
    ],
  );
}