import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  static const orange    = Color(0xFFFF6D00);
  static const blue      = Color(0xFF1565C0);
}

// ── Enums ──────────────────────────────────────────────────────────────────
enum ProductType     { goods, service }
enum StockSaleType   { stockWise, freeSale }
enum NonTax          { no, yes }
enum ProductTaxRate  { zero, five, twelve, eighteen, twentyEight }
enum ProductUOM      { none, kgs, ltr, nos, gms, mls, packets, bags }
enum ProductCategory {
  pesticides, fertilizers, seeds, herbicides,
  fungicides, insecticides, micronutrients, others
}

// ── Tab enum ───────────────────────────────────────────────────────────────
enum _Tab { products, viewProducts }

// ── ProductItem model ──────────────────────────────────────────────────────
class ProductItem {
  String          code;
  String          name;
  String          size;
  String          tamilName;
  String          description;
  ProductType     type;
  String          hsnSacCode;
  ProductCategory category;
  String          subCategory;
  String          brandCompany;
  NonTax          nonTax;
  ProductTaxRate  taxRate;
  ProductUOM      uom;
  StockSaleType   stockSaleType;
  double          minimumLimit;
  double          pointValue;
  final DateTime  savedAt;

  ProductItem({
    this.code          = '',
    this.name          = '',
    this.size          = '',
    this.tamilName     = '',
    this.description   = '',
    this.type          = ProductType.goods,
    this.hsnSacCode    = '',
    this.category      = ProductCategory.pesticides,
    this.subCategory   = '',
    this.brandCompany  = '',
    this.nonTax        = NonTax.no,
    this.taxRate       = ProductTaxRate.zero,
    this.uom           = ProductUOM.none,
    this.stockSaleType = StockSaleType.stockWise,
    this.minimumLimit  = 0,
    this.pointValue    = 0,
    DateTime? savedAt,
  }) : savedAt = savedAt ?? DateTime.now();
}

