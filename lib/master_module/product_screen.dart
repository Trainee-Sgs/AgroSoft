import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ── Colors ────────────────────────────────────────────────────────────────────
class _C {
  static const bg        = Color(0xFFF4F6F9);
  static const surface   = Colors.white;
  static const primary   = Color(0xFF1B8A3E);
  static const primaryDk = Color(0xFF136B2F);
  static const primaryLt = Color(0xFFE8F5ED);
  static const textDark  = Color(0xFF1A1E2C);
  static const textMid   = Color(0xFF6B7280);
  static const textLight = Color(0xFFB0B8C5);
  static const gold      = Color(0xFFF59E0B);
  static const border    = Color(0xFFE2E8F0);
}

// ── Field type ────────────────────────────────────────────────────────────────
enum _FType { text, dropdown, multiline, number, date }

// ── Layout width ──────────────────────────────────────────────────────────────
enum _FWidth { half, full }

class _FDef {
  final String        label;
  final String        hint;
  final IconData      icon;
  final _FType        type;
  final _FWidth       width;
  final List<String>? opts;
  final String?       defaultVal;

  const _FDef({
    required this.label,
    required this.hint,
    required this.icon,
    this.type       = _FType.text,
    this.width      = _FWidth.half,
    this.opts,
    this.defaultVal,
  });

  bool get isMulti     => type == _FType.multiline;
  bool get isDropdown  => type == _FType.dropdown;
  bool get isFullWidth => width == _FWidth.full;
}

// ── Sizes ─────────────────────────────────────────────────────────────────────
const double _kInputH = 44.0;
const double _kMultiH = 88.0;
const double _kLabelH = 17.0;
const double _kGap1   =  4.0;
const double _kGap2   = 12.0;

// ── Section definition (flat field list) ─────────────────────────────────────
class _Section {
  final String      title;
  final IconData    icon;
  final List<_FDef> fields;
  const _Section({
    required this.title,
    required this.icon,
    required this.fields,
  });
}

