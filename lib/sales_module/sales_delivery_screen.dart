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
  static const blue      = Color(0xFF1565C0);
}

// ── Product Info with Price & Stock ────────────────────────────────────────
class ProductInfo {
  final String name;
  final double oldPrice;
  final int    currentStock;

  ProductInfo({
    required this.name,
    required this.oldPrice,
    required this.currentStock,
  });
}

// ── Product Database ──────────────────────────────────────────────────────
final Map<String, ProductInfo> productDatabase = {
  'AACHI HYBRID TOMATO SEEDS 10G': ProductInfo(name: 'AACHI HYBRID TOMATO SEEDS 10G', oldPrice: 85.00, currentStock: 45),
  'AADHI PADDY SEEDS 5 KGS': ProductInfo(name: 'AADHI PADDY SEEDS 5 KGS', oldPrice: 320.00, currentStock: 120),
  'AADHI PADDY SEEDS 10 KGS': ProductInfo(name: 'AADHI PADDY SEEDS 10 KGS', oldPrice: 620.00, currentStock: 80),
  'AARTHY HYBRID CHILLI SEEDS 10G': ProductInfo(name: 'AARTHY HYBRID CHILLI SEEDS 10G', oldPrice: 95.00, currentStock: 60),
  'AARTHY HYBRID CHILLI SEEDS 25G': ProductInfo(name: 'AARTHY HYBRID CHILLI SEEDS 25G', oldPrice: 220.00, currentStock: 40),
  'ADITYA HYBRID MAIZE SEEDS 1 KGS': ProductInfo(name: 'ADITYA HYBRID MAIZE SEEDS 1 KGS', oldPrice: 180.00, currentStock: 75),
  'ADITYA HYBRID MAIZE SEEDS 5 KGS': ProductInfo(name: 'ADITYA HYBRID MAIZE SEEDS 5 KGS', oldPrice: 850.00, currentStock: 35),
  'AGNI HYBRID COTTON SEEDS 450G': ProductInfo(name: 'AGNI HYBRID COTTON SEEDS 450G', oldPrice: 420.00, currentStock: 25),
  'AGNI HYBRID COTTON SEEDS 900G': ProductInfo(name: 'AGNI HYBRID COTTON SEEDS 900G', oldPrice: 810.00, currentStock: 18),
  'AGRI GOLD PADDY SEEDS 5 KGS': ProductInfo(name: 'AGRI GOLD PADDY SEEDS 5 KGS', oldPrice: 310.00, currentStock: 100),
  'AGRI GOLD PADDY SEEDS 26 KGS': ProductInfo(name: 'AGRI GOLD PADDY SEEDS 26 KGS', oldPrice: 1550.00, currentStock: 15),
  'HYBRID TOMATO SEEDS 10G': ProductInfo(name: 'HYBRID TOMATO SEEDS 10G', oldPrice: 90.00, currentStock: 55),
  'HYBRID TOMATO SEEDS 50G': ProductInfo(name: 'HYBRID TOMATO SEEDS 50G', oldPrice: 380.00, currentStock: 30),
  'HYBRID CHILLI SEEDS 10G': ProductInfo(name: 'HYBRID CHILLI SEEDS 10G', oldPrice: 100.00, currentStock: 65),
  'HYBRID CHILLI SEEDS 25G': ProductInfo(name: 'HYBRID CHILLI SEEDS 25G', oldPrice: 240.00, currentStock: 45),
  'HYBRID MAIZE SEEDS 1 KGS': ProductInfo(name: 'HYBRID MAIZE SEEDS 1 KGS', oldPrice: 190.00, currentStock: 80),
  'HYBRID MAIZE SEEDS 5 KGS': ProductInfo(name: 'HYBRID MAIZE SEEDS 5 KGS', oldPrice: 900.00, currentStock: 40),
  'HYBRID PADDY SEEDS 5 KGS': ProductInfo(name: 'HYBRID PADDY SEEDS 5 KGS', oldPrice: 330.00, currentStock: 110),
  'HYBRID PADDY SEEDS 26 KGS': ProductInfo(name: 'HYBRID PADDY SEEDS 26 KGS', oldPrice: 1620.00, currentStock: 20),
  'HYBRID ONION SEEDS 100G': ProductInfo(name: 'HYBRID ONION SEEDS 100G', oldPrice: 450.00, currentStock: 35),
  'HYBRID ONION SEEDS 500G': ProductInfo(name: 'HYBRID ONION SEEDS 500G', oldPrice: 2100.00, currentStock: 12),
  'UREA 50 KGS': ProductInfo(name: 'UREA 50 KGS', oldPrice: 650.00, currentStock: 200),
  'DAP 50 KGS': ProductInfo(name: 'DAP 50 KGS', oldPrice: 1200.00, currentStock: 150),
  'NPK 19-19-19 5 KGS': ProductInfo(name: 'NPK 19-19-19 5 KGS', oldPrice: 580.00, currentStock: 90),
  'MANCOZEB 75% WP 1 KGS': ProductInfo(name: 'MANCOZEB 75% WP 1 KGS', oldPrice: 320.00, currentStock: 55),
  'IMIDACLOPRID 17.8% SL 1 LTR': ProductInfo(name: 'IMIDACLOPRID 17.8% SL 1 LTR', oldPrice: 480.00, currentStock: 40),
};

