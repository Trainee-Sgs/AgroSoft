import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../theme/app_theme.dart';

// ── Color palette ──────────────────────────────────────────────────────────
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
}

// ── Supplier Autocomplete Names ────────────────────────────────────────────
class SupplierNames {
  static const List<String> all = [
    'AACHI AGRO TRADERS','AADHI FARM DISTRIBUTORS','ABINAYA SEEDS AND FERTILIZERS',
    'AGRI FRESH SUPPLIERS','AGRI GOLD TRADERS PVT LTD','AGRO BHARAT DISTRIBUTORS',
    'AGRO INDIA ENTERPRISE','AGRO KRISHNA TRADERS','AGRO WORLD SUPPLIERS',
  ];

  static List<String> search(String query) {
    if (query.trim().isEmpty) return [];
    final q = query.toUpperCase().trim();
    return all.where((s) => s.contains(q)).take(20).toList();
  }
}

// ── Agro Product Catalogue ─────────────────────────────────────────────────
class AgroProducts {
  static const List<String> all = [
    'AACHI HYBRID TOMATO SEEDS 10G','AADHI PADDY SEEDS 5 KGS',
    'AARTHY HYBRID CHILLI SEEDS 10G','ADITYA HYBRID MAIZE SEEDS 1 KGS',
    'AGNI HYBRID COTTON SEEDS 450G','BAJRA SEEDS 1 KGS',
  ];

  static List<String> search(String query) {
    if (query.trim().isEmpty) return [];
    final q = query.toUpperCase().trim();
    return all.where((p) => p.contains(q)).take(30).toList();
  }
}

// ── Enums ──────────────────────────────────────────────────────────────────
enum TaxType       { inclusive, exclusive }
enum OrderType     { delivery, returnOrder }
enum GstType       { cgstSgst, igst }
enum TcsType       { noTcs, tcs01, tcs1 }
enum PaymentMode   { credit, cash, upi, cheque, neft }

// ── Data model ─────────────────────────────────────────────────────────────
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

// ── Saved Order model ──────────────────────────────────────────────────────
class SavedOrder {
  final String          id;
  final String          supplierName;
  final String          supplierPhone;
  final String          supplierAddress;
  final String          supplierAadhaar;
  final String          reference;
  final DateTime        date;
  final DateTime        dueDate;
  final List<OrderItem> items;
  final OrderType       orderType;
  final GstType         gstType;
  final TaxType         globalTaxType;
  final TcsType         tcsType;
  final PaymentMode     paymentMode;

  SavedOrder({
    required this.id,
    required this.supplierName,
    required this.supplierPhone,
    required this.supplierAddress,
    required this.supplierAadhaar,
    required this.reference,
    required this.date,
    required this.dueDate,
    required this.items,
    required this.orderType,
    required this.gstType,
    required this.globalTaxType,
    required this.tcsType,
    required this.paymentMode,
  });

  double get subtotal   => items.fold(0, (s, i) => s + i.subtotal);
  double get discTotal  => items.fold(0, (s, i) => s + i.discountAmount);
  double get taxTotal   => items.fold(0, (s, i) => s + i.taxAmount);
  double get grandTotal => items.fold(0, (s, i) => s + i.grandTotal);
}

// ── Main Screen ────────────────────────────────────────────────────────────
class SalesInvoiceScreen extends StatefulWidget {
  const SalesInvoiceScreen({super.key});
  @override
  State<SalesInvoiceScreen> createState() => _SalesInvoiceScreenState();
}