// ════════════════════════════════════════════════════════════════════════════
//  MAIN SCREEN
// ════════════════════════════════════════════════════════════════════════════
class ProductScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const ProductScreen({super.key, this.onBack});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>
    with TickerProviderStateMixin {

  // ── CHANGE: default tab is View Products (left) ───────────────────────────
  _Tab _activeTab = _Tab.viewProducts;

  final List<ProductItem> _savedProducts = [];

  // ── Collapsible card states ───────────────────────────────────────────────
  bool _basicExpanded          = true;
  bool _classificationExpanded = false;
  bool _pricingExpanded        = false;

  late AnimationController _basicAnim;
  late AnimationController _classAnim;
  late AnimationController _priceAnim;

  // ── Product form controllers ──────────────────────────────────────────────
  final _pCodeCtrl     = TextEditingController();
  final _pNameCtrl     = TextEditingController();
  final _pTamilCtrl    = TextEditingController();
  final _pDescCtrl     = TextEditingController();
  final _pHsnCtrl      = TextEditingController();
  final _pSubCatCtrl   = TextEditingController();
  final _pBrandCtrl    = TextEditingController();
  final _pMinLimitCtrl = TextEditingController();
  final _pPointValCtrl = TextEditingController();

  ProductType     _pType          = ProductType.goods;
  StockSaleType   _pStockSaleType = StockSaleType.stockWise;
  NonTax          _pNonTax        = NonTax.no;
  ProductTaxRate  _pTaxRate       = ProductTaxRate.zero;
  ProductUOM      _pUom           = ProductUOM.none;
  ProductCategory _pCategory      = ProductCategory.pesticides;
  String          _pSize          = '';

  // ── View Products search ──────────────────────────────────────────────────
  final _searchCtrl   = TextEditingController();
  String _searchQuery = '';
  ProductCategory? _filterCategory;

  static const _sizes = [
    '10G','25G','50G','100G','250G','500G',
    '1 KGS','5 KGS','10 KGS','25 KGS','50 KGS',
    '100 MLS','250 MLS','500 MLS','1 LTR','5 LTR',
  ];

  @override
  void initState() {
    super.initState();
    _basicAnim = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 260), value: 1.0);
    _classAnim = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 260), value: 0.0);
    _priceAnim = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 260), value: 0.0);
  }

  @override
  void dispose() {
    _pCodeCtrl.dispose(); _pNameCtrl.dispose(); _pTamilCtrl.dispose();
    _pDescCtrl.dispose(); _pHsnCtrl.dispose(); _pSubCatCtrl.dispose();
    _pBrandCtrl.dispose(); _pMinLimitCtrl.dispose(); _pPointValCtrl.dispose();
    _searchCtrl.dispose();
    _basicAnim.dispose(); _classAnim.dispose(); _priceAnim.dispose();
    super.dispose();
  }

  void _toggleSectionAccordion(
      bool current,
      Function(bool) setter,
      AnimationController anim,
      AnimationController other1,
      AnimationController other2,
      ) {
    setter(!current);
    if (!current) {
      anim.forward();
      other1.reverse();
      other2.reverse();
    } else {
      anim.reverse();
    }
  }

  // ── Helpers ───────────────────────────────────────────────────────────────
  void _showSnack(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ));
  }

  String _taxRateLabel(ProductTaxRate r) {
    switch (r) {
      case ProductTaxRate.zero:        return '0%';
      case ProductTaxRate.five:        return '5%';
      case ProductTaxRate.twelve:      return '12%';
      case ProductTaxRate.eighteen:    return '18%';
      case ProductTaxRate.twentyEight: return '28%';
    }
  }

  String _uomLabel(ProductUOM u) {
    switch (u) {
      case ProductUOM.none:    return '—';
      case ProductUOM.kgs:     return 'KGS';
      case ProductUOM.ltr:     return 'LTR';
      case ProductUOM.nos:     return 'NOS';
      case ProductUOM.gms:     return 'GMS';
      case ProductUOM.mls:     return 'MLS';
      case ProductUOM.packets: return 'PACKETS';
      case ProductUOM.bags:    return 'BAGS';
    }
  }

  String _categoryLabel(ProductCategory c) {
    switch (c) {
      case ProductCategory.pesticides:     return 'PESTICIDES';
      case ProductCategory.fertilizers:    return 'FERTILIZERS';
      case ProductCategory.seeds:          return 'SEEDS';
      case ProductCategory.herbicides:     return 'HERBICIDES';
      case ProductCategory.fungicides:     return 'FUNGICIDES';
      case ProductCategory.insecticides:   return 'INSECTICIDES';
      case ProductCategory.micronutrients: return 'MICRONUTRIENTS';
      case ProductCategory.others:         return 'OTHERS';
    }
  }

  Color _categoryColor(ProductCategory c) {
    switch (c) {
      case ProductCategory.pesticides:     return const Color(0xFFEF4444);
      case ProductCategory.fertilizers:    return const Color(0xFF1B8A3E);
      case ProductCategory.seeds:          return const Color(0xFFF59E0B);
      case ProductCategory.herbicides:     return const Color(0xFF8B5CF6);
      case ProductCategory.fungicides:     return const Color(0xFF06B6D4);
      case ProductCategory.insecticides:   return const Color(0xFFFF6D00);
      case ProductCategory.micronutrients: return const Color(0xFF1565C0);
      case ProductCategory.others:         return const Color(0xFF6B7280);
    }
  }

  IconData _categoryIcon(ProductCategory c) {
    switch (c) {
      case ProductCategory.pesticides:     return Icons.bug_report_rounded;
      case ProductCategory.fertilizers:    return Icons.grass_rounded;
      case ProductCategory.seeds:          return Icons.eco_rounded;
      case ProductCategory.herbicides:     return Icons.local_florist_rounded;
      case ProductCategory.fungicides:     return Icons.science_rounded;
      case ProductCategory.insecticides:   return Icons.pest_control_rounded;
      case ProductCategory.micronutrients: return Icons.bolt_rounded;
      case ProductCategory.others:         return Icons.category_rounded;
    }
  }

  List<ProductItem> get _filteredProducts {
    var list = _savedProducts;
    if (_filterCategory != null) {
      list = list.where((p) => p.category == _filterCategory).toList();
    }
    if (_searchQuery.trim().isNotEmpty) {
      final q = _searchQuery.toUpperCase().trim();
      list = list.where((p) =>
      p.name.toUpperCase().contains(q) ||
          p.code.toUpperCase().contains(q) ||
          p.brandCompany.toUpperCase().contains(q)).toList();
    }
    return list;
  }

  // ════════════════════════════════════════════════════════════════════════
  //  BUILD
  // ════════════════════════════════════════════════════════════════════════
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
              duration: const Duration(milliseconds: 280),
              layoutBuilder: (currentChild, previousChildren) => Stack(
                alignment: Alignment.topCenter,
                children: [
                  ...previousChildren,
                  if (currentChild != null) currentChild,
                ],
              ),
              transitionBuilder: (child, anim) => FadeTransition(
                opacity: anim,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.03), end: Offset.zero,
                  ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOut)),
                  child: child,
                ),
              ),
              child: _activeTab == _Tab.products
                  ? _buildProductForm()
                  : _buildViewProducts(),
            ),
          ),
        ],
      ),
    );
  }

  // ════════════════════════════════════════════════════════════════════════
  //  HEADER
  // ════════════════════════════════════════════════════════════════════════
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
                    constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                    padding: const EdgeInsets.all(8),
                  ),
                  const Expanded(
                    child: Text('Products',
                        style: TextStyle(
                            color: Colors.white, fontSize: 19,
                            fontWeight: FontWeight.w800, letterSpacing: 0.3)),
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
                    // ── CHANGE: View Products LEFT, Add Product RIGHT ─────────
                    _tabBtn(
                      label: 'View Products',
                      icon: Icons.list_alt_rounded,
                      active: _activeTab == _Tab.viewProducts,
                      onTap: () => setState(() => _activeTab = _Tab.viewProducts),
                    ),
                    _tabBtn(
                      label: 'Add Product',
                      icon: Icons.add_circle_outline_rounded,
                      active: _activeTab == _Tab.products,
                      onTap: () => setState(() => _activeTab = _Tab.products),
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

  Widget _tabBtn({
    required String    label,
    required IconData  icon,
    required bool      active,
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
                ? [BoxShadow(
                color: Colors.black.withOpacity(0.10),
                blurRadius: 8, offset: const Offset(0, 2))]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 15,
                  color: active ? _C.primary : Colors.white.withOpacity(0.8)),
              const SizedBox(width: 6),
              Text(label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                    color: active ? _C.primary : Colors.white.withOpacity(0.8),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  // ════════════════════════════════════════════════════════════════════════
  //  ADD PRODUCT FORM  (3 collapsible cards)
  // ════════════════════════════════════════════════════════════════════════
  Widget _buildProductForm() {
    return SingleChildScrollView(
      key: const ValueKey('add_product'),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          _collapsibleCard(
            icon: Icons.info_outline_rounded,
            title: 'Basic Information',
            expanded: _basicExpanded,
            anim: _basicAnim,
            onTap: () => setState(() => _toggleSectionAccordion(
                _basicExpanded,
                    (v) => _basicExpanded = v,
                _basicAnim,
                _classAnim,
                _priceAnim)),
            child: _buildBasicBody(),
          ),
          const SizedBox(height: 14),

          _collapsibleCard(
            icon: Icons.category_rounded,
            title: 'Classification',
            expanded: _classificationExpanded,
            anim: _classAnim,
            onTap: () => setState(() => _toggleSectionAccordion(
                _classificationExpanded,
                    (v) => _classificationExpanded = v,
                _classAnim,
                _basicAnim,
                _priceAnim)),
            child: _buildClassificationBody(),
          ),
          const SizedBox(height: 14),

          _collapsibleCard(
            icon: Icons.price_change_rounded,
            title: 'Pricing & Stock',
            expanded: _pricingExpanded,
            anim: _priceAnim,
            onTap: () => setState(() => _toggleSectionAccordion(
                _pricingExpanded,
                    (v) => _pricingExpanded = v,
                _priceAnim,
                _basicAnim,
                _classAnim)),
            child: _buildPricingBody(),
          ),
          const SizedBox(height: 16),

          _buildSaveProductButton(),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 24),
        ],
      ),
    );
  }

  // ── Collapsible card shell ────────────────────────────────────────────────
  Widget _collapsibleCard({
    required IconData icon,
    required String title,
    required bool expanded,
    required AnimationController anim,
    required VoidCallback onTap,
    required Widget child,
  }) {
    final rotate = Tween<double>(begin: 0.0, end: 0.5)
        .animate(CurvedAnimation(parent: anim, curve: Curves.easeInOut));
    final fade = CurvedAnimation(parent: anim, curve: Curves.easeInOut);

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
        children: [
          InkWell(
            onTap: onTap,
            borderRadius: expanded
                ? const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))
                : BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: _C.primaryLt,
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(icon, color: _C.primary, size: 18),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(title,
                        style: const TextStyle(
                            color: _C.textDark, fontSize: 15,
                            fontWeight: FontWeight.w700)),
                  ),
                  RotationTransition(
                    turns: rotate,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: _C.primaryLt,
                          borderRadius: BorderRadius.circular(8)),
                      child: const Icon(Icons.keyboard_arrow_down_rounded,
                          color: _C.primary, size: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizeTransition(
            sizeFactor: fade,
            axisAlignment: -1,
            child: FadeTransition(
              opacity: fade,
              child: Column(
                children: [
                  Divider(height: 1, color: _C.border.withOpacity(0.7)),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
                    child: child,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Basic Information body ────────────────────────────────────────────────
  Widget _buildBasicBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Expanded(child: _PField(label: 'Code', ctrl: _pCodeCtrl,
              hint: 'Product code')),
          const SizedBox(width: 12),
          Expanded(child: _PDropField<String>(
            label: 'Size',
            value: _pSize.isEmpty ? null : _pSize,
            hint: 'Select size',
            items: _sizes.map((s) =>
                DropdownMenuItem(value: s, child: Text(s))).toList(),
            onChanged: (v) => setState(() => _pSize = v ?? ''),
          )),
        ]),
        const SizedBox(height: 12),
        _PField(label: 'Name', ctrl: _pNameCtrl, hint: 'Product name'),
        const SizedBox(height: 12),
        _PField(label: 'Tamil Name', ctrl: _pTamilCtrl, hint: 'தமிழ் பெயர்'),
        const SizedBox(height: 12),
        _PField(label: 'Description', ctrl: _pDescCtrl,
            hint: 'Enter description', maxLines: 2),
      ],
    );
  }

  // ── Classification body ───────────────────────────────────────────────────
  Widget _buildClassificationBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Expanded(child: _PDropField<ProductType>(
            label: 'Type', value: _pType,
            items: const [
              DropdownMenuItem(value: ProductType.goods,   child: Text('GOODS')),
              DropdownMenuItem(value: ProductType.service, child: Text('SERVICE')),
            ],
            onChanged: (v) { if (v != null) setState(() => _pType = v); },
          )),
          const SizedBox(width: 12),
          Expanded(child: _PDropField<NonTax>(
            label: 'Non Tax', value: _pNonTax,
            items: const [
              DropdownMenuItem(value: NonTax.no,  child: Text('NO')),
              DropdownMenuItem(value: NonTax.yes, child: Text('YES')),
            ],
            onChanged: (v) { if (v != null) setState(() => _pNonTax = v); },
          )),
        ]),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: _PDropField<ProductCategory>(
            label: 'Category', value: _pCategory,
            items: ProductCategory.values.map((c) =>
                DropdownMenuItem(value: c, child: Text(_categoryLabel(c))))
                .toList(),
            onChanged: (v) { if (v != null) setState(() => _pCategory = v); },
          )),
        ]),
        const SizedBox(height: 12),
        _PField(label: 'HSN/SAC Code', ctrl: _pHsnCtrl,
            hint: 'Enter HSN / SAC code',
            keyboardType: TextInputType.number),
        const SizedBox(height: 12),
        _PField(label: 'Sub Category', ctrl: _pSubCatCtrl,
            hint: 'Enter sub category'),
        const SizedBox(height: 12),
        _PField(label: 'Brand / Company', ctrl: _pBrandCtrl,
            hint: 'Enter brand or company name'),
      ],
    );
  }

  // ── Pricing & Stock body ──────────────────────────────────────────────────
  Widget _buildPricingBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Expanded(child: _PDropField<ProductTaxRate>(
            label: 'Tax Rate', value: _pTaxRate,
            items: const [
              DropdownMenuItem(value: ProductTaxRate.zero,        child: Text('0%')),
              DropdownMenuItem(value: ProductTaxRate.five,        child: Text('5%')),
              DropdownMenuItem(value: ProductTaxRate.twelve,      child: Text('12%')),
              DropdownMenuItem(value: ProductTaxRate.eighteen,    child: Text('18%')),
              DropdownMenuItem(value: ProductTaxRate.twentyEight, child: Text('28%')),
            ],
            onChanged: (v) { if (v != null) setState(() => _pTaxRate = v); },
          )),
          const SizedBox(width: 12),
          Expanded(child: _PDropField<ProductUOM>(
            label: 'UOM', value: _pUom,
            hint: 'Select UOM',
            items: const [
              DropdownMenuItem(value: ProductUOM.none,    child: Text('Select')),
              DropdownMenuItem(value: ProductUOM.kgs,     child: Text('KGS')),
              DropdownMenuItem(value: ProductUOM.ltr,     child: Text('LTR')),
              DropdownMenuItem(value: ProductUOM.nos,     child: Text('NOS')),
              DropdownMenuItem(value: ProductUOM.gms,     child: Text('GMS')),
              DropdownMenuItem(value: ProductUOM.mls,     child: Text('MLS')),
              DropdownMenuItem(value: ProductUOM.packets, child: Text('PACKETS')),
              DropdownMenuItem(value: ProductUOM.bags,    child: Text('BAGS')),
            ],
            onChanged: (v) { if (v != null) setState(() => _pUom = v); },
          )),
        ]),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: _PDropField<StockSaleType>(
            label: 'Stock Sale Type', value: _pStockSaleType,
            items: const [
              DropdownMenuItem(value: StockSaleType.stockWise, child: Text('Stock Wise')),
              DropdownMenuItem(value: StockSaleType.freeSale,  child: Text('Free Sale')),
            ],
            onChanged: (v) { if (v != null) setState(() => _pStockSaleType = v); },
          )),
          const SizedBox(width: 12),
          Expanded(child: _PField(label: 'Minimum Limit', ctrl: _pMinLimitCtrl,
              hint: '0', keyboardType: TextInputType.number)),
        ]),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: _PField(
              label: 'Point Value', ctrl: _pPointValCtrl,
              hint: '0.00',
              keyboardType:
              const TextInputType.numberWithOptions(decimal: true))),
          const Expanded(child: SizedBox()),
        ]),
      ],
    );
  }

  // ── Save button ───────────────────────────────────────────────────────────
  Widget _buildSaveProductButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade300, Colors.green.shade200],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: _C.primary.withOpacity(0.4),
            blurRadius: 16, offset: const Offset(0, 6))],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _saveProduct,
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.save_rounded,
                      color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                const Text('SAVE PRODUCT',
                    style: TextStyle(color: Colors.white, fontSize: 15,
                        fontWeight: FontWeight.w800, letterSpacing: 0.8)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveProduct() {
    if (_pNameCtrl.text.trim().isEmpty) {
      _showSnack('Please enter Product Name', _C.gold); return;
    }
    if (_pCodeCtrl.text.trim().isEmpty) {
      _showSnack('Please enter Product Code', _C.gold); return;
    }
    HapticFeedback.mediumImpact();
    final p = ProductItem(
      code:          _pCodeCtrl.text.trim(),
      name:          _pNameCtrl.text.trim(),
      size:          _pSize,
      tamilName:     _pTamilCtrl.text.trim(),
      description:   _pDescCtrl.text.trim(),
      type:          _pType,
      hsnSacCode:    _pHsnCtrl.text.trim(),
      category:      _pCategory,
      subCategory:   _pSubCatCtrl.text.trim(),
      brandCompany:  _pBrandCtrl.text.trim(),
      nonTax:        _pNonTax,
      taxRate:       _pTaxRate,
      uom:           _pUom,
      stockSaleType: _pStockSaleType,
      minimumLimit:  double.tryParse(_pMinLimitCtrl.text) ?? 0,
      pointValue:    double.tryParse(_pPointValCtrl.text) ?? 0,
    );
    setState(() {
      _savedProducts.insert(0, p);
      _pCodeCtrl.clear(); _pNameCtrl.clear(); _pTamilCtrl.clear();
      _pDescCtrl.clear(); _pHsnCtrl.clear(); _pSubCatCtrl.clear();
      _pBrandCtrl.clear(); _pMinLimitCtrl.clear(); _pPointValCtrl.clear();
      _pSize = ''; _pType = ProductType.goods;
      _pStockSaleType = StockSaleType.stockWise;
      _pNonTax = NonTax.no; _pTaxRate = ProductTaxRate.zero;
      _pUom = ProductUOM.none; _pCategory = ProductCategory.pesticides;
      _basicExpanded = true; _classificationExpanded = false; _pricingExpanded = false;
      _basicAnim.forward(); _classAnim.reverse(); _priceAnim.reverse();
      // ── After save, go to View Products (left tab) ────────────────────────
      _activeTab = _Tab.viewProducts;
    });
    _showSnack('Product "${p.name}" saved successfully!', _C.primary);
  }

  // ════════════════════════════════════════════════════════════════════════
  //  VIEW PRODUCTS TAB
  // ════════════════════════════════════════════════════════════════════════
  Widget _buildViewProducts() {
    if (_savedProducts.isEmpty) {
      return Center(
        key: const ValueKey('empty'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90, height: 90,
              decoration: const BoxDecoration(
                  color: _C.primaryLt, shape: BoxShape.circle),
              child: const Icon(Icons.inventory_2_rounded,
                  color: _C.primary, size: 44),
            ),
            const SizedBox(height: 20),
            const Text('No Products Yet',
                style: TextStyle(color: _C.textDark,
                    fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            const Text('Add a product to see it here',
                style: TextStyle(color: _C.textMid, fontSize: 14)),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => setState(() => _activeTab = _Tab.products),
              icon: const Icon(Icons.add_rounded, color: Colors.white, size: 18),
              label: const Text('Add Product',
                  style: TextStyle(color: Colors.white,
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

    final filtered = _filteredProducts;

    return Column(
      key: const ValueKey('view_products'),
      children: [
        Container(
          color: _C.surface,
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Column(
            children: [
              TextField(
                controller: _searchCtrl,
                onChanged: (v) => setState(() => _searchQuery = v),
                style: const TextStyle(color: _C.textDark, fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Search by name, code, brand…',
                  hintStyle: const TextStyle(color: _C.textLight, fontSize: 13),
                  prefixIcon: const Icon(Icons.search_rounded,
                      color: _C.primary, size: 20),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                      icon: const Icon(Icons.clear_rounded,
                          color: _C.textLight, size: 18),
                      onPressed: () {
                        _searchCtrl.clear();
                        setState(() => _searchQuery = '');
                      })
                      : null,
                  filled: true, fillColor: _C.bg,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
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
              const SizedBox(height: 10),
              Row(
                children: [
                  _MiniStat(label: 'Total',
                      value: '${_savedProducts.length}', color: _C.primary),
                  const SizedBox(width: 8),
                  _MiniStat(label: 'Showing',
                      value: '${filtered.length}', color: _C.blue),
                  const SizedBox(width: 8),
                  _MiniStat(
                    label: 'Categories',
                    value: '${_savedProducts.map((p) => p.category).toSet().length}',
                    color: _C.orange,
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 42,
          color: _C.surface,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
            children: [
              _FilterChip(
                label: 'All',
                selected: _filterCategory == null,
                color: _C.primary,
                onTap: () => setState(() => _filterCategory = null),
              ),
              ...ProductCategory.values.map((c) => Padding(
                padding: const EdgeInsets.only(left: 8),
                child: _FilterChip(
                  label: _categoryLabel(c),
                  selected: _filterCategory == c,
                  color: _categoryColor(c),
                  onTap: () => setState(() =>
                  _filterCategory = _filterCategory == c ? null : c),
                ),
              )),
            ],
          ),
        ),
        const Divider(height: 1, color: _C.border),
        Expanded(
          child: filtered.isEmpty
              ? Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.search_off_rounded,
                    size: 56, color: _C.textLight),
                const SizedBox(height: 12),
                Text('No results for "$_searchQuery"',
                    style: const TextStyle(color: _C.textMid, fontSize: 14)),
              ],
            ),
          )
              : ListView.builder(
            padding: const EdgeInsets.all(14),
            physics: const BouncingScrollPhysics(),
            itemCount: filtered.length,
            itemBuilder: (_, i) => _buildProductCard(filtered[i]),
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(ProductItem p) {
    final catColor = _categoryColor(p.category);
    final catIcon  = _categoryIcon(p.category);

    return GestureDetector(
      onTap: () => _showProductDetailSheet(p),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: _C.surface,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.06),
                blurRadius: 14, offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: catColor.withOpacity(0.08),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18), topRight: Radius.circular(18),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(
                      color: catColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(catIcon, color: catColor, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(p.name,
                            style: const TextStyle(color: _C.textDark,
                                fontSize: 14, fontWeight: FontWeight.w800),
                            maxLines: 2, overflow: TextOverflow.ellipsis),
                        if (p.size.isNotEmpty) ...[
                          const SizedBox(height: 2),
                          Text(p.size,
                              style: TextStyle(color: catColor,
                                  fontSize: 11, fontWeight: FontWeight.w700)),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: catColor.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(_categoryLabel(p.category),
                            style: TextStyle(color: catColor, fontSize: 10,
                                fontWeight: FontWeight.w800)),
                      ),
                      const SizedBox(height: 4),
                      Text('#${p.code}',
                          style: const TextStyle(color: _C.textLight,
                              fontSize: 10, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  Row(
                    children: [
                      _InfoCell(icon: Icons.percent_rounded, label: 'Tax Rate',
                          value: _taxRateLabel(p.taxRate), color: _C.primary),
                      _InfoCell(icon: Icons.scale_rounded, label: 'UOM',
                          value: _uomLabel(p.uom), color: _C.blue),
                      _InfoCell(
                        icon: Icons.storefront_rounded, label: 'Stock Type',
                        value: p.stockSaleType == StockSaleType.stockWise
                            ? 'Stock Wise' : 'Free Sale',
                        color: _C.orange,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 9),
                    decoration: BoxDecoration(
                      color: _C.primaryLt,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: _C.primary.withOpacity(0.25)),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.visibility_rounded, color: _C.primary, size: 14),
                        SizedBox(width: 6),
                        Text('TAP FOR FULL DETAILS',
                            style: TextStyle(color: _C.primary, fontSize: 11,
                                fontWeight: FontWeight.w800, letterSpacing: 0.4)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProductDetailSheet(ProductItem p) {
    final catColor = _categoryColor(p.category);
    final catIcon  = _categoryIcon(p.category);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.88,
        maxChildSize: 0.95,
        minChildSize: 0.4,
        builder: (_, ctrl) => Container(
          decoration: const BoxDecoration(
            color: _C.bg,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(28), topRight: Radius.circular(28)),
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [catColor, catColor.withOpacity(0.75)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28)),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      width: 40, height: 4,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(2)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 14, 20, 18),
                      child: Row(
                        children: [
                          Container(
                            width: 52, height: 52,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.22),
                                borderRadius: BorderRadius.circular(14)),
                            child: Icon(catIcon, color: Colors.white, size: 26),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(p.name,
                                    style: const TextStyle(color: Colors.white,
                                        fontSize: 17, fontWeight: FontWeight.w900),
                                    maxLines: 2, overflow: TextOverflow.ellipsis),
                                const SizedBox(height: 3),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text('Code: ${p.code}',
                                          style: const TextStyle(
                                              color: Colors.white, fontSize: 11,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                    if (p.size.isNotEmpty) ...[
                                      const SizedBox(width: 6),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 3),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Text(p.size,
                                            style: const TextStyle(
                                                color: Colors.white, fontSize: 11,
                                                fontWeight: FontWeight.w600)),
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close_rounded,
                                color: Colors.white, size: 22),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  controller: ctrl,
                  padding: const EdgeInsets.all(16),
                  children: [
                    Wrap(
                      spacing: 8, runSpacing: 8,
                      children: [
                        _QuickChip(icon: Icons.percent_rounded,
                            label: _taxRateLabel(p.taxRate), color: _C.primary),
                        _QuickChip(icon: Icons.scale_rounded,
                            label: _uomLabel(p.uom), color: _C.blue),
                        _QuickChip(
                          icon: Icons.inventory_rounded,
                          label: p.type == ProductType.goods ? 'GOODS' : 'SERVICE',
                          color: _C.orange,
                        ),
                        _QuickChip(
                          icon: Icons.storefront_rounded,
                          label: p.stockSaleType == StockSaleType.stockWise
                              ? 'Stock Wise' : 'Free Sale',
                          color: catColor,
                        ),
                        if (p.nonTax == NonTax.yes)
                          const _QuickChip(icon: Icons.receipt_long_rounded,
                              label: 'NON TAXABLE', color: _C.red),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _detailCard(
                      icon: Icons.info_outline_rounded,
                      title: 'Basic Information',
                      child: Column(children: [
                        _detailRow('Name', p.name),
                        if (p.tamilName.isNotEmpty)
                          _detailRow('Tamil Name', p.tamilName),
                        _detailRow('Code', p.code.isEmpty ? '—' : p.code),
                        _detailRow('Size', p.size.isEmpty ? '—' : p.size),
                        if (p.description.isNotEmpty)
                          _detailRow('Description', p.description),
                      ]),
                    ),
                    const SizedBox(height: 12),
                    _detailCard(
                      icon: Icons.category_rounded,
                      title: 'Classification',
                      child: Column(children: [
                        _detailRow('Type',
                            p.type == ProductType.goods ? 'GOODS' : 'SERVICE'),
                        _detailRow('Category', _categoryLabel(p.category)),
                        if (p.subCategory.isNotEmpty)
                          _detailRow('Sub Category', p.subCategory),
                        if (p.brandCompany.isNotEmpty)
                          _detailRow('Brand / Company', p.brandCompany),
                        _detailRow('HSN/SAC Code',
                            p.hsnSacCode.isEmpty ? '—' : p.hsnSacCode),
                        _detailRow('Non Tax',
                            p.nonTax == NonTax.no ? 'NO' : 'YES'),
                      ]),
                    ),
                    const SizedBox(height: 12),
                    _detailCard(
                      icon: Icons.price_change_rounded,
                      title: 'Pricing & Stock',
                      child: Column(children: [
                        _detailRow('Tax Rate', _taxRateLabel(p.taxRate)),
                        _detailRow('UOM', _uomLabel(p.uom)),
                        _detailRow('Stock Sale Type',
                            p.stockSaleType == StockSaleType.stockWise
                                ? 'Stock Wise' : 'Free Sale'),
                        _detailRow('Minimum Limit',
                            '${p.minimumLimit.toStringAsFixed(0)}'),
                        _detailRow('Point Value',
                            p.pointValue.toStringAsFixed(2)),
                      ]),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        setState(() => _savedProducts.remove(p));
                        _showSnack('Product deleted', _C.red);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: _C.red.withOpacity(0.07),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: _C.red.withOpacity(0.3)),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.delete_rounded, color: _C.red, size: 18),
                            SizedBox(width: 8),
                            Text('DELETE PRODUCT',
                                style: TextStyle(color: _C.red, fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.5)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailCard({
    required IconData icon,
    required String   title,
    required Widget   child,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _C.surface, borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05),
            blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(color: _C.primaryLt,
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: _C.primary, size: 16)),
          const SizedBox(width: 10),
          Text(title, style: const TextStyle(color: _C.textDark,
              fontSize: 14, fontWeight: FontWeight.w700)),
        ]),
        const SizedBox(height: 12),
        const Divider(height: 1, color: _C.border),
        const SizedBox(height: 8),
        child,
      ]),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(label,
                style: const TextStyle(color: _C.textMid,
                    fontSize: 13, fontWeight: FontWeight.w500)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(color: _C.textDark,
                    fontSize: 13, fontWeight: FontWeight.w700),
                textAlign: TextAlign.right),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
//  REUSABLE WIDGETS
// ════════════════════════════════════════════════════════════════════════════

class _PField extends StatelessWidget {
  final String label, hint;
  final TextEditingController ctrl;
  final int maxLines;
  final TextInputType keyboardType;

  const _PField({
    required this.label,
    required this.hint,
    required this.ctrl,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label,
          style: const TextStyle(color: _C.textMid, fontSize: 12,
              fontWeight: FontWeight.w600)),
      const SizedBox(height: 6),
      TextField(
        controller: ctrl,
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: const TextStyle(color: _C.textDark, fontSize: 14,
            fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: _C.textLight, fontSize: 13),
          filled: true,
          fillColor: _C.bg,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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

class _PDropField<T> extends StatelessWidget {
  final String label;
  final T? value;
  final String? hint;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;

  const _PDropField({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hint,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label,
          style: const TextStyle(color: _C.textMid, fontSize: 12,
              fontWeight: FontWeight.w600)),
      const SizedBox(height: 6),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        decoration: BoxDecoration(
            color: _C.bg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _C.border)),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            value: value,
            isExpanded: true,
            hint: hint != null
                ? Text(hint!,
                style: const TextStyle(color: _C.textLight, fontSize: 13))
                : null,
            icon: const Icon(Icons.keyboard_arrow_down_rounded,
                color: _C.primary, size: 20),
            dropdownColor: _C.surface,
            style: const TextStyle(color: _C.textDark, fontSize: 13,
                fontWeight: FontWeight.w600),
            items: items,
            onChanged: onChanged,
          ),
        ),
      ),
    ],
  );
}

class _InfoCell extends StatelessWidget {
  final IconData icon;
  final String   label;
  final String   value;
  final Color    color;

  const _InfoCell({
    required this.icon, required this.label,
    required this.value, required this.color,
  });

  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      margin: const EdgeInsets.only(right: 6),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
      decoration: BoxDecoration(
        color: color.withOpacity(0.07),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(icon, color: color, size: 11),
            const SizedBox(width: 4),
            Flexible(child: Text(label,
                style: TextStyle(color: color, fontSize: 9,
                    fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis)),
          ]),
          const SizedBox(height: 3),
          Text(value,
              style: const TextStyle(color: _C.textDark, fontSize: 11,
                  fontWeight: FontWeight.w800),
              overflow: TextOverflow.ellipsis, maxLines: 1),
        ],
      ),
    ),
  );
}

class _QuickChip extends StatelessWidget {
  final IconData icon;
  final String   label;
  final Color    color;

  const _QuickChip({
    required this.icon, required this.label, required this.color,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withOpacity(0.25)),
    ),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, color: color, size: 13),
      const SizedBox(width: 5),
      Text(label, style: TextStyle(color: color, fontSize: 11,
          fontWeight: FontWeight.w700)),
    ]),
  );
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool   selected;
  final Color  color;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label, required this.selected,
    required this.color, required this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: selected ? color : color.withOpacity(0.07),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: selected ? color : color.withOpacity(0.25)),
      ),
      child: Text(label,
          style: TextStyle(
            color: selected ? Colors.white : color,
            fontSize: 11, fontWeight: FontWeight.w700,
          )),
    ),
  );
}

class _MiniStat extends StatelessWidget {
  final String label, value;
  final Color  color;

  const _MiniStat({
    required this.label, required this.value, required this.color,
  });

  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(children: [
        Text(value, style: TextStyle(color: color, fontSize: 15,
            fontWeight: FontWeight.w900)),
        Text(label, style: const TextStyle(color: _C.textMid, fontSize: 10,
            fontWeight: FontWeight.w500)),
      ]),
    ),
  );
}