// ── Supplier Autocomplete Names (A–Z) ──────────────────────────────────────
class SupplierNames {
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

  static List<String> search(String query) {
    if (query.trim().isEmpty) return [];
    final q = query.toUpperCase().trim();
    return all.where((p) => p.contains(q)).take(30).toList();
  }
}

// ── Enums ──────────────────────────────────────────────────────────────────
enum TaxType    { inclusive, exclusive }
enum OrderType  { wholesaleBB, retailBC, wholesaleBC }
enum GstType    { cgstSgst, igst }
enum TcsType    { noTcs, tcs01, tcs1 }

// ── Data model ─────────────────────────────────────────────────────────────
class OrderItem {
  String  product;
  double  price;
  int     quantity;
  double  discountValue;
  bool    discountIsPercent;
  double  taxRate;
  TaxType taxType;
  var     batch;

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
  final String          supplierAddress;
  final String          reference;
  final DateTime        date;
  final List<OrderItem> items;
  final OrderType       orderType;
  final GstType         gstType;
  final TaxType         globalTaxType;
  final TcsType         tcsType;

  SavedOrder({
    required this.id,
    required this.supplierName,
    required this.supplierAddress,
    required this.reference,
    required this.date,
    required this.items,
    required this.orderType,
    required this.gstType,
    required this.globalTaxType,
    required this.tcsType,
  });

  double get subtotal   => items.fold(0, (s, i) => s + i.subtotal);
  double get discTotal  => items.fold(0, (s, i) => s + i.discountAmount);
  double get taxTotal   => items.fold(0, (s, i) => s + i.taxAmount);
  double get grandTotal => items.fold(0, (s, i) => s + i.grandTotal);
}

// ── Collapsible Section Card ───────────────────────────────────────────────
class _CollapsibleCard extends StatefulWidget {
  final IconData   icon;
  final String     title;
  final Widget     child;
  final bool       initiallyExpanded;

  const _CollapsibleCard({
    required this.icon,
    required this.title,
    required this.child,
    this.initiallyExpanded = true,
  });

  @override
  State<_CollapsibleCard> createState() => _CollapsibleCardState();
}

