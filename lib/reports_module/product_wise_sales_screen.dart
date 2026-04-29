import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

// ─────────────────────────────────────────────────────────────────────────────
// DATA MODELS
// ─────────────────────────────────────────────────────────────────────────────
class CategoryInfo {
  final String id;
  final String name;
  const CategoryInfo({required this.id, required this.name});
}

class ProductInfo {
  final String id;
  final String name;
  final String categoryId;
  final String hsn;
  const ProductInfo({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.hsn,
  });
}

class SalesReportEntry {
  final int    sno;
  final String name;
  final String hsn;
  final double salesQty;
  final double salesAmt;
  final double returnQty;
  final double returnAmt;

  const SalesReportEntry({
    required this.sno,
    required this.name,
    required this.hsn,
    required this.salesQty,
    required this.salesAmt,
    required this.returnQty,
    required this.returnAmt,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// SAMPLE DATA
// ─────────────────────────────────────────────────────────────────────────────
final List<CategoryInfo> _allCategories = [
  CategoryInfo(id: 'C1', name: 'Fertilizers'),
  CategoryInfo(id: 'C2', name: 'Pesticides'),
  CategoryInfo(id: 'C3', name: 'Seeds'),
  CategoryInfo(id: 'C4', name: 'Tools & Equipment'),
  CategoryInfo(id: 'C5', name: 'Irrigation'),
  CategoryInfo(id: 'C6', name: 'Organic Products'),
];

final List<ProductInfo> _allProducts = [
  // Fertilizers
  ProductInfo(id: 'P01', name: 'Ammonium Sulphate',   categoryId: 'C1', hsn: '3102'),
  ProductInfo(id: 'P02', name: 'DAP Fertilizer',       categoryId: 'C1', hsn: '3105'),
  ProductInfo(id: 'P03', name: 'Potassium Chloride',   categoryId: 'C1', hsn: '3104'),
  ProductInfo(id: 'P04', name: 'Urea 46%',             categoryId: 'C1', hsn: '3102'),
  // Pesticides
  ProductInfo(id: 'P05', name: 'Chlorpyrifos 20EC',    categoryId: 'C2', hsn: '3808'),
  ProductInfo(id: 'P06', name: 'Cypermethrin 10EC',    categoryId: 'C2', hsn: '3808'),
  ProductInfo(id: 'P07', name: 'Fungicide Mancozeb',   categoryId: 'C2', hsn: '3808'),
  ProductInfo(id: 'P08', name: 'Imidacloprid 70WG',    categoryId: 'C2', hsn: '3808'),
  // Seeds
  ProductInfo(id: 'P09', name: 'Bajra Hybrid Seeds',   categoryId: 'C3', hsn: '1209'),
  ProductInfo(id: 'P10', name: 'Cotton Bt Seeds',      categoryId: 'C3', hsn: '1209'),
  ProductInfo(id: 'P11', name: 'Maize Hybrid Seeds',   categoryId: 'C3', hsn: '1209'),
  ProductInfo(id: 'P12', name: 'Paddy Seeds IR-36',    categoryId: 'C3', hsn: '1006'),
  ProductInfo(id: 'P13', name: 'Sunflower Seeds',      categoryId: 'C3', hsn: '1206'),
  ProductInfo(id: 'P14', name: 'Tomato F1 Hybrid',     categoryId: 'C3', hsn: '1209'),
  // Tools
  ProductInfo(id: 'P15', name: 'Garden Sprayer 16L',   categoryId: 'C4', hsn: '8424'),
  ProductInfo(id: 'P16', name: 'Hand Cultivator',      categoryId: 'C4', hsn: '8201'),
  ProductInfo(id: 'P17', name: 'Power Tiller',         categoryId: 'C4', hsn: '8432'),
  ProductInfo(id: 'P18', name: 'Sickle Blade',         categoryId: 'C4', hsn: '8201'),
  // Irrigation
  ProductInfo(id: 'P19', name: 'Drip Tape 16mm',       categoryId: 'C5', hsn: '3917'),
  ProductInfo(id: 'P20', name: 'Micro Sprinkler',      categoryId: 'C5', hsn: '8424'),
  ProductInfo(id: 'P21', name: 'PVC Pipe 2inch',       categoryId: 'C5', hsn: '3917'),
  ProductInfo(id: 'P22', name: 'Water Pump 1HP',       categoryId: 'C5', hsn: '8413'),
  // Organic
  ProductInfo(id: 'P23', name: 'Bio Compost 50kg',     categoryId: 'C6', hsn: '3101'),
  ProductInfo(id: 'P24', name: 'Neem Cake Powder',     categoryId: 'C6', hsn: '3808'),
  ProductInfo(id: 'P25', name: 'Vermi Compost',        categoryId: 'C6', hsn: '3101'),
];

final List<String> _salesTypes = [
  'Select One option', 'Retail', 'Wholesale', 'Credit', 'Cash',
];

List<SalesReportEntry> _getSalesData(
    String? categoryId, String? productId) {
  List<ProductInfo> products = productId != null
      ? _allProducts.where((p) => p.id == productId).toList()
      : categoryId != null
      ? _allProducts
      .where((p) => p.categoryId == categoryId)
      .toList()
      : _allProducts;

  return products.asMap().entries.map((e) {
    final p = e.value;
    // Dummy numbers — replace with real DB values
    final salesQ = (e.key + 1) * 10.0;
    final salesA = salesQ * 250;
    final retQ   = e.key % 3 == 0 ? 2.0 : 0.0;
    final retA   = retQ * 250;
    return SalesReportEntry(
      sno: e.key + 1,
      name: p.name,
      hsn: p.hsn,
      salesQty: salesQ,
      salesAmt: salesA,
      returnQty: retQ,
      returnAmt: retA,
    );
  }).toList();
}

// ─────────────────────────────────────────────────────────────────────────────
// PAGE
// ─────────────────────────────────────────────────────────────────────────────
class ProductWiseSalesPage extends StatefulWidget {
  const ProductWiseSalesPage({super.key});
  @override
  State<ProductWiseSalesPage> createState() =>
      _ProductWiseSalesPageState();
}

class _ProductWiseSalesPageState extends State<ProductWiseSalesPage>
    with SingleTickerProviderStateMixin {

  final _fromCtrl = TextEditingController();
  final _toCtrl   = TextEditingController();
  String  _salesType   = 'Select One option';
  String? _ssFilter;
  String  _destination = 'EXCEL';

  CategoryInfo? _selectedCategory;
  ProductInfo?  _selectedProduct;
  final _catCtrl  = TextEditingController();
  final _prodCtrl = TextEditingController();

  bool                     _showReport = false;
  List<SalesReportEntry>   _reportData = [];
  late AnimationController _animCtrl;
  late Animation<double>   _fadeAnim;

  final _destOptions = ['EXCEL', 'PDF', 'PRINT'];

  // Products filtered by selected category
  List<ProductInfo> get _filteredProducts => _selectedCategory == null
      ? _allProducts
      : _allProducts
      .where((p) => p.categoryId == _selectedCategory!.id)
      .toList();

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final fmt = '${now.day.toString().padLeft(2, '0')}-'
        '${now.month.toString().padLeft(2, '0')}-${now.year}';
    _fromCtrl.text = fmt;
    _toCtrl.text   = fmt;

    _animCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    _fadeAnim =
        CurvedAnimation(parent: _animCtrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    _fromCtrl.dispose();
    _toCtrl.dispose();
    _catCtrl.dispose();
    _prodCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate(TextEditingController ctrl) async {
    final parts = ctrl.text.split('-');
    DateTime init = DateTime.now();
    if (parts.length == 3) {
      init = DateTime(int.tryParse(parts[2]) ?? init.year,
          int.tryParse(parts[1]) ?? init.month,
          int.tryParse(parts[0]) ?? init.day);
    }
    final picked = await showDatePicker(
      context: context,
      initialDate: init,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (ctx, child) => Theme(
        data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
                primary: AppTheme.primaryGreen)),
        child: child!,
      ),
    );
    if (picked != null) {
      ctrl.text =
      '${picked.day.toString().padLeft(2, '0')}-'
          '${picked.month.toString().padLeft(2, '0')}-${picked.year}';
    }
  }

  void _onDisplay() {
    setState(() {
      _reportData = _getSalesData(
          _selectedCategory?.id, _selectedProduct?.id);
      _showReport = true;
    });
    _animCtrl.forward(from: 0);
  }

  void _onBack() {
    setState(() => _showReport = false);
    _animCtrl.reverse();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Column(children: [
      _appBar(),
      Expanded(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 380),
          child: _showReport
              ? _ReportView(
            key: const ValueKey('rpt'),
            data: _reportData,
            fromDate: _fromCtrl.text,
            toDate: _toCtrl.text,
            fadeAnim: _fadeAnim,
            onBack: _onBack,
          )
              : _filterForm(),
        ),
      ),
    ]),
  );

