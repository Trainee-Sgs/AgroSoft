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
// SEGMENT 2 — Enums & Data Models
// ══════════════════════════════════════════════════════════════════════════════
enum GstType       { cgstSgst, igst }
enum TaxInclusion  { exclude, include }

class OrderItem {
  String  product;
  double  price;
  int     quantity;
  double  discountValue;
  bool    discountIsPercent;
  double  taxRate;
  TaxInclusion taxType;

  OrderItem({
    required this.product,
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
    if (taxType == TaxInclusion.include) {
      return afterDiscount - afterDiscount / (1 + taxRate / 100);
    }
    return afterDiscount * taxRate / 100;
  }
  double get grandTotal =>
      afterDiscount + (taxType == TaxInclusion.exclude ? taxAmount : 0);
}

// ══════════════════════════════════════════════════════════════════════════════
// SEGMENT 2b — Saved Quotation Model
// ══════════════════════════════════════════════════════════════════════════════
class SavedQuotation {
  final String   id;
  final String   customerName;
  final String   customerPhone;
  final String   customerAddress;
  final String   reference;
  final DateTime date;
  final DateTime dueDate;
  final GstType  gstType;
  final TaxInclusion taxInclusion;
  final List<OrderItem> items;

  SavedQuotation({
    required this.id,
    required this.customerName,
    required this.customerPhone,
    required this.customerAddress,
    required this.reference,
    required this.date,
    required this.dueDate,
    required this.gstType,
    required this.taxInclusion,
    required this.items,
  });

  double get subTotal   => items.fold(0, (s, i) => s + i.subtotal);
  double get discTotal  => items.fold(0, (s, i) => s + i.discountAmount);
  double get taxTotal   => items.fold(0, (s, i) => s + i.taxAmount);
  double get grandTotal => items.fold(0, (s, i) => s + i.grandTotal);
}

// ══════════════════════════════════════════════════════════════════════════════
// SEGMENT 3 — Product Catalogue (Agro Products)
// ══════════════════════════════════════════════════════════════════════════════
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

class _ProductInfo {
  final double oldPrice;
  final int    currentStock;
  const _ProductInfo({required this.oldPrice, required this.currentStock});
}

// ══════════════════════════════════════════════════════════════════════════════
// SEGMENT 4 — Inline Item Form Model
// ══════════════════════════════════════════════════════════════════════════════
class _InlineItemForm {
  final TextEditingController productCtrl = TextEditingController();
  final TextEditingController priceCtrl   = TextEditingController();
  final TextEditingController qtyCtrl     = TextEditingController(text: '1');
  final TextEditingController discCtrl    = TextEditingController();
  final TextEditingController taxCtrl     = TextEditingController();
  bool          discIsPercent  = true;
  double        previewTotal   = 0;
  _ProductInfo? selectedProduct;
  List<String>  suggestions    = [];

  void dispose() {
    productCtrl.dispose();
    priceCtrl.dispose();
    qtyCtrl.dispose();
    discCtrl.dispose();
    taxCtrl.dispose();
  }

  void recalc(TaxInclusion taxType) {
    final p     = double.tryParse(priceCtrl.text) ?? 0;
    final q     = int.tryParse(qtyCtrl.text) ?? 0;
    final dv    = double.tryParse(discCtrl.text) ?? 0;
    final t     = double.tryParse(taxCtrl.text) ?? 0;
    final sub   = p * q;
    final disc  = discIsPercent ? sub * dv / 100 : dv;
    final after = sub - disc;
    previewTotal = taxType == TaxInclusion.include
        ? after
        : after + after * t / 100;
  }

