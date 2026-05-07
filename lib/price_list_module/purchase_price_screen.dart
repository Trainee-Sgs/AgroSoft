import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

// ── Field type ────────────────────────────────────────────────────────────────
enum FieldType { text, dropdown, date, number }
enum LayoutWidth { halfWidth, fullWidth }

class FormFieldDef {
  final String        label;
  final String        hint;
  final IconData      icon;
  final FieldType     type;
  final List<String>? options;
  final LayoutWidth   layoutWidth;

  const FormFieldDef({
    required this.label,
    required this.hint,
    required this.icon,
    this.type        = FieldType.text,
    this.options,
    this.layoutWidth = LayoutWidth.halfWidth,
  });

  bool get isDropdown   => type == FieldType.dropdown;
  bool get isDate       => type == FieldType.date;
  bool get isFullWidth  => layoutWidth == LayoutWidth.fullWidth;
}

// ── Fixed sizes ───────────────────────────────────────────────────────────────
const double _kInputH   = 48.0;
const double _kLabelH   = 18.0;
const double _kLabelGap =  6.0;
const double _kRowGap   = 14.0;

// ── Section definition ────────────────────────────────────────────────────────
class _SectionDef {
  final IconData           icon;
  final String             title;
  final List<FormFieldDef> fields;
  const _SectionDef({required this.icon, required this.title, required this.fields});
}

// ── SECTIONS ──────────────────────────────────────────────────────────────────
const List<_SectionDef> _sections = [
  _SectionDef(
    icon: Icons.local_offer_rounded,
    title: 'Purchase Price Details',
    fields: [
      // Row 1: Date (left) | Price Group (right)
      FormFieldDef(
        label: 'Date',
        hint: 'Select Date',
        icon: Icons.calendar_today_rounded,
        type: FieldType.date,
      ),
      FormFieldDef(
        label: 'Price Group',
        hint: 'Select Option',
        icon: Icons.category_rounded,
        type: FieldType.dropdown,
        options: ['Standard', 'Premium', 'Budget', 'Seasonal'],
      ),
      // Row 2: Product (full width)
      FormFieldDef(
        label: 'Product',
        hint: 'Product',
        icon: Icons.shopping_bag_rounded,
        layoutWidth: LayoutWidth.fullWidth,
      ),
      // Row 3: Price (full width)
      FormFieldDef(
        label: 'Price',
        hint: 'Price',
        icon: Icons.currency_rupee_rounded,
        type: FieldType.number,
        layoutWidth: LayoutWidth.fullWidth,
      ),
    ],
  ),
];

// Gather all fields in one flat list for controller init
List<FormFieldDef> get _allFields =>
    _sections.expand((s) => s.fields).toList();

// ── Data model ────────────────────────────────────────────────────────────────
class PurchasePriceEntry {
  final String             id;
  final Map<String,String> data;
  final DateTime           createdAt;

  PurchasePriceEntry({
    required this.id,
    required this.data,
    required this.createdAt,
  });

  String get product     => data['Product']      ?? '—';
  String get price       => data['Price']        ?? '—';
  String get priceGroup  => data['Price Group']  ?? '—';
  String get date        => data['Date']         ?? '—';
}

// ── Screen ────────────────────────────────────────────────────────────────────
class PurchasePriceScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const PurchasePriceScreen({super.key, this.onBack});

  @override
  State<PurchasePriceScreen> createState() => _PurchasePriceScreenState();
}