class _CollapsibleCardState extends State<_CollapsibleCard>
    with SingleTickerProviderStateMixin {
  late bool _expanded;
  late AnimationController _ctrl;
  late Animation<double>   _rotate;
  late Animation<double>   _fade;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
      value: _expanded ? 1.0 : 0.0,
    );
    _rotate = Tween<double>(begin: 0.0, end: 0.5).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _expanded = !_expanded);
    if (_expanded) {
      _ctrl.forward();
    } else {
      _ctrl.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          // ── Header row (always visible) ──────────────────────────
          InkWell(
            onTap: _toggle,
            borderRadius: _expanded
                ? const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )
                : BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _C.primaryLt,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(widget.icon, color: _C.primary, size: 18),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        color: _C.textDark,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  RotationTransition(
                    turns: _rotate,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: _C.primaryLt,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: _C.primary,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // ── Animated body ─────────────────────────────────────────
          SizeTransition(
            sizeFactor: _fade,
            axisAlignment: -1,
            child: FadeTransition(
              opacity: _fade,
              child: Column(
                children: [
                  Divider(height: 1, color: _C.border.withOpacity(0.7)),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
                    child: widget.child,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Main Screen ────────────────────────────────────────────────────────────
class SalesDeliveryScreen extends StatefulWidget {
  const SalesDeliveryScreen({super.key});
  @override
  State<SalesDeliveryScreen> createState() => _SalesDeliveryScreenState();
}

class _SalesDeliveryScreenState extends State<SalesDeliveryScreen>
    with TickerProviderStateMixin {

  bool _showViewOrders = false;

  final _supplierNameCtrl    = TextEditingController();
  final _supplierAddressCtrl = TextEditingController();
  final _referenceCtrl       = TextEditingController();

  OrderType _orderType     = OrderType.wholesaleBB;
  GstType   _gstType       = GstType.cgstSgst;
  TaxType   _globalTaxType = TaxType.exclusive;
  TcsType   _tcsType       = TcsType.noTcs;

  DateTime        _selectedDate        = DateTime.now();
  List<OrderItem> _items               = [];
  int?            _selectedIndex;
  List<String>    _supplierSuggestions = [];
  final _supplierFocus = FocusNode();

  final List<SavedOrder> _savedOrders = [];

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
    ProductInfo? selectedProduct;

    void recalc(StateSetter ss) {
      final p     = double.tryParse(priceCtrl.text) ?? 0;
      final q     = int.tryParse(qtyCtrl.text) ?? 0;
      final dv    = double.tryParse(discCtrl.text) ?? 0;
      final t     = double.tryParse(taxCtrl.text) ?? 0;
      final sub   = p * q;
      final disc  = discIsPercent ? sub * dv / 100 : dv;
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
                        // ── Product search ─────────────────────────────
                        const Text('Goods & Services Description',
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
                            ss(() {
                              suggestions = AgroProducts.search(val);
                              selectedProduct = null;
                            });
                            recalc(ss);
                          },
                          decoration: InputDecoration(
                            hintText: 'Type to search product…',
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
                                  final s     = suggestions[i];
                                  final query =
                                  productCtrl.text.toUpperCase().trim();
                                  final idx   = s.indexOf(query);
                                  return InkWell(
                                    onTap: () {
                                      productCtrl.text = s;
                                      productCtrl.selection =
                                          TextSelection.fromPosition(
                                              TextPosition(offset: s.length));
                                      ss(() {
                                        suggestions = [];
                                        selectedProduct = productDatabase[s];
                                      });
                                      recalc(ss);
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
                                                      color: _C.textMid,
                                                      fontSize: 13,
                                                      fontWeight:
                                                      FontWeight.w500),
                                                ),
                                                TextSpan(
                                                  text: s.substring(
                                                      idx,
                                                      idx + query.length),
                                                  style: const TextStyle(
                                                      color: _C.primary,
                                                      fontSize: 13,
                                                      fontWeight:
                                                      FontWeight.w800,
                                                      backgroundColor:
                                                      Color(0xFFE8F5ED)),
                                                ),
                                                TextSpan(
                                                  text: s.substring(
                                                      idx + query.length),
                                                  style: const TextStyle(
                                                      color: _C.textMid,
                                                      fontSize: 13,
                                                      fontWeight:
                                                      FontWeight.w500),
                                                ),
                                              ]),
                                            )
                                                : Text(s,
                                                style: const TextStyle(
                                                    color: _C.textDark,
                                                    fontSize: 13,
                                                    fontWeight:
                                                    FontWeight.w500)),
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

                        // ── Product Info Card (Old Price + Stock) ─────
                        if (selectedProduct != null) ...[
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEFF8F3),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                  color: _C.primary.withOpacity(0.25)),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: _C.primary.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(Icons.inventory_rounded,
                                      color: _C.primary, size: 18),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Old Price: ₹${selectedProduct!.oldPrice.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                              color: _C.textMid, fontSize: 12,
                                              fontWeight: FontWeight.w500)),
                                      const SizedBox(height: 4),
                                      Text('Current Stock: ${selectedProduct!.currentStock} units',
                                          style: const TextStyle(
                                              color: _C.primary, fontSize: 13,
                                              fontWeight: FontWeight.w700)),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ],
                        const SizedBox(height: 14),

                        // ── Batch No field ─────────────────────────────
                        _DialogField(
                          label: 'Batch No',
                          controller: batchCtrl,
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 14),

                        // ── Price & Qty ────────────────────────────────
                        Row(
                          children: [
                            Expanded(child: _DialogField(
                              label: 'Price (₹)', controller: priceCtrl,
                              keyboardType: TextInputType.number,
                              onChanged: (_) => recalc(ss),
                            )),
                            const SizedBox(width: 12),
                            Expanded(child: _DialogField(
                              label: 'Quantity', controller: qtyCtrl,
                              keyboardType: TextInputType.number,
                              onChanged: (_) => recalc(ss),
                            )),
                          ],
                        ),
                        const SizedBox(height: 14),
                        // ── Discount ───────────────────────────────────
                        const Text('Discount',
                            style: TextStyle(
                                color: _C.textMid, fontSize: 12,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Container(
                              height: 46,
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              decoration: BoxDecoration(
                                color: _C.bg,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: _C.border),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<bool>(
                                  value: discIsPercent,
                                  dropdownColor: _C.surface,
                                  icon: const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: _C.primary, size: 16),
                                  items: const [
                                    DropdownMenuItem(
                                      value: true,
                                      child: Text('%', style: TextStyle(
                                          color: _C.primary,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 15)),
                                    ),
                                    DropdownMenuItem(
                                      value: false,
                                      child: Text('₹', style: TextStyle(
                                          color: _C.primary,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 15)),
                                    ),
                                  ],
                                  onChanged: (val) {
                                    if (val != null) {
                                      ss(() => discIsPercent = val);
                                      recalc(ss);
                                    }
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                controller: discCtrl,
                                keyboardType: TextInputType.number,
                                onChanged: (_) => recalc(ss),
                                style: const TextStyle(
                                    color: _C.textDark, fontSize: 14,
                                    fontWeight: FontWeight.w500),
                                decoration: InputDecoration(
                                  hintText:
                                  discIsPercent ? '0.00 %' : '0.00 ₹',
                                  hintStyle: const TextStyle(
                                      color: _C.textLight, fontSize: 12),
                                  filled: true, fillColor: _C.bg,
                                  contentPadding:
                                  const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 12),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                          color: _C.border)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                          color: _C.border)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                          color: _C.primary, width: 1.5)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        // ── Tax % ───────────────────────────────────────
                        _DialogField(
                          label: 'Tax (%)',
                          controller: taxCtrl,
                          keyboardType: TextInputType.number,
                          onChanged: (_) => recalc(ss),
                        ),
                        const SizedBox(height: 14),
                        // ── Item Total preview ─────────────────────────
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Item Total',
                                  style: TextStyle(
                                      color: _C.primary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14)),
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
                  // ── Dialog Buttons ─────────────────────────────────
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
                                discountValue:     double.tryParse(discCtrl.text) ?? 0,
                                discountIsPercent: discIsPercent,
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
      supplierAddress: _supplierAddressCtrl.text.trim(),
      reference:       _referenceCtrl.text.trim(),
      date:            _selectedDate,
      items:           List.from(_items),
      orderType:       _orderType,
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
      _orderType           = OrderType.wholesaleBB;
      _gstType             = GstType.cgstSgst;
      _globalTaxType       = TaxType.exclusive;
      _tcsType             = TcsType.noTcs;
      _showViewOrders      = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          const Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
                'Order saved! Total ₹${order.grandTotal.toStringAsFixed(2)}'),
          ),
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
                    child: Text('Direct Delivery',
                        style: TextStyle(
                            color: Colors.white, fontSize: 19,
                            fontWeight: FontWeight.w800, letterSpacing: 0.3)),
                  ),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
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
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Order Types — collapsible ──────────────────────────────
          _CollapsibleCard(
            icon: Icons.tune_rounded,
            title: 'Order Types',
            initiallyExpanded: false,
            child: _buildTypesBody(),
          ),
          const SizedBox(height: 14),
          // ── Customer Details — collapsible ─────────────────────────
          _CollapsibleCard(
            icon: Icons.store_rounded,
            title: 'Customer Details',
            initiallyExpanded: false,
            child: _buildSupplierBody(),
          ),
          const SizedBox(height: 14),
          // ── Date & Reference — collapsible ─────────────────────────
          _CollapsibleCard(
            icon: Icons.calendar_month_rounded,
            title: 'Date & Reference',
            initiallyExpanded: false,
            child: _buildDateRefBody(),
          ),
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

  // ── Order Types body (extracted from old _buildTypesCard) ──────────────
  Widget _buildTypesBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: _TypeDropdown<OrderType>(
              label: 'Types',
              value: _orderType,
              items: const [
                DropdownMenuItem(value: OrderType.wholesaleBB,
                    child: Text('Delivery')),
                DropdownMenuItem(value: OrderType.retailBC,
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
              label: 'Tax Inclusion',
              value: _globalTaxType,
              items: const [
                DropdownMenuItem(value: TaxType.exclusive,
                    child: Text('Exclude Tax')),
                DropdownMenuItem(value: TaxType.inclusive,
                    child: Text('Include Tax')),
              ],
              onChanged: (v) {
                if (v != null) setState(() => _globalTaxType = v);
              },
            )),
          ],
        ),
      ],
    );
  }

  // ── Customer Details body ──────────────────────────────────────────────
  Widget _buildSupplierBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _FieldLabel(label: 'Customer Name'),
        const SizedBox(height: 6),
        TextField(
          controller: _supplierNameCtrl,
          focusNode: _supplierFocus,
          textCapitalization: TextCapitalization.characters,
          style: const TextStyle(
              color: _C.textDark, fontSize: 15, fontWeight: FontWeight.w500),
          onChanged: (val) {
            setState(() => _supplierSuggestions = SupplierNames.search(val));
          },
          decoration: InputDecoration(
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
            hintText: 'Search or enter Customer name',
            hintStyle:
            const TextStyle(color: _C.textLight, fontSize: 14),
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
                borderSide:
                const BorderSide(color: _C.primary, width: 1.5)),
          ),
        ),
        if (_supplierSuggestions.isNotEmpty) ...[
          const SizedBox(height: 4),
          Container(
            constraints: const BoxConstraints(maxHeight: 200),
            decoration: BoxDecoration(
              color: _C.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _C.primary.withOpacity(0.25)),
              boxShadow: [
                BoxShadow(color: _C.primary.withOpacity(0.08),
                    blurRadius: 16, offset: const Offset(0, 4)),
              ],
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
                  final s     = _supplierSuggestions[i];
                  final query =
                  _supplierNameCtrl.text.toUpperCase().trim();
                  final idx   = s.indexOf(query);
                  return InkWell(
                    onTap: () => setState(() {
                      _supplierNameCtrl.text = s;
                      _supplierNameCtrl.selection =
                          TextSelection.fromPosition(
                              TextPosition(offset: s.length));
                      _supplierSuggestions = [];
                      _supplierFocus.unfocus();
                    }),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 12),
                      child: Row(
                        children: [
                          const Icon(Icons.store_rounded,
                              color: _C.primary, size: 15),
                          const SizedBox(width: 10),
                          Expanded(
                            child: idx >= 0 && query.isNotEmpty
                                ? RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: s.substring(0, idx),
                                  style: const TextStyle(
                                      color: _C.textMid, fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),
                                TextSpan(
                                  text: s.substring(
                                      idx, idx + query.length),
                                  style: const TextStyle(
                                      color: _C.primary, fontSize: 13,
                                      fontWeight: FontWeight.w800,
                                      backgroundColor:
                                      Color(0xFFE8F5ED)),
                                ),
                                TextSpan(
                                  text: s.substring(idx + query.length),
                                  style: const TextStyle(
                                      color: _C.textMid, fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),
                              ]),
                            )
                                : Text(s,
                                style: const TextStyle(
                                    color: _C.textDark, fontSize: 13,
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
        const SizedBox(height: 14),
        const _FieldLabel(label: 'Customer Address'),
        const SizedBox(height: 6),
        _InputField(
          controller: _supplierAddressCtrl,
          hint: 'Enter Customer address',
          maxLines: 2,
        ),
      ],
    );
  }

  // ── Date & Reference body ──────────────────────────────────────────────
  Widget _buildDateRefBody() {
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
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_month_rounded,
                          color: _C.primary, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        DateFormat('dd-MM-yyyy').format(_selectedDate),
                        style: const TextStyle(
                            color: _C.textDark, fontSize: 10,
                            fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      const Icon(Icons.keyboard_arrow_down_rounded,
                          color: _C.textMid, size: 18),
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
              const _FieldLabel(label: 'Ref / Invoice No'),
              const SizedBox(height: 6),
              _InputField(
                controller: _referenceCtrl,
                hint: 'Enter invoice no',
              ),
            ],
          ),
        ),
      ],
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
          const Text('Order Items',
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
                  Text('ADD ITEM',
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('₹${item.grandTotal.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      color: _C.primary, fontSize: 14,
                                      fontWeight: FontWeight.w900)),
                              Container(
                                margin: const EdgeInsets.only(top: 2),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: item.taxType == TaxType.inclusive
                                      ? const Color(0xFFE8F5ED)
                                      : const Color(0xFFFFF3CD),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  item.taxType == TaxType.inclusive
                                      ? 'incl. tax' : 'excl. tax',
                                  style: TextStyle(
                                    color: item.taxType == TaxType.inclusive
                                        ? _C.primary : _C.gold,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 6, runSpacing: 4,
                        children: [
                          _InfoChip(
                              value: '₹${item.price.toStringAsFixed(0)}'),
                          _InfoChip(
                              value: '× ${item.quantity}'),
                          if (item.discountValue > 0)
                            _InfoChip(
                              value: item.discountIsPercent
                                  ? '${item.discountValue.toStringAsFixed(0)}% off'
                                  : '₹${item.discountValue.toStringAsFixed(0)} off',
                              isHighlight: true,
                            ),
                          _InfoChip(
                              value: '${item.taxRate.toStringAsFixed(0)}% tax'),
                          _InfoChip(
                              value: 'double-tap to edit'),
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
                      color: _C.textDark, fontSize: 15,
                      fontWeight: FontWeight.w700)),
            ],
          ),
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
                        Text('SAVE ORDER',
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

  Widget _buildOrderCard(SavedOrder order, int index) {
    final orderTypeLabel = {
      OrderType.wholesaleBB: 'Wholesale B-B',
      OrderType.retailBC:    'Retail B-C',
      OrderType.wholesaleBC: 'Wholesale B-C',
    }[order.orderType]!;

    final gstLabel =
    order.gstType == GstType.cgstSgst ? 'CGST/SGST' : 'IGST';

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
                  Text(DateFormat('dd MMM yyyy').format(order.date),
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
                  Wrap(
                    spacing: 6, runSpacing: 6,
                    children: [
                      _Tag(label: orderTypeLabel),
                      _Tag(label: gstLabel),
                      _Tag(label: order.globalTaxType == TaxType.exclusive
                          ? 'Excl. Tax' : 'Incl. Tax'),
                      if (order.tcsType != TcsType.noTcs)
                        _Tag(
                            label: order.tcsType == TcsType.tcs01
                                ? 'TCS 0.1%' : 'TCS 1%',
                            isGold: true),
                    ],
                  ),
                  if (order.supplierAddress.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.location_on_rounded,
                            color: _C.textMid, size: 13),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(order.supplierAddress,
                              style: const TextStyle(
                                  color: _C.textMid, fontSize: 12,
                                  fontWeight: FontWeight.w500),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ],
                  if (order.reference.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.tag_rounded,
                            color: _C.textMid, size: 13),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text('Ref: ${order.reference}',
                              style: const TextStyle(
                                  color: _C.textMid, fontSize: 12,
                                  fontWeight: FontWeight.w500),
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _StatBox(
                        label: 'Items',
                        value: '${order.items.length}',
                      ),
                      const SizedBox(width: 8),
                      _StatBox(
                        label: 'Tax',
                        value: '₹${order.taxTotal.toStringAsFixed(0)}',
                      ),
                      if (order.discTotal > 0) ...[
                        const SizedBox(width: 8),
                        _StatBox(
                          label: 'Discount',
                          value: '₹${order.discTotal.toStringAsFixed(0)}',
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...order.items.take(2).map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      children: [
                        Container(
                          width: 6, height: 6,
                          decoration: const BoxDecoration(
                              color: _C.primary,
                              shape: BoxShape.circle),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(item.product,
                              style: const TextStyle(
                                  color: _C.textDark, fontSize: 12,
                                  fontWeight: FontWeight.w500),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                        ),
                        const SizedBox(width: 8),
                        Text('₹${item.grandTotal.toStringAsFixed(2)}',
                            style: const TextStyle(
                                color: _C.textDark, fontSize: 12,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  )),
                  if (order.items.length > 2) ...[
                    const SizedBox(height: 4),
                    Text(
                      '+ ${order.items.length - 2} more item${order.items.length - 2 == 1 ? '' : 's'}',
                      style: const TextStyle(
                          color: _C.primary, fontSize: 12,
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
                              color: _C.textMid, fontSize: 13,
                              fontWeight: FontWeight.w600)),
                      Text('₹${order.grandTotal.toStringAsFixed(2)}',
                          style: const TextStyle(
                              color: _C.primary, fontSize: 20,
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

// ── _StatBox ──────────────────────────────────────────────────────────────
class _StatBox extends StatelessWidget {
  final String   label;
  final String   value;

  const _StatBox({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: _C.primaryLt,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                        color: _C.primary, fontSize: 12,
                        fontWeight: FontWeight.w800),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    label,
                    style: const TextStyle(
                        color: _C.textMid, fontSize: 10,
                        fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
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

// ── Reusable Widgets ──────────────────────────────────────────────────────

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
  final TextInputType          keyboardType;
  final ValueChanged<String>?  onChanged;
  final int                    maxLines;

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
        color: _C.textDark, fontSize: 15, fontWeight: FontWeight.w500),
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: _C.textLight, fontSize: 14),
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
  final TextInputType          keyboardType;
  final ValueChanged<String>?  onChanged;

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
  final String   value;
  final bool     isHighlight;
  const _InfoChip({
    required this.value,
    this.isHighlight = false,
  });
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: isHighlight ? const Color(0xFFFFF3CD) : _C.surface,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
          color: isHighlight
              ? _C.gold.withOpacity(0.5) : _C.border),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(value,
            style: TextStyle(
                color: isHighlight ? _C.gold : _C.textDark,
                fontSize: 11, fontWeight: FontWeight.w600)),
      ],
    ),
  );
}

class _Tag extends StatelessWidget {
  final String label;
  final bool   isGold;
  const _Tag({required this.label, this.isGold = false});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: isGold ? const Color(0xFFFFF3CD) : _C.primaryLt,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(
          color: isGold
              ? _C.gold.withOpacity(0.4)
              : _C.primary.withOpacity(0.2)),
    ),
    child: Text(label,
        style: TextStyle(
            color: isGold ? _C.gold : _C.primary,
            fontSize: 11, fontWeight: FontWeight.w600)),
  );
}