  OrderItem toOrderItem(TaxInclusion taxType) => OrderItem(
    product:           productCtrl.text.trim(),
    price:             double.tryParse(priceCtrl.text) ?? 0,
    quantity:          int.tryParse(qtyCtrl.text) ?? 1,
    discountValue:     double.tryParse(discCtrl.text) ?? 0,
    discountIsPercent: discIsPercent,
    taxRate:           double.tryParse(taxCtrl.text) ?? 0,
    taxType:           taxType,
  );
}

// ══════════════════════════════════════════════════════════════════════════════
// SEGMENT 5 — Accordion Section Keys
// ══════════════════════════════════════════════════════════════════════════════
const _kTypes      = 'Types';
const _kCustomer   = 'Customer Details';
const _kDateRef    = 'Date & Reference';
const _kOrderItems = 'OrderItems';

// ══════════════════════════════════════════════════════════════════════════════
// SEGMENT 6 — Left border colors for quotation cards (cyclic)
// ══════════════════════════════════════════════════════════════════════════════
const List<Color> _cardBorderColors = [
  Color(0xFF1565C0),
  Color(0xFF2E7D32),
  Color(0xFF6A1B9A),
  Color(0xFFE65100),
  Color(0xFFC62828),
  Color(0xFF00838F),
];

// ══════════════════════════════════════════════════════════════════════════════
// SEGMENT 7 — Main Screen StatefulWidget
// ══════════════════════════════════════════════════════════════════════════════
class SalesQuotationScreen extends StatefulWidget {
  const SalesQuotationScreen({super.key});
  @override
  State<SalesQuotationScreen> createState() => _SalesQuotationScreenState();
}

class _SalesQuotationScreenState extends State<SalesQuotationScreen>
    with TickerProviderStateMixin {

  bool _showViewQuotations = false;
  final List<SavedQuotation> _savedQuotations = [];
  final _searchCtrl = TextEditingController();
  String _searchQuery = '';

  final _customerNameCtrl    = TextEditingController();
  final _customerPhoneCtrl   = TextEditingController();
  final _customerAddressCtrl = TextEditingController();
  final _referenceCtrl       = TextEditingController();

  GstType      _gstType      = GstType.cgstSgst;
  TaxInclusion _taxInclusion = TaxInclusion.exclude;
  DateTime     _selectedDate = DateTime.now();
  DateTime     _dueDate      = DateTime.now().add(const Duration(days: 1));
  List<OrderItem> _items     = [];

  final List<_InlineItemForm> _forms = [];
  String? _openSection = _kTypes;

  @override
  void initState() {
    super.initState();
    _addNewForm();
  }

  @override
  void dispose() {
    _customerNameCtrl.dispose();
    _customerPhoneCtrl.dispose();
    _customerAddressCtrl.dispose();
    _referenceCtrl.dispose();
    _searchCtrl.dispose();
    for (final f in _forms) f.dispose();
    super.dispose();
  }

  void _addNewForm() {
    _forms.add(_InlineItemForm());
  }

  void _removeForm(int index) {
    _forms[index].dispose();
    _forms.removeAt(index);
    if (_forms.isEmpty) _addNewForm();
  }

  void _toggleSection(String key) {
    HapticFeedback.lightImpact();
    setState(() => _openSection = _openSection == key ? null : key);
  }

  Future<void> _pickDate(bool isDue) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isDue ? _dueDate : _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.light(
            primary: _C.primary, onPrimary: Colors.white, surface: Colors.white,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        if (isDue) _dueDate = picked; else _selectedDate = picked;
      });
    }
  }

  double get _grandTotal {
    double total = 0;
    for (final f in _forms) {
      f.recalc(_taxInclusion);
      total += f.previewTotal;
    }
    return total;
  }

  void _showSnack(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ));
  }

  void _save() {
    if (_customerNameCtrl.text.trim().isEmpty) {
      _showSnack('Please enter Customer Name', _C.gold);
      return;
    }
    final validForms = _forms.where((f) => f.productCtrl.text.trim().isNotEmpty).toList();
    if (validForms.isEmpty) {
      _showSnack('Please add at least one item', _C.gold);
      return;
    }
    HapticFeedback.mediumImpact();

    final items = validForms.map((f) => f.toOrderItem(_taxInclusion)).toList();
    final grandTotal = items.fold<double>(0, (s, i) => s + i.grandTotal);

    final quotation = SavedQuotation(
      id:              'SQ-${DateTime.now().millisecondsSinceEpoch}',
      customerName:    _customerNameCtrl.text.trim(),
      customerPhone:   _customerPhoneCtrl.text.trim(),
      customerAddress: _customerAddressCtrl.text.trim(),
      reference:       _referenceCtrl.text.trim(),
      date:            _selectedDate,
      dueDate:         _dueDate,
      gstType:         _gstType,
      taxInclusion:    _taxInclusion,
      items:           items,
    );

    for (final f in _forms) f.dispose();
    _forms.clear();

    setState(() {
      _savedQuotations.insert(0, quotation);
      _customerNameCtrl.clear();
      _customerPhoneCtrl.clear();
      _customerAddressCtrl.clear();
      _referenceCtrl.clear();
      _items.clear();
      _selectedDate    = DateTime.now();
      _dueDate         = DateTime.now().add(const Duration(days: 1));
      _gstType         = GstType.cgstSgst;
      _taxInclusion    = TaxInclusion.exclude;
      _openSection     = _kTypes;
      _showViewQuotations = true;
      _addNewForm();
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          const Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
          const SizedBox(width: 10),
          Flexible(child: Text(
              'Quotation saved! Total ₹${grandTotal.toStringAsFixed(2)}')),
        ],
      ),
      backgroundColor: _C.primary,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ));
  }

  List<SavedQuotation> get _filteredQuotations {
    if (_searchQuery.trim().isEmpty) return _savedQuotations;
    final q = _searchQuery.toLowerCase();
    return _savedQuotations.where((sq) {
      final soNumber = 'SO-${(_savedQuotations.indexOf(sq) + 1).toString().padLeft(4, '0')}';
      return sq.customerName.toLowerCase().contains(q) ||
          sq.customerPhone.contains(q) ||
          sq.reference.toLowerCase().contains(q) ||
          soNumber.toLowerCase().contains(q);
    }).toList();
  }

