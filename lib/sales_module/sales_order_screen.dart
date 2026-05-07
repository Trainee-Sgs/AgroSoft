import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../theme/app_theme.dart';

// ── Color palette ─────────────────────────────────────────────────────────────
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

// ── Product Info model ────────────────────────────────────────────────────────
class ProductInfo {
  final double oldPrice;
  final int    currentStock;
  const ProductInfo({required this.oldPrice, required this.currentStock});
}

// ── Agro Product Catalogue ────────────────────────────────────────────────────
class AgroProducts {
  static const List<String> all = [
    'AACHI HYBRID TOMATO SEEDS 10G','AADHI PADDY SEEDS 5 KGS','AADHI PADDY SEEDS 10 KGS',
    'AARTHY HYBRID CHILLI SEEDS 10G','AARTHY HYBRID CHILLI SEEDS 25G',
    'ADITYA HYBRID MAIZE SEEDS 1 KGS','ADITYA HYBRID MAIZE SEEDS 5 KGS',
    'AGNI HYBRID COTTON SEEDS 450G','AGNI HYBRID COTTON SEEDS 900G',
    'AGRI GOLD PADDY SEEDS 5 KGS','AGRI GOLD PADDY SEEDS 26 KGS',
    'ALADIN HYBRID OKRA SEEDS 500G','ALADIN HYBRID OKRA SEEDS 1 KGS',
    'AMARANTH SEEDS 100G','AMARANTH SEEDS 500G',
    'ANKUR HYBRID COTTON SEEDS 450G','ANKUR HYBRID COTTON SEEDS 900G',
    'ANNAPOORNA PADDY SEEDS 5 KGS','ANNAPOORNA PADDY SEEDS 26 KGS',
    'BAJRA SEEDS 1 KGS','BAJRA SEEDS 5 KGS','BAJRA SEEDS 25 KGS',
    'BASIL SEEDS 100G','BASIL SEEDS 500G',
    'BENGAL GRAM SEEDS 1 KGS','BENGAL GRAM SEEDS 5 KGS',
    'BHINDI SEEDS 500G','BHINDI SEEDS 1 KGS','BHINDI SEEDS 5 KGS',
    'BITTER GOURD SEEDS 50G','BITTER GOURD SEEDS 100G','BITTER GOURD SEEDS 500G',
    'BLACK GRAM SEEDS 1 KGS','BLACK GRAM SEEDS 5 KGS',
    'BOTTLE GOURD SEEDS 50G','BOTTLE GOURD SEEDS 100G','BOTTLE GOURD SEEDS 500G',
    'BRINJAL SEEDS 10G','BRINJAL SEEDS 50G','BRINJAL SEEDS 100G',
    'BT COTTON SEEDS 450G','BT COTTON SEEDS 900G',
    'CABBAGE SEEDS 10G','CABBAGE SEEDS 50G','CABBAGE SEEDS 100G',
    'CAPSICUM SEEDS 10G','CAPSICUM SEEDS 50G',
    'CAULIFLOWER SEEDS 10G','CAULIFLOWER SEEDS 50G','CAULIFLOWER SEEDS 100G',
    'CHILLI SEEDS 10G','CHILLI SEEDS 25G','CHILLI SEEDS 50G','CHILLI SEEDS 100G',
    'CORIANDER SEEDS 100G','CORIANDER SEEDS 500G','CORIANDER SEEDS 1 KGS',
    'CORN SEEDS 1 KGS','CORN SEEDS 5 KGS',
    'CUCUMBER SEEDS 10G','CUCUMBER SEEDS 50G','CUCUMBER SEEDS 100G',
    'DAP 50 KGS','FENUGREEK SEEDS 100G','FENUGREEK SEEDS 500G',
    'FRENCH BEANS SEEDS 500G','FRENCH BEANS SEEDS 1 KGS',
    'GARLIC SEEDS 1 KGS','GARLIC SEEDS 5 KGS',
    'GINGER SEEDS 1 KGS','GINGER SEEDS 5 KGS',
    'GREEN GRAM SEEDS 1 KGS','GREEN GRAM SEEDS 5 KGS',
    'GROUNDNUT SEEDS 1 KGS','GROUNDNUT SEEDS 5 KGS','GROUNDNUT SEEDS 25 KGS',
    'HYBRID CHILLI SEEDS 10G','HYBRID CHILLI SEEDS 25G',
    'HYBRID MAIZE SEEDS 1 KGS','HYBRID MAIZE SEEDS 5 KGS',
    'HYBRID ONION SEEDS 100G','HYBRID ONION SEEDS 500G',
    'HYBRID PADDY SEEDS 5 KGS','HYBRID PADDY SEEDS 26 KGS',
    'HYBRID TOMATO SEEDS 10G','HYBRID TOMATO SEEDS 50G',
    'IFFCO NANO DAP 500 MLS','IFFCO NANO UREA 500 MLS',
    'IFFCO NPK 19-19-19 1 KGS','IFFCO NPK 19-19-19 5 KGS',
    'IFFCO NPK 20-20-20 1 KGS','IFFCO NPK 20-20-20 5 KGS',
    'IMIDACLOPRID 17.8% SL 100 MLS','IMIDACLOPRID 17.8% SL 250 MLS',
    'IMIDACLOPRID 17.8% SL 500 MLS','IMIDACLOPRID 17.8% SL 1 LTR',
    'JOWAR SEEDS 1 KGS','JOWAR SEEDS 5 KGS','JOWAR SEEDS 25 KGS',
    'KAVERI HYBRID COTTON SEEDS 450G','KAVERI HYBRID COTTON SEEDS 900G',
    'KAVERI HYBRID MAIZE SEEDS 1 KGS','KAVERI HYBRID MAIZE SEEDS 5 KGS',
    'KAVERI PADDY SEEDS 5 KGS','KAVERI PADDY SEEDS 26 KGS',
    'MAIZE SEEDS 1 KGS','MAIZE SEEDS 5 KGS','MAIZE SEEDS 25 KGS',
    'MANCOZEB 75% WP 500G','MANCOZEB 75% WP 1 KGS','MANCOZEB 75% WP 5 KGS',
    'METHI SEEDS 100G','METHI SEEDS 500G','METHI SEEDS 1 KGS',
    'MOONG SEEDS 1 KGS','MOONG SEEDS 5 KGS','MOONG SEEDS 25 KGS',
    'MUSTARD SEEDS 500G','MUSTARD SEEDS 1 KGS','MUSTARD SEEDS 5 KGS',
    'NEEM OIL 10000 PPM 100 MLS','NEEM OIL 10000 PPM 250 MLS',
    'NEEM OIL 10000 PPM 500 MLS','NEEM OIL 10000 PPM 1 LTR',
    'NPK 19-19-19 1 KGS','NPK 19-19-19 5 KGS',
    'NPK 20-20-20 1 KGS','NPK 20-20-20 5 KGS',
    'OKRA SEEDS 500G','OKRA SEEDS 1 KGS','OKRA SEEDS 5 KGS',
    'ONION SEEDS 100G','ONION SEEDS 500G','ONION SEEDS 1 KGS',
    'PADDY SEEDS 5 KGS','PADDY SEEDS 10 KGS','PADDY SEEDS 26 KGS',
    'PALAK SEEDS 100G','PALAK SEEDS 500G','PALAK SEEDS 1 KGS',
    'POTASSIUM NITRATE 1 KGS','POTASSIUM NITRATE 5 KGS',
    'PUMPKIN SEEDS 50G','PUMPKIN SEEDS 100G','PUMPKIN SEEDS 500G',
    'RAGI SEEDS 1 KGS','RAGI SEEDS 5 KGS','RAGI SEEDS 25 KGS',
    'RIDGE GOURD SEEDS 50G','RIDGE GOURD SEEDS 100G',
    'ROUNDUP 500 MLS','ROUNDUP 1 LTR','ROUNDUP 5 LTR',
    'SESAME SEEDS 500G','SESAME SEEDS 1 KGS',
    'SNAKE GOURD SEEDS 50G','SNAKE GOURD SEEDS 100G',
    'SOYABEAN SEEDS 1 KGS','SOYABEAN SEEDS 5 KGS','SOYABEAN SEEDS 25 KGS',
    'SPINACH SEEDS 100G','SPINACH SEEDS 500G',
    'SUNFLOWER SEEDS 1 KGS','SUNFLOWER SEEDS 5 KGS',
    'TOMATO SEEDS 10G','TOMATO SEEDS 50G','TOMATO SEEDS 100G',
    'UREA 45 KGS','UREA 50 KGS','UREA COATED NEEM 50 KGS',
    'VERMICOMPOST 5 KGS','VERMICOMPOST 10 KGS','VERMICOMPOST 25 KGS',
    'WATERMELON SEEDS 50G','WATERMELON SEEDS 100G','WATERMELON SEEDS 500G',
    'WHEAT SEEDS 5 KGS','WHEAT SEEDS 10 KGS','WHEAT SEEDS 25 KGS',
    'ZINC SULPHATE 21% 500G','ZINC SULPHATE 21% 1 KGS','ZINC SULPHATE 21% 5 KGS',
    'ZINC SULPHATE 33% 500G','ZINC SULPHATE 33% 1 KGS','ZINC SULPHATE 33% 5 KGS',
    'A PLUS 250 MLS','A PLUS 500 MLS','A PLUS 1 LTR',
    'ABACIN 1.9% EC 250 MLS','ABACIN 1.9% EC 500 MLS',
    'ACETAMIPRID 20% SP 100G','ACETAMIPRID 20% SP 250G','ACETAMIPRID 20% SP 500G',
    'AMISTAR 100 MLS','AMISTAR 250 MLS','AMISTAR 500 MLS',
    'AMISTAR XTRA 100 MLS','AMISTAR XTRA 250 MLS','AMISTAR XTRA 500 MLS',
    'ANTRACOL 500G','ANTRACOL 1 KGS',
    'BAVISTIN 100G','BAVISTIN 250G','BAVISTIN 500G','BAVISTIN 1 KGS',
    'CARBENDAZIM 50% WP 100G','CARBENDAZIM 50% WP 500G',
    'CHLORPYRIFOS 20% EC 250 MLS','CHLORPYRIFOS 20% EC 500 MLS','CHLORPYRIFOS 20% EC 1 LTR',
    'CONFIDOR 100 MLS','CONFIDOR 250 MLS','CONFIDOR 500 MLS',
    'CORAGEN 60 MLS','CORAGEN 150 MLS','CORAGEN 300 MLS',
    'CYPERMETHRIN 10% EC 250 MLS','CYPERMETHRIN 10% EC 500 MLS',
    'DACONIL 500G','DACONIL 1 KGS',
    'GLYPHOSATE 41% SL 250 MLS','GLYPHOSATE 41% SL 500 MLS',
    'GLYPHOSATE 41% SL 1 LTR','GLYPHOSATE 41% SL 5 LTR',
    'GRAMOXONE 500 MLS','GRAMOXONE 1 LTR','GRAMOXONE 5 LTR',
    'KARATE 100 MLS','KARATE 250 MLS','KARATE 500 MLS',
    'NUVAN 100 MLS','NUVAN 250 MLS','NUVAN 500 MLS',
    'REGENT 100 MLS','REGENT 250 MLS','REGENT 500 MLS',
    'RIDOMIL GOLD 100G','RIDOMIL GOLD 250G','RIDOMIL GOLD 500G',
    'ROGOR 100 MLS','ROGOR 250 MLS','ROGOR 500 MLS',
    'SCORE 100 MLS','SCORE 250 MLS','SCORE 500 MLS',
    'SULPHUR 80% WP 500G','SULPHUR 80% WP 1 KGS',
    'TATA MIDA 100 MLS','TATA MIDA 250 MLS','TATA MIDA 500 MLS',
    'THIAMETHOXAM 25% WG 100G','THIAMETHOXAM 25% WG 250G',
    'TILT 100 MLS','TILT 250 MLS','TILT 500 MLS',
    'TRACER 100 MLS','TRACER 250 MLS','TRACER 500 MLS',
    'USTAAD 100 MLS','USTAAD 250 MLS','USTAAD 500 MLS',
    'VERTIMEC 100 MLS','VERTIMEC 250 MLS','VERTIMEC 500 MLS',
    'WARRIOR 100 MLS','WARRIOR 250 MLS','WARRIOR 500 MLS',
    'AMMONIUM SULPHATE 50 KGS','CALCIUM NITRATE 1 KGS','CALCIUM NITRATE 5 KGS',
    'CHELATED MICRONUTRIENT 500G','CHELATED MICRONUTRIENT 1 KGS',
    'CITY COMPOST 25 KGS','CITY COMPOST 50 KGS',
    'COPPER SULPHATE 500G','COPPER SULPHATE 1 KGS',
    'FERROUS SULPHATE 500G','FERROUS SULPHATE 1 KGS',
    'GYPSUM 25 KGS','GYPSUM 50 KGS',
    'HUMIC ACID 500G','HUMIC ACID 1 KGS','HUMIC ACID 5 KGS',
    'LIME POWDER 25 KGS','LIME POWDER 50 KGS',
    'MAGNESIUM SULPHATE 500G','MAGNESIUM SULPHATE 1 KGS',
    'NEEM CAKE 25 KGS','NEEM CAKE 50 KGS',
    'POTASSIUM SULPHATE 1 KGS','POTASSIUM SULPHATE 5 KGS',
    'ROCK PHOSPHATE 25 KGS','ROCK PHOSPHATE 50 KGS',
    'SEAWEED EXTRACT 500 MLS','SEAWEED EXTRACT 1 LTR',
    'SINGLE SUPER PHOSPHATE 25 KGS','SINGLE SUPER PHOSPHATE 50 KGS',
    'TRIPLE SUPER PHOSPHATE 25 KGS','TRIPLE SUPER PHOSPHATE 50 KGS',
    'VERMICOMPOST 50 KGS',
  ];

