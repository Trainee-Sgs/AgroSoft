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

// ── Product Info ───────────────────────────────────────────────────────────
class _ProductInfo {
  final double oldPrice;
  final int    currentStock;
  const _ProductInfo({required this.oldPrice, required this.currentStock});
}

// ── Product Database ───────────────────────────────────────────────────────
final Map<String, _ProductInfo> _productDatabase = {
  'AACHI HYBRID TOMATO SEEDS 10G':   _ProductInfo(oldPrice: 85.00,   currentStock: 45),
  'AADHI PADDY SEEDS 5 KGS':         _ProductInfo(oldPrice: 320.00,  currentStock: 120),
  'AADHI PADDY SEEDS 10 KGS':        _ProductInfo(oldPrice: 620.00,  currentStock: 80),
  'AARTHY HYBRID CHILLI SEEDS 10G':  _ProductInfo(oldPrice: 95.00,   currentStock: 60),
  'AARTHY HYBRID CHILLI SEEDS 25G':  _ProductInfo(oldPrice: 220.00,  currentStock: 40),
  'ADITYA HYBRID MAIZE SEEDS 1 KGS': _ProductInfo(oldPrice: 180.00,  currentStock: 75),
  'ADITYA HYBRID MAIZE SEEDS 5 KGS': _ProductInfo(oldPrice: 850.00,  currentStock: 35),
  'AGNI HYBRID COTTON SEEDS 450G':   _ProductInfo(oldPrice: 420.00,  currentStock: 25),
  'AGNI HYBRID COTTON SEEDS 900G':   _ProductInfo(oldPrice: 810.00,  currentStock: 18),
  'AGRI GOLD PADDY SEEDS 5 KGS':     _ProductInfo(oldPrice: 310.00,  currentStock: 100),
  'AGRI GOLD PADDY SEEDS 26 KGS':    _ProductInfo(oldPrice: 1550.00, currentStock: 15),
  'HYBRID TOMATO SEEDS 10G':         _ProductInfo(oldPrice: 90.00,   currentStock: 55),
  'HYBRID TOMATO SEEDS 50G':         _ProductInfo(oldPrice: 380.00,  currentStock: 30),
  'HYBRID CHILLI SEEDS 10G':         _ProductInfo(oldPrice: 100.00,  currentStock: 65),
  'HYBRID CHILLI SEEDS 25G':         _ProductInfo(oldPrice: 240.00,  currentStock: 45),
  'HYBRID MAIZE SEEDS 1 KGS':        _ProductInfo(oldPrice: 190.00,  currentStock: 80),
  'HYBRID MAIZE SEEDS 5 KGS':        _ProductInfo(oldPrice: 900.00,  currentStock: 40),
  'HYBRID PADDY SEEDS 5 KGS':        _ProductInfo(oldPrice: 330.00,  currentStock: 110),
  'HYBRID PADDY SEEDS 26 KGS':       _ProductInfo(oldPrice: 1620.00, currentStock: 20),
  'HYBRID ONION SEEDS 100G':         _ProductInfo(oldPrice: 450.00,  currentStock: 35),
  'HYBRID ONION SEEDS 500G':         _ProductInfo(oldPrice: 2100.00, currentStock: 12),
  'UREA 50 KGS':                     _ProductInfo(oldPrice: 650.00,  currentStock: 200),
  'DAP 50 KGS':                      _ProductInfo(oldPrice: 1200.00, currentStock: 150),
  'NPK 19-19-19 5 KGS':              _ProductInfo(oldPrice: 580.00,  currentStock: 90),
  'MANCOZEB 75% WP 1 KGS':           _ProductInfo(oldPrice: 320.00,  currentStock: 55),
  'IMIDACLOPRID 17.8% SL 1 LTR':    _ProductInfo(oldPrice: 480.00,  currentStock: 40),
};

// ── Supplier Names ─────────────────────────────────────────────────────────
class _SupplierNames {
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

// ── Agro Product Catalogue ─────────────────────────────────────────────────
class _AgroProducts {
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
    'VERMICOMPOST 5 KGS','VERMICOMPOST 10 KGS','VERMICOMPOST 25 KGS','VERMICOMPOST 50 KGS',
    'WATERMELON SEEDS 50G','WATERMELON SEEDS 100G','WATERMELON SEEDS 500G',
    'WHEAT SEEDS 5 KGS','WHEAT SEEDS 10 KGS','WHEAT SEEDS 25 KGS',
    'ZINC SULPHATE 21% 500G','ZINC SULPHATE 21% 1 KGS','ZINC SULPHATE 21% 5 KGS',
    'ZINC SULPHATE 33% 500G','ZINC SULPHATE 33% 1 KGS','ZINC SULPHATE 33% 5 KGS',
    'BAVISTIN 100G','BAVISTIN 250G','BAVISTIN 500G','BAVISTIN 1 KGS',
    'CHLORPYRIFOS 20% EC 250 MLS','CHLORPYRIFOS 20% EC 500 MLS','CHLORPYRIFOS 20% EC 1 LTR',
    'CORAGEN 60 MLS','CORAGEN 150 MLS','CORAGEN 300 MLS',
    'GLYPHOSATE 41% SL 250 MLS','GLYPHOSATE 41% SL 500 MLS','GLYPHOSATE 41% SL 1 LTR',
    'GRAMOXONE 500 MLS','GRAMOXONE 1 LTR','GRAMOXONE 5 LTR',
    'KARATE 100 MLS','KARATE 250 MLS','KARATE 500 MLS',
    'NUVAN 100 MLS','NUVAN 250 MLS','NUVAN 500 MLS',
    'REGENT 100 MLS','REGENT 250 MLS','REGENT 500 MLS',
    'RIDOMIL GOLD 100G','RIDOMIL GOLD 250G','RIDOMIL GOLD 500G',
    'SCORE 100 MLS','SCORE 250 MLS','SCORE 500 MLS',
    'SULPHUR 80% WP 500G','SULPHUR 80% WP 1 KGS',
    'TATA MIDA 100 MLS','TATA MIDA 250 MLS','TATA MIDA 500 MLS',
    'THIAMETHOXAM 25% WG 100G','THIAMETHOXAM 25% WG 250G',
    'AMMONIUM SULPHATE 50 KGS','CALCIUM NITRATE 1 KGS','CALCIUM NITRATE 5 KGS',
    'HUMIC ACID 500G','HUMIC ACID 1 KGS','HUMIC ACID 5 KGS',
    'SEAWEED EXTRACT 500 MLS','SEAWEED EXTRACT 1 LTR',
    'SINGLE SUPER PHOSPHATE 25 KGS','SINGLE SUPER PHOSPHATE 50 KGS',
    'TRIPLE SUPER PHOSPHATE 25 KGS','TRIPLE SUPER PHOSPHATE 50 KGS',
  ];