// ══════════════════════════════════════════════════════════════════════════════
// SEGMENT 8 — Build (Root)
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
              child: _showViewQuotations
                  ? _buildViewQuotations()
                  : _buildNewQuotationForm(),
            ),
          ),
        ],
      ),
    );
  }

// ══════════════════════════════════════════════════════════════════════════════
// SEGMENT 9 — Header with Toggle Tabs
// FIX: Both tabs now use same active style (white pill + green text/icon)
// ══════════════════════════════════════════════════════════════════════════════
  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.appBarGradStart, AppTheme.appBarGradEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x441B8A3E),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 4, 12, 0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded,
                        color: Colors.white, size: 20),
                    onPressed: () => Navigator.pop(context),
                    constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                    padding: const EdgeInsets.all(8),
                  ),
                  const Expanded(
                    child: Text('Sales Quotation',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.3)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 12),
              child: Container(
                height: 48,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Row(
                  children: [
                    // ── VIEW QUOTATION tab ─────────────────────────────────
                    _tab(
                      label: 'VIEW QUOTATION',
                      icon: Icons.list_alt_rounded,
                      active: _showViewQuotations,
                      onTap: () => setState(() => _showViewQuotations = true),
                    ),
                    // ── NEW QUOTATION tab ──────────────────────────────────
                    _tab(
                      label: 'NEW QUOTATION',
                      icon: Icons.add_circle_outline_rounded,
                      active: !_showViewQuotations,
                      onTap: () => setState(() => _showViewQuotations = false),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // FIX: Active tab always shows white pill with green icon+text (same for both tabs)
  Widget _tab({
    required String       label,
    required IconData     icon,
    required bool         active,
    required VoidCallback onTap,
  }) {
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
                ? [BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 8,
              offset: const Offset(0, 2),
            )]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                // Active: primary green; Inactive: white
                color: active ? _C.primary : Colors.white,
              ),
              const SizedBox(width: 5),
              Text(
                label,
                style: TextStyle(
                  fontSize: active ? 13 : 12,
                  fontWeight: active ? FontWeight.w800 : FontWeight.w600,
                  // Active: primary green; Inactive: white
                  color: active ? _C.primary : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// ══════════════════════════════════════════════════════════════════════════════
// SEGMENT 10 — New Quotation Form
// ══════════════════════════════════════════════════════════════════════════════
  Widget _buildNewQuotationForm() {
    return SingleChildScrollView(
      key: const ValueKey('form'),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _accordionCard(
            sectionKey: _kTypes,
            icon: Icons.tune_rounded,
            title: _kTypes,
            child: _buildTypesBody(),
          ),
          const SizedBox(height: 14),
          _accordionCard(
            sectionKey: _kCustomer,
            icon: Icons.person_rounded,
            title: _kCustomer,
            child: _buildCustomerBody(),
          ),
          const SizedBox(height: 14),
          _accordionCard(
            sectionKey: _kDateRef,
            icon: Icons.calendar_month_rounded,
            title: _kDateRef,
            child: _buildDateRefBody(),
          ),
          const SizedBox(height: 14),
          _accordionCard(
            sectionKey: _kOrderItems,
            icon: Icons.shopping_cart_rounded,
            title: 'Order Items',
            child: _buildInlineItemsBody(),
          ),
          const SizedBox(height: 16),
          _buildSaveButton(),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

// ══════════════════════════════════════════════════════════════════════════════
// SEGMENT 11 — Accordion Card (shared)
// ══════════════════════════════════════════════════════════════════════════════
  Widget _accordionCard({
    required String   sectionKey,
    required IconData icon,
    required String   title,
    required Widget   child,
  }) {
    final isExpanded = _openSection == sectionKey;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => _toggleSection(sectionKey),
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
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
                  Expanded(
                    child: Text(title,
                        style: const TextStyle(
                            color: _C.textDark,
                            fontSize: 15,
                            fontWeight: FontWeight.w700)),
                  ),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: _C.primaryLt,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.keyboard_arrow_down_rounded,
                          color: _C.primary, size: 20),
                    ),
                  ),
                ],
              ),
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
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
            sizeCurve: Curves.easeInOut,
          ),
        ],
      ),
    );
  }