const List<_Section> _sections = [
  // ── Section 1: Basic Information ──────────────────────────────────────────
  _Section(
    title: 'Basic Information',
    icon: Icons.inventory_2_rounded,
    fields: [
      // Row 1: Code | GST Type
      _FDef(label: 'Code',         hint: 'Code',              icon: Icons.qr_code_rounded),
      _FDef(label: 'GST Type',     hint: 'Select One option', icon: Icons.receipt_long_rounded,
          type: _FType.dropdown, opts: ['Regular','Composition','Unregistered','Consumer']),
      // Row 2: Category | Material Type
      _FDef(label: 'Category',     hint: 'Select Option',     icon: Icons.category_rounded,
          type: _FType.dropdown, opts: ['Seeds','Fertilizer','Pesticide','Equipment','Other']),
      _FDef(label: 'Material Type',hint: 'Select One option', icon: Icons.category_outlined,
          type: _FType.dropdown, opts: ['Raw Material','Finished Goods','Semi-Finished','Trading']),
      // Row 3: Sub Category | UOM
      _FDef(label: 'Sub Category', hint: 'Select Option',     icon: Icons.account_tree_rounded,
          type: _FType.dropdown, opts: ['Hybrid Seeds','Paddy','Vegetables','Pulses','Other']),
      _FDef(label: 'UOM',          hint: 'Select Option',     icon: Icons.straighten_rounded,
          type: _FType.dropdown, opts: ['Kg','Grams','Litre','ML','Nos','Bags','Packets']),
      // Row 4: Product Name (full width)
      _FDef(label: 'Product Name', hint: 'Product Name',      icon: Icons.inventory_2_rounded,
          width: _FWidth.full),
      // Row 5: Description (full width, multiline)
      _FDef(label: 'Description',  hint: 'Description',       icon: Icons.description_rounded,
          type: _FType.multiline, width: _FWidth.full),
      // Row 6: SKU/Case | Size/Model
      _FDef(label: 'SKU/Case',     hint: 'SKU/Case',          icon: Icons.cases_rounded,
          type: _FType.number),
      _FDef(label: 'Size/Model',   hint: 'Size/Model',        icon: Icons.straighten_rounded),
      // Row 7: HSN/SAC | Price Group
      _FDef(label: 'HSN/SAC',      hint: 'HSN/SAC',           icon: Icons.numbers_rounded),
      _FDef(label: 'Price Group',  hint: 'Select Option',     icon: Icons.group_work_rounded,
          type: _FType.dropdown, opts: ['Group A','Group B','Group C','Default']),
    ],
  ),

  // ── Section 2: Pricing & Tax ──────────────────────────────────────────────
  _Section(
    title: 'Pricing & Tax',
    icon: Icons.currency_rupee_rounded,
    fields: [
      _FDef(label: 'Price',      hint: 'Price',             icon: Icons.currency_rupee_rounded,
          type: _FType.number),
      _FDef(label: 'TOD - DAYS', hint: 'TOD - DAYS',        icon: Icons.timer_rounded,
          type: _FType.number),
      _FDef(label: 'Sales Type', hint: 'Both',              icon: Icons.swap_horiz_rounded,
          type: _FType.dropdown, opts: ['Both','Purchase','Sale'], defaultVal: 'Both'),
      _FDef(label: 'Non Tax',    hint: 'Select One option', icon: Icons.money_off_rounded,
          type: _FType.dropdown, opts: ['Yes','No']),
      _FDef(label: 'GST',        hint: 'Select One option', icon: Icons.percent_rounded,
          type: _FType.dropdown, opts: ['0%','5%','12%','18%','28%']),
      _FDef(label: 'MRP',        hint: 'MRP',               icon: Icons.currency_rupee_rounded,
          type: _FType.number),
    ],
  ),

  // ── Section 3: Stock & Verification ──────────────────────────────────────
  _Section(
    title: 'Stock & Verification',
    icon: Icons.verified_rounded,
    fields: [
      _FDef(label: 'QC Verification', hint: 'Select One option', icon: Icons.verified_rounded,
          type: _FType.dropdown, opts: ['Required','Not Required']),
      _FDef(label: 'Stock Sale Type', hint: 'Select One option', icon: Icons.sell_rounded,
          type: _FType.dropdown, opts: ['FIFO','LIFO','Weighted Average']),
      _FDef(label: 'Minimum Limit',   hint: 'Minimum Limit',     icon: Icons.arrow_downward_rounded,
          type: _FType.number),
      _FDef(label: 'Barcode',         hint: 'Barcode',           icon: Icons.barcode_reader),
      _FDef(label: 'Expiry Date',     hint: 'Expiry Date',       icon: Icons.calendar_month_rounded,
          type: _FType.date),
      _FDef(label: 'Active',          hint: 'Select Option',     icon: Icons.toggle_on_rounded,
          type: _FType.dropdown, opts: ['Yes','No'], defaultVal: 'Yes'),
    ],
  ),
];

// ── All fields combined (for save/clear) ─────────────────────────────────────
List<_FDef> get _allFields =>
    _sections.expand((s) => s.fields).toList();

// ── Product model ─────────────────────────────────────────────────────────────
class ProductEntry {
  final String             id;
  final Map<String,String> data;
  final DateTime           createdAt;
  ProductEntry({required this.id, required this.data, required this.createdAt});

  String get name     => data['Product Name'] ?? '—';
  String get category => data['Category']     ?? '—';
  String get code     => data['Code']         ?? '—';
  String get price    => data['Price']        ?? '—';
  String get gst      => data['GST']          ?? '—';
  String get uom      => data['UOM']          ?? '—';
}

// ── Screen ────────────────────────────────────────────────────────────────────
class ProductMasterScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const ProductMasterScreen({super.key, this.onBack});

  @override
  State<ProductMasterScreen> createState() => _ProductMasterScreenState();
}