  // ── AppBar ────────────────────────────────────────────────────────────────
  Widget _appBar() => Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [AppTheme.appBarGradStart, AppTheme.appBarGradEnd],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 14),
        child: Row(children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios_new ,

              color: Colors.white,
              size: _showReport ? 20 : 24,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Text(
              'Product Wise Sales',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3),
            ),
          ),
        ]),
      ),
    ),
  );

  // ── Filter Form ───────────────────────────────────────────────────────────
  Widget _filterForm() => SingleChildScrollView(
    key: const ValueKey('form'),
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),

        // Date Range
        _card(
          icon: Icons.date_range_outlined,
          title: 'Date',
          child: GestureDetector(
            onTap: _showDateRangeDialog,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 13),
              decoration: BoxDecoration(
                color: AppTheme.surfaceCard,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppTheme.lightGreen),
              ),
              child: Row(children: [
                const Icon(Icons.calendar_month,
                    color: AppTheme.primaryGreen, size: 18),
                const SizedBox(width: 10),
                Text('${_fromCtrl.text} - ${_toCtrl.text}',
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textDark)),
                const Spacer(),
                const Icon(Icons.edit_calendar_outlined,
                    color: AppTheme.textMuted, size: 16),
              ]),
            ),
          ),
        ),

        const SizedBox(height: 14),

        // Sales Type
        _card(
          icon: Icons.point_of_sale_outlined,
          title: 'Sales Type',
          child: _dropdown(
            value: _salesType,
            items: _salesTypes,
            onChanged: (v) => setState(() => _salesType = v!),
          ),
        ),

        const SizedBox(height: 14),

        // Include / Exclude SS
        _card(
          icon: Icons.filter_alt_outlined,
          title: 'SS Filter',
          child: Row(
            children: ['Include SS', 'Exclude SS'].map((opt) {
              final sel = _ssFilter == opt;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(
                          () => _ssFilter = sel ? null : opt),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 4),
                    padding:
                    const EdgeInsets.symmetric(vertical: 9),
                    decoration: BoxDecoration(
                      color: sel
                          ? AppTheme.primaryGreen
                          : AppTheme.surfaceCard,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: sel
                              ? AppTheme.deepGreen
                              : AppTheme.lightGreen),
                    ),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration:
                          const Duration(milliseconds: 180),
                          width: 14, height: 14,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: sel
                                ? Colors.white
                                : Colors.transparent,
                            border: Border.all(
                              color: sel
                                  ? Colors.white
                                  : AppTheme.textMuted,
                              width: 1.5,
                            ),
                          ),
                          child: sel
                              ? const Icon(Icons.check,
                              size: 9,
                              color: AppTheme.deepGreen)
                              : null,
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(opt,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: sel
                                      ? Colors.white
                                      : AppTheme.textDark),
                              overflow:
                              TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 14),

        // Category Autocomplete
        _card(
          icon: Icons.category_outlined,
          title: 'Category',
          child: _buildCategoryAutocomplete(),
        ),
        if (_selectedCategory != null) ...[
          const SizedBox(height: 8),
          _selectedChip(
              _selectedCategory!.name, Icons.category,
                  () => setState(() {
                _selectedCategory = null;
                _catCtrl.clear();
                _selectedProduct = null;
                _prodCtrl.clear();
              })),
        ],

        const SizedBox(height: 14),

        // Product Autocomplete
        _card(
          icon: Icons.inventory_2_outlined,
          title: 'Product',
          child: _buildProductAutocomplete(),
        ),
        if (_selectedProduct != null) ...[
          const SizedBox(height: 8),
          _selectedChip(
              '${_selectedProduct!.name}  •  HSN: ${_selectedProduct!.hsn}',
              Icons.inventory_2,
                  () => setState(() {
                _selectedProduct = null;
                _prodCtrl.clear();
              })),
        ],

        const SizedBox(height: 14),

        // Destination
        _card(
          icon: Icons.output_outlined,
          title: 'Destination',
          child: _dropdown(
            value: _destination,
            items: _destOptions,
            onChanged: (v) => setState(() => _destination = v!),
          ),
        ),

        const SizedBox(height: 28),

        // DISPLAY
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: _onDisplay,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryGreen,
              foregroundColor: Colors.white,
              elevation: 4,
              shadowColor: AppTheme.deepGreen.withOpacity(0.4),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.bar_chart_rounded, size: 20),
                SizedBox(width: 10),
                Text('DISPLAY',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    ),
  );

  // ── Category Autocomplete ─────────────────────────────────────────────────
  Widget _buildCategoryAutocomplete() {
    return Autocomplete<CategoryInfo>(
      optionsBuilder: (tv) {
        if (tv.text.isEmpty) return _allCategories;
        return _allCategories.where((c) =>
            c.name.toLowerCase().contains(tv.text.toLowerCase()));
      },
      displayStringForOption: (c) => c.name,
      onSelected: (c) => setState(() {
        _selectedCategory = c;
        // reset product if category changes
        _selectedProduct = null;
        _prodCtrl.clear();
      }),
      fieldViewBuilder: (ctx, ctrl, fn, onSub) =>
          _autocompleteField(ctrl, fn, 'Select Option',
              Icons.category_outlined),
      optionsViewBuilder: (ctx, onSel, opts) =>
          _optionsView(opts, onSel,
                  (c) => c.name, (c) => c.id, Icons.category),
    );
  }

  // ── Product Autocomplete ──────────────────────────────────────────────────
  Widget _buildProductAutocomplete() {
    return Autocomplete<ProductInfo>(
      optionsBuilder: (tv) {
        final list = _filteredProducts;
        if (tv.text.isEmpty) return list;
        return list.where((p) =>
        p.name.toLowerCase().contains(tv.text.toLowerCase()) ||
            p.hsn.contains(tv.text));
      },
      displayStringForOption: (p) => p.name,
      onSelected: (p) => setState(() => _selectedProduct = p),
      fieldViewBuilder: (ctx, ctrl, fn, onSub) =>
          _autocompleteField(ctrl, fn, 'Select Option',
              Icons.inventory_2_outlined),
      optionsViewBuilder: (ctx, onSel, opts) =>
          _optionsView(opts, onSel,
                  (p) => p.name, (p) => 'HSN: ${p.hsn}',
              Icons.inventory_2),
    );
  }

  // ── Shared autocomplete field ─────────────────────────────────────────────
  Widget _autocompleteField(TextEditingController ctrl,
      FocusNode fn, String hint, IconData icon) {
    return TextField(
      controller: ctrl,
      focusNode: fn,
      style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppTheme.textDark),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:
        const TextStyle(color: AppTheme.textMuted, fontSize: 14),
        prefixIcon:
        Icon(icon, color: AppTheme.primaryGreen, size: 20),
        suffixIcon: ctrl.text.isNotEmpty
            ? GestureDetector(
          onTap: () => ctrl.clear(),
          child: const Icon(Icons.close,
              color: AppTheme.textMuted, size: 18),
        )
            : const Icon(Icons.keyboard_arrow_down,
            color: AppTheme.primaryGreen, size: 20),
        filled: true,
        fillColor: AppTheme.surfaceCard,
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 14, vertical: 12),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
                color: AppTheme.lightGreen, width: 1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
                color: AppTheme.primaryGreen, width: 1.5)),
      ),
    );
  }

  // ── Shared options dropdown ───────────────────────────────────────────────
  Widget _optionsView<T extends Object>(
      Iterable<T> opts,
      AutocompleteOnSelected<T> onSel,
      String Function(T) primary,
      String Function(T) secondary,
      IconData icon) {
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(12),
        shadowColor: AppTheme.primaryGreen.withOpacity(0.2),
        child: Container(
          constraints:
          const BoxConstraints(maxHeight: 230, maxWidth: 320),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: AppTheme.lightGreen.withOpacity(0.4)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: opts.length,
              separatorBuilder: (_, __) => Divider(
                  height: 1,
                  color: AppTheme.lightGreen.withOpacity(0.3)),
              itemBuilder: (ctx, i) {
                final item = opts.elementAt(i);
                return InkWell(
                  onTap: () => onSel(item),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    child: Row(children: [
                      Container(
                        width: 34, height: 34,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryGreen
                              .withOpacity(0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            primary(item)[0].toUpperCase(),
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.deepGreen),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(primary(item),
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.textDark)),
                            Text(secondary(item),
                                style: const TextStyle(
                                    fontSize: 11,
                                    color: AppTheme.textMuted)),
                          ],
                        ),
                      ),
                    ]),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  // ── Selected chip ─────────────────────────────────────────────────────────
  Widget _selectedChip(
      String label, IconData icon, VoidCallback onClear) {
    return Container(
      padding:
      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.primaryGreen.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: AppTheme.primaryGreen.withOpacity(0.3)),
      ),
      child: Row(children: [
        const Icon(Icons.check_circle,
            color: AppTheme.primaryGreen, size: 16),
        const SizedBox(width: 8),
        Expanded(
          child: Text(label,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.deepGreen)),
        ),
        GestureDetector(
          onTap: onClear,
          child: const Icon(Icons.close,
              color: AppTheme.textMuted, size: 16),
        ),
      ]),
    );
  }

  // ── Date range dialog ─────────────────────────────────────────────────────
  Future<void> _showDateRangeDialog() async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)),
        title: const Text('Select Date Range',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppTheme.textDark)),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          _dateRow('From', _fromCtrl),
          const SizedBox(height: 12),
          _dateRow('To', _toCtrl),
        ]),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Done',
                style: TextStyle(
                    color: AppTheme.primaryGreen,
                    fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
    setState(() {});
  }

  Widget _dateRow(String label, TextEditingController ctrl) =>
      GestureDetector(
        onTap: () => _pickDate(ctrl),
        child: AbsorbPointer(
          child: TextField(
            controller: ctrl,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.textDark),
            decoration: InputDecoration(
              labelText: label,
              labelStyle: const TextStyle(
                  color: AppTheme.textMuted, fontSize: 13),
              prefixIcon: const Icon(Icons.calendar_today,
                  color: AppTheme.primaryGreen, size: 18),
              filled: true,
              fillColor: AppTheme.surfaceCard,
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 10),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: AppTheme.lightGreen, width: 1)),
            ),
          ),
        ),
      );

  // ── Helpers ───────────────────────────────────────────────────────────────
  Widget _card({
    required IconData icon,
    required String title,
    required Widget child,
  }) =>
      Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
                color: AppTheme.primaryGreen.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon,
                    size: 16, color: AppTheme.deepGreen),
              ),
              const SizedBox(width: 8),
              Text(title,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textMuted,
                      letterSpacing: 0.4)),
            ]),
            const SizedBox(height: 12),
            child,
          ],
        ),
      );

  Widget _dropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) =>
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: AppTheme.surfaceCard,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppTheme.lightGreen),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            icon: const Icon(Icons.keyboard_arrow_down,
                color: AppTheme.primaryGreen),
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppTheme.textDark),
            dropdownColor: Colors.white,
            items: items
                .map((s) =>
                DropdownMenuItem(value: s, child: Text(s)))
                .toList(),
            onChanged: onChanged,
          ),
        ),
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// REPORT VIEW
// ─────────────────────────────────────────────────────────────────────────────
class _ReportView extends StatelessWidget {
  final List<SalesReportEntry> data;
  final String                 fromDate;
  final String                 toDate;
  final Animation<double>      fadeAnim;
  final VoidCallback           onBack;