// ══════════════════════════════════════════════════════════════════════════════
// SEGMENT 12 — Types Body
// ══════════════════════════════════════════════════════════════════════════════
  Widget _buildTypesBody() {
    return Row(
      children: [
        Expanded(
          child: _TypeDropdown<GstType>(
            label: 'GST Type',
            value: _gstType,
            items: const [
              DropdownMenuItem(value: GstType.cgstSgst, child: Text('CGST/SGST')),
              DropdownMenuItem(value: GstType.igst, child: Text('IGST')),
            ],
            onChanged: (v) { if (v != null) setState(() => _gstType = v); },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _TypeDropdown<TaxInclusion>(
            label: 'Tax Inclusion',
            value: _taxInclusion,
            items: const [
              DropdownMenuItem(value: TaxInclusion.exclude, child: Text('Exclude Tax')),
              DropdownMenuItem(value: TaxInclusion.include, child: Text('Include Tax')),
            ],
            onChanged: (v) { if (v != null) setState(() => _taxInclusion = v); },
          ),
        ),
      ],
    );
  }

// ══════════════════════════════════════════════════════════════════════════════
// SEGMENT 13 — Customer Details Body
// ══════════════════════════════════════════════════════════════════════════════
  Widget _buildCustomerBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _FieldLabel(label: 'Customer Name'),
        const SizedBox(height: 6),
        _InputField(controller: _customerNameCtrl, hint: 'Enter customer name', keyboardType: TextInputType.name),
        const SizedBox(height: 14),
        const _FieldLabel(label: 'Customer Phone'),
        const SizedBox(height: 6),
        _InputField(controller: _customerPhoneCtrl, hint: 'Enter phone number', keyboardType: TextInputType.phone),
        const SizedBox(height: 14),
        const _FieldLabel(label: 'Customer Address'),
        const SizedBox(height: 6),
        _InputField(controller: _customerAddressCtrl, hint: 'Enter customer address', maxLines: 2),
      ],
    );
  }

// ══════════════════════════════════════════════════════════════════════════════
// SEGMENT 14 — Date & Reference Body
// ══════════════════════════════════════════════════════════════════════════════
  Widget _buildDateRefBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _FieldLabel(label: 'Date'),
                  const SizedBox(height: 6),
                  GestureDetector(
                    onTap: () => _pickDate(false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                      decoration: BoxDecoration(
                        color: _C.bg,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: _C.border),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_month_rounded, color: _C.primary, size: 14),
                          const SizedBox(width: 8),
                          Text(DateFormat('dd-MM-yyyy').format(_selectedDate),
                              style: const TextStyle(color: _C.textDark, fontSize: 12, fontWeight: FontWeight.w600)),
                          const Spacer(),
                          const Icon(Icons.keyboard_arrow_down_rounded, color: _C.textMid, size: 10),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _FieldLabel(label: 'Reference No'),
                  const SizedBox(height: 6),
                  _InputField(controller: _referenceCtrl, hint: 'Enter reference'),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            const _FieldLabel(label: 'Due Date'),
            const SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: () => _pickDate(true),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  decoration: BoxDecoration(
                    color: _C.bg,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: _C.border),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.event_rounded, color: _C.primary, size: 18),
                      const SizedBox(width: 8),
                      Text(DateFormat('dd-MM-yyyy').format(_dueDate),
                          style: const TextStyle(color: _C.textDark, fontSize: 13, fontWeight: FontWeight.w600)),
                      const Spacer(),
                      const Icon(Icons.keyboard_arrow_down_rounded, color: _C.textMid, size: 18),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