  static _ProductInfo? getInfo(String name) => _productDatabase[name];

  static List<String> search(String query) {
    if (query.trim().isEmpty) return [];
    final q = query.toUpperCase().trim();
    return all.where((p) => p.contains(q)).take(30).toList();
  }
}

// ── Enums ──────────────────────────────────────────────────────────────────
enum _TaxType      { inclusive, exclusive }
enum _PurchaseType { purchase, purchaseReturn }
enum _GstType      { cgstSgst, igst }
enum _TcsType      { noTcs, tcs01, tcs1 }

// ── Data model ─────────────────────────────────────────────────────────────
class _PurchaseItem {
  String    product;
  String    batch;
  double    price;
  int       quantity;
  double    discountValue;
  bool      discountIsPercent;
  double    taxRate;
  _TaxType  taxType;

  _PurchaseItem({
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
    if (taxType == _TaxType.inclusive) {
      return afterDiscount - afterDiscount / (1 + taxRate / 100);
    }
    return afterDiscount * taxRate / 100;
  }
  double get grandTotal =>
      afterDiscount + (taxType == _TaxType.exclusive ? taxAmount : 0);
}

// ── Saved Purchase model ────────────────────────────────────────────────────
class _SavedPurchase {
  final String              id;
  final String              supplierName;
  final String              supplierAddress;
  final String              reference;
  final DateTime            date;
  final List<_PurchaseItem> items;
  final _PurchaseType       purchaseType;
  final _GstType            gstType;
  final _TaxType            globalTaxType;
  final _TcsType            tcsType;

  _SavedPurchase({
    required this.id,
    required this.supplierName,
    required this.supplierAddress,
    required this.reference,
    required this.date,
    required this.items,
    required this.purchaseType,
    required this.gstType,
    required this.globalTaxType,
    required this.tcsType,
  });