  const _ReportView({
    super.key,
    required this.data,
    required this.fromDate,
    required this.toDate,
    required this.fadeAnim,
    required this.onBack,
  });

  double get _totSalesQty  => data.fold(0, (s, e) => s + e.salesQty);
  double get _totSalesAmt  => data.fold(0, (s, e) => s + e.salesAmt);
  double get _totReturnQty => data.fold(0, (s, e) => s + e.returnQty);
  double get _totReturnAmt => data.fold(0, (s, e) => s + e.returnAmt);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnim,
      child: Column(children: [
        // PRINT / EXCEL buttons
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 20, vertical: 12),
          child: Row(children: [
            _actionBtn(
                Icons.print_outlined, 'PRINT', AppTheme.deepGreen),
            const SizedBox(width: 12),
            _actionBtn(Icons.table_chart_outlined, 'EXCEL',
                AppTheme.primaryGreen),
          ]),
        ),

        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            child: Column(children: [
              // Company header
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      AppTheme.darkCard1,
                      AppTheme.darkCard3
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(14)),
                  boxShadow: [
                    BoxShadow(
                        color: AppTheme.deepGreen.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4)),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color:
                          AppTheme.accentLime.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.eco,
                            color: AppTheme.accentLime, size: 18),
                      ),
                      const SizedBox(width: 10),
                      const Text('Demo Software',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  _hLine(Icons.payment,
                      'GPAY : 9047099444 / 9047099447'),
                  const SizedBox(height: 2),
                  _hLine(Icons.receipt_long,
                      'GSTIN: PL.NO:CBE/PL/0001  FL.NO:FL 2025-2030\nSL.NO: CBE/SL/0003'),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 6),
                    decoration: BoxDecoration(
                      color:
                      AppTheme.primaryGreen.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: AppTheme.lightGreen
                              .withOpacity(0.4)),
                    ),
                    child: const Text('Product Wise Sales Reports',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8)),
                  ),
                  const SizedBox(height: 8),
                  Text('FROM: $fromDate  TO: $toDate',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.65),
                          fontSize: 11)),
                ]),
              ),

              // Table
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(14)),
                  boxShadow: [
                    BoxShadow(
                        color: AppTheme.primaryGreen
                            .withOpacity(0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 4)),
                  ],
                ),
                child: Column(children: [
                  _SalesRow(
                    cells: const [
                      'SNO', 'NAME', 'HSN',
                      'SALES\nQTY', 'SALES\nAMT',
                      'RETURN\nQTY', 'RETURN\nAMT'
                    ],
                    isHeader: true,
                  ),

                  if (data.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(children: [
                        Icon(Icons.inbox_outlined,
                            size: 48,
                            color: AppTheme.lightGreen),
                        const SizedBox(height: 8),
                        const Text('No records found',
                            style: TextStyle(
                                color: AppTheme.textMuted,
                                fontSize: 14)),
                      ]),
                    )
                  else
                    ...data.asMap().entries.map((entry) {
                      final i = entry.key;
                      final e = entry.value;
                      return _SalesRow(
                        cells: [
                          e.sno.toString(),
                          e.name,
                          e.hsn,
                          e.salesQty.toStringAsFixed(0),
                          e.salesAmt.toStringAsFixed(2),
                          e.returnQty.toStringAsFixed(0),
                          e.returnAmt.toStringAsFixed(2),
                        ],
                        isEven: i.isEven,
                      );
                    }),

                  // Total
                  _SalesRow(
                    cells: [
                      '', 'TOTAL', '',
                      _totSalesQty.toStringAsFixed(0),
                      _totSalesAmt.toStringAsFixed(2),
                      _totReturnQty.toStringAsFixed(0),
                      _totReturnAmt.toStringAsFixed(2),
                    ],
                    isTotal: true,
                  ),
                ]),
              ),
            ]),
          ),
        ),
      ]),
    );
  }

  Widget _hLine(IconData icon, String text) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 1),
    child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 12, color: AppTheme.lightGreen),
          const SizedBox(width: 6),
          Flexible(
            child: Text(text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.75),
                    fontSize: 11)),
          ),
        ]),
  );

  Widget _actionBtn(
      IconData icon, String label, Color color) =>
      Expanded(
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: Icon(icon, size: 16),
          label: Text(label,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8)),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            elevation: 3,
            shadowColor: color.withOpacity(0.4),
          ),
        ),
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// TABLE ROW
// ─────────────────────────────────────────────────────────────────────────────
class _SalesRow extends StatelessWidget {
  final List<String> cells;
  final bool isHeader;
  final bool isEven;
  final bool isTotal;