class _SalesInvoiceScreenState extends State<SalesInvoiceScreen>
    with TickerProviderStateMixin {

  bool _showViewOrders = false;

  // ── Collapsible section states — all START CLOSED ──────────────────────
  bool _typesExpanded    = false;
  bool _customerExpanded = false;
  bool _dateRefExpanded  = false;

  // ── Animation controllers — value: 1.0 = arrow pointing DOWN (closed) ──
  late AnimationController _typesArrowAnim;
  late AnimationController _customerArrowAnim;
  late AnimationController _dateRefArrowAnim;

  // ── Controllers ───────────────────────────────────────────────────────────
  final _supplierNameCtrl    = TextEditingController();
  final _supplierPhoneCtrl   = TextEditingController();
  final _supplierAddressCtrl = TextEditingController();
  final _supplierAadhaarCtrl = TextEditingController();
  final _referenceCtrl       = TextEditingController();

  // ── State ─────────────────────────────────────────────────────────────────
  OrderType   _orderType     = OrderType.delivery;
  GstType     _gstType       = GstType.cgstSgst;
  TaxType     _globalTaxType = TaxType.exclusive;
  TcsType     _tcsType       = TcsType.noTcs;
  PaymentMode _paymentMode   = PaymentMode.credit;

  DateTime        _selectedDate        = DateTime.now();
  DateTime        _dueDate             = DateTime.now().add(const Duration(days: 30));
  List<OrderItem> _items               = [];
  int?            _selectedIndex;
  List<String>    _supplierSuggestions = [];
  final _supplierFocus = FocusNode();

  final List<SavedOrder> _savedOrders = [];

  @override
  void initState() {
    super.initState();
    _typesArrowAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
      value: 1.0,
    );
    _customerArrowAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
      value: 1.0,
    );
    _dateRefArrowAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
      value: 1.0,
    );
  }

  @override
  void dispose() {
    _supplierNameCtrl.dispose();
    _supplierPhoneCtrl.dispose();
    _supplierAddressCtrl.dispose();
    _supplierAadhaarCtrl.dispose();
    _referenceCtrl.dispose();
    _supplierFocus.dispose();
    _typesArrowAnim.dispose();
    _customerArrowAnim.dispose();
    _dateRefArrowAnim.dispose();
    super.dispose();
  }

  void _toggleTypesSection() {
    setState(() => _typesExpanded = !_typesExpanded);
    if (_typesExpanded) {
      _typesArrowAnim.reverse();
    } else {
      _typesArrowAnim.forward();
    }
  }

  void _toggleCustomerSection() {
    setState(() => _customerExpanded = !_customerExpanded);
    if (_customerExpanded) {
      _customerArrowAnim.reverse();
    } else {
      _customerArrowAnim.forward();
    }
  }

  void _toggleDateRefSection() {
    setState(() => _dateRefExpanded = !_dateRefExpanded);
    if (_dateRefExpanded) {
      _dateRefArrowAnim.reverse();
    } else {
      _dateRefArrowAnim.forward();
    }
  }

  double get _subTotal   => _items.fold(0, (s, i) => s + i.subtotal);
  double get _discTotal  => _items.fold(0, (s, i) => s + i.discountAmount);
  double get _taxTotal   => _items.fold(0, (s, i) => s + i.taxAmount);
  double get _grandTotal => _items.fold(0, (s, i) => s + i.grandTotal);

  Future<void> _pickDate({bool isDue = false}) async {
    final initial = isDue ? _dueDate : _selectedDate;
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
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
        if (isDue) {
          _dueDate = picked;
        } else {
          _selectedDate = picked;
        }
      });
    }
  }

  void _showItemDialog({OrderItem? existing, int? editIndex}) {
    final productCtrl = TextEditingController(text: existing?.product ?? '');
    final batchCtrl   = TextEditingController(text: existing?.batch ?? '');
    final priceCtrl   = TextEditingController(
        text: existing != null ? existing.price.toStringAsFixed(2) : '');
    final qtyCtrl     = TextEditingController(
        text: existing != null ? existing.quantity.toString() : '');
    final discCtrl    = TextEditingController(
        text: existing != null && existing.discountValue > 0
            ? existing.discountValue.toStringAsFixed(2) : '');
    final taxCtrl     = TextEditingController(
        text: existing != null ? existing.taxRate.toStringAsFixed(0) : '');

    TaxType      selectedTaxType = existing?.taxType ?? _globalTaxType;
    bool         discIsPercent   = existing?.discountIsPercent ?? true;
    double       previewTotal    = existing?.grandTotal ?? 0;
    List<String> suggestions     = [];

    void recalc(StateSetter ss) {
      final p    = double.tryParse(priceCtrl.text) ?? 0;
      final q    = int.tryParse(qtyCtrl.text) ?? 0;
      final dv   = double.tryParse(discCtrl.text) ?? 0;
      final t    = double.tryParse(taxCtrl.text) ?? 0;
      final sub  = p * q;
      final disc = discIsPercent ? sub * dv / 100 : dv;
      final after = sub - disc;
      final total = selectedTaxType == TaxType.inclusive
          ? after
          : after + after * t / 100;
      ss(() => previewTotal = total);
    }

    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (_) => StatefulBuilder(builder: (ctx, ss) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: _C.surface,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: _C.primary.withOpacity(0.15),
                    blurRadius: 40, offset: const Offset(0, 16),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ── Dialog Header ────────────────────────────────────
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [_C.primary, _C.primaryDk],
                        begin: Alignment.topLeft, end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(28), topRight: Radius.circular(28),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.shopping_bag_rounded,
                            color: Colors.white, size: 22),
                        const SizedBox(width: 10),
                        Text(editIndex != null ? 'Edit Item' : 'Add Item',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 17,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Product',
                            style: TextStyle(
                                color: _C.textMid, fontSize: 12,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(height: 6),
                        TextField(
                          controller: productCtrl,
                          textCapitalization: TextCapitalization.characters,
                          style: const TextStyle(
                              color: _C.textDark, fontSize: 14,
                              fontWeight: FontWeight.w500),
                          onChanged: (val) {
                            ss(() => suggestions = AgroProducts.search(val));
                            recalc(ss);
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.inventory_2_rounded,
                                color: _C.primary, size: 18),
                            hintText: 'Search product…',
                            hintStyle: const TextStyle(
                                color: _C.textLight, fontSize: 12),
                            filled: true, fillColor: _C.bg,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: _C.border)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: _C.border)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: _C.primary, width: 1.5)),
                          ),
                        ),
                        if (suggestions.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Container(
                            constraints: const BoxConstraints(maxHeight: 160),
                            decoration: BoxDecoration(
                              color: _C.surface,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                  color: _C.primary.withOpacity(0.25)),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: ListView.separated(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount: suggestions.length,
                                separatorBuilder: (_, __) =>
                                const Divider(height: 1, color: _C.border),
                                itemBuilder: (_, i) {
                                  final s = suggestions[i];
                                  return InkWell(
                                    onTap: () {
                                      productCtrl.text = s;
                                      ss(() => suggestions = []);
                                      recalc(ss);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 14, vertical: 10),
                                      child: Text(s,
                                          style: const TextStyle(
                                              color: _C.textDark,
                                              fontSize: 13)),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                        const SizedBox(height: 14),
                        _DialogField(
                          label: 'Batch No',
                          controller: batchCtrl,
                          icon: Icons.qr_code_rounded,
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Expanded(child: _DialogField(
                              label: 'Price (₹)', controller: priceCtrl,
                              icon: Icons.currency_rupee_rounded,
                              keyboardType: TextInputType.number,
                              onChanged: (_) => recalc(ss),
                            )),
                            const SizedBox(width: 12),
                            Expanded(child: _DialogField(
                              label: 'Qty', controller: qtyCtrl,
                              icon: Icons.layers_rounded,
                              keyboardType: TextInputType.number,
                              onChanged: (_) => recalc(ss),
                            )),
                          ],
                        ),
                        const SizedBox(height: 14),
                        _DialogField(
                          label: 'Tax (%)', controller: taxCtrl,
                          icon: Icons.percent_rounded,
                          keyboardType: TextInputType.number,
                          onChanged: (_) => recalc(ss),
                        ),
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: _C.primaryLt,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Total',
                                  style: TextStyle(
                                      color: _C.primary,
                                      fontWeight: FontWeight.w600)),
                              Text('₹${previewTotal.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      color: _C.primary,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(ctx),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              side: const BorderSide(color: _C.border),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)),
                            ),
                            child: const Text('Cancel',
                                style: TextStyle(
                                    color: _C.textMid,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            onPressed: () {
                              if (productCtrl.text.trim().isEmpty) return;
                              final item = OrderItem(
                                product:           productCtrl.text.trim(),
                                batch:             batchCtrl.text.trim(),
                                price:             double.tryParse(priceCtrl.text) ?? 0,
                                quantity:          int.tryParse(qtyCtrl.text) ?? 1,
                                taxRate:           double.tryParse(taxCtrl.text) ?? 0,
                                taxType:           selectedTaxType,
                              );
                              setState(() {
                                if (editIndex != null) {
                                  _items[editIndex] = item;
                                } else {
                                  _items.add(item);
                                }
                                _selectedIndex = null;
                              });
                              Navigator.pop(ctx);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _C.primary,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)),
                            ),
                            child: Text(
                              editIndex != null ? 'Update' : 'Add Item',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  void _deleteSelected() {
    if (_selectedIndex == null) {
      _showSnack('Select an item to delete', _C.red);
      return;
    }
    setState(() {
      _items.removeAt(_selectedIndex!);
      _selectedIndex = null;
    });
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
    if (_supplierNameCtrl.text.trim().isEmpty) {
      _showSnack('Please enter Customer Name', _C.gold);
      return;
    }
    if (_items.isEmpty) {
      _showSnack('Please add at least one item', _C.gold);
      return;
    }
    HapticFeedback.mediumImpact();

    final order = SavedOrder(
      id:              'PO-${DateTime.now().millisecondsSinceEpoch}',
      supplierName:    _supplierNameCtrl.text.trim(),
      supplierPhone:   _supplierPhoneCtrl.text.trim(),
      supplierAddress: _supplierAddressCtrl.text.trim(),
      supplierAadhaar: _supplierAadhaarCtrl.text.trim(),
      reference:       _referenceCtrl.text.trim(),
      date:            _selectedDate,
      dueDate:         _dueDate,
      items:           List.from(_items),
      orderType:       _orderType,
      gstType:         _gstType,
      globalTaxType:   _globalTaxType,
      tcsType:         _tcsType,
      paymentMode:     _paymentMode,
    );

    setState(() {
      _savedOrders.insert(0, order);
      _supplierNameCtrl.clear();
      _supplierPhoneCtrl.clear();
      _supplierAddressCtrl.clear();
      _supplierAadhaarCtrl.clear();
      _referenceCtrl.clear();
      _items.clear();
      _selectedIndex       = null;
      _supplierSuggestions = [];
      _selectedDate        = DateTime.now();
      _dueDate             = DateTime.now().add(const Duration(days: 30));
      _orderType           = OrderType.delivery;
      _gstType             = GstType.cgstSgst;
      _globalTaxType       = TaxType.exclusive;
      _tcsType             = TcsType.noTcs;
      _paymentMode         = PaymentMode.credit;
      _showViewOrders      = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          const Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
          const SizedBox(width: 10),
          Flexible(child: Text('Order saved! Total ₹${order.grandTotal.toStringAsFixed(2)}')),
        ],
      ),
      backgroundColor: _C.primary,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ));
  }

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
              layoutBuilder: (currentChild, previousChildren) => Stack(
                alignment: Alignment.topCenter,
                children: [
                  ...previousChildren,
                  if (currentChild != null) currentChild,
                ],
              ),
              child: _showViewOrders
                  ? _buildViewOrders()
                  : _buildOrderForm(),
            ),
          ),
          if (!_showViewOrders) _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.appBarGradStart, AppTheme.appBarGradEnd],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
              color: Color(0x441B8A3E), blurRadius: 16, offset: Offset(0, 6)),
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
                    constraints:
                    const BoxConstraints(minWidth: 40, minHeight: 40),
                    padding: const EdgeInsets.all(8),
                  ),
                  const Expanded(
                    child: Text('Sales Invoice',
                        style: TextStyle(
                            color: Colors.white, fontSize: 19,
                            fontWeight: FontWeight.w800, letterSpacing: 0.3)),
                  ),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 10),
              child: Container(
                height: 46,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    _tab(
                        label: 'New Order',
                        icon: Icons.add_circle_outline_rounded,
                        active: !_showViewOrders,
                        onTap: () => setState(() => _showViewOrders = false)),
                    _tab(
                        label: 'View Orders',
                        icon: Icons.list_alt_rounded,
                        active: _showViewOrders,
                        onTap: () => setState(() => _showViewOrders = true)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tab({
    required String label,
    required IconData icon,
    required bool active,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: active ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: active
                ? [BoxShadow(
                color: Colors.black.withOpacity(0.10),
                blurRadius: 8, offset: const Offset(0, 2))]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16,
                  color: active
                      ? _C.primary : Colors.white.withOpacity(0.75)),
              const SizedBox(width: 6),
              Text(label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                    color: active
                        ? _C.primary : Colors.white.withOpacity(0.75),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderForm() {
    return SingleChildScrollView(
      key: const ValueKey('form'),
      // ── FIX 2: Form padding top 16 → 8 ──
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTypesCard(),
          const SizedBox(height: 14),
          _buildSupplierCard(),
          const SizedBox(height: 14),
          _buildDateRefCard(),
          const SizedBox(height: 16),
          _buildAddBar(),
          const SizedBox(height: 12),
          if (_items.isNotEmpty) ...[
            _buildItemsCards(),
            const SizedBox(height: 12),
            _buildDeleteBar(),
            const SizedBox(height: 12),
            _buildSummaryCard(),
            const SizedBox(height: 16),
          ],
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  // ── Types Card (COLLAPSIBLE) ──────────────────────────────────────────────
  Widget _buildTypesCard() {
    return Container(
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.06),
              blurRadius: 16, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: _toggleTypesSection,
            borderRadius: _typesExpanded
                ? const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )
                : BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: _C.primaryLt,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(Icons.tune_rounded,
                        color: _C.primary, size: 18),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text('Order Types',
                        style: TextStyle(
                            color: _C.textDark, fontSize: 15,
                            fontWeight: FontWeight.w700)),
                  ),
                  RotationTransition(
                    turns: Tween(begin: 0.0, end: 0.5).animate(
                        CurvedAnimation(
                            parent: _typesArrowAnim,
                            curve: Curves.easeInOut)),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: _C.primaryLt,
                          borderRadius: BorderRadius.circular(8)),
                      child: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: _C.primary,
                          size: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ClipRect(
            child: AnimatedSize(
              duration: const Duration(milliseconds: 280),
              curve: Curves.easeInOut,
              alignment: Alignment.topCenter,
              child: _typesExpanded
                  ? Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(height: 1, color: _C.border),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: _TypeDropdown<OrderType>(
                          label: 'Type',
                          value: _orderType,
                          items: const [
                            DropdownMenuItem(value: OrderType.delivery,
                                child: Text('Delivery')),
                            DropdownMenuItem(value: OrderType.returnOrder,
                                child: Text('Return')),
                          ],
                          onChanged: (v) {
                            if (v != null) setState(() => _orderType = v);
                          },
                        )),
                        const SizedBox(width: 12),
                        Expanded(child: _TypeDropdown<GstType>(
                          label: 'GST Type',
                          value: _gstType,
                          items: const [
                            DropdownMenuItem(value: GstType.cgstSgst,
                                child: Text('CGST/SGST')),
                            DropdownMenuItem(value: GstType.igst,
                                child: Text('IGST')),
                          ],
                          onChanged: (v) {
                            if (v != null) setState(() => _gstType = v);
                          },
                        )),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: _TypeDropdown<TaxType>(
                          label: 'Tax',
                          value: _globalTaxType,
                          items: const [
                            DropdownMenuItem(value: TaxType.exclusive,
                                child: Text('Exclude')),
                            DropdownMenuItem(value: TaxType.inclusive,
                                child: Text('Include')),
                          ],
                          onChanged: (v) {
                            if (v != null) setState(() => _globalTaxType = v);
                          },
                        )),
                        const SizedBox(width: 12),
                        Expanded(child: _TypeDropdown<TcsType>(
                          label: 'TCS',
                          value: _tcsType,
                          items: const [
                            DropdownMenuItem(value: TcsType.noTcs,
                                child: Text('No TCS')),
                            DropdownMenuItem(value: TcsType.tcs01,
                                child: Text('TCS 0.1%')),
                            DropdownMenuItem(value: TcsType.tcs1,
                                child: Text('TCS 1%')),
                          ],
                          onChanged: (v) {
                            if (v != null) setState(() => _tcsType = v);
                          },
                        )),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _TypeDropdown<PaymentMode>(
                      label: 'Payment Mode',
                      value: _paymentMode,
                      items: const [
                        DropdownMenuItem(value: PaymentMode.credit,
                            child: Text('Credit')),
                        DropdownMenuItem(value: PaymentMode.cash,
                            child: Text('Cash')),
                        DropdownMenuItem(value: PaymentMode.upi,
                            child: Text('UPI')),
                        DropdownMenuItem(value: PaymentMode.cheque,
                            child: Text('Cheque')),
                        DropdownMenuItem(value: PaymentMode.neft,
                            child: Text('NEFT / Bank Transfer')),
                      ],
                      onChanged: (v) {
                        if (v != null) setState(() => _paymentMode = v);
                      },
                    ),
                  ],
                ),
              )
                  : const SizedBox(width: double.infinity, height: 0),
            ),
          ),
        ],
      ),
    );
  }

  // ── Customer Card (COLLAPSIBLE) ───────────────────────────────────────────
  Widget _buildSupplierCard() {
    return Container(
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.06),
              blurRadius: 16, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: _toggleCustomerSection,
            borderRadius: _customerExpanded
                ? const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )
                : BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: _C.primaryLt,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(Icons.store_rounded,
                        color: _C.primary, size: 18),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text('Customer Details',
                        style: TextStyle(
                            color: _C.textDark, fontSize: 15,
                            fontWeight: FontWeight.w700)),
                  ),
                  RotationTransition(
                    turns: Tween(begin: 0.0, end: 0.5).animate(
                        CurvedAnimation(
                            parent: _customerArrowAnim,
                            curve: Curves.easeInOut)),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: _C.primaryLt,
                          borderRadius: BorderRadius.circular(8)),
                      child: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: _C.primary,
                          size: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ClipRect(
            child: AnimatedSize(
              duration: const Duration(milliseconds: 280),
              curve: Curves.easeInOut,
              alignment: Alignment.topCenter,
              child: _customerExpanded
                  ? Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(height: 1, color: _C.border),
                    const SizedBox(height: 16),
                    const _FieldLabel(label: 'Customer Name'),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _supplierNameCtrl,
                      textCapitalization: TextCapitalization.characters,
                      style: const TextStyle(
                          color: _C.textDark, fontSize: 15,
                          fontWeight: FontWeight.w500),
                      onChanged: (val) {
                        setState(() => _supplierSuggestions =
                            SupplierNames.search(val));
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.store_rounded,
                            color: _C.primary, size: 20),
                        hintText: 'Enter Customer name',
                        hintStyle: const TextStyle(
                            color: _C.textLight, fontSize: 14),
                        filled: true, fillColor: _C.bg,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(color: _C.border)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(color: _C.border)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(
                                color: _C.primary, width: 1.5)),
                      ),
                    ),
                    if (_supplierSuggestions.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Container(
                        constraints: const BoxConstraints(maxHeight: 150),
                        decoration: BoxDecoration(
                          color: _C.surface,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                              color: _C.primary.withOpacity(0.25)),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: ListView.separated(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: _supplierSuggestions.length,
                            separatorBuilder: (_, __) =>
                            const Divider(height: 1, color: _C.border),
                            itemBuilder: (_, i) {
                              final s = _supplierSuggestions[i];
                              return InkWell(
                                onTap: () => setState(() {
                                  _supplierNameCtrl.text = s;
                                  _supplierSuggestions = [];
                                  _supplierFocus.unfocus();
                                }),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 10),
                                  child: Text(s,
                                      style: const TextStyle(
                                          color: _C.textDark,
                                          fontSize: 13)),
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
                    _InputField(
                      controller: _supplierPhoneCtrl,
                      hint: 'Enter mobile number',
                      icon: Icons.phone_rounded,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 14),
                    const _FieldLabel(label: 'Address'),
                    const SizedBox(height: 6),
                    _InputField(
                      controller: _supplierAddressCtrl,
                      hint: 'Enter address',
                      icon: Icons.location_on_rounded,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 14),
                    const _FieldLabel(label: 'Aadhaar'),
                    const SizedBox(height: 6),
                    _InputField(
                      controller: _supplierAadhaarCtrl,
                      hint: 'Enter 12-digit Aadhaar',
                      icon: Icons.credit_card_rounded,
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              )
                  : const SizedBox(width: double.infinity, height: 0),
            ),
          ),
        ],
      ),
    );
  }

  // ── Date & Reference Card (COLLAPSIBLE) ────────────────────────────────────
  Widget _buildDateRefCard() {
    return Container(
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.06),
              blurRadius: 16, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: _toggleDateRefSection,
            borderRadius: _dateRefExpanded
                ? const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )
                : BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: _C.primaryLt,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(Icons.calendar_month_rounded,
                        color: _C.primary, size: 18),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text('Date & Reference',
                        style: TextStyle(
                            color: _C.textDark, fontSize: 15,
                            fontWeight: FontWeight.w700)),
                  ),
                  RotationTransition(
                    turns: Tween(begin: 0.0, end: 0.5).animate(
                        CurvedAnimation(
                            parent: _dateRefArrowAnim,
                            curve: Curves.easeInOut)),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: _C.primaryLt,
                          borderRadius: BorderRadius.circular(8)),
                      child: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: _C.primary,
                          size: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ClipRect(
            child: AnimatedSize(
              duration: const Duration(milliseconds: 280),
              curve: Curves.easeInOut,
              alignment: Alignment.topCenter,
              child: _dateRefExpanded
                  ? Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(height: 1, color: _C.border),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const _FieldLabel(label: 'Date'),
                              const SizedBox(height: 6),
                              _DatePicker(
                                date: _selectedDate,
                                onTap: () => _pickDate(),
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
                              _InputField(
                                controller: _referenceCtrl,
                                hint: 'Enter reference no',
                                icon: Icons.tag_rounded,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    const _FieldLabel(label: 'Due Date'),
                    const SizedBox(height: 6),
                    _DatePicker(
                      date: _dueDate,
                      onTap: () => _pickDate(isDue: true),
                      accentColor: _C.gold,
                    ),
                  ],
                ),
              )
                  : const SizedBox(width: double.infinity, height: 0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.06),
              blurRadius: 16, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: _C.primaryLt,
                borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.shopping_cart_rounded,
                color: _C.primary, size: 18),
          ),
          const SizedBox(width: 10),
          const Text('Items',
              style: TextStyle(
                  color: _C.textDark, fontSize: 15,
                  fontWeight: FontWeight.w700)),
          const Spacer(),
          GestureDetector(
            onTap: () => _showItemDialog(),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: _C.primary,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: _C.primary.withOpacity(0.3),
                      blurRadius: 8, offset: const Offset(0, 3)),
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add_rounded, color: Colors.white, size: 18),
                  SizedBox(width: 6),
                  Text('ADD',
                      style: TextStyle(
                          color: Colors.white, fontSize: 12,
                          fontWeight: FontWeight.w800, letterSpacing: 0.5)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsCards() {
    return Container(
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.06),
              blurRadius: 16, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                const Text('Items',
                    style: TextStyle(
                        color: _C.textDark, fontSize: 14,
                        fontWeight: FontWeight.w700)),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: _C.primaryLt,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('${_items.length}',
                      style: const TextStyle(
                          color: _C.primary, fontSize: 11,
                          fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _items.length,
            separatorBuilder: (_, __) => Divider(
                height: 1, indent: 16, endIndent: 16, color: _C.border),
            itemBuilder: (_, i) {
              final item     = _items[i];
              final selected = _selectedIndex == i;
              return GestureDetector(
                onTap: () =>
                    setState(() => _selectedIndex = selected ? null : i),
                onDoubleTap: () =>
                    _showItemDialog(existing: item, editIndex: i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 5),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: selected ? _C.primaryLt : _C.bg,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: selected
                          ? _C.primary.withOpacity(0.4) : _C.border,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 26, height: 26,
                            decoration: BoxDecoration(
                              color: selected
                                  ? _C.primary
                                  : _C.primary.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text('${i + 1}',
                                  style: TextStyle(
                                      color: selected
                                          ? Colors.white : _C.primary,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w800)),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(item.product,
                                style: const TextStyle(
                                    color: _C.textDark, fontSize: 13,
                                    fontWeight: FontWeight.w700),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis),
                          ),
                          const SizedBox(width: 8),
                          Text('₹${item.grandTotal.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  color: _C.primary, fontSize: 14,
                                  fontWeight: FontWeight.w900)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 6, runSpacing: 4,
                        children: [
                          _InfoChip(icon: Icons.currency_rupee_rounded,
                              value: '₹${item.price.toStringAsFixed(0)}'),
                          _InfoChip(icon: Icons.layers_rounded,
                              value: '× ${item.quantity}'),
                          if (item.batch.isNotEmpty)
                            _InfoChip(icon: Icons.qr_code_rounded,
                                value: item.batch),
                          _InfoChip(icon: Icons.percent_rounded,
                              value:
                              '${item.taxRate.toStringAsFixed(0)}% tax'),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildDeleteBar() {
    String selectedLabel = 'Tap an item to select';
    if (_selectedIndex != null && _selectedIndex! < _items.length) {
      final name = _items[_selectedIndex!].product;
      selectedLabel = name.length > 24 ? '${name.substring(0, 24)}…' : name;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _C.red.withOpacity(0.15)),
        boxShadow: [
          BoxShadow(color: _C.red.withOpacity(0.05),
              blurRadius: 16, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: _C.red.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.delete_sweep_rounded,
                color: _C.red, size: 18),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Remove',
                    style: TextStyle(
                        color: _C.textDark, fontSize: 13,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(selectedLabel,
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: _selectedIndex != null ? _C.red : _C.textLight,
                      fontSize: 11, fontWeight: FontWeight.w500,
                    )),
              ],
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: _deleteSelected,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: _selectedIndex != null
                    ? _C.red : _C.red.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _selectedIndex != null
                      ? _C.red : _C.red.withOpacity(0.25),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.delete_rounded,
                      color: _selectedIndex != null
                          ? Colors.white : _C.red, size: 16),
                  const SizedBox(width: 5),
                  Text('DELETE',
                      style: TextStyle(
                        color: _selectedIndex != null
                            ? Colors.white : _C.red,
                        fontSize: 12, fontWeight: FontWeight.w800,
                        letterSpacing: 0.4,
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    double tcsAmount = 0;
    if (_tcsType == TcsType.tcs01) tcsAmount = _grandTotal * 0.001;
    if (_tcsType == TcsType.tcs1)  tcsAmount = _grandTotal * 0.01;
    final netTotal = _grandTotal + tcsAmount;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05),
              blurRadius: 12, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Order Summary',
              style: TextStyle(
                  color: _C.textDark, fontSize: 15,
                  fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          _SummaryRow('Subtotal', '₹${_subTotal.toStringAsFixed(2)}'),
          if (_discTotal > 0)
            _SummaryRow('Discount',
                '− ₹${_discTotal.toStringAsFixed(2)}', isRed: true),
          _SummaryRow('Tax', '₹${_taxTotal.toStringAsFixed(2)}'),
          if (tcsAmount > 0)
            _SummaryRow(
              _tcsType == TcsType.tcs01 ? 'TCS @0.1%' : 'TCS @1%',
              '₹${tcsAmount.toStringAsFixed(2)}',
            ),
          const Divider(height: 20, color: _C.border),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Grand Total',
                  style: TextStyle(
                      color: _C.textDark, fontSize: 15,
                      fontWeight: FontWeight.w700)),
              Text('₹${netTotal.toStringAsFixed(2)}',
                  style: const TextStyle(
                      color: _C.primary, fontSize: 20,
                      fontWeight: FontWeight.w900)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    double tcsAmount = 0;
    if (_tcsType == TcsType.tcs01) tcsAmount = _grandTotal * 0.001;
    if (_tcsType == TcsType.tcs1)  tcsAmount = _grandTotal * 0.01;
    final netTotal = _grandTotal + tcsAmount;

    return Container(
      padding: EdgeInsets.fromLTRB(
          16, 12, 16, MediaQuery.of(context).padding.bottom + 12),
      decoration: BoxDecoration(
        color: _C.surface,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1),
              blurRadius: 20, offset: const Offset(0, -4)),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [_C.primary, _C.primaryDk],
            begin: Alignment.centerLeft, end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(color: _C.primary.withOpacity(0.4),
                blurRadius: 16, offset: const Offset(0, 6)),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _save,
            borderRadius: BorderRadius.circular(18),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('TOTAL AMOUNT',
                          style: TextStyle(
                              color: Colors.white60, fontSize: 10,
                              fontWeight: FontWeight.w600, letterSpacing: 1.0)),
                      const SizedBox(height: 2),
                      Text('₹${netTotal.toStringAsFixed(2)}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 22,
                              fontWeight: FontWeight.w900)),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: Colors.white.withOpacity(0.3)),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.save_rounded,
                            color: Colors.white, size: 18),
                        SizedBox(width: 8),
                        Text('SAVE',
                            style: TextStyle(
                                color: Colors.white, fontSize: 13,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.5)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildViewOrders() {
    if (_savedOrders.isEmpty) {
      return Center(
        key: const ValueKey('empty'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90, height: 90,
              decoration: const BoxDecoration(
                  color: _C.primaryLt, shape: BoxShape.circle),
              child: const Icon(Icons.receipt_long_rounded,
                  color: _C.primary, size: 44),
            ),
            const SizedBox(height: 20),
            const Text('No Orders Yet',
                style: TextStyle(
                    color: _C.textDark, fontSize: 18,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            const Text('Save an order to see it here',
                style: TextStyle(color: _C.textMid, fontSize: 14)),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () =>
                  setState(() => _showViewOrders = false),
              icon: const Icon(Icons.add_rounded,
                  color: Colors.white, size: 18),
              label: const Text('Create',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700)),
              style: ElevatedButton.styleFrom(
                backgroundColor: _C.primary,
                padding: const EdgeInsets.symmetric(
                    horizontal: 28, vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      key: const ValueKey('list'),
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      itemCount: _savedOrders.length,
      itemBuilder: (_, i) => _buildOrderCard(_savedOrders[i], i),
    );
  }

  Widget _buildOrderCard(SavedOrder order, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.06),
              blurRadius: 16, offset: const Offset(0, 4)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [_C.primary, _C.primaryDk],
                  begin: Alignment.centerLeft, end: Alignment.centerRight,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'PO-${_savedOrders.length - index}',
                      style: const TextStyle(
                          color: Colors.white, fontSize: 11,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(order.supplierName,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 15,
                            fontWeight: FontWeight.w700),
                        overflow: TextOverflow.ellipsis),
                  ),
                  Text(DateFormat('dd MMM').format(order.date),
                      style: const TextStyle(
                          color: Colors.white70, fontSize: 10)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${order.items.length} items',
                          style: const TextStyle(
                              color: _C.textMid, fontSize: 13,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        '₹${order.grandTotal.toStringAsFixed(2)}',
                        style: const TextStyle(
                            color: _C.primary, fontSize: 20,
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── _DatePicker ───────────────────────────────────────────────────────────────
class _DatePicker extends StatelessWidget {
  final DateTime  date;
  final VoidCallback onTap;
  final Color     accentColor;

  const _DatePicker({
    required this.date,
    required this.onTap,
    this.accentColor = _C.primary,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: _C.bg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _C.border),
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_month_rounded,
                color: accentColor, size: 18),
            const SizedBox(width: 8),
            Text(DateFormat('dd-MM-yyyy').format(date),
                style: const TextStyle(
                    color: _C.textDark, fontSize: 10,
                    fontWeight: FontWeight.w600)),
            const Spacer(),
            const Icon(Icons.keyboard_arrow_down_rounded,
                color: _C.textMid, size: 18),
          ],
        ),
      ),
    );
  }
}

// ── Reusable Widgets ──────────────────────────────────────────────────────────

class _FieldLabel extends StatelessWidget {
  final String label;
  const _FieldLabel({required this.label});
  @override
  Widget build(BuildContext context) => Text(label,
      style: const TextStyle(
          color: _C.textMid, fontSize: 13,
          fontWeight: FontWeight.w600, letterSpacing: 0.2));
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String                 hint;
  final IconData               icon;
  final TextInputType          keyboardType;
  final ValueChanged<String>?  onChanged;
  final int                    maxLines;

  const _InputField({
    required this.controller,
    required this.hint,
    required this.icon,
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
    style: const TextStyle(
        color: _C.textDark, fontSize: 15, fontWeight: FontWeight.w500),
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: _C.textLight, fontSize: 14),
      prefixIcon: Icon(icon, color: _C.primary, size: 20),
      filled: true, fillColor: _C.bg,
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: _C.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: _C.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: _C.primary, width: 1.5),
      ),
    ),
  );
}

class _DialogField extends StatelessWidget {
  final String                 label;
  final TextEditingController  controller;
  final IconData               icon;
  final TextInputType          keyboardType;
  final ValueChanged<String>?  onChanged;

  const _DialogField({
    required this.label,
    required this.controller,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label,
          style: const TextStyle(
              color: _C.textMid, fontSize: 12,
              fontWeight: FontWeight.w600)),
      const SizedBox(height: 6),
      TextField(
        controller: controller,
        keyboardType: keyboardType,
        onChanged: onChanged,
        style: const TextStyle(
            color: _C.textDark, fontSize: 14,
            fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: _C.primary, size: 18),
          filled: true, fillColor: _C.bg,
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 12, vertical: 12),
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
    ],
  );
}

class _TypeDropdown<T> extends StatelessWidget {
  final String                   label;
  final T                        value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>         onChanged;

  const _TypeDropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                color: _C.textMid, fontSize: 12,
                fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          decoration: BoxDecoration(
            color: _C.bg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _C.border),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down_rounded,
                  color: _C.primary, size: 18),
              dropdownColor: _C.surface,
              style: const TextStyle(
                  color: _C.textDark, fontSize: 13,
                  fontWeight: FontWeight.w600),
              items: items,
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label, value;
  final bool   isRed;
  const _SummaryRow(this.label, this.value, {this.isRed = false});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(
                color: _C.textMid, fontSize: 13,
                fontWeight: FontWeight.w500)),
        Text(value,
            style: TextStyle(
                color: isRed ? _C.red : _C.textDark,
                fontSize: 13, fontWeight: FontWeight.w700)),
      ],
    ),
  );
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String   value;
  const _InfoChip({required this.icon, required this.value});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: _C.surface,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _C.border),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: _C.textMid, size: 11),
        const SizedBox(width: 4),
        Text(value,
            style: const TextStyle(
                color: _C.textDark, fontSize: 11,
                fontWeight: FontWeight.w600)),
      ],
    ),
  );
}