  static final Map<String, ProductInfo> _info = {
    for (int i = 0; i < all.length; i++)
      all[i]: ProductInfo(
        oldPrice:     50.0 + (i % 20) * 12.5,
        currentStock: 10   + (i % 50),
      ),
  };

  static ProductInfo? getInfo(String productName) =>
      _info[productName.trim().toUpperCase()];

  static List<String> search(String query) {
    if (query.trim().isEmpty) return [];
    final q = query.toUpperCase().trim();
    return all.where((p) => p.contains(q)).take(30).toList();
  }
}

enum TaxType { inclusive, exclusive }

class OrderItem {
  String  product;
  double  price;
  int     quantity;
  double  taxRate;
  TaxType taxType;

  OrderItem({
    required this.product,
    required this.price,
    required this.quantity,
    required this.taxRate,
    required this.taxType,
  });

  double get baseAmount {
    if (taxType == TaxType.inclusive) {
      return (price * quantity) / (1 + taxRate / 100);
    }
    return price * quantity;
  }

  double get taxAmount  => baseAmount * taxRate / 100;
  double get grandTotal => baseAmount + taxAmount;
  double get subtotal   => price * quantity;
}

class SavedOrder {
  final String   id;
  final String   customer;
  final String   reference;
  final DateTime date;
  final List<OrderItem> items;
  final double   discount;