  double get subtotal   => items.fold(0, (s, i) => s + i.subtotal);
  double get discTotal  => items.fold(0, (s, i) => s + i.discountAmount);
  double get taxTotal   => items.fold(0, (s, i) => s + i.taxAmount);
  double get grandTotal => items.fold(0, (s, i) => s + i.grandTotal);
}

// ── Main Screen ────────────────────────────────────────────────────────────
class PurchaseOrderScreen extends StatefulWidget {
  const PurchaseOrderScreen({super.key});
  @override
  State<PurchaseOrderScreen> createState() => _PurchaseOrderScreenState();
}

class _PurchaseOrderScreenState extends State<PurchaseOrderScreen>
    with TickerProviderStateMixin {

  bool _showViewOrders = false;
  int? _expandedCard   = 0;

  final _supplierNameCtrl    = TextEditingController();
  final _supplierAddressCtrl = TextEditingController();
  final _referenceCtrl       = TextEditingController();
  final _supplierFocus       = FocusNode();

  _PurchaseType _purchaseType  = _PurchaseType.purchase;
  _GstType      _gstType       = _GstType.cgstSgst;
  _TaxType      _globalTaxType = _TaxType.exclusive;
  _TcsType      _tcsType       = _TcsType.noTcs;

  DateTime             _selectedDate        = DateTime.now();
  List<_PurchaseItem>  _items               = [];
  int?                 _selectedIndex;
  List<String>         _supplierSuggestions = [];
  final List<_SavedPurchase> _savedOrders   = [];

  @override
  void dispose() {
    _supplierNameCtrl.dispose();
    _supplierAddressCtrl.dispose();
    _referenceCtrl.dispose();
    _supplierFocus.dispose();
    super.dispose();
  }

  double get _subTotal   => _items.fold(0, (s, i) => s + i.subtotal);
  double get _discTotal  => _items.fold(0, (s, i) => s + i.discountAmount);
  double get _taxTotal   => _items.fold(0, (s, i) => s + i.taxAmount);
  double get _grandTotal => _items.fold(0, (s, i) => s + i.grandTotal);

  void _toggleCard(int index) =>
      setState(() => _expandedCard = _expandedCard == index ? null : index);

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

  // ── Shared input decoration ───────────────────────────────────────────────
  static InputDecoration _inputDec({String hint = ''}) => InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(color: _C.textLight, fontSize: 12),
    filled: true,
    fillColor: _C.bg,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _C.border)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _C.border)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _C.primary, width: 1.5)),
  );

  // ── Suggestion dropdown box ───────────────────────────────────────────────
  static Widget _suggestionBox({
    required List<String> items,
    required String queryText,
    required IconData icon,
    required ValueChanged<String> onSelect,
  }) {
    final query = queryText.toUpperCase().trim();
    return Container(
      constraints: const BoxConstraints(maxHeight: 180),
      decoration: BoxDecoration(
        color: _C.surface,
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
          itemCount: items.length,
          separatorBuilder: (_, __) =>
          const Divider(height: 1, color: _C.border),
          itemBuilder: (_, i) {
            final s   = items[i];
            final idx = s.indexOf(query);
            return InkWell(
              onTap: () => onSelect(s),
              child: Container(
                color: i.isEven
                    ? _C.primaryLt.withOpacity(0.4)
                    : _C.surface,
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 10),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: _C.primaryLt,
                          borderRadius: BorderRadius.circular(6)),
                      child: Icon(icon, color: _C.primary, size: 12),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: idx >= 0 && query.isNotEmpty
                          ? RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: s.substring(0, idx),
                            style: const TextStyle(
                                color: _C.textMid,
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
                                color: _C.textMid,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                        ]),
                      )
                          : Text(s,
                          style: const TextStyle(
                              color: _C.primary,
                              fontSize: 13,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ── Badge helpers ─────────────────────────────────────────────────────────
  static Widget _badgeGold(String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF3CD),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: _C.gold.withOpacity(0.5)),
    ),
    child: Text(text,
        style: const TextStyle(
            color: _C.gold, fontSize: 10, fontWeight: FontWeight.w700)),
  );

  static Widget _badgeGreen(String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
    decoration: BoxDecoration(
      color: _C.primaryLt,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: _C.primary.withOpacity(0.35)),
    ),
    child: Text(text,
        style: const TextStyle(
            color: _C.primary, fontSize: 10, fontWeight: FontWeight.w700)),
  );

  // ── Add / Edit Item bottom sheet ──────────────────────────────────────────
  void _showItemSheet({_PurchaseItem? existing, int? editIndex}) {
    final productCtrl = TextEditingController(text: existing?.product ?? '');
    final batchCtrl   = TextEditingController(text: existing?.batch   ?? '');
    final priceCtrl   = TextEditingController(
        text: existing != null ? existing.price.toStringAsFixed(2) : '');
    final qtyCtrl     = TextEditingController(
        text: existing != null ? existing.quantity.toString() : '');
    final discCtrl    = TextEditingController(
        text: existing != null && existing.discountValue > 0
            ? existing.discountValue.toStringAsFixed(2) : '');
    final taxCtrl     = TextEditingController(
        text: existing != null ? existing.taxRate.toStringAsFixed(0) : '');

    _TaxType      selTaxType    = existing?.taxType ?? _globalTaxType;
    bool          discIsPercent = existing?.discountIsPercent ?? true;
    double        previewTotal  = existing?.grandTotal ?? 0;
    _ProductInfo? selProduct    =
    existing != null ? _AgroProducts.getInfo(existing.product) : null;
    List<String>  suggestions   = [];

    void recalc(StateSetter ss) {
      final p     = double.tryParse(priceCtrl.text) ?? 0;
      final q     = int.tryParse(qtyCtrl.text) ?? 0;
      final dv    = double.tryParse(discCtrl.text) ?? 0;
      final t     = double.tryParse(taxCtrl.text) ?? 0;
      final sub   = p * q;
      final disc  = discIsPercent ? sub * dv / 100 : dv;
      final after = sub - disc;
      final total = selTaxType == _TaxType.inclusive
          ? after
          : after + after * t / 100;
      ss(() => previewTotal = total);
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
                // ── Sheet Header ─────────────────────────────────────
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [_C.primary, _C.primaryDk],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(28)),
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

                // ── Scrollable Fields ────────────────────────────────
                Expanded(
                  child: ListView(
                    controller: scrollCtrl,
                    padding: const EdgeInsets.all(20),
                    children: [

                      // ── Product Search ───────────────────────────
                      const Text('Goods & Services Description',
                          style: TextStyle(
                              color: _C.textMid,
                              fontSize: 12,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 6),
                      TextField(
                        controller: productCtrl,
                        textCapitalization: TextCapitalization.characters,
                        style: const TextStyle(
                            color: _C.textDark,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        onChanged: (val) {
                          ss(() {
                            suggestions = _AgroProducts.search(val);
                            selProduct  = null;
                          });
                          recalc(ss);
                        },
                        decoration:
                        _inputDec(hint: 'Type to search product…'),
                      ),

                      // ── Product Suggestions ──────────────────────
                      if (suggestions.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        _suggestionBox(
                          items: suggestions,
                          queryText: productCtrl.text,
                          icon: Icons.eco_rounded,
                          onSelect: (s) {
                            productCtrl.text = s;
                            productCtrl.selection =
                                TextSelection.fromPosition(
                                    TextPosition(offset: s.length));
                            ss(() {
                              suggestions = [];
                              selProduct  = _AgroProducts.getInfo(s);
                            });
                            recalc(ss);
                          },
                        ),
                      ],

                      const SizedBox(height: 14),

                      // ── Batch No ─────────────────────────────────
                      const Text('Batch No',
                          style: TextStyle(
                              color: _C.textMid,
                              fontSize: 12,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 6),
                      TextField(
                        controller: batchCtrl,
                        style: const TextStyle(
                            color: _C.textDark,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        decoration: _inputDec(hint: 'Enter batch number'),
                      ),

                      const SizedBox(height: 14),

                      // ── Price + Qty ──────────────────────────────
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  const Text('Price (₹)',
                                      style: TextStyle(
                                          color: _C.textMid,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600)),
                                  if (selProduct != null) ...[
                                    const SizedBox(width: 6),
                                    _badgeGold(
                                        'Old: ₹${selProduct!.oldPrice.toStringAsFixed(0)}'),
                                  ],
                                ]),
                                const SizedBox(height: 6),
                                TextField(
                                  controller: priceCtrl,
                                  keyboardType: TextInputType.number,
                                  onChanged: (_) => recalc(ss),
                                  style: const TextStyle(
                                      color: _C.textDark,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  decoration: _inputDec(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  const Text('Quantity',
                                      style: TextStyle(
                                          color: _C.textMid,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600)),
                                  if (selProduct != null) ...[
                                    const SizedBox(width: 6),
                                    _badgeGreen(
                                        'Stock: ${selProduct!.currentStock}'),
                                  ],
                                ]),
                                const SizedBox(height: 6),
                                TextField(
                                  controller: qtyCtrl,
                                  keyboardType: TextInputType.number,
                                  onChanged: (_) => recalc(ss),
                                  style: const TextStyle(
                                      color: _C.textDark,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  decoration: _inputDec(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      // ── Discount + Tax ───────────────────────────
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Discount',
                                    style: TextStyle(
                                        color: _C.textMid,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600)),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Container(
                                      height: 46,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6),
                                      decoration: BoxDecoration(
                                        color: _C.bg,
                                        borderRadius:
                                        BorderRadius.circular(12),
                                        border: Border.all(
                                            color: _C.border),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<bool>(
                                          value: discIsPercent,
                                          dropdownColor: _C.surface,
                                          icon: const Icon(
                                              Icons
                                                  .keyboard_arrow_down_rounded,
                                              color: _C.primary,
                                              size: 14),
                                          items: const [
                                            DropdownMenuItem(
                                              value: true,
                                              child: Text('%',
                                                  style: TextStyle(
                                                      color: _C.primary,
                                                      fontWeight:
                                                      FontWeight.w800,
                                                      fontSize: 14)),
                                            ),
                                            DropdownMenuItem(
                                              value: false,
                                              child: Text('₹',
                                                  style: TextStyle(
                                                      color: _C.primary,
                                                      fontWeight:
                                                      FontWeight.w800,
                                                      fontSize: 14)),
                                            ),
                                          ],
                                          onChanged: (val) {
                                            if (val != null) {
                                              ss(() =>
                                              discIsPercent = val);
                                              recalc(ss);
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: TextField(
                                        controller: discCtrl,
                                        keyboardType:
                                        TextInputType.number,
                                        onChanged: (_) => recalc(ss),
                                        style: const TextStyle(
                                            color: _C.textDark,
                                            fontSize: 14,
                                            fontWeight:
                                            FontWeight.w500),
                                        decoration: _inputDec(
                                            hint: discIsPercent
                                                ? '0 %'
                                                : '0 ₹'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                const Text('Tax (%)',
                                    style: TextStyle(
                                        color: _C.textMid,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600)),
                                const SizedBox(height: 6),
                                TextField(
                                  controller: taxCtrl,
                                  keyboardType: TextInputType.number,
                                  onChanged: (_) => recalc(ss),
                                  style: const TextStyle(
                                      color: _C.textDark,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  decoration: _inputDec(hint: '0'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // ── Item Total preview ────────────────────────
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: _C.primaryLt,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                              color: _C.primary.withOpacity(0.2)),
                        ),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Item Total',
                                style: TextStyle(
                                    color: _C.primary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14)),
                            Text(
                                '₹${previewTotal.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    color: _C.primary,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18)),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // ── Cancel / Add buttons ──────────────────────
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Navigator.pop(ctx),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14),
                                side: const BorderSide(
                                    color: _C.border),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(14)),
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
                                if (productCtrl.text
                                    .trim()
                                    .isEmpty) return;
                                final item = _PurchaseItem(
                                  product:
                                  productCtrl.text.trim(),
                                  batch: batchCtrl.text.trim(),
                                  price: double.tryParse(
                                      priceCtrl.text) ??
                                      0,
                                  quantity:
                                  int.tryParse(qtyCtrl.text) ??
                                      1,
                                  discountValue:
                                  double.tryParse(
                                      discCtrl.text) ??
                                      0,
                                  discountIsPercent:
                                  discIsPercent,
                                  taxRate: double.tryParse(
                                      taxCtrl.text) ??
                                      0,
                                  taxType: selTaxType,
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
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(14)),
                              ),
                              child: Text(
                                editIndex != null
                                    ? 'Update'
                                    : 'Add Item',
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
                          height: MediaQuery.of(ctx).viewInsets.bottom +
                              16),
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
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ));
  }

  void _save() {
    if (_supplierNameCtrl.text.trim().isEmpty) {
      _showSnack('Please enter Supplier Name', _C.gold);
      return;
    }
    if (_items.isEmpty) {
      _showSnack('Please add at least one item', _C.gold);
      return;
    }
    HapticFeedback.mediumImpact();

    final order = _SavedPurchase(
      id:              'PO-${DateTime.now().millisecondsSinceEpoch}',
      supplierName:    _supplierNameCtrl.text.trim(),
      supplierAddress: _supplierAddressCtrl.text.trim(),
      reference:       _referenceCtrl.text.trim(),
      date:            _selectedDate,
      items:           List.from(_items),
      purchaseType:    _purchaseType,
      gstType:         _gstType,
      globalTaxType:   _globalTaxType,
      tcsType:         _tcsType,
    );

    setState(() {
      _savedOrders.insert(0, order);
      _supplierNameCtrl.clear();
      _supplierAddressCtrl.clear();
      _referenceCtrl.clear();
      _items.clear();
      _selectedIndex       = null;
      _supplierSuggestions = [];
      _selectedDate        = DateTime.now();
      _purchaseType        = _PurchaseType.purchase;
      _gstType             = _GstType.cgstSgst;
      _globalTaxType       = _TaxType.exclusive;
      _tcsType             = _TcsType.noTcs;
      _expandedCard        = 0;
      _showViewOrders      = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(children: [
        const Icon(Icons.check_circle_rounded,
            color: Colors.white, size: 20),
        const SizedBox(width: 10),
        Flexible(
            child: Text(
                'Order saved! Total ₹${order.grandTotal.toStringAsFixed(2)}')),
      ]),
      backgroundColor: _C.primary,
      behavior: SnackBarBehavior.floating,
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ));
  }

  // ── Build ──────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              layoutBuilder: (cur, prev) => Stack(
                alignment: Alignment.topCenter,
                children: [...prev, if (cur != null) cur],
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

  // ── Header ─────────────────────────────────────────────────────────────────
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
              offset: Offset(0, 6)),
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
                    constraints: const BoxConstraints(
                        minWidth: 40, minHeight: 40),
                    padding: const EdgeInsets.all(8),
                  ),
                  const Expanded(
                    child: Text('Purchase Order',
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
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    _tab(
                        label: 'New Order',
                        icon: Icons.add_circle_outline_rounded,
                        active: !_showViewOrders,
                        onTap: () =>
                            setState(() => _showViewOrders = false)),
                    _tab(
                        label: 'View Orders',
                        icon: Icons.list_alt_rounded,
                        active: _showViewOrders,
                        onTap: () =>
                            setState(() => _showViewOrders = true)),
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
          height: double.infinity,
          decoration: BoxDecoration(
            color: active ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
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
              Icon(icon,
                  size: 16,
                  color: active
                      ? _C.primary
                      : Colors.white.withOpacity(0.75)),
              const SizedBox(width: 6),
              Text(label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight:
                    active ? FontWeight.w700 : FontWeight.w500,
                    color: active
                        ? _C.primary
                        : Colors.white.withOpacity(0.75),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  // ── Order Form ─────────────────────────────────────────────────────────────
  Widget _buildOrderForm() {
    return SingleChildScrollView(
      key: const ValueKey('form'),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAccordionCard(
            index: 0,
            icon: Icons.tune_rounded,
            title: 'Order Types',
            child: _buildOrderTypesContent(),
          ),
          const SizedBox(height: 10),
          _buildAccordionCard(
            index: 1,
            icon: Icons.store_rounded,
            title: 'Supplier Details',
            child: _buildSupplierContent(),
          ),
          const SizedBox(height: 10),
          _buildAccordionCard(
            index: 2,
            icon: Icons.calendar_month_rounded,
            title: 'Date & Reference',
            child: _buildDateRefContent(),
          ),
          const SizedBox(height: 16),
          _buildAddBar(),
          const SizedBox(height: 12),
          if (_items.isNotEmpty) ...[
            _buildItemsCards(),
            const SizedBox(height: 12),
            _buildSummaryCard(),
            const SizedBox(height: 16),
          ],
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ── Accordion Card ─────────────────────────────────────────────────────────
  Widget _buildAccordionCard({
    required int index,
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    final isOpen = _expandedCard == index;
    return Container(
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 16,
              offset: const Offset(0, 4)),
        ],
        border: isOpen
            ? Border.all(
            color: _C.primary.withOpacity(0.25), width: 1.2)
            : Border.all(color: Colors.transparent, width: 1.2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => _toggleCard(index),
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 14, 14, 14),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isOpen ? _C.primary : _C.primaryLt,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icon,
                        color: isOpen ? Colors.white : _C.primary,
                        size: 18),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(title,
                        style: TextStyle(
                          color: _C.textDark,
                          fontSize: 15,
                          fontWeight: isOpen
                              ? FontWeight.w800
                              : FontWeight.w700,
                        )),
                  ),
                  AnimatedRotation(
                    turns: isOpen ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 280),
                    curve: Curves.easeInOut,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: isOpen
                            ? _C.primary.withOpacity(0.08)
                            : _C.bg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: isOpen ? _C.primary : _C.textMid,
                          size: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: isOpen
                ? Padding(
              padding:
              const EdgeInsets.fromLTRB(18, 0, 18, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(height: 1, color: _C.border),
                  const SizedBox(height: 16),
                  child,
                ],
              ),
            )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  // ── Order Types Content ───────────────────────────────────────────────────
  Widget _buildOrderTypesContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _TypeDropdown<_PurchaseType>(
                label: 'Types',
                value: _purchaseType,
                items: const [
                  DropdownMenuItem(
                    value: _PurchaseType.purchase,
                    child: Row(children: [
                      Icon(Icons.shopping_cart_rounded,
                          color: _C.primary, size: 14),
                      SizedBox(width: 6),
                      Text('Purchase'),
                    ]),
                  ),
                  DropdownMenuItem(
                    value: _PurchaseType.purchaseReturn,
                    child: Row(children: [
                      Icon(Icons.assignment_return_rounded,
                          color: _C.red, size: 14),
                      SizedBox(width: 6),
                      Text('Return'),
                    ]),
                  ),
                ],
                onChanged: (v) {
                  if (v != null) setState(() => _purchaseType = v);
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _TypeDropdown<_GstType>(
                label: 'GST Type',
                value: _gstType,
                items: const [
                  DropdownMenuItem(
                      value: _GstType.cgstSgst,
                      child: Text('CGST/SGST')),
                  DropdownMenuItem(
                      value: _GstType.igst, child: Text('IGST')),
                ],
                onChanged: (v) {
                  if (v != null) setState(() => _gstType = v);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _TypeDropdown<_TaxType>(
                label: 'Tax Inclusion',
                value: _globalTaxType,
                items: const [
                  DropdownMenuItem(
                      value: _TaxType.exclusive,
                      child: Text('Exclude Tax')),
                  DropdownMenuItem(
                      value: _TaxType.inclusive,
                      child: Text('Include Tax')),
                ],
                onChanged: (v) {
                  if (v != null)
                    setState(() => _globalTaxType = v);
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _TypeDropdown<_TcsType>(
                label: 'TCS',
                value: _tcsType,
                items: const [
                  DropdownMenuItem(
                      value: _TcsType.noTcs,
                      child: Text('No TCS')),
                  DropdownMenuItem(
                      value: _TcsType.tcs01,
                      child: Text('TCS 0.1%')),
                  DropdownMenuItem(
                      value: _TcsType.tcs1,
                      child: Text('TCS 1%')),
                ],
                onChanged: (v) {
                  if (v != null) setState(() => _tcsType = v);
                },
              ),
            ),
          ],
        ),
        if (_purchaseType == _PurchaseType.purchaseReturn) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: _C.red.withOpacity(0.07),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _C.red.withOpacity(0.3)),
            ),
            child: const Row(children: [
              Icon(Icons.assignment_return_rounded,
                  color: _C.red, size: 14),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Purchase Return — items will be credited back to supplier.',
                  style: TextStyle(
                      color: _C.red,
                      fontSize: 11,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ]),
          ),
        ],
      ],
    );
  }

  // ── Supplier Content ──────────────────────────────────────────────────────
  Widget _buildSupplierContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _FieldLabel(label: 'Supplier Name'),
        const SizedBox(height: 6),
        TextField(
          controller: _supplierNameCtrl,
          focusNode: _supplierFocus,
          textCapitalization: TextCapitalization.characters,
          style: const TextStyle(
              color: _C.textDark,
              fontSize: 15,
              fontWeight: FontWeight.w500),
          onChanged: (val) => setState(
                  () => _supplierSuggestions = _SupplierNames.search(val)),
          decoration: InputDecoration(
            hintText: 'Search or enter supplier name',
            hintStyle:
            const TextStyle(color: _C.textLight, fontSize: 14),
            filled: true,
            fillColor: _C.bg,
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 14),
            suffixIcon: _supplierNameCtrl.text.isNotEmpty
                ? IconButton(
              icon: const Icon(Icons.clear,
                  color: _C.textLight, size: 18),
              onPressed: () => setState(() {
                _supplierNameCtrl.clear();
                _supplierSuggestions = [];
              }),
            )
                : null,
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
          _suggestionBox(
            items: _supplierSuggestions,
            queryText: _supplierNameCtrl.text,
            icon: Icons.store_rounded,
            onSelect: (s) => setState(() {
              _supplierNameCtrl.text = s;
              _supplierNameCtrl.selection =
                  TextSelection.fromPosition(
                      TextPosition(offset: s.length));
              _supplierSuggestions = [];
              _supplierFocus.unfocus();
            }),
          ),
        ],
        const SizedBox(height: 14),
        const _FieldLabel(label: 'Supplier Address'),
        const SizedBox(height: 6),
        _InputField(
          controller: _supplierAddressCtrl,
          hint: 'Enter supplier address',
          maxLines: 2,
        ),
      ],
    );
  }

  // ── Date & Reference Content ──────────────────────────────────────────────
  Widget _buildDateRefContent() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _FieldLabel(label: 'Date'),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: _pickDate,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 14),
                  decoration: BoxDecoration(
                    color: _C.bg,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: _C.border),
                  ),
                  child: Row(children: [
                    const Icon(Icons.calendar_month_rounded,
                        color: _C.primary, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      DateFormat('dd-MM-yyyy')
                          .format(_selectedDate),
                      style: const TextStyle(
                          color: _C.textDark,
                          fontSize: 10,
                          fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: _C.textMid,
                        size: 18),
                  ]),
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
              const _FieldLabel(label: 'Ref / Invoice No'),
              const SizedBox(height: 6),
              _InputField(
                  controller: _referenceCtrl,
                  hint: 'Enter invoice no'),
            ],
          ),
        ),
      ],
    );
  }

  // ── Add Bar ────────────────────────────────────────────────────────────────
  Widget _buildAddBar() {
    return Container(
      padding:
      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
      child: Row(children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: _C.primaryLt,
              borderRadius: BorderRadius.circular(10)),
          child: const Icon(Icons.shopping_cart_rounded,
              color: _C.primary, size: 18),
        ),
        const SizedBox(width: 10),
        const Text('Order Items',
            style: TextStyle(
                color: _C.textDark,
                fontSize: 15,
                fontWeight: FontWeight.w700)),
        if (_items.isNotEmpty) ...[
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
                color: _C.primaryLt,
                borderRadius: BorderRadius.circular(20)),
            child: Text('${_items.length}',
                style: const TextStyle(
                    color: _C.primary,
                    fontSize: 11,
                    fontWeight: FontWeight.w700)),
          ),
        ],
        const Spacer(),
        GestureDetector(
          onTap: () => _showItemSheet(),
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: _C.primaryLt,
                borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.add_rounded,
                color: _C.primary, size: 16),
          ),
        ),
      ]),
    );
  }

  // ── Items Cards ────────────────────────────────────────────────────────────
  Widget _buildItemsCards() {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(children: [
              const Text('Items',
                  style: TextStyle(
                      color: _C.textDark,
                      fontSize: 14,
                      fontWeight: FontWeight.w700)),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                    color: _C.primaryLt,
                    borderRadius: BorderRadius.circular(20)),
                child: Text('${_items.length}',
                    style: const TextStyle(
                        color: _C.primary,
                        fontSize: 11,
                        fontWeight: FontWeight.w700)),
              ),
            ]),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _items.length,
            separatorBuilder: (_, __) => Divider(
                height: 1,
                indent: 16,
                endIndent: 16,
                color: _C.border),
            itemBuilder: (_, i) => _buildItemCard(_items[i], i),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  // ── Single Item Card ───────────────────────────────────────────────────────
  Widget _buildItemCard(_PurchaseItem item, int i) {
    final isReturn =
        _purchaseType == _PurchaseType.purchaseReturn;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
      decoration: BoxDecoration(
        color: _C.bg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _C.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Row 1: Number + Product name + Price + tax badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 24, height: 24,
                decoration: BoxDecoration(
                  color: isReturn
                      ? _C.red.withOpacity(0.12)
                      : _C.primary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Center(
                  child: Text('${i + 1}',
                      style: TextStyle(
                          color: isReturn ? _C.red : _C.primary,
                          fontSize: 11,
                          fontWeight: FontWeight.w800)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  item.product,
                  style: const TextStyle(
                      color: _C.textDark,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      height: 1.3),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '₹${item.grandTotal.toStringAsFixed(2)}',
                      style: TextStyle(
                          color: isReturn ? _C.red : _C.primary,
                          fontSize: 15,
                          fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 3),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: item.taxType == _TaxType.inclusive
                              ? const Color(0xFFE8F5ED)
                              : const Color(0xFFFFF3CD),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          item.taxType == _TaxType.inclusive
                              ? 'incl. tax'
                              : 'excl. tax',
                          style: TextStyle(
                            color: item.taxType == _TaxType.inclusive
                                ? _C.primary
                                : _C.gold,
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Row 2: Batch number
          if (item.batch.isNotEmpty) ...[
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 32),
              child: Row(
                children: [
                  const Icon(Icons.qr_code_rounded,
                      color: _C.textMid, size: 11),
                  const SizedBox(width: 4),
                  Text(
                    'Batch: ${item.batch}',
                    style: const TextStyle(
                        color: _C.textMid,
                        fontSize: 11,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],

          // Row 3: Action chips
          const SizedBox(height: 10),
          Row(
            children: [
              GestureDetector(
                onTap: () =>
                    _showItemSheet(existing: item, editIndex: i),
                child: Container(
                  width: 28, height: 28,
                  decoration: BoxDecoration(
                    color: _C.primaryLt,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: _C.primary.withOpacity(0.3)),
                  ),
                  child: const Icon(Icons.edit_rounded,
                      color: _C.primary, size: 14),
                ),
              ),
              const SizedBox(width: 3),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _chip(
                          '₹${item.price.toStringAsFixed(0)}'),
                      const SizedBox(width: 3),
                      _chip('×${item.quantity}'),
                      if (item.discountValue > 0) ...[
                        const SizedBox(width: 3),
                        _chip(
                          item.discountIsPercent
                              ? '${item.discountValue.toStringAsFixed(0)}%off'
                              : '₹${item.discountValue.toStringAsFixed(0)} off',
                          isGold: true,
                        ),
                      ],
                      const SizedBox(width: 3),
                      _chip(
                          '${item.taxRate.toStringAsFixed(0)}%tax'),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 4),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _items.removeAt(i);
                    _selectedIndex = null;
                  });
                },
                child: Container(
                  width: 28, height: 28,
                  decoration: BoxDecoration(
                    color: _C.red.withOpacity(0.08),
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: _C.red.withOpacity(0.35)),
                  ),
                  child: const Icon(Icons.delete_outline_rounded,
                      color: _C.red, size: 14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Chip helper ────────────────────────────────────────────────────────────
  static Widget _chip(String label, {bool isGold = false}) {
    return Container(
      padding:
      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isGold ? const Color(0xFFFFF3CD) : _C.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: isGold
                ? _C.gold.withOpacity(0.5)
                : _C.border),
      ),
      child: Text(
        label,
        style: TextStyle(
            color: isGold ? _C.gold : _C.textDark,
            fontSize: 11,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  // ── Summary Card ───────────────────────────────────────────────────────────
  Widget _buildSummaryCard() {
    double tcsAmount = 0;
    if (_tcsType == _TcsType.tcs01) tcsAmount = _grandTotal * 0.001;
    if (_tcsType == _TcsType.tcs1)  tcsAmount = _grandTotal * 0.01;
    final netTotal = _grandTotal + tcsAmount;

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
          Row(children: [
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
          ]),
          const SizedBox(height: 16),
          _SummaryRow(
              'Subtotal', '₹${_subTotal.toStringAsFixed(2)}'),
          if (_discTotal > 0)
            _SummaryRow('Discount',
                '− ₹${_discTotal.toStringAsFixed(2)}',
                isRed: true),
          _SummaryRow('Tax', '₹${_taxTotal.toStringAsFixed(2)}'),
          if (tcsAmount > 0)
            _SummaryRow(
              _tcsType == _TcsType.tcs01
                  ? 'TCS @0.1%'
                  : 'TCS @1%',
              '₹${tcsAmount.toStringAsFixed(2)}',
            ),
          const Divider(height: 20, color: _C.border),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Grand Total',
                  style: TextStyle(
                      color: _C.textDark,
                      fontSize: 15,
                      fontWeight: FontWeight.w700)),
              Text('₹${netTotal.toStringAsFixed(2)}',
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

  // ── Bottom Bar ─────────────────────────────────────────────────────────────
  Widget _buildBottomBar() {
    final isReturn =
        _purchaseType == _PurchaseType.purchaseReturn;
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isReturn
                  ? [_C.red, const Color(0xFFB91C1C)]
                  : [_C.primary, _C.primaryDk],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: (isReturn ? _C.red : _C.primary)
                    .withOpacity(0.45),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _save,
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'TOTAL AMOUNT',
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 2),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '₹${_grandTotal.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                            color: Colors.white.withOpacity(0.35),
                            width: 1),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isReturn
                                ? Icons.assignment_return_rounded
                                : Icons.save_rounded,
                            color: Colors.white,
                            size: 17,
                          ),
                          const SizedBox(width: 7),
                          Text(
                            isReturn
                                ? 'SAVE RETURN'
                                : 'SAVE ORDER',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── View Orders ────────────────────────────────────────────────────────────
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
                style:
                TextStyle(color: _C.textMid, fontSize: 14)),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () =>
                  setState(() => _showViewOrders = false),
              icon: const Icon(Icons.add_rounded,
                  color: Colors.white, size: 18),
              label: const Text('Create Order',
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

  Widget _buildOrderCard(_SavedPurchase order, int index) {
    final isReturn =
        order.purchaseType == _PurchaseType.purchaseReturn;
    final typeLabel  = isReturn ? 'Purchase Return' : 'Purchase';
    final gstLabel   =
    order.gstType == _GstType.cgstSgst ? 'CGST/SGST' : 'IGST';

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
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isReturn
                      ? [_C.red, const Color(0xFFB91C1C)]
                      : [_C.primary, _C.primaryDk],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Row(children: [
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
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w700)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(order.supplierName,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                      overflow: TextOverflow.ellipsis),
                ),
                Text(DateFormat('dd MMM yyyy').format(order.date),
                    style: const TextStyle(
                        color: Colors.white70, fontSize: 10)),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(spacing: 6, runSpacing: 6, children: [
                    _Tag(label: typeLabel, isRed: isReturn),
                    _Tag(label: gstLabel),
                    _Tag(
                        label: order.globalTaxType ==
                            _TaxType.exclusive
                            ? 'Excl. Tax'
                            : 'Incl. Tax'),
                    if (order.tcsType != _TcsType.noTcs)
                      _Tag(
                          label: order.tcsType == _TcsType.tcs01
                              ? 'TCS 0.1%'
                              : 'TCS 1%',
                          isGold: true),
                  ]),
                  if (order.supplierAddress.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Row(children: [
                      const Icon(Icons.location_on_rounded,
                          color: _C.textMid, size: 13),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(order.supplierAddress,
                            style: const TextStyle(
                                color: _C.textMid,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ]),
                  ],
                  if (order.reference.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Row(children: [
                      const Icon(Icons.tag_rounded,
                          color: _C.textMid, size: 13),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text('Ref: ${order.reference}',
                            style: const TextStyle(
                                color: _C.textMid,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis),
                      ),
                    ]),
                  ],
                  const SizedBox(height: 12),
                  Row(children: [
                    _StatBox(
                        label: 'Items',
                        value: '${order.items.length}',
                        icon: Icons.list_rounded),
                    const SizedBox(width: 8),
                    _StatBox(
                        label: 'Tax',
                        value:
                        '₹${order.taxTotal.toStringAsFixed(0)}',
                        icon: Icons.percent_rounded),
                    if (order.discTotal > 0) ...[
                      const SizedBox(width: 8),
                      _StatBox(
                          label: 'Discount',
                          value:
                          '₹${order.discTotal.toStringAsFixed(0)}',
                          icon: Icons.discount_rounded),
                    ],
                  ]),
                  const SizedBox(height: 12),
                  ...order.items.take(2).map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(children: [
                      Container(
                        width: 6, height: 6,
                        decoration: BoxDecoration(
                            color: isReturn
                                ? _C.red
                                : _C.primary,
                            shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(item.product,
                                style: const TextStyle(
                                    color: _C.textDark,
                                    fontSize: 12,
                                    fontWeight:
                                    FontWeight.w500),
                                maxLines: 1,
                                overflow:
                                TextOverflow.ellipsis),
                            if (item.batch.isNotEmpty)
                              Text('Batch: ${item.batch}',
                                  style: const TextStyle(
                                      color: _C.textMid,
                                      fontSize: 10,
                                      fontWeight:
                                      FontWeight.w400)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                          '₹${item.grandTotal.toStringAsFixed(2)}',
                          style: const TextStyle(
                              color: _C.textDark,
                              fontSize: 12,
                              fontWeight: FontWeight.w700)),
                    ]),
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
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Grand Total',
                          style: TextStyle(
                              color: _C.textMid,
                              fontSize: 13,
                              fontWeight: FontWeight.w600)),
                      Text(
                          '₹${order.grandTotal.toStringAsFixed(2)}',
                          style: TextStyle(
                              color:
                              isReturn ? _C.red : _C.primary,
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
}

// ══════════════════════════════════════════════════════════════════════════════
//  Reusable Widgets
// ══════════════════════════════════════════════════════════════════════════════

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
  final int maxLines;
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
    style: const TextStyle(
        color: _C.textDark,
        fontSize: 15,
        fontWeight: FontWeight.w500),
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
          color: _C.textLight, fontSize: 14),
      filled: true,
      fillColor: _C.bg,
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
  );
}

class _TypeDropdown<T> extends StatelessWidget {
  final String label;
  final T value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
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
          style: const TextStyle(
              color: _C.textMid,
              fontSize: 12,
              fontWeight: FontWeight.w600)),
      const SizedBox(height: 6),
      Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 12, vertical: 2),
        decoration: BoxDecoration(
          color: _C.bg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _C.border),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            value: value,
            isExpanded: true,
            icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: _C.primary,
                size: 18),
            dropdownColor: _C.surface,
            style: const TextStyle(
                color: _C.textDark,
                fontSize: 13,
                fontWeight: FontWeight.w600),
            items: items,
            onChanged: onChanged,
          ),
        ),
      ),
    ],
  );
}

class _SummaryRow extends StatelessWidget {
  final String label, value;
  final bool isRed;
  const _SummaryRow(this.label, this.value, {this.isRed = false});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(
                color: _C.textMid,
                fontSize: 13,
                fontWeight: FontWeight.w500)),
        Text(value,
            style: TextStyle(
                color: isRed ? _C.red : _C.textDark,
                fontSize: 13,
                fontWeight: FontWeight.w700)),
      ],
    ),
  );
}

