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

  static List<String> search(String query) {
    if (query.trim().isEmpty) return [];
    final q = query.toUpperCase().trim();
    return all.where((p) => p.contains(q)).take(30).toList();
  }
}

// ── Status ────────────────────────────────────────────────────────────────────
enum ItemStatus { active, inactive }

// ── Data models ───────────────────────────────────────────────────────────────
class OrderItem {
  String     product;
  String     batchNo;
  DateTime   expiryDate;
  ItemStatus status;

  OrderItem({
    required this.product,
    required this.batchNo,
    required this.expiryDate,
    required this.status,
  });
}

class SavedOrder {
  final String          id;
  final DateTime        date;
  final List<OrderItem> items;

  SavedOrder({
    required this.id,
    required this.date,
    required this.items,
  });
}

// ── Main Screen ───────────────────────────────────────────────────────────────
class BatchLotsScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const BatchLotsScreen({super.key, this.onBack});

  @override
  State<BatchLotsScreen> createState() => _BatchLotsScreenState();
}

class _BatchLotsScreenState extends State<BatchLotsScreen>
    with SingleTickerProviderStateMixin {

  bool _showViewOrders = false;

  // ── Accordion state (default: collapsed) ─────────────────────────────────
  bool _addItemExpanded = false;

  final _productCtrl    = TextEditingController();
  final _batchCtrl      = TextEditingController();
  DateTime   _expiryDate    = DateTime.now();
  ItemStatus _selectedStatus = ItemStatus.active;
  List<String> _suggestions  = [];

  final List<OrderItem>  _items       = [];
  final List<SavedOrder> _savedOrders = [];

  @override
  void dispose() {
    _productCtrl.dispose();
    _batchCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickExpiryDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _expiryDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.light(
            primary: _C.primary,
            onPrimary: Colors.white,
            surface: Colors.white,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _expiryDate = picked);
  }

  void _saveItem() {
    if (_productCtrl.text.trim().isEmpty) {
      _showSnack('Please select a product name', _C.gold);
      return;
    }
    HapticFeedback.mediumImpact();
    setState(() {
      _items.add(OrderItem(
        product:    _productCtrl.text.trim(),
        batchNo:    _batchCtrl.text.trim(),
        expiryDate: _expiryDate,
        status:     _selectedStatus,
      ));
      _productCtrl.clear();
      _batchCtrl.clear();
      _expiryDate     = DateTime.now();
      _selectedStatus = ItemStatus.active;
      _suggestions    = [];
      // Collapse after saving item
      _addItemExpanded = false;
    });
    _showSnack('Item added!', _C.primary);
  }

  void _saveOrder() {
    if (_items.isEmpty) {
      _showSnack('Please add at least one item', _C.gold);
      return;
    }
    HapticFeedback.mediumImpact();
    final saved = SavedOrder(
      id:    'SO-${DateTime.now().millisecondsSinceEpoch}',
      date:  DateTime.now(),
      items: List.from(_items),
    );
    setState(() {
      _savedOrders.insert(0, saved);
      _items.clear();
      _addItemExpanded = false;
      _showViewOrders  = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(children: [
        const Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
        const SizedBox(width: 10),
        Text('Order saved! ${saved.items.length} item(s)'),
      ]),
      backgroundColor: _C.primary,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ));
  }

  void _showSnack(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ));
  }

  // ══════════════════════════════════════════════════════════════════════════
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
                    child: Text(
                      'Batch & Lots',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.3,
                      ),
                    ),
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
                      label: 'Add Items',
                      icon: Icons.add_circle_outline_rounded,
                      active: !_showViewOrders,
                      onTap: () => setState(() => _showViewOrders = false),
                    ),
                    _tab(
                      label: 'View Items',
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
              blurRadius: 8,
              offset: const Offset(0, 2),
            )]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16,
                  color: active ? _C.primary : Colors.white.withOpacity(0.75)),
              const SizedBox(width: 6),
              Text(label, style: TextStyle(
                fontSize: 13,
                fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                color: active ? _C.primary : Colors.white.withOpacity(0.75),
              )),
            ],
          ),
        ),
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // ORDER FORM — accordion card + items list below
  // ══════════════════════════════════════════════════════════════════════════
  Widget _buildOrderForm() {
    return SingleChildScrollView(
      key: const ValueKey('form'),
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(
        16, 16, 16,
        MediaQuery.of(context).padding.bottom + 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Accordion card ──────────────────────────────────────────────
          _accordionCard(),

          // ── Added items list ────────────────────────────────────────────
          if (_items.isNotEmpty) ...[
            const SizedBox(height: 16),
            _itemsListCard(),
          ],

          // ── Save Order bar ──────────────────────────────────────────────
          if (_items.isNotEmpty) ...[
            const SizedBox(height: 14),
            _buildSaveOrderBar(),
          ],

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ── Accordion card ────────────────────────────────────────────────────────
  Widget _accordionCard() {
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
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header (always visible) ───────────────────────────────────
          InkWell(
            onTap: () {
              HapticFeedback.lightImpact();
              setState(() => _addItemExpanded = !_addItemExpanded);
            },
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(children: [
                // Icon box
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: _addItemExpanded ? _C.primary : _C.primaryLt,
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(Icons.shopping_bag_rounded,
                      color: _addItemExpanded ? Colors.white : _C.primary,
                      size: 18),
                ),
                const SizedBox(width: 10),
                // Title
                const Expanded(
                  child: Text('Add Item',
                      style: TextStyle(
                          color: _C.textDark,
                          fontSize: 15,
                          fontWeight: FontWeight.w700)),
                ),

                const SizedBox(width: 8),
                // Animated arrow
                AnimatedRotation(
                  turns: _addItemExpanded ? 0.5 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: _addItemExpanded ? _C.primary : _C.textMid,
                    size: 24,
                  ),
                ),
              ]),
            ),
          ),

          // ── Animated content ──────────────────────────────────────────
          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity, height: 0),
            secondChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(height: 1, color: _C.border),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // ── Name ──────────────────────────────────────────
                      _lbl('Name'),
                      const SizedBox(height: 6),
                      TextField(
                        controller: _productCtrl,
                        textCapitalization: TextCapitalization.characters,
                        style: const TextStyle(
                          color: _C.textDark,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        onChanged: (val) => setState(
                                () => _suggestions = AgroProducts.search(val)),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.inventory_2_rounded,
                              color: _C.primary, size: 18),
                          suffixIcon: _productCtrl.text.isNotEmpty
                              ? IconButton(
                            icon: const Icon(Icons.clear,
                                color: _C.textLight, size: 18),
                            onPressed: () => setState(() {
                              _productCtrl.clear();
                              _suggestions = [];
                            }),
                          )
                              : const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: _C.textLight, size: 20),
                          hintText: 'Select Option',
                          hintStyle: const TextStyle(
                              color: _C.textLight, fontSize: 13),
                          filled: true,
                          fillColor: _C.bg,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                            const BorderSide(color: _C.border),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                            const BorderSide(color: _C.border),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: _C.primary, width: 1.5),
                          ),
                        ),
                      ),

                      // ── Suggestions ───────────────────────────────────
                      if (_suggestions.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Container(
                          constraints:
                          const BoxConstraints(maxHeight: 200),
                          decoration: BoxDecoration(
                            color: _C.surface,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                                color: _C.primary.withOpacity(0.25)),
                            boxShadow: [
                              BoxShadow(
                                color: _C.primary.withOpacity(0.08),
                                blurRadius: 16,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: ListView.separated(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: _suggestions.length,
                              separatorBuilder: (_, __) =>
                              const Divider(height: 1, color: _C.border),
                              itemBuilder: (_, i) {
                                final s = _suggestions[i];
                                final query = _productCtrl.text
                                    .toUpperCase()
                                    .trim();
                                final idx = s.indexOf(query);
                                return InkWell(
                                  onTap: () => setState(() {
                                    _productCtrl.text = s;
                                    _productCtrl.selection =
                                        TextSelection.fromPosition(
                                            TextPosition(
                                                offset: s.length));
                                    _suggestions = [];
                                  }),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 11),
                                    child: Row(children: [
                                      const Icon(Icons.eco_rounded,
                                          color: _C.primary, size: 14),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: idx >= 0 &&
                                            query.isNotEmpty
                                            ? RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text: s.substring(0, idx),
                                              style: const TextStyle(
                                                color: _C.textMid,
                                                fontSize: 13,
                                                fontWeight:
                                                FontWeight.w500,
                                              ),
                                            ),
                                            TextSpan(
                                              text: s.substring(idx,
                                                  idx + query.length),
                                              style: const TextStyle(
                                                color: _C.primary,
                                                fontSize: 13,
                                                fontWeight:
                                                FontWeight.w800,
                                                backgroundColor:
                                                Color(0xFFE8F5ED),
                                              ),
                                            ),
                                            TextSpan(
                                              text: s.substring(
                                                  idx + query.length),
                                              style: const TextStyle(
                                                color: _C.textMid,
                                                fontSize: 13,
                                                fontWeight:
                                                FontWeight.w500,
                                              ),
                                            ),
                                          ]),
                                        )
                                            : Text(s,
                                            style: const TextStyle(
                                              color: _C.textDark,
                                              fontSize: 13,
                                              fontWeight:
                                              FontWeight.w500,
                                            )),
                                      ),
                                    ]),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],

                      const SizedBox(height: 16),

                      // ── Batch No | Expiry Date ────────────────────────
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _lbl('Batch No'),
                                const SizedBox(height: 6),
                                TextField(
                                  controller: _batchCtrl,
                                  style: const TextStyle(
                                    color: _C.textDark,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Batch No',
                                    hintStyle: const TextStyle(
                                        color: _C.textLight,
                                        fontSize: 13),
                                    prefixIcon: const Icon(
                                        Icons.qr_code_rounded,
                                        color: _C.primary,
                                        size: 18),
                                    filled: true,
                                    fillColor: _C.bg,
                                    contentPadding:
                                    const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 14),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                          color: _C.border),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                          color: _C.border),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                          color: _C.primary, width: 1.5),
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
                                _lbl('Expiry Date'),
                                const SizedBox(height: 6),
                                GestureDetector(
                                  onTap: _pickExpiryDate,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 14),
                                    decoration: BoxDecoration(
                                      color: _C.bg,
                                      borderRadius:
                                      BorderRadius.circular(12),
                                      border:
                                      Border.all(color: _C.border),
                                    ),
                                    child: Row(children: [
                                      const Icon(
                                          Icons.calendar_month_rounded,
                                          color: _C.primary,
                                          size: 17),
                                      const SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          DateFormat('dd-MM-yyyy')
                                              .format(_expiryDate),
                                          style: const TextStyle(
                                            color: _C.textDark,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // ── Status ────────────────────────────────────────
                      _lbl('Status'),
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
                          child: DropdownButton<ItemStatus>(
                            value: _selectedStatus,
                            isExpanded: true,
                            icon: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: _C.primary,
                                size: 20),
                            dropdownColor: _C.surface,
                            style: const TextStyle(
                              color: _C.textDark,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: ItemStatus.active,
                                child: Text('ACTIVE',
                                    style: TextStyle(fontSize: 13)),
                              ),
                              DropdownMenuItem(
                                value: ItemStatus.inactive,
                                child: Text('INACTIVE',
                                    style: TextStyle(fontSize: 13)),
                              ),
                            ],
                            onChanged: (val) {
                              if (val != null)
                                setState(() => _selectedStatus = val);
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // ── SAVE item button ──────────────────────────────
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _saveItem,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _C.primary,
                            padding:
                            const EdgeInsets.symmetric(vertical: 15),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                          ),
                          child: const Text(
                            'SAVE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.6,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            crossFadeState: _addItemExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
            sizeCurve: Curves.easeInOut,
          ),
        ],
      ),
    );
  }

  // ── Added items list card ─────────────────────────────────────────────────
  Widget _itemsListCard() {
    return Container(
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 16,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card title
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: Row(children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: _C.primaryLt,
                    borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.list_alt_rounded,
                    color: _C.primary, size: 18),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text('Added Items',
                    style: TextStyle(
                        color: _C.textDark,
                        fontSize: 15,
                        fontWeight: FontWeight.w700)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                    color: _C.primaryLt,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  '${_items.length} item${_items.length == 1 ? '' : 's'}',
                  style: const TextStyle(
                      color: _C.primary,
                      fontSize: 11,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ]),
          ),
          const SizedBox(height: 10),
          const Divider(height: 1, color: _C.border),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
            itemCount: _items.length,
            separatorBuilder: (_, __) =>
            const Divider(height: 14, color: _C.border),
            itemBuilder: (_, i) => _itemRow(_items[i], i),
          ),
        ],
      ),
    );
  }

  Widget _itemRow(OrderItem item, int index) {
    return Row(children: [
      // Index circle
      Container(
        width: 26, height: 26,
        decoration: const BoxDecoration(
            color: _C.primaryLt, shape: BoxShape.circle),
        alignment: Alignment.center,
        child: Text('${index + 1}',
            style: const TextStyle(
                color: _C.primary,
                fontSize: 11,
                fontWeight: FontWeight.w800)),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.product,
                style: const TextStyle(
                    color: _C.textDark,
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
            const SizedBox(height: 2),
            Text(
              '${item.batchNo.isEmpty ? "No Batch" : item.batchNo}  •  '
                  '${DateFormat('dd-MM-yyyy').format(item.expiryDate)}',
              style: const TextStyle(
                  color: _C.textMid,
                  fontSize: 11,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      const SizedBox(width: 8),
      // Status badge
      Container(
        padding:
        const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
        decoration: BoxDecoration(
          color: item.status == ItemStatus.active
              ? const Color(0xFFE8F5ED)
              : const Color(0xFFFFEEEE),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          item.status == ItemStatus.active ? 'ACTIVE' : 'INACTIVE',
          style: TextStyle(
            color: item.status == ItemStatus.active
                ? _C.primary
                : _C.red,
            fontSize: 9,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      const SizedBox(width: 6),
      // Delete button
      GestureDetector(
        onTap: () => setState(() => _items.removeAt(index)),
        child: const Icon(Icons.delete_outline_rounded,
            color: _C.red, size: 18),
      ),
    ]);
  }

  Widget _lbl(String text) => Text(
    text,
    style: const TextStyle(
      color: _C.textMid,
      fontSize: 13,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.2,
    ),
  );

  // ── Save Order bar ────────────────────────────────────────────────────────
  Widget _buildSaveOrderBar() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade400, Colors.green.shade300],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: _C.primary.withOpacity(0.4),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _saveOrder,
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'ITEMS ADDED',
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${_items.length} item${_items.length == 1 ? '' : 's'}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border:
                  Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.save_rounded,
                        color: Colors.white, size: 18),
                    SizedBox(width: 8),
                    Text(
                      'SAVE ORDER',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // VIEW ORDERS
  // ══════════════════════════════════════════════════════════════════════════
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
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 16,
              offset: const Offset(0, 4))
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(children: [
          Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [_C.primary, _C.primaryDk],
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
                  'SO-${_savedOrders.length - index}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  '${order.items.length} item${order.items.length == 1 ? '' : 's'}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Text(
                DateFormat('dd MMM yyyy').format(order.date),
                style:
                const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  _statBox('Total', '${order.items.length}',
                      Icons.list_rounded),
                  const SizedBox(width: 10),
                  _statBox(
                    'Active',
                    '${order.items.where((e) => e.status == ItemStatus.active).length}',
                    Icons.check_circle_rounded,
                  ),
                  const SizedBox(width: 10),
                  _statBox(
                    'Inactive',
                    '${order.items.where((e) => e.status == ItemStatus.inactive).length}',
                    Icons.cancel_rounded,
                  ),
                ]),
                const SizedBox(height: 12),
                ...order.items.take(2).map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(children: [
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
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: item.status == ItemStatus.active
                            ? const Color(0xFFE8F5ED)
                            : const Color(0xFFFFEEEE),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        item.status == ItemStatus.active
                            ? 'ACTIVE'
                            : 'INACTIVE',
                        style: TextStyle(
                          color: item.status == ItemStatus.active
                              ? _C.primary
                              : _C.red,
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
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
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget _statBox(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding:
        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
            color: _C.primaryLt,
            borderRadius: BorderRadius.circular(10)),
        child: Row(children: [
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
        ]),
      ),
    );
  }
}