  SavedOrder({
    required this.id,
    required this.customer,
    required this.reference,
    required this.date,
    required this.items,
    required this.discount,
  });

  double get subtotal   => items.fold(0, (s, i) => s + i.subtotal);
  double get taxTotal   => items.fold(0, (s, i) => s + i.taxAmount);
  double get grandTotal => subtotal + taxTotal - discount;
}

// ── Accordion section keys ────────────────────────────────────────────────────
const _kOrderDetails = 'OrderDetails';
const _kOrderItems   = 'OrderItems';

// ── Main Screen ───────────────────────────────────────────────────────────────
class SalesOrderScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const SalesOrderScreen({super.key, this.onBack});

  @override
  State<SalesOrderScreen> createState() => _SalesOrderScreenState();
}

class _SalesOrderScreenState extends State<SalesOrderScreen>
    with TickerProviderStateMixin {

  bool _showViewOrders = false;

  // ── Accordion: which section is open ──────────────────────────────────
  String? _openSection = _kOrderDetails;

  final _customerCtrl  = TextEditingController();
  final _referenceCtrl = TextEditingController();
  final _discountCtrl  = TextEditingController();

  DateTime        _selectedDate = DateTime.now();
  List<OrderItem> _items        = [];
  int?            _selectedIndex;

  final List<SavedOrder> _savedOrders = [];

  @override
  void dispose() {
    _customerCtrl.dispose();
    _referenceCtrl.dispose();
    _discountCtrl.dispose();
    super.dispose();
  }

  // ── Toggle accordion section ───────────────────────────────────────────
  void _toggleSection(String key) {
    HapticFeedback.lightImpact();
    setState(() => _openSection = _openSection == key ? null : key);
  }

  double get _subTotal   => _items.fold(0, (s, i) => s + i.subtotal);
  double get _taxTotal   => _items.fold(0, (s, i) => s + i.taxAmount);
  double get _discount   => double.tryParse(_discountCtrl.text) ?? 0;
  double get _grandTotal => _subTotal + _taxTotal - _discount;

  int? _existingIndexFor(String productName, {int? skipIndex}) {
    final name = productName.trim().toUpperCase();
    for (int i = 0; i < _items.length; i++) {
      if (i == skipIndex) continue;
      if (_items[i].product.toUpperCase() == name) return i;
    }
    return null;
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
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
    if (picked != null) setState(() => _selectedDate = picked);
  }

  void _deleteItem(int index) {
    final productName = _items[index].product;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.delete_rounded, color: _C.red, size: 22),
            SizedBox(width: 8),
            Text('Delete Item',
                style: TextStyle(color: _C.textDark, fontSize: 17, fontWeight: FontWeight.w700)),
          ],
        ),
        content: Text('Remove "$productName" from this order?',
            style: const TextStyle(color: _C.textMid, fontSize: 14)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel',
                style: TextStyle(color: _C.textMid, fontWeight: FontWeight.w600)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              setState(() {
                _items.removeAt(index);
                if (_selectedIndex == index) {
                  _selectedIndex = null;
                } else if (_selectedIndex != null && _selectedIndex! > index) {
                  _selectedIndex = _selectedIndex! - 1;
                }
              });
              _showSnack('Item removed', _C.red);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _C.red, elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Delete',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  // ── Add / Edit Item — Bottom Sheet ────────────────────────────────────────
  void _showItemSheet({OrderItem? existing, int? editIndex}) {
    final productCtrl = TextEditingController(text: existing?.product ?? '');
    final priceCtrl   = TextEditingController(
        text: existing != null ? existing.price.toStringAsFixed(2) : '');
    final qtyCtrl     = TextEditingController(
        text: existing != null ? existing.quantity.toString() : '');
    final taxCtrl     = TextEditingController(
        text: existing != null ? existing.taxRate.toStringAsFixed(0) : '');

    const TaxType fixedTaxType = TaxType.exclusive;

    double       previewTotal  = existing?.grandTotal ?? 0;
    double?      oldPrice;
    List<String> suggestions   = [];
    ProductInfo? selectedProduct =
    existing != null ? AgroProducts.getInfo(existing.product) : null;

    void checkOldPrice(StateSetter ss, String productName) {
      final idx = _existingIndexFor(productName, skipIndex: editIndex);
      ss(() => oldPrice = idx != null ? _items[idx].price : null);
    }

    void recalc(StateSetter ss) {
      final p     = double.tryParse(priceCtrl.text) ?? 0;
      final q     = int.tryParse(qtyCtrl.text) ?? 0;
      final t     = double.tryParse(taxCtrl.text) ?? 0;
      final total = p * q + p * q * t / 100;
      ss(() => previewTotal = total);
    }

    if (existing != null) {
      final idx = _existingIndexFor(existing.product, skipIndex: editIndex);
      oldPrice = idx != null ? _items[idx].price : null;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => StatefulBuilder(
        builder: (ctx, ss) => DraggableScrollableSheet(
          initialChildSize: 0.75,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (_, scrollCtrl) => Container(
            decoration: const BoxDecoration(
              color: _C.surface,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
            child: Column(
              children: [
                // ── Sheet header ─────────────────────────────────────────
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [_C.primary, _C.primaryDk],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Container(
                        width: 40, height: 4,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
                        child: Row(
                          children: [
                            const Icon(Icons.shopping_bag_rounded,
                                color: Colors.white, size: 22),
                            const SizedBox(width: 10),
                            Text(
                              editIndex != null ? 'Edit Item' : 'Add Item',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () => Navigator.pop(ctx),
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(Icons.close_rounded,
                                    color: Colors.white, size: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Scrollable body ──────────────────────────────────────
                Expanded(
                  child: ListView(
                    controller: scrollCtrl,
                    padding: const EdgeInsets.all(20),
                    children: [
                      // Product search
                      const Text('Product Name',
                          style: TextStyle(
                              color: _C.textMid, fontSize: 12, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 6),
                      TextField(
                        controller: productCtrl,
                        textCapitalization: TextCapitalization.characters,
                        style: const TextStyle(
                            color: _C.textDark, fontSize: 14, fontWeight: FontWeight.w500),
                        onChanged: (val) {
                          ss(() {
                            suggestions     = AgroProducts.search(val);
                            selectedProduct = null;
                          });
                          checkOldPrice(ss, val);
                          recalc(ss);
                        },
                        decoration: InputDecoration(
                          suffixIcon: productCtrl.text.isNotEmpty
                              ? IconButton(
                            icon: const Icon(Icons.clear,
                                color: _C.textLight, size: 18),
                            onPressed: () {
                              productCtrl.clear();
                              ss(() {
                                suggestions     = [];
                                oldPrice        = null;
                                selectedProduct = null;
                              });
                            },
                          )
                              : null,
                          hintText: 'Type to search product…',
                          hintStyle:
                          const TextStyle(color: _C.textLight, fontSize: 12),
                          filled: true, fillColor: _C.bg,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 12),
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

                      // Suggestions
                      if (suggestions.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Container(
                          constraints: const BoxConstraints(maxHeight: 200),
                          decoration: BoxDecoration(
                            color: _C.primaryLt,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: _C.primary.withOpacity(0.25)),
                            boxShadow: [
                              BoxShadow(
                                  color: _C.primary.withOpacity(0.08),
                                  blurRadius: 16,
                                  offset: const Offset(0, 4)),
                            ],
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
                                final s        = suggestions[i];
                                final query    = productCtrl.text.toUpperCase().trim();
                                final idx      = s.indexOf(query);
                                final existIdx = _existingIndexFor(s, skipIndex: editIndex);
                                return InkWell(
                                  onTap: () {
                                    productCtrl.text = s;
                                    productCtrl.selection = TextSelection.fromPosition(
                                        TextPosition(offset: s.length));
                                    checkOldPrice(ss, s);
                                    ss(() {
                                      suggestions     = [];
                                      selectedProduct = AgroProducts.getInfo(s);
                                    });
                                    recalc(ss);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 11),
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
                                                      fontWeight: FontWeight.w500)),
                                              TextSpan(
                                                  text: s.substring(
                                                      idx, idx + query.length),
                                                  style: const TextStyle(
                                                      color: _C.primary,
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w800,
                                                      backgroundColor:
                                                      Color(0xFFBEEDD1))),
                                              TextSpan(
                                                  text: s.substring(
                                                      idx + query.length),
                                                  style: const TextStyle(
                                                      color: _C.primaryDk,
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w500)),
                                            ]),
                                          )
                                              : Text(s,
                                              style: const TextStyle(
                                                  color:_C.primaryDk,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500)),
                                        ),
                                        if (existIdx != null) ...[
                                          const SizedBox(width: 6),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 6, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: _C.primaryLt,
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: Text('×${_items[existIdx].quantity}',
                                                style: const TextStyle(
                                                    color: _C.primary,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w700)),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],

                      // Old price hint
                      if (oldPrice != null) ...[
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 7),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF8EC),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: _C.gold.withOpacity(0.4)),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.history_rounded,
                                  size: 14, color: _C.gold),
                              const SizedBox(width: 6),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: _C.gold,
                                        fontWeight: FontWeight.w500),
                                    children: [
                                      const TextSpan(text: 'Already in order — Previous price: '),
                                      TextSpan(
                                          text: '₹${oldPrice!.toStringAsFixed(2)}',
                                          style: const TextStyle(fontWeight: FontWeight.w800)),
                                      const TextSpan(
                                          text: '. Qty will be added to existing row.'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      const SizedBox(height: 14),

                      // Price + Qty with inline Old Price & Stock badges
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text('Price (₹)',
                                        style: TextStyle(color: _C.textMid,
                                            fontSize: 12, fontWeight: FontWeight.w600)),
                                    if (selectedProduct != null) ...[
                                      const SizedBox(width: 6),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFFF3CD),
                                          borderRadius: BorderRadius.circular(6),
                                          border: Border.all(color: _C.gold.withOpacity(0.5)),
                                        ),
                                        child: Text(
                                          'Old: ₹${selectedProduct!.oldPrice.toStringAsFixed(0)}',
                                          style: const TextStyle(color: _C.gold,
                                              fontSize: 10, fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                const SizedBox(height: 6),
                                TextField(
                                  controller: priceCtrl,
                                  keyboardType: TextInputType.number,
                                  onChanged: (_) => recalc(ss),
                                  style: const TextStyle(color: _C.textDark,
                                      fontSize: 14, fontWeight: FontWeight.w500),
                                  decoration: InputDecoration(
                                    filled: true, fillColor: _C.bg,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(color: _C.border)),
                                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(color: _C.border)),
                                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(color: _C.primary, width: 1.5)),
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
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text('Quantity',
                                        style: TextStyle(color: _C.textMid,
                                            fontSize: 12, fontWeight: FontWeight.w600)),
                                    if (selectedProduct != null) ...[
                                      const SizedBox(width: 6),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: _C.primaryLt,
                                          borderRadius: BorderRadius.circular(6),
                                          border: Border.all(color: _C.primary.withOpacity(0.35)),
                                        ),
                                        child: Text(
                                          'Stock: ${selectedProduct!.currentStock}',
                                          style: const TextStyle(color: _C.primary,
                                              fontSize: 10, fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                const SizedBox(height: 6),
                                TextField(
                                  controller: qtyCtrl,
                                  keyboardType: TextInputType.number,
                                  onChanged: (_) => recalc(ss),
                                  style: const TextStyle(color: _C.textDark,
                                      fontSize: 14, fontWeight: FontWeight.w500),
                                  decoration: InputDecoration(
                                    filled: true, fillColor: _C.bg,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(color: _C.border)),
                                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(color: _C.border)),
                                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(color: _C.primary, width: 1.5)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Tax
                      _DialogField(
                        label: 'Tax (%)',
                        controller: taxCtrl,
                        keyboardType: TextInputType.number,
                        onChanged: (_) => recalc(ss),
                      ),
                      const SizedBox(height: 14),

                      // Item total preview
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: _C.primaryLt,
                          borderRadius: BorderRadius.circular(14),
                          border:
                          Border.all(color: _C.primary.withOpacity(0.2)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Flexible(
                              child: Text('Item Total',
                                  style: TextStyle(
                                      color: _C.primary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14)),
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                '₹${previewTotal.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    color: _C.primary,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Buttons
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Navigator.pop(ctx),
                              style: OutlinedButton.styleFrom(
                                padding:
                                const EdgeInsets.symmetric(vertical: 14),
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
                                final productName = productCtrl.text.trim();
                                if (productName.isEmpty) return;
                                final newPrice =
                                    double.tryParse(priceCtrl.text) ?? 0;
                                final newQty =
                                    int.tryParse(qtyCtrl.text) ?? 1;
                                final newTax =
                                    double.tryParse(taxCtrl.text) ?? 0;
                                setState(() {
                                  if (editIndex != null) {
                                    _items[editIndex] = OrderItem(
                                      product:  productName,
                                      price:    newPrice,
                                      quantity: newQty,
                                      taxRate:  newTax,
                                      taxType:  fixedTaxType,
                                    );
                                  } else {
                                    final existIdx =
                                    _existingIndexFor(productName);
                                    if (existIdx != null) {
                                      final old = _items[existIdx];
                                      _items[existIdx] = OrderItem(
                                        product:  old.product,
                                        price:    newPrice,
                                        quantity: old.quantity + newQty,
                                        taxRate:  newTax,
                                        taxType:  fixedTaxType,
                                      );
                                    } else {
                                      _items.add(OrderItem(
                                        product:  productName,
                                        price:    newPrice,
                                        quantity: newQty,
                                        taxRate:  newTax,
                                        taxType:  fixedTaxType,
                                      ));
                                    }
                                  }
                                  _selectedIndex = null;
                                  // Keep order items section open after adding
                                  _openSection = _kOrderItems;
                                });
                                Navigator.pop(ctx);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _C.primary,
                                padding:
                                const EdgeInsets.symmetric(vertical: 14),
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
                      SizedBox(
                          height: MediaQuery.of(ctx).viewInsets.bottom + 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
    if (_customerCtrl.text.trim().isEmpty) {
      _showSnack('Please enter Customer Name', _C.gold);
      return;
    }
    if (_items.isEmpty) {
      _showSnack('Please add at least one item', _C.gold);
      return;
    }
    HapticFeedback.mediumImpact();

    final order = SavedOrder(
      id:        'SO-${DateTime.now().millisecondsSinceEpoch}',
      customer:  _customerCtrl.text.trim(),
      reference: _referenceCtrl.text.trim(),
      date:      _selectedDate,
      items:     List.from(_items),
      discount:  _discount,
    );

    setState(() {
      _savedOrders.insert(0, order);
      _customerCtrl.clear();
      _referenceCtrl.clear();
      _discountCtrl.clear();
      _items.clear();
      _selectedIndex      = null;
      _selectedDate       = DateTime.now();
      _showViewOrders     = true;
      _openSection        = _kOrderDetails;
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          const Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
          const SizedBox(width: 10),
          Flexible(
              child: Text(
                  'Order saved! Total ₹${order.grandTotal.toStringAsFixed(2)}')),
        ],
      ),
      backgroundColor: _C.primary,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ));
  }

  // ── Build ─────────────────────────────────────────────────────────────────
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

  // ── Header ────────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.appBarGradStart, AppTheme.appBarGradEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(color: Color(0x441B8A3E), blurRadius: 16, offset: Offset(0, 6)),
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
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      } else {
                        widget.onBack?.call();
                      }
                    },
                    constraints:
                    const BoxConstraints(minWidth: 40, minHeight: 40),
                    padding: const EdgeInsets.all(8),
                  ),
                  const Expanded(
                    child: Text('Sales Order',
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
              padding: const EdgeInsets.fromLTRB(16, 2, 16, 10),
              child: Container(
                height: 48,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Row(
                  children: [
                    _tab(
                      label: 'New Order',
                      icon: Icons.add_circle_outline_rounded,
                      active: !_showViewOrders,
                      onTap: () => setState(() => _showViewOrders = false),
                    ),
                    _tab(
                      label: 'View Orders',
                      icon: Icons.list_alt_rounded,
                      active: _showViewOrders,
                      onTap: () => setState(() => _showViewOrders = true),
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
                ? [
              BoxShadow(
                  color: Colors.black.withOpacity(0.10),
                  blurRadius: 8,
                  offset: const Offset(0, 2))
            ]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: active ? _C.primary : Colors.white),
              const SizedBox(width: 6),
              Text(label,
                  style: TextStyle(
                    fontSize: active ? 15 : 14,
                    fontWeight: active ? FontWeight.w800 : FontWeight.w600,
                    color: active ? _C.primary : Colors.white,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  // ── Order Form ────────────────────────────────────────────────────────────
  Widget _buildOrderForm() {
    return SingleChildScrollView(
      key: const ValueKey('form'),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Order Details accordion ──────────────────────────────────
          _accordionCard(
            sectionKey: _kOrderDetails,
            icon: Icons.receipt_long_rounded,
            title: 'Order Details',
            child: _buildOrderDetailsBody(),
          ),
          const SizedBox(height: 14),

          // ── Order Items accordion (+ opens sheet) ────────────────────
          _accordionCard(
            sectionKey: _kOrderItems,
            icon: Icons.shopping_cart_rounded,
            title: 'Order Items',
            onHeaderTap: () => _showItemSheet(),
            child: _buildItemsBody(),
          ),

          if (_items.isNotEmpty) ...[
            const SizedBox(height: 12),
            _buildSummaryCard(),
          ],

          const SizedBox(height: 16),
          _buildSaveButton(),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 24),
        ],
      ),
    );
  }

  // ── Accordion Card (shared) ───────────────────────────────────────────────
  Widget _accordionCard({
    required String   sectionKey,
    required IconData icon,
    required String   title,
    required Widget   child,
    VoidCallback?     onHeaderTap,
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
            onTap: () {
              if (onHeaderTap != null) {
                onHeaderTap();
              } else {
                _toggleSection(sectionKey);
              }
            },
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
                        color: isExpanded ? Colors.white : _C.primary,
                        size: 18),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(title,
                        style: const TextStyle(
                            color: _C.textDark,
                            fontSize: 15,
                            fontWeight: FontWeight.w700)),
                  ),
                  // If onHeaderTap provided → show "+" (items section)
                  // else → show chevron (toggle section)
                  if (onHeaderTap == null)
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
                    )
                  else
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: _C.primaryLt,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.add_rounded,
                          color: _C.primary, size: 16),
                    ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity, height: 0),
            secondChild: Column(
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

  // ── Order Details Body ────────────────────────────────────────────────────
  Widget _buildOrderDetailsBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _FieldLabel(label: 'Select Date'),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: _pickDate,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              color: _C.bg,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _C.border),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_month_rounded,
                    color: _C.primary, size: 20),
                const SizedBox(width: 10),
                Text(
                  DateFormat('dd-MM-yyyy').format(_selectedDate),
                  style: const TextStyle(
                      color: _C.textDark,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                const Icon(Icons.keyboard_arrow_down_rounded,
                    color: _C.textMid, size: 20),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),
        const _FieldLabel(label: 'Customer Name'),
        const SizedBox(height: 6),
        _InputField(controller: _customerCtrl, hint: 'Enter customer name'),
        const SizedBox(height: 14),
        const _FieldLabel(label: 'Reference'),
        const SizedBox(height: 6),
        _InputField(controller: _referenceCtrl, hint: 'Enter reference number'),
      ],
    );
  }

  // ── Items Body (inside accordion) ─────────────────────────────────────────
  Widget _buildItemsBody() {
    if (_items.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Column(
            children: [
              Container(
                width: 70, height: 70,
                decoration: const BoxDecoration(
                    color: _C.primaryLt, shape: BoxShape.circle),
                child: const Icon(Icons.shopping_bag_outlined,
                    color: _C.primary, size: 36),
              ),
              const SizedBox(height: 12),
              const Text('No Items Added',
                  style: TextStyle(
                      color: _C.textDark,
                      fontSize: 14,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              const Text('Tap "+" to add items',
                  style: TextStyle(
                      color: _C.textMid,
                      fontSize: 12,
                      fontWeight: FontWeight.w400)),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _C.primaryLt,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                    '${_items.length} item${_items.length == 1 ? '' : 's'}',
                    style: const TextStyle(
                        color: _C.primary,
                        fontSize: 11,
                        fontWeight: FontWeight.w700)),
              ),
              const Spacer(),
              const Text('Tap "+" to add more',
                  style: TextStyle(
                      color: _C.textMid,
                      fontSize: 11,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _items.length,
          separatorBuilder: (_, __) =>
              Divider(height: 1, color: _C.border),
          itemBuilder: (_, i) {
            final item     = _items[i];
            final selected = _selectedIndex == i;
            return GestureDetector(
              onTap: () =>
                  setState(() => _selectedIndex = selected ? null : i),
              onDoubleTap: () =>
                  _showItemSheet(existing: item, editIndex: i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: selected ? _C.primaryLt : _C.bg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: selected
                        ? _C.primary.withOpacity(0.4)
                        : _C.border,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 24, height: 24,
                          decoration: BoxDecoration(
                            color: selected
                                ? _C.primary
                                : _C.primary.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Center(
                            child: Text('${i + 1}',
                                style: TextStyle(
                                    color: selected
                                        ? Colors.white
                                        : _C.primary,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800)),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(item.product,
                              style: const TextStyle(
                                  color: _C.textDark,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                        ),
                        const SizedBox(width: 8),
                        Text('₹${item.grandTotal.toStringAsFixed(2)}',
                            style: const TextStyle(
                                color: _C.primary,
                                fontSize: 13,
                                fontWeight: FontWeight.w800)),
                        const SizedBox(width: 4),
                        // Quick delete (X) like quotation screen
                        GestureDetector(
                          onTap: () => _deleteItem(i),
                          child: const Icon(Icons.close_rounded,
                              color: _C.textLight, size: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: [
                        _InfoChip(
                            icon: Icons.currency_rupee_rounded,
                            value: '₹${item.price.toStringAsFixed(0)}'),
                        _InfoChip(
                            icon: Icons.layers_rounded,
                            value: '× ${item.quantity}'),
                        _InfoChip(
                            icon: Icons.percent_rounded,
                            value: '${item.taxRate.toStringAsFixed(0)}%'),
                        _InfoChip(
                            icon: Icons.edit_rounded,
                            value: 'double-tap to edit'),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // ── Summary Card ─────────────────────────────────────────────────────────
  Widget _buildSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: _C.primaryLt,
                    borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.summarize_rounded,
                    color: _C.primary, size: 18),
              ),
              const SizedBox(width: 10),
              const Text('Order Summary',
                  style: TextStyle(
                      color: _C.textDark,
                      fontSize: 15,
                      fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 14),
          const _FieldLabel(label: 'Discount (₹)'),
          const SizedBox(height: 8),
          _InputField(
            controller: _discountCtrl,
            hint: '0.00',
            keyboardType: TextInputType.number,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 16),
          _SummaryRow('Subtotal', '₹${_subTotal.toStringAsFixed(2)}'),
          _SummaryRow('Tax', '₹${_taxTotal.toStringAsFixed(2)}'),
          if (_discount > 0)
            _SummaryRow('Discount', '− ₹${_discount.toStringAsFixed(2)}',
                isRed: true),
          const Divider(height: 20, color: _C.border),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Grand Total',
                  style: TextStyle(
                      color: _C.textDark,
                      fontSize: 15,
                      fontWeight: FontWeight.w700)),
              Text('₹${_grandTotal.toStringAsFixed(2)}',
                  style: const TextStyle(
                      color: _C.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.w900)),
            ],
          ),
        ],
      ),
    );
  }

  // ── Save Button ───────────────────────────────────────────────────────────
  Widget _buildSaveButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade300, Colors.green.shade200],
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('TOTAL AMOUNT',
                          style: TextStyle(
                              color: Colors.white60,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.0)),
                      const SizedBox(height: 2),
                      Text('₹${_grandTotal.toStringAsFixed(2)}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w900),
                          overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 7, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                      border:
                      Border.all(color: Colors.white.withOpacity(0.3)),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.save_rounded, color: Colors.white, size: 18),
                        SizedBox(width: 8),
                        Text('SAVE ORDER',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.5)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── View Orders ───────────────────────────────────────────────────────────
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
                    color: _C.textDark,
                    fontSize: 18,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            const Text('Save an order to see it here',
                style: TextStyle(color: _C.textMid, fontSize: 14)),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => setState(() => _showViewOrders = false),
              icon: const Icon(Icons.add_rounded, color: Colors.white, size: 18),
              label: const Text('Create Order',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700)),
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
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 16,
              offset: const Offset(0, 4)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [_C.primary, _C.primaryDk],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
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
                    child: Text('SO-${_savedOrders.length - index}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w700)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(order.customer,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                        overflow: TextOverflow.ellipsis),
                  ),
                  Text(DateFormat('dd MMM yyyy').format(order.date),
                      style:
                      const TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  Row(
                    children: [
                      _statBox('Items', '${order.items.length}',
                          Icons.list_rounded),
                      const SizedBox(width: 10),
                      _statBox('Tax', '₹${order.taxTotal.toStringAsFixed(0)}',
                          Icons.percent_rounded),
                      if (order.discount > 0) ...[
                        const SizedBox(width: 10),
                        _statBox('Discount',
                            '₹${order.discount.toStringAsFixed(0)}',
                            Icons.discount_rounded),
                      ],
                    ],
                  ),
                  if (order.reference.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.tag_rounded,
                            color: _C.textMid, size: 13),
                        const SizedBox(width: 4),
                        Text('Ref: ${order.reference}',
                            style: const TextStyle(
                                color: _C.textMid,
                                fontSize: 12,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ],
                  const SizedBox(height: 12),
                  ...order.items.take(2).map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      children: [
                        Container(
                          width: 6, height: 6,
                          decoration: const BoxDecoration(
                              color: _C.primary, shape: BoxShape.circle),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(item.product,
                              style: const TextStyle(
                                  color: _C.textDark,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                        ),
                        Text('₹${item.grandTotal.toStringAsFixed(2)}',
                            style: const TextStyle(
                                color: _C.textDark,
                                fontSize: 12,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  )),
                  if (order.items.length > 2) ...[
                    const SizedBox(height: 4),
                    Text(
                      '+ ${order.items.length - 2} more item${order.items.length - 2 == 1 ? '' : 's'}',
                      style: const TextStyle(
                          color: _C.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                  const SizedBox(height: 12),
                  const Divider(height: 1, color: _C.border),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Grand Total',
                          style: TextStyle(
                              color: _C.textMid,
                              fontSize: 13,
                              fontWeight: FontWeight.w600)),
                      Text('₹${order.grandTotal.toStringAsFixed(2)}',
                          style: const TextStyle(
                              color: _C.primary,
                              fontSize: 20,
                              fontWeight: FontWeight.w900)),
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

  Widget _statBox(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: _C.primaryLt,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, color: _C.primary, size: 14),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(value,
                      style: const TextStyle(
                          color: _C.primary,
                          fontSize: 13,
                          fontWeight: FontWeight.w800),
                      overflow: TextOverflow.ellipsis),
                  Text(label,
                      style: const TextStyle(
                          color: _C.textMid,
                          fontSize: 10,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Reusable widgets ──────────────────────────────────────────────────────────
class _FieldLabel extends StatelessWidget {
  final String label;
  const _FieldLabel({required this.label});
  @override
  Widget build(BuildContext context) => Text(label,
      style: const TextStyle(
          color: _C.textMid,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2));
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;

  const _InputField({
    required this.controller,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) => TextField(
    controller: controller,
    keyboardType: keyboardType,
    onChanged: onChanged,
    style: const TextStyle(
        color: _C.textDark, fontSize: 13, fontWeight: FontWeight.w500),
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: _C.textLight, fontSize: 12),
      filled: true, fillColor: _C.bg, isDense: true,
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: _C.border)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: _C.border)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: _C.primary, width: 1.5)),
    ),
  );
}

class _DialogField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;

  const _DialogField({
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label,
          style: const TextStyle(
              color: _C.textMid, fontSize: 12, fontWeight: FontWeight.w600)),
      const SizedBox(height: 6),
      TextField(
        controller: controller,
        keyboardType: keyboardType,
        onChanged: onChanged,
        style: const TextStyle(
            color: _C.textDark, fontSize: 14, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          filled: true, fillColor: _C.bg,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
    ],
  );
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
                color: _C.textMid, fontSize: 13, fontWeight: FontWeight.w500)),
        Text(value,
            style: TextStyle(
                color: isRed ? _C.red : _C.textDark,
                fontSize: 13,
                fontWeight: FontWeight.w700)),
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
                color: _C.textDark, fontSize: 11, fontWeight: FontWeight.w600)),
      ],
    ),
  );
}