class _StatBox extends StatelessWidget {
  final String   label;
  final String   value;
  final IconData icon;
  const _StatBox(
      {required this.label, required this.value, required this.icon});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
            color: _C.primaryLt,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: _C.primary, size: 13),
            const SizedBox(width: 5),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(value,
                      style: const TextStyle(
                          color: _C.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.w800),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1),
                  Text(label,
                      style: const TextStyle(
                          color: _C.textMid,
                          fontSize: 10,
                          fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  final bool   isRed;
  final bool   isGold;
  const _Tag(
      {required this.label, this.isRed = false, this.isGold = false});
  @override
  Widget build(BuildContext context) {
    final bgColor = isRed
        ? _C.red.withOpacity(0.08)
        : isGold
        ? const Color(0xFFFFF3CD)
        : _C.primaryLt;
    final borderColor = isRed
        ? _C.red.withOpacity(0.3)
        : isGold
        ? _C.gold.withOpacity(0.4)
        : _C.primary.withOpacity(0.2);
    final textColor =
    isRed ? _C.red : isGold ? _C.gold : _C.primary;
    return Container(
      padding:
      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: borderColor),
      ),
      child: Text(label,
          style: TextStyle(
              color: textColor,
              fontSize: 11,
              fontWeight: FontWeight.w600)),
    );
  }
}