// ══════════════════════════════════════════════════════════════════════════════
// SEGMENT 15 — Inline Items Body
// FIX: Replaced ListView.builder(shrinkWrap) with Column + List.generate
//      to eliminate the extra white space rendered by shrinkWrap inside
//      AnimatedCrossFade. Column respects mainAxisSize.min properly.
// ══════════════════════════════════════════════════════════════════════════════
  Widget _buildInlineItemsBody() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Direct Column children — no ListView.builder shrinkWrap
        ...List.generate(_forms.length, (i) => _buildSingleItemForm(i)),

        // Add Item button
        GestureDetector(
          onTap: () => setState(() => _addNewForm()),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: _C.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _C.primary, width: 1.5),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_rounded, color: _C.primary, size: 20),
                SizedBox(width: 8),
                Text('Add Item',
                    style: TextStyle(
                        color: _C.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w700)),
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
        void recalc() {
          ss(() => form.recalc(_taxInclusion));
        }

        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: _C.bg,
            borderRadius: BorderRadius.circular(16),
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
                child: Row(
                  children: [
                    Text('Item ${index + 1}',
                        style: const TextStyle(
                            color: _C.primary,
                            fontSize: 13,
                            fontWeight: FontWeight.w700)),
                    const Spacer(),
                    if (_forms.length > 1)
                      GestureDetector(
                        onTap: () => setState(() => _removeForm(index)),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: _C.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.close_rounded, color: _C.red, size: 16),
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Description',
                        style: TextStyle(
                            color: _C.textMid, fontSize: 12, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    TextField(
                      controller: form.productCtrl,
                      textCapitalization: TextCapitalization.characters,
                      style: const TextStyle(
                          color: _C.textDark, fontSize: 14, fontWeight: FontWeight.w500),
                      onChanged: (val) {
                        ss(() => form.suggestions = AgroProducts.search(val));
                        recalc();
                      },
                      decoration: InputDecoration(
                        hintText: 'Select product...',
                        hintStyle: const TextStyle(color: _C.textLight, fontSize: 13),
                        filled: true,
                        fillColor: _C.surface,
                        suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded,
                            color: _C.textMid, size: 20),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: _C.border)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: _C.border)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
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
                          border: Border.all(color: _C.primary.withOpacity(0.25)),
                          boxShadow: [
                            BoxShadow(
                                color: _C.primary.withOpacity(0.08),
                                blurRadius: 12,
                                offset: const Offset(0, 4)),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: ListView.separated(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: form.suggestions.length,
                            separatorBuilder: (_, __) =>
                            const Divider(height: 1, color: _C.border),
                            itemBuilder: (_, si) {
                              final s = form.suggestions[si];
                              final query = form.productCtrl.text.toUpperCase().trim();
                              final idx = s.indexOf(query);
                              return InkWell(
                                onTap: () {
                                  form.productCtrl.text = s;
                                  form.productCtrl.selection = TextSelection.fromPosition(
                                      TextPosition(offset: s.length));
                                  ss(() {
                                    form.suggestions = [];
                                    form.selectedProduct = AgroProducts.getInfo(s);
                                  });
                                  recalc();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 10),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.eco_rounded,
                                          color: _C.primary, size: 14),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: idx >= 0 && query.isNotEmpty
                                            ? RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text: s.substring(0, idx),
                                              style: const TextStyle(
                                                  color: _C.primaryDk,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            TextSpan(
                                              text: s.substring(idx, idx + query.length),
                                              style: const TextStyle(
                                                  color: _C.primary,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w800,
                                                  backgroundColor: Color(0xFFE8F5ED)),
                                            ),
                                            TextSpan(
                                              text: s.substring(idx + query.length),
                                              style: const TextStyle(
                                                  color: _C.primaryDk,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ]),
                                        )
                                            : Text(s,
                                            style: const TextStyle(
                                                color: _C.primaryDk,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500)),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Text('Price (₹)',
                            style: TextStyle(
                                color: _C.textMid,
                                fontSize: 12,
                                fontWeight: FontWeight.w600)),
                        if (form.selectedProduct != null) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF3CD),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: _C.gold.withOpacity(0.5)),
                            ),
                            child: Text(
                              'Old: ₹${form.selectedProduct!.oldPrice.toStringAsFixed(0)}',
                              style: const TextStyle(
                                  color: _C.gold,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: form.priceCtrl,
                      keyboardType: TextInputType.number,
                      onChanged: (_) => recalc(),
                      style: const TextStyle(
                          color: _C.textDark, fontSize: 14, fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        hintText: '0.00',
                        hintStyle: const TextStyle(color: _C.textLight, fontSize: 13),
                        filled: true,
                        fillColor: _C.surface,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 13),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: _C.border)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: _C.border)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                            const BorderSide(color: _C.primary, width: 1.5)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Text('Quantity',
                            style: TextStyle(
                                color: _C.textMid,
                                fontSize: 12,
                                fontWeight: FontWeight.w600)),
                        if (form.selectedProduct != null) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                              color: _C.primaryLt,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: _C.primary.withOpacity(0.35)),
                            ),
                            child: Text(
                              'Stock: ${form.selectedProduct!.currentStock}',
                              style: const TextStyle(
                                  color: _C.primary,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: form.qtyCtrl,
                      keyboardType: TextInputType.number,
                      onChanged: (_) => recalc(),
                      style: const TextStyle(
                          color: _C.textDark, fontSize: 14, fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        hintText: '1',
                        hintStyle: const TextStyle(color: _C.textLight, fontSize: 13),
                        filled: true,
                        fillColor: _C.surface,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 13),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: _C.border)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: _C.border)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                            const BorderSide(color: _C.primary, width: 1.5)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Discount (%)',
                                  style: TextStyle(
                                      color: _C.textMid,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600)),
                              const SizedBox(height: 6),
                              TextField(
                                controller: form.discCtrl,
                                keyboardType: TextInputType.number,
                                onChanged: (_) => recalc(),
                                style: const TextStyle(
                                    color: _C.textDark,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                                decoration: InputDecoration(
                                  hintText: '0',
                                  hintStyle: const TextStyle(
                                      color: _C.textLight, fontSize: 13),
                                  filled: true,
                                  fillColor: _C.surface,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 13),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide:
                                      const BorderSide(color: _C.border)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide:
                                      const BorderSide(color: _C.border)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                          color: _C.primary, width: 1.5)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Tax (%)',
                                  style: TextStyle(
                                      color: _C.textMid,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600)),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _C.surface,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: _C.border),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: form.taxCtrl.text.isEmpty
                                        ? '0%'
                                        : '${form.taxCtrl.text}%',
                                    isExpanded: true,
                                    icon: const Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: _C.primary,
                                        size: 18),
                                    dropdownColor: _C.surface,
                                    style: const TextStyle(
                                        color: _C.textDark,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    items: ['0%', '5%', '12%', '18%', '28%']
                                        .map((t) => DropdownMenuItem(
                                      value: t,
                                      child: Text(t),
                                    ))
                                        .toList(),
                                    onChanged: (val) {
                                      if (val != null) {
                                        form.taxCtrl.text =
                                            val.replaceAll('%', '');
                                        recalc();
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
// SEGMENT 16 — Save Button
// ══════════════════════════════════════════════════════════════════════════════
  Widget _buildSaveButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_C.primary, _C.primaryDk],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
              color: _C.primary.withOpacity(0.4),
              blurRadius: 16,
              offset: const Offset(0, 6)),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _save,
          borderRadius: BorderRadius.circular(18),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.save_rounded, color: Colors.white, size: 20),
                SizedBox(width: 12),
                Text('SAVE ORDER',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5)),
              ],
            ),
          ),
        ),
      ),
    );
  }