class _PurchasePriceScreenState extends State<PurchasePriceScreen>
    with TickerProviderStateMixin {

  bool _showList = false;
  String? _openSection = _sections.first.title;

  final List<PurchasePriceEntry>              _entries     = [];
  final Map<String,TextEditingController>     _controllers = {};
  final Map<String,String>                    _dropValues  = {};

  @override
  void initState() {
    super.initState();
    for (final f in _allFields) {
      if (!f.isDropdown) {
        _controllers[f.label] = TextEditingController();
      }
    }
    // Set today's date by default
    _controllers['Date']?.text = _getTodayDate();
  }

  @override
  void dispose() {
    for (final c in _controllers.values) c.dispose();
    super.dispose();
  }

  String _getTodayDate() {
    final now = DateTime.now();
    return '${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}';
  }

  String _val(FormFieldDef f) =>
      f.isDropdown
          ? (_dropValues[f.label] ?? '')
          : (_controllers[f.label]?.text ?? '');

  bool get _isValid =>
      (_controllers['Product']?.text.trim() ?? '').isNotEmpty &&
          (_controllers['Price']?.text.trim() ?? '').isNotEmpty;

  void _toggleSection(String title) {
    HapticFeedback.lightImpact();
    setState(() {
      _openSection = _openSection == title ? null : title;
    });
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
    );
    if (picked != null) {
      final formatted = '${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}';
      setState(() {
        _controllers['Date']?.text = formatted;
      });
    }
  }

  void _save() {
    if (!_isValid) {
      _snack('Please fill Product and Price', _C.gold);
      return;
    }
    HapticFeedback.mediumImpact();

    final data  = {for (final f in _allFields) f.label: _val(f)};
    final entry = PurchasePriceEntry(
      id: 'PP-${DateTime.now().millisecondsSinceEpoch}',
      data: data,
      createdAt: DateTime.now(),
    );

    for (final c in _controllers.values) c.clear();
    _dropValues.clear();
    _controllers['Date']?.text = _getTodayDate();

    setState(() {
      _entries.insert(0, entry);
      _showList    = true;
      _openSection = null;
    });
    _snack('Purchase price saved for "${entry.product}"!', _C.primary);
  }

  void _snack(String msg, Color color) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(msg,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600)),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ));

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

  Widget _header() => Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
          colors: [Color(0xFF1B8A3E), Color(0xFF136B2F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight),
      boxShadow: [
        BoxShadow(
            color: Color(0x441B8A3E), blurRadius: 16, offset: Offset(0, 6))
      ],
    ),
    child: SafeArea(
      bottom: false,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
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
            const Expanded(
              child: Text('Purchase Price',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.3)),
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 2, 16, 10),
          child: Container(
            height: 48,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(22)),
            child: Row(children: [
              _tab('New Price', Icons.add_circle_outline_rounded,
                  !_showList, () => setState(() => _showList = false)),
              _tab('Price List', Icons.list_alt_rounded,
                  _showList,  () => setState(() => _showList = true)),
            ]),
          ),
        ),
      ]),
    ),
  );

  Widget _tab(String label, IconData icon, bool active, VoidCallback onTap) =>
      Expanded(
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
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 10,
                  offset: const Offset(0, 3))]
                  : [],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon,
                    size: 20,
                    color:
                    active ? _C.primary : Colors.white.withOpacity(0.85)),
                const SizedBox(width: 8),
                Text(label,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight:
                      active ? FontWeight.w700 : FontWeight.w500,
                      color: active
                          ? _C.primary
                          : Colors.white.withOpacity(0.85),
                    )),
              ],
            ),
          ),
        ),
      );

  Widget _formView() => Column(
    key: const ValueKey('form'),
    children: [
      Expanded(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final section in _sections) ...[
                _accordionSection(section),
                const SizedBox(height: 12),
              ],
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      _saveBar(),
      SizedBox(height: MediaQuery.of(context).padding.bottom + 12),
    ],
  );

  Widget _accordionSection(_SectionDef section) {
    final isExpanded = _openSection == section.title;
    final rows = _buildRows(section.fields);

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
          InkWell(
            onTap: () => _toggleSection(section.title),
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: isExpanded ? _C.primary : _C.primaryLt,
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(section.icon,
                      color: isExpanded ? Colors.white : _C.primary,
                      size: 18),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(section.title,
                      style: const TextStyle(
                          color: _C.textDark,
                          fontSize: 15,
                          fontWeight: FontWeight.w700)),
                ),
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

          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity, height: 0),
            secondChild: Column(
              children: [
                const Divider(height: 1, color: _C.border),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                  child: Column(
                    children: [
                      for (int ri = 0; ri < rows.length; ri++) ...[
                        if (ri > 0) const SizedBox(height: _kRowGap),
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

  List<List<FormFieldDef>> _buildRows(List<FormFieldDef> fields) {
    final rows = <List<FormFieldDef>>[];
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

  Widget _renderRow(List<FormFieldDef> row) {
    if (row.length == 1 && row[0].isFullWidth) {
      return _cell(row[0], _kInputH, fullWidth: true);
    } else if (row.length == 2) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _cell(row[0], _kInputH)),
          const SizedBox(width: 12),
          Expanded(child: _cell(row[1], _kInputH)),
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _cell(row[0], _kInputH)),
          const Expanded(child: SizedBox()),
        ],
      );
    }
  }

  Widget _cell(FormFieldDef f, double inputH, {bool fullWidth = false}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: _kLabelH,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(f.label,
                  style: const TextStyle(
                      color: _C.textMid,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2),
                  overflow: TextOverflow.ellipsis),
            ),
          ),
          const SizedBox(height: _kLabelGap),
          SizedBox(
            height: inputH,
            width: fullWidth ? double.infinity : null,
            child: f.isDropdown ? _dropdown(f) : _input(f, inputH),
          ),
        ],
      );

  Widget _input(FormFieldDef f, double inputH) => TextField(
    controller: _controllers[f.label],
    maxLines: 1,
    readOnly: f.isDate,
    onTap: f.isDate ? _selectDate : null,
    keyboardType: f.type == FieldType.number
        ? TextInputType.number
        : TextInputType.text,
    style: const TextStyle(
        color: _C.textDark, fontSize: 13, fontWeight: FontWeight.w500),
    decoration: InputDecoration(
      hintText:  f.hint,
      hintStyle: const TextStyle(color: _C.textLight, fontSize: 12),
      filled:    true,
      fillColor: _C.bg,
      isDense:   true,
      suffixIcon: f.isDate ? const Icon(Icons.calendar_today_rounded,
          color: _C.primary, size: 18) : null,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: _C.border)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: _C.border)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: _C.primary, width: 1.5)),
    ),
  );

  Widget _dropdown(FormFieldDef f) {
    final val = _dropValues[f.label];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: _C.bg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _C.border)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: val,
          isExpanded: true,
          isDense: true,
          hint: Row(children: [
            Icon(f.icon, color: _C.textLight, size: 16),
            const SizedBox(width: 6),
            Flexible(
              child: Text(f.hint,
                  style: const TextStyle(color: _C.textLight, fontSize: 12),
                  overflow: TextOverflow.ellipsis),
            ),
          ]),
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: _C.primary, size: 18),
          dropdownColor: _C.surface,
          style: const TextStyle(
              color: _C.textDark,
              fontSize: 13,
              fontWeight: FontWeight.w600),
          items: f.options!
              .map((o) => DropdownMenuItem(
            value: o,
            child: Row(children: [
              Icon(f.icon, color: _C.primary, size: 14),
              const SizedBox(width: 6),
              Flexible(
                  child: Text(o,
                      style: const TextStyle(fontSize: 13),
                      overflow: TextOverflow.ellipsis)),
            ]),
          ))
              .toList(),
          onChanged: (v) {
            if (v != null) setState(() => _dropValues[f.label] = v);
          },
        ),
      ),
    );
  }

  Widget _saveBar() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.green.shade400, Colors.green.shade700]),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: _C.primary.withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 4))
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _save,
          borderRadius: BorderRadius.circular(16),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.save_rounded, color: Colors.white, size: 20),
                SizedBox(width: 10),
                Text('SAVE PRICE',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8)),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  Widget _listView() {
    if (_entries.isEmpty) {
      return Center(
        key: const ValueKey('empty'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90, height: 90,
              decoration: const BoxDecoration(
                  color: _C.primaryLt, shape: BoxShape.circle),
              child: const Icon(Icons.local_offer_rounded,
                  color: _C.primary, size: 44),
            ),
            const SizedBox(height: 20),
            const Text('No Prices Yet',
                style: TextStyle(
                    color: _C.textDark,
                    fontSize: 18,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            const Text('Save a price to see it here',
                style: TextStyle(color: _C.textMid, fontSize: 14)),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => setState(() => _showList = false),
              icon: const Icon(Icons.add_rounded, color: Colors.white, size: 18),
              label: const Text('Create Price',
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
      itemCount: _entries.length,
      itemBuilder: (_, i) => _entryCard(_entries[i], i),
    );
  }

  Widget _entryCard(PurchasePriceEntry e, int i) => Container(
    margin: const EdgeInsets.only(bottom: 14),
    decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 16,
              offset: const Offset(0, 4))
        ]),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Column(children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [_C.primary, _C.primaryDk],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight)),
          child: Row(children: [
            _badge('PP-${_entries.length - i}'),
            const SizedBox(width: 10),
            Expanded(
                child: Text(e.product,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                    overflow: TextOverflow.ellipsis)),
            _badge(e.date),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(14),
          child: Column(children: [
            Row(children: [
              _statBox('Price', e.price, Icons.currency_rupee_rounded),
              const SizedBox(width: 10),
              _statBox('Price Group', e.priceGroup, Icons.category_rounded),
            ]),
            const SizedBox(height: 10),
            const Divider(height: 1, color: _C.border),
            const SizedBox(height: 10),
            Row(children: [
              const Icon(Icons.access_time_rounded,
                  color: _C.textLight, size: 12),
              const SizedBox(width: 4),
              Text('Created ${_fmt(e.createdAt)}',
                  style: const TextStyle(
                      color: _C.textLight,
                      fontSize: 11,
                      fontWeight: FontWeight.w500)),
            ]),
          ]),
        ),
      ]),
    ),
  );

  Widget _badge(String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8)),
    child: Text(text,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w700)),
  );

  Widget _statBox(String label, String value, IconData icon) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
          color: _C.primaryLt, borderRadius: BorderRadius.circular(10)),
      child: Row(children: [
        Icon(icon, color: _C.primary, size: 14),
        const SizedBox(width: 6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value.isEmpty ? '—' : value,
                  style: const TextStyle(
                      color: _C.primary,
                      fontSize: 12,
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

  String _fmt(DateTime d) {
    const m = ['','Jan','Feb','Mar','Apr','May','Jun',
      'Jul','Aug','Sep','Oct','Nov','Dec'];
    return '${d.day} ${m[d.month]} ${d.year}';
  }
}