  const _SalesRow({
    required this.cells,
    this.isHeader = false,
    this.isEven   = false,
    this.isTotal  = false,
  });

  @override
  Widget build(BuildContext context) {
    Color bg = Colors.transparent;
    if (isHeader) bg = AppTheme.deepGreen;
    else if (isTotal) bg = AppTheme.surfaceCard;
    else if (isEven)  bg = AppTheme.scaffoldBg;

    // SNO, NAME, HSN, SALES QTY, SALES AMT, RETURN QTY, RETURN AMT
    const flex = [1, 3, 2, 2, 2, 2, 2];

    return Container(
      color: bg,
      padding:
      const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Row(
        children: List.generate(cells.length, (i) {
          final rightAlign = i >= 3;
          Color textColor = isHeader
              ? Colors.white
              : isTotal
              ? AppTheme.deepGreen
              : AppTheme.textDark;

          return Expanded(
            flex: flex[i],
            child: Text(
              cells[i],
              textAlign: rightAlign
                  ? TextAlign.right
                  : TextAlign.left,
              style: TextStyle(
                fontSize: isHeader ? 10 : 11,
                fontWeight: (isHeader || isTotal)
                    ? FontWeight.w700
                    : FontWeight.w400,
                color: textColor,
                height: 1.3,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          );
        }),
      ),
    );
  }
}