// ══════════════════════════════════════════════════════════════════════════════
// SEGMENT 17 — View Quotations Tab
// ══════════════════════════════════════════════════════════════════════════════
  Widget _buildViewQuotations() {
    if (_savedQuotations.isEmpty) {
      return Center(
        key: const ValueKey('empty'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90, height: 90,
              decoration: const BoxDecoration(color: _C.primaryLt, shape: BoxShape.circle),
              child: const Icon(Icons.description_rounded, color: _C.primary, size: 44),
            ),
            const SizedBox(height: 20),
            const Text('No Quotations Yet',
                style: TextStyle(color: _C.textDark, fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            const Text('Save a quotation to see it here',
                style: TextStyle(color: _C.textMid, fontSize: 14)),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => setState(() => _showViewQuotations = false),
              icon: const Icon(Icons.add_rounded, color: Colors.white, size: 18),
              label: const Text('Create Quotation',
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

    final filtered = _filteredQuotations;
    final totalCount = _savedQuotations.length;

    return Column(
      key: const ValueKey('list'),
      children: [
        // ── Search Bar ─────────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: _C.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _C.border),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Icon(Icons.search_rounded, color: _C.textMid, size: 20),
                ),
                Expanded(
                  child: TextField(
                    controller: _searchCtrl,
                    onChanged: (v) => setState(() => _searchQuery = v),
                    style: const TextStyle(
                        color: _C.textDark, fontSize: 14, fontWeight: FontWeight.w500),
                    decoration: const InputDecoration(
                      hintText: 'Search name, order no, phone...',
                      hintStyle: TextStyle(color: _C.textLight, fontSize: 13),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                if (_searchQuery.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: _C.textMid, size: 18),
                    onPressed: () {
                      _searchCtrl.clear();
                      setState(() => _searchQuery = '');
                    },
                    padding: const EdgeInsets.all(8),
                    constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                  ),
              ],
            ),
          ),
        ),

        // ── Count row ──────────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
          child: Row(
            children: [
              Text(
                _searchQuery.isEmpty
                    ? '$totalCount order${totalCount != 1 ? 's' : ''}'
                    : '${filtered.length} result${filtered.length != 1 ? 's' : ''}',
                style: const TextStyle(
                    color: _C.textMid, fontSize: 13, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),

        // ── List ───────────────────────────────────────────────────────────
        Expanded(
          child: filtered.isEmpty
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.search_off_rounded, color: _C.textLight, size: 48),
                const SizedBox(height: 12),
                Text('No results for "$_searchQuery"',
                    style: const TextStyle(color: _C.textMid, fontSize: 14)),
              ],
            ),
          )
              : ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
            physics: const BouncingScrollPhysics(),
            itemCount: filtered.length,
            itemBuilder: (_, i) {
              final q = filtered[i];
              final originalIndex = _savedQuotations.indexOf(q);
              final soNumber = (_savedQuotations.length - originalIndex)
                  .toString()
                  .padLeft(4, '0');
              final borderColor =
              _cardBorderColors[originalIndex % _cardBorderColors.length];
              return _buildListCard(q, soNumber, borderColor);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildListCard(SavedQuotation q, String soNumber, Color borderColor) {
    return GestureDetector(
      onTap: () => _showDetailSheet(q, soNumber),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: _C.surface,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 3)),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                width: 4,
                decoration: BoxDecoration(
                  color: _C.primary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(14),
                    bottomLeft: Radius.circular(14),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    q.customerName,
                                    style: const TextStyle(
                                        color: _C.textDark,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: _C.primaryLt,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: _C.primaryLt, width: 0.8),
                                  ),
                                  child: Text(
                                    'SO-$soNumber',
                                    style: const TextStyle(
                                        color: _C.primary,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                            if (q.reference.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text(
                                'Ref: ${q.reference}',
                                style: const TextStyle(
                                    color: _C.textMid,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Rs. ${_formatAmount(q.grandTotal)}',
                            style: const TextStyle(
                                color: _C.textDark,
                                fontSize: 15,
                                fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 4),
                          GestureDetector(
                            onTap: () => _showDetailSheet(q, soNumber),
                            child: const Text(
                              'View Details >',
                              style: TextStyle(
                                  color:_C.primary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatAmount(double amount) {
    final formatter = NumberFormat('#,##,##0.00', 'en_IN');
    return formatter.format(amount);
  }

  void _showDetailSheet(SavedQuotation q, String soNumber) {
    final originalIndex = _savedQuotations.indexOf(q);
    final cardIndex = originalIndex + 1;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _QuotationDetailSheet(
        quotation: q,
        soNumber: soNumber,
        cardIndex: cardIndex,
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// SEGMENT 18 — Quotation Detail Bottom Sheet
// ══════════════════════════════════════════════════════════════════════════════
class _QuotationDetailSheet extends StatelessWidget {
  final SavedQuotation quotation;
  final String         soNumber;
  final int            cardIndex;

  const _QuotationDetailSheet({
    required this.quotation,
    required this.soNumber,
    required this.cardIndex,
  });

  String _fmt(double v) => NumberFormat('#,##,##0.00', 'en_IN').format(v);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.88,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, scrollCtrl) {
        return Container(
          decoration: const BoxDecoration(
            color: _C.bg,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                width: 40, height: 4,
                decoration: BoxDecoration(
                    color: _C.border, borderRadius: BorderRadius.circular(4)),
              ),
              const SizedBox(height: 6),
              Container(
                margin: const EdgeInsets.fromLTRB(16, 6, 16, 0),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF7ECBAA), Color(0xFF4BAD7A)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '#$cardIndex',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(quotation.customerName,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800)),
                          const SizedBox(height: 2),
                          Text('SO-$soNumber',
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 13)),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Rs. ${_fmt(quotation.grandTotal)}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w900),
                        ),
                        if (quotation.reference.isNotEmpty)
                          Text(quotation.reference,
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
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
                      _DetailRow(label: 'Customer Name', value: quotation.customerName, bold: true),
                      if (quotation.customerPhone.isNotEmpty)
                        _DetailRow(label: 'Phone Number', value: quotation.customerPhone, valueColor: _C.primary),
                      if (quotation.customerAddress.isNotEmpty)
                        _DetailRow(label: 'Address', value: quotation.customerAddress, bold: true),
                    ]),
                    const SizedBox(height: 14),
                    _sectionLabel('ORDER INFO'),
                    const SizedBox(height: 8),
                    _infoCard([
                      _DetailRow(label: 'Order No', value: 'SO-$soNumber', valueColor: _C.primary),
                      _DetailRow(label: 'Date', value: DateFormat('dd-MM-yyyy').format(quotation.date), bold: true),
                      if (quotation.reference.isNotEmpty)
                        _DetailRow(label: 'Reference', value: quotation.reference, bold: true),
                      _DetailRow(label: 'Due Date', value: DateFormat('dd-MM-yyyy').format(quotation.dueDate), bold: true),
                      _DetailRow(
                        label: 'GST Type',
                        value: quotation.gstType == GstType.cgstSgst ? 'CGST/SGST' : 'IGST',
                        bold: true,
                      ),
                      _DetailRow(
                        label: 'Tax',
                        value: quotation.taxInclusion == TaxInclusion.exclude ? 'Excluded' : 'Included',
                        bold: true,
                      ),
                    ]),
                    const SizedBox(height: 14),
                    _sectionLabel('ITEMS (${quotation.items.length})'),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: _C.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: _C.border),
                      ),
                      child: Column(
                        children: [
                          for (int i = 0; i < quotation.items.length; i++) ...[
                            if (i > 0) const Divider(height: 1, color: _C.border),
                            _buildItemRow(quotation.items[i], i + 1),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    _sectionLabel('TOTAL'),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: _C.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: _C.border),
                      ),
                      child: Column(
                        children: [
                          if (quotation.discTotal > 0)
                            _DetailRow(label: 'Discount', value: '- Rs. ${_fmt(quotation.discTotal)}', valueColor: _C.red).withPadding(),
                          if (quotation.taxTotal > 0)
                            _DetailRow(label: 'Tax', value: '+ Rs. ${_fmt(quotation.taxTotal)}', valueColor: _C.textMid).withPadding(),
                          const Divider(height: 1, color: _C.border),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Grand Total',
                                    style: TextStyle(
                                        color: _C.textMid,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600)),
                                Text(
                                  'Rs. ${_fmt(quotation.grandTotal)}',
                                  style: const TextStyle(
                                      color: _C.textDark,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w900),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Download feature coming soon'),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            icon: const Icon(Icons.download_rounded, size: 18),
                            label: const Text('Download',
                                style: TextStyle(fontWeight: FontWeight.w700)),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Color(0xFF2E7D55),
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Share feature coming soon'),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            icon: const Icon(Icons.share_rounded,
                                color: Colors.white, size: 18),
                            label: const Text('Share',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2E7D55),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              elevation: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _sectionLabel(String label) => Text(
    label,
    style: const TextStyle(
        color: _C.textMid,
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.0),
  );

  Widget _infoCard(List<_DetailRow> rows) {
    return Container(
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _C.border),
      ),
      child: Column(
        children: [
          for (int i = 0; i < rows.length; i++) ...[
            if (i > 0) const Divider(height: 1, color: _C.border),
            rows[i].withPadding(),
          ],
        ],
      ),
    );
  }

  Widget _buildItemRow(OrderItem item, int idx) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 22, height: 22,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: _C.primaryLt, shape: BoxShape.circle),
                child: Text('$idx',
                    style: const TextStyle(
                        color: _C.primary,
                        fontSize: 11,
                        fontWeight: FontWeight.w800)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(item.product,
                    style: const TextStyle(
                        color: _C.textDark,
                        fontSize: 13,
                        fontWeight: FontWeight.w600)),
              ),
              Text('Rs. ${_fmt(item.grandTotal)}',
                  style: const TextStyle(
                      color: _C.textDark,
                      fontSize: 13,
                      fontWeight: FontWeight.w800)),
            ],
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              'Qty: ${item.quantity}  ×  Rs. ${item.price.toStringAsFixed(2)}'
                  '${item.discountAmount > 0 ? '  |  Disc: Rs. ${item.discountAmount.toStringAsFixed(2)}' : ''}'
                  '${item.taxAmount > 0 ? '  |  Tax: Rs. ${item.taxAmount.toStringAsFixed(2)}' : ''}',
              style: const TextStyle(
                  color: _C.textMid, fontSize: 11, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// SEGMENT 19 — Detail Row Helper
// ══════════════════════════════════════════════════════════════════════════════
class _DetailRow {
  final String  label;
  final String  value;
  final bool    bold;
  final Color?  valueColor;

  const _DetailRow({
    required this.label,
    required this.value,
    this.bold       = false,
    this.valueColor,
  });

  Widget withPadding() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(
                color: _C.textMid, fontSize: 13, fontWeight: FontWeight.w500)),
        const SizedBox(width: 16),
        Flexible(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor ?? _C.textDark,
              fontSize: 13,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w600,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    ),
  );
}

// ══════════════════════════════════════════════════════════════════════════════
// SEGMENT 20 — Reusable Widgets
// ══════════════════════════════════════════════════════════════════════════════

class _FieldLabel extends StatelessWidget {
  final String label;
  const _FieldLabel({required this.label});
  @override
  Widget build(BuildContext context) => Text(label,
      style: const TextStyle(
          color: _C.textMid, fontSize: 13, fontWeight: FontWeight.w600, letterSpacing: 0.2));
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String                hint;
  final TextInputType         keyboardType;
  final ValueChanged<String>? onChanged;
  final int                   maxLines;

  const _InputField({
    required this.controller,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) => TextField(
    controller: controller,
    keyboardType: keyboardType,
    onChanged: onChanged,
    maxLines: maxLines,
    style: const TextStyle(color: _C.textDark, fontSize: 15, fontWeight: FontWeight.w500),
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: _C.textLight, fontSize: 14),
      filled: true, fillColor: _C.bg,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: _C.border)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: _C.border)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
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
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label,
          style: const TextStyle(color: _C.textMid, fontSize: 12, fontWeight: FontWeight.w600)),
      const SizedBox(height: 6),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        decoration: BoxDecoration(
          color: _C.bg, borderRadius: BorderRadius.circular(12), border: Border.all(color: _C.border),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            value: value,
            isExpanded: true,
            icon: const Icon(Icons.keyboard_arrow_down_rounded, color: _C.primary, size: 18),
            dropdownColor: _C.surface,
            style: const TextStyle(color: _C.textDark, fontSize: 13, fontWeight: FontWeight.w600),
            items: items,
            onChanged: onChanged,
          ),
        ),
      ),
    ],
  );
}