class _ProductMasterScreenState extends State<ProductMasterScreen>
    with TickerProviderStateMixin {

  bool _showList = false;

  final Map<String, bool> _sectionExpanded = {
    'Basic Information'    : false,
    'Pricing & Tax'        : false,
    'Stock & Verification' : false,
  };

  final List<ProductEntry>                _entries = [];
  final Map<String,TextEditingController> _ctrl    = {};
  final Map<String,String>                _drop    = {};
  final Map<String,DateTime>              _dates   = {};

  @override
  void initState() {
    super.initState();
    for (final f in _allFields) {
      if (!f.isDropdown && f.type != _FType.date) {
        _ctrl[f.label] = TextEditingController();
      }
      if (f.defaultVal != null && f.isDropdown) {
        _drop[f.label] = f.defaultVal!;
      }
    }
  }

  @override
  void dispose() {
    for (final c in _ctrl.values) c.dispose();
    super.dispose();
  }

  // ── Helpers ───────────────────────────────────────────────────────────────
  String _val(_FDef f) {
    if (f.isDropdown)      return _drop[f.label] ?? '';
    if (f.type == _FType.date) {
      final d = _dates[f.label];
      return d == null
          ? ''
          : '${d.day.toString().padLeft(2,'0')}-'
          '${d.month.toString().padLeft(2,'0')}-${d.year}';
    }
    return _ctrl[f.label]?.text ?? '';
  }

  bool get _isValid =>
      (_ctrl['Product Name']?.text.trim() ?? '').isNotEmpty &&
          (_drop['Category'] ?? '').isNotEmpty;

  void _save() {
    if (!_isValid) {
      _snack('Please fill Category & Product Name', _C.gold);
      return;
    }
    HapticFeedback.mediumImpact();

    final data = {for (final f in _allFields) f.label: _val(f)};
    final entry = ProductEntry(
      id: 'PM-${DateTime.now().millisecondsSinceEpoch}',
      data: data,
      createdAt: DateTime.now(),
    );

    for (final c in _ctrl.values) c.clear();
    _drop.clear();
    _dates.clear();
    for (final f in _allFields) {
      if (f.defaultVal != null && f.isDropdown) {
        _drop[f.label] = f.defaultVal!;
      }
    }
    _sectionExpanded.updateAll((key, value) => false);

    setState(() {
      _entries.insert(0, entry);
      _showList = true;
    });
    _snack('Product "${entry.name}" saved!', _C.primary);
  }

  void _snack(String msg, Color c) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(msg,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600)),
        backgroundColor: c,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ));

  Future<void> _pickDate(_FDef f) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dates[f.label] ?? DateTime.now(),
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
    if (picked != null) setState(() => _dates[f.label] = picked);
  }

  // ── Build rows from flat field list ───────────────────────────────────────
  List<List<_FDef>> _buildRows(List<_FDef> fields) {
    final rows = <List<_FDef>>[];
    int i = 0;
    while (i < fields.length) {
      final f = fields[i];
      if (f.isFullWidth) {
        rows.add([f]);
        i++;
      } else {
        if (i + 1 < fields.length && !fields[i + 1].isFullWidth) {
          rows.add([f, fields[i + 1]]);
          i += 2;
        } else {
          rows.add([f]);
          i++;
        }
      }
    }
    return rows;
  }

  // ── Build ─────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: _C.bg,
    resizeToAvoidBottomInset: true,
    body: Column(children: [
      _header(),
      Expanded(child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 260),
        child: _showList ? _listView() : _formView(),
      )),
    ]),
  );

  // ── Header ────────────────────────────────────────────────────────────────
  Widget _header() => Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF1B8A3E), Color(0xFF136B2F)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [BoxShadow(
        color: Color(0x441B8A3E), blurRadius: 16, offset: Offset(0, 6),
      )],
    ),
    child: SafeArea(bottom: false, child: Column(mainAxisSize: MainAxisSize.min, children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(4, 4, 12, 0),
        child: Row(children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.white, size: 20),
            onPressed: () {
              if (Navigator.canPop(context)) Navigator.pop(context);
              else widget.onBack?.call();
            },
          ),
          const Expanded(child: Text('Product Master',
              style: TextStyle(color: Colors.white, fontSize: 19,
                  fontWeight: FontWeight.w800, letterSpacing: 0.3))),

        ]),
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
          child: Row(children: [
            _tab('New Product', Icons.add_circle_outline_rounded,
                !_showList, () => setState(() => _showList = false)),
            _tab('Product List', Icons.list_alt_rounded,
                _showList,  () => setState(() => _showList = true)),
          ]),
        ),
      ),
    ])),
  );

  Widget _tab(String label, IconData icon, bool active, VoidCallback onTap) =>
      Expanded(child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: active ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: active
                ? [BoxShadow(color: Colors.black.withOpacity(0.10),
                blurRadius: 8, offset: const Offset(0, 2))]
                : [],
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(icon, size: 16,
                color: active ? _C.primary : Colors.white.withOpacity(0.75)),
            const SizedBox(width: 6),
            Text(label, style: TextStyle(
              fontSize: 13,
              fontWeight: active ? FontWeight.w700 : FontWeight.w500,
              color: active ? _C.primary : Colors.white.withOpacity(0.75),
            )),
          ]),
        ),
      ));

  // ── Form view ─────────────────────────────────────────────────────────────
  Widget _formView() => Column(
    key: const ValueKey('form'),
    children: [
      Expanded(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              for (int si = 0; si < _sections.length; si++) ...[
                if (si > 0) const SizedBox(height: 12),
                _accordionSection(_sections[si]),
              ],
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      _saveBar(),
      SizedBox(height: MediaQuery.of(context).padding.bottom + 10),
    ],
  );

  // ── Accordion Section ─────────────────────────────────────────────────────
  Widget _accordionSection(_Section s) {
    final isExpanded = _sectionExpanded[s.title] ?? false;
    final rows       = _buildRows(s.fields);

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
          // ── Accordion Header (no field count badge) ────────────────────
          InkWell(
            onTap: () {
              HapticFeedback.lightImpact();
              setState(() => _sectionExpanded[s.title] = !isExpanded);
            },
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
              child: Row(children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: isExpanded ? _C.primary : _C.primaryLt,
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(s.icon,
                      color: isExpanded ? Colors.white : _C.primary,
                      size: 18),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(s.title,
                      style: const TextStyle(
                          color: _C.textDark,
                          fontSize: 15,
                          fontWeight: FontWeight.w700)),
                ),
                // ── No field count badge ──────────────────────────────
                const SizedBox(width: 8),
                AnimatedRotation(
                  turns: isExpanded ? 0.5 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: isExpanded ? _C.primary : _C.textMid,
                    size: 24,
                  ),
                ),
              ]),
            ),
          ),

          // ── Animated expand/collapse ───────────────────────────────────
          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity, height: 0),
            secondChild: Column(
              children: [
                const Divider(height: 1, color: _C.border),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
                  child: Column(
                    children: [
                      for (int ri = 0; ri < rows.length; ri++) ...[
                        if (ri > 0) const SizedBox(height: _kGap2),
                        _renderRow(rows[ri]),
                      ],
                    ],
                  ),
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

  // ── Render a row ──────────────────────────────────────────────────────────
  Widget _renderRow(List<_FDef> row) {
    if (row.length == 1 && row[0].isFullWidth) {
      // Full-width field
      return _cell(row[0], row[0].isMulti ? _kMultiH : _kInputH);
    } else if (row.length == 2) {
      final h = (row[0].isMulti || row[1].isMulti) ? _kMultiH : _kInputH;
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _cell(row[0], h)),
          const SizedBox(width: _kGap2),
          Expanded(child: _cell(row[1], h)),
        ],
      );
    } else {
      // Lone half-width — left aligned, right side empty
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _cell(row[0], _kInputH)),
          const Expanded(child: SizedBox()),
        ],
      );
    }
  }

  // ── Cell: label + input ───────────────────────────────────────────────────
  Widget _cell(_FDef f, double inputH) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(
        height: _kLabelH,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(f.label,
              style: const TextStyle(color: _C.textMid, fontSize: 11,
                  fontWeight: FontWeight.w600, letterSpacing: 0.1),
              overflow: TextOverflow.ellipsis),
        ),
      ),
      const SizedBox(height: _kGap1),
      SizedBox(
        height: inputH,
        width: double.infinity,
        child: f.isDropdown         ? _dropdown(f)
            : f.type == _FType.date ? _datePicker(f)
            :                         _input(f),
      ),
    ],
  );

  // ── Text / multiline input ────────────────────────────────────────────────
  Widget _input(_FDef f) => TextField(
    controller: _ctrl[f.label],
    maxLines: f.isMulti ? null : 1,
    expands:  f.isMulti,
    textAlignVertical: f.isMulti
        ? TextAlignVertical.top : TextAlignVertical.center,
    keyboardType: f.type == _FType.number
        ? TextInputType.number : TextInputType.text,
    style: const TextStyle(color: _C.textDark, fontSize: 12,
        fontWeight: FontWeight.w500),
    decoration: InputDecoration(
      hintText: f.hint,
      hintStyle: const TextStyle(color: _C.textLight, fontSize: 12),
      filled: true,
      fillColor: _C.bg,
      isDense: true,
      contentPadding: f.isMulti
          ? const EdgeInsets.fromLTRB(10, 10, 10, 10)
          : const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: _C.border)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: _C.border)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: _C.primary, width: 1.5)),
    ),
  );

  // ── Dropdown ──────────────────────────────────────────────────────────────
  Widget _dropdown(_FDef f) {
    final val = _drop[f.label];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: _C.bg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _C.border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: val,
          isExpanded: true,
          isDense: true,
          hint: Text(f.hint,
              style: const TextStyle(color: _C.textLight, fontSize: 12),
              overflow: TextOverflow.ellipsis),
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: _C.primary, size: 18),
          dropdownColor: _C.surface,
          style: const TextStyle(color: _C.textDark, fontSize: 12,
              fontWeight: FontWeight.w600),
          items: f.opts!.map((o) => DropdownMenuItem(
            value: o,
            child: Text(o,
                style: const TextStyle(fontSize: 12),
                overflow: TextOverflow.ellipsis),
          )).toList(),
          onChanged: (v) {
            if (v != null) setState(() => _drop[f.label] = v);
          },
        ),
      ),
    );
  }

  // ── Date picker ───────────────────────────────────────────────────────────
  Widget _datePicker(_FDef f) {
    final d   = _dates[f.label];
    final txt = d == null
        ? f.hint
        : '${d.day.toString().padLeft(2,'0')}-'
        '${d.month.toString().padLeft(2,'0')}-${d.year}';
    return GestureDetector(
      onTap: () => _pickDate(f),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: _C.bg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _C.border),
        ),
        child: Row(children: [
          Expanded(child: Text(txt,
              style: TextStyle(
                color: d == null ? _C.textLight : _C.textDark,
                fontSize: 12, fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis)),
          const Icon(Icons.calendar_month_rounded, color: _C.primary, size: 16),
        ]),
      ),
    );
  }

  // ── Save bar ──────────────────────────────────────────────────────────────
  Widget _saveBar() => Padding(
    padding: const EdgeInsets.fromLTRB(14, 0, 14, 8),
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.green.shade400, Colors.green.shade700]),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(
          color: _C.primary.withOpacity(0.4),
          blurRadius: 12, offset: const Offset(0, 4),
        )],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _save,
          borderRadius: BorderRadius.circular(16),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.save_rounded, color: Colors.white, size: 20),
              SizedBox(width: 10),
              Text('SAVE PRODUCT',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8)),
            ]),
          ),
        ),
      ),
    ),
  );

  // ── List view ─────────────────────────────────────────────────────────────
  Widget _listView() {
    if (_entries.isEmpty) {
      return Center(
        key: const ValueKey('empty'),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            width: 90, height: 90,
            decoration: const BoxDecoration(
                color: _C.primaryLt, shape: BoxShape.circle),
            child: const Icon(Icons.inventory_2_rounded,
                color: _C.primary, size: 44),
          ),
          const SizedBox(height: 20),
          const Text('No Products Yet',
              style: TextStyle(color: _C.textDark, fontSize: 18,
                  fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          const Text('Save a product to see it here',
              style: TextStyle(color: _C.textMid, fontSize: 14)),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => setState(() => _showList = false),
            icon: const Icon(Icons.add_rounded, color: Colors.white, size: 18),
            label: const Text('Add Product',
                style: TextStyle(color: Colors.white,
                    fontWeight: FontWeight.w700)),
            style: ElevatedButton.styleFrom(
              backgroundColor: _C.primary,
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
            ),
          ),
        ]),
      );
    }

    return ListView.builder(
      key: const ValueKey('list'),
      padding: const EdgeInsets.all(14),
      physics: const BouncingScrollPhysics(),
      itemCount: _entries.length,
      itemBuilder: (_, i) => _productCard(_entries[i], i),
    );
  }

  // ── Product card ──────────────────────────────────────────────────────────
  Widget _productCard(ProductEntry e, int i) => Container(
    margin: const EdgeInsets.only(bottom: 14),
    decoration: BoxDecoration(
      color: _C.surface,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [BoxShadow(
        color: Colors.black.withOpacity(0.06),
        blurRadius: 16, offset: const Offset(0, 4),
      )],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Column(children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(gradient: LinearGradient(
            colors: [_C.primary, _C.primaryDk],
            begin: Alignment.centerLeft, end: Alignment.centerRight,
          )),
          child: Row(children: [
            _badge('PM-${_entries.length - i}'),
            const SizedBox(width: 10),
            Expanded(child: Text(e.name,
                style: const TextStyle(color: Colors.white, fontSize: 15,
                    fontWeight: FontWeight.w700),
                overflow: TextOverflow.ellipsis)),
            _badge(e.category),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(14),
          child: Column(children: [
            Row(children: [
              _statBox('Code',  e.code,  Icons.qr_code_rounded),
              const SizedBox(width: 10),
              _statBox('Price',
                  e.price.isEmpty ? '—' : '₹${e.price}',
                  Icons.currency_rupee_rounded),
              const SizedBox(width: 10),
              _statBox('GST',   e.gst,   Icons.percent_rounded),
            ]),
            if (e.uom.isNotEmpty)
              _detailRow('UOM', e.uom),
            if ((e.data['HSN/SAC']    ?? '').isNotEmpty)
              _detailRow('HSN/SAC',    e.data['HSN/SAC']!),
            if ((e.data['GST Type']   ?? '').isNotEmpty)
              _detailRow('GST Type',   e.data['GST Type']!),
            if ((e.data['Sales Type'] ?? '').isNotEmpty)
              _detailRow('Sales Type', e.data['Sales Type']!),
            const SizedBox(height: 10),
            const Divider(height: 1, color: _C.border),
            const SizedBox(height: 10),
            Row(children: [
              const Icon(Icons.access_time_rounded,
                  color: _C.textLight, size: 12),
              const SizedBox(width: 4),
              Text('Added ${_fmt(e.createdAt)}',
                  style: const TextStyle(color: _C.textLight,
                      fontSize: 11, fontWeight: FontWeight.w500)),
              const Spacer(),
              if ((e.data['SKU/Case'] ?? '').isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: _C.primaryLt,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text('SKU: ${e.data['SKU/Case']!}',
                      style: const TextStyle(color: _C.primary,
                          fontSize: 11, fontWeight: FontWeight.w700)),
                ),
            ]),
          ]),
        ),
      ]),
    ),
  );

  Widget _detailRow(String k, String v) => Padding(
    padding: const EdgeInsets.only(top: 8),
    child: Row(children: [
      const Icon(Icons.chevron_right_rounded, color: _C.primary, size: 14),
      const SizedBox(width: 4),
      Text('$k: ', style: const TextStyle(color: _C.textMid,
          fontSize: 12, fontWeight: FontWeight.w600)),
      Expanded(child: Text(v,
          style: const TextStyle(color: _C.textDark,
              fontSize: 12, fontWeight: FontWeight.w500),
          overflow: TextOverflow.ellipsis)),
    ]),
  );

  Widget _badge(String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.2),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(text, style: const TextStyle(color: Colors.white,
        fontSize: 11, fontWeight: FontWeight.w700)),
  );

  Widget _statBox(String label, String value, IconData icon) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
      decoration: BoxDecoration(
        color: _C.primaryLt,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(children: [
        Icon(icon, color: _C.primary, size: 13),
        const SizedBox(width: 5),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value.isEmpty ? '—' : value,
                style: const TextStyle(color: _C.primary,
                    fontSize: 11, fontWeight: FontWeight.w800),
                overflow: TextOverflow.ellipsis),
            Text(label, style: const TextStyle(color: _C.textMid,
                fontSize: 9, fontWeight: FontWeight.w500)),
          ],
        )),
      ]),
    ),
  );

  String _fmt(DateTime d) {
    const m = ['','Jan','Feb','Mar','Apr','May','Jun',
      'Jul','Aug','Sep','Oct','Nov','Dec'];
    return '${d.day} ${m[d.month]} ${d.year}';
  }
}