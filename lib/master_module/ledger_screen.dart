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
enum FieldType { text, dropdown, multiline, phone, email, number }

// ── Layout type ───────────────────────────────────────────────────────────────
// fullWidth = spans both columns; halfWidth = normal half column
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

  bool get isMultiline  => type == FieldType.multiline;
  bool get isFullWidth  => layoutWidth == LayoutWidth.fullWidth;
  bool get isDropdown   => type == FieldType.dropdown;
}

// ── Fixed sizes ───────────────────────────────────────────────────────────────
const double _kInputH   = 48.0;
const double _kMultiH   = 90.0;
const double _kLabelH   = 18.0;
const double _kLabelGap =  6.0;
const double _kRowGap   = 14.0;

// ── Section definition ────────────────────────────────────────────────────────
// Each section holds a flat list of FormFieldDef; we render them row-by-row:
//   - fullWidth fields get their own row
//   - halfWidth fields are paired left+right
//
// SECTIONS:
//   Basic Information    : Ledger Category, GST Type, Ledger Name*, Sub Ledger,
//                          PAN Type, Short Name, GST, PAN
//   Contact Details      : Email*, Phone, Mobile*, Aadhaar*
//   Address & Financial  : Address*, Remarks*, Pincode, Credit Limit
//
// (*) = full width

class _SectionDef {
  final IconData       icon;
  final String         title;
  final List<FormFieldDef> fields;
  const _SectionDef({required this.icon, required this.title, required this.fields});
}

const List<_SectionDef> _sections = [
  _SectionDef(
    icon: Icons.account_balance_wallet_rounded,
    title: 'Basic Information',
    fields: [
      // Row 1: Ledger Category | GST Type
      FormFieldDef(label:'Ledger Category', hint:'Select One option',
          icon:Icons.category_rounded, type:FieldType.dropdown,
          options:['Agent','Equity','Liability','Assets','Transport','Refferral','Customer','Vendor','Supplier','Bank','Cash','Expense','Income','Staff','Debitors','Suriety']),
      FormFieldDef(label:'GST Type', hint:'Select One option',
          icon:Icons.receipt_long_rounded, type:FieldType.dropdown,
          options:['Regular','Composition','Unregistered','Consumer','Overseas']),
      // Row 2: Ledger Name (full)
      FormFieldDef(label:'Ledger Name', hint:'Ledger Name',
          icon:Icons.account_balance_wallet_rounded,
          layoutWidth: LayoutWidth.fullWidth),
      // Row 3: Sub Ledger | PAN Type
      FormFieldDef(label:'Sub Ledger', hint:'Select Option',
          icon:Icons.account_tree_rounded, type:FieldType.dropdown,
          options:['None','Sub-Category A','Sub-Category B','Sub-Category C']),
      FormFieldDef(label:'PAN Type', hint:'Select One option',
          icon:Icons.credit_card_rounded, type:FieldType.dropdown,
          options:['Individual','Company','HUF','Firm','Trust']),
      // Row 4: Short Name | GST
      FormFieldDef(label:'Short Name', hint:'Short Name',
          icon:Icons.short_text_rounded),
      FormFieldDef(label:'GST', hint:'GST',
          icon:Icons.numbers_rounded),
      // Row 5: PAN (half — no pair needed, renders alone)
      FormFieldDef(label:'PAN', hint:'PAN',
          icon:Icons.badge_rounded),
    ],
  ),
  _SectionDef(
    icon: Icons.contact_phone_rounded,
    title: 'Contact Details',
    fields: [
      // Row 1: Email (full)
      FormFieldDef(label:'Email', hint:'Email',
          icon:Icons.email_rounded, type:FieldType.email,
          layoutWidth: LayoutWidth.fullWidth),
      // Row 3: Mobile (full)
      FormFieldDef(label:'Mobile', hint:'Mobile',
          icon:Icons.smartphone_rounded, type:FieldType.phone,
          layoutWidth: LayoutWidth.fullWidth),
      // Row 4: Aadhaar (full)
      FormFieldDef(label:'Aadhaar', hint:'Aadhaar',
          icon:Icons.fingerprint_rounded, type:FieldType.number,
          layoutWidth: LayoutWidth.fullWidth),
    ],
  ),
  _SectionDef(
    icon: Icons.location_on_rounded,
    title: 'Address & Financial',
    fields: [
      // Row 1: Address (full, multiline)
      FormFieldDef(label:'Address', hint:'Address',
          icon:Icons.location_on_rounded, type:FieldType.multiline,
          layoutWidth: LayoutWidth.fullWidth),
      // Row 2: Remarks (full, multiline)
      FormFieldDef(label:'Remarks', hint:'Remarks',
          icon:Icons.comment_rounded, type:FieldType.multiline,
          layoutWidth: LayoutWidth.fullWidth),
      // Row 3: Pincode | Credit Limit
      FormFieldDef(label:'Pincode', hint:'Pincode',
          icon:Icons.map_rounded, type:FieldType.number),
      FormFieldDef(label:'Credit Limit', hint:'Credit Limit',
          icon:Icons.account_balance_rounded, type:FieldType.number),
    ],
  ),
];

// ── Data model ────────────────────────────────────────────────────────────────
class LedgerEntry {
  final String             id;
  final Map<String,String> data;
  final DateTime           createdAt;
  LedgerEntry({required this.id, required this.data, required this.createdAt});

  String get ledgerName => data['Ledger Name']     ?? '—';
  String get category   => data['Ledger Category'] ?? '—';
  String get gstType    => data['GST Type']        ?? '—';
  String get mobile     => data['Mobile'] ?? data['Phone'] ?? '—';
}

// Gather all fields in one flat list for controller init
List<FormFieldDef> get _allFields =>
    _sections.expand((s) => s.fields).toList();

// ── Screen ────────────────────────────────────────────────────────────────────
class LedgerMasterScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const LedgerMasterScreen({super.key, this.onBack});

  @override
  State<LedgerMasterScreen> createState() => _LedgerMasterScreenState();
}

class _LedgerMasterScreenState extends State<LedgerMasterScreen>
    with TickerProviderStateMixin {

  bool _showList = false;

  final Map<String, bool> _sectionExpanded = {
    'Basic Information'   : false,
    'Contact Details'     : false,
    'Address & Financial' : false,
  };

  final List<LedgerEntry>                 _entries     = [];
  final Map<String,TextEditingController> _controllers = {};
  final Map<String,String>                _dropValues  = {};

  @override
  void initState() {
    super.initState();
    for (final f in _allFields) {
      if (!f.isDropdown) {
        _controllers[f.label] = TextEditingController();
      }
    }
  }

  @override
  void dispose() {
    for (final c in _controllers.values) c.dispose();
    super.dispose();
  }

  String _val(FormFieldDef f) =>
      f.isDropdown
          ? (_dropValues[f.label] ?? '')
          : (_controllers[f.label]?.text ?? '');

  bool get _isValid =>
      (_dropValues['Ledger Category'] ?? '').isNotEmpty &&
          (_controllers['Ledger Name']?.text.trim() ?? '').isNotEmpty;

  void _save() {
    if (!_isValid) {
      _snack('Please fill Ledger Category & Ledger Name', _C.gold);
      return;
    }
    HapticFeedback.mediumImpact();

    final data  = {for (final f in _allFields) f.label: _val(f)};
    final entry = LedgerEntry(
      id: 'LM-${DateTime.now().millisecondsSinceEpoch}',
      data: data,
      createdAt: DateTime.now(),
    );

    for (final c in _controllers.values) c.clear();
    _dropValues.clear();

    setState(() {
      _entries.insert(0, entry);
      _showList = true;
      _sectionExpanded.updateAll((key, value) => false);
    });
    _snack('Ledger "${entry.ledgerName}" saved!', _C.primary);
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

  // ── Root ──────────────────────────────────────────────────────────────────
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
              child: Text('Ledger Master',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.3)),
            ),

          ]),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
          child: Container(
            height: 46,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(14)),
            child: Row(children: [
              _tab('New Ledger', Icons.add_circle_outline_rounded,
                  !_showList, () => setState(() => _showList = false)),
              _tab('Ledger List', Icons.list_alt_rounded,
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
            decoration: BoxDecoration(
              color: active ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              boxShadow: active
                  ? [BoxShadow(
                  color: Colors.black.withOpacity(0.10),
                  blurRadius: 8,
                  offset: const Offset(0, 2))]
                  : [],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon,
                    size: 16,
                    color:
                    active ? _C.primary : Colors.white.withOpacity(0.75)),
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

  // ── Form view ─────────────────────────────────────────────────────────────
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

  // ── Accordion Section ─────────────────────────────────────────────────────
  Widget _accordionSection(_SectionDef section) {
    final isExpanded = _sectionExpanded[section.title] ?? false;
    // Build rows from flat field list
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
          // Header
          InkWell(
            onTap: () {
              HapticFeedback.lightImpact();
              setState(() => _sectionExpanded[section.title] = !isExpanded);
            },
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

  // ── Build rows from flat field list ──────────────────────────────────────
  // Returns list of rows; each row is a List<FormFieldDef>:
  //   - [f]     => full-width field
  //   - [l, r]  => two half-width fields side by side
  //   - [f]     => lone half-width (no pair) — rendered half-width left-aligned
  List<List<FormFieldDef>> _buildRows(List<FormFieldDef> fields) {
    final rows = <List<FormFieldDef>>[];
    int i = 0;
    while (i < fields.length) {
      final f = fields[i];
      if (f.isFullWidth) {
        rows.add([f]);
        i++;
      } else {
        // look ahead for a second half-width
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

  // ── Render a single row ───────────────────────────────────────────────────
  Widget _renderRow(List<FormFieldDef> row) {
    if (row.length == 1 && row[0].isFullWidth) {
      // Full-width field
      return _cell(row[0], row[0].isMultiline ? _kMultiH : _kInputH,
          fullWidth: true);
    } else if (row.length == 2) {
      final inputH =
      (row[0].isMultiline || row[1].isMultiline) ? _kMultiH : _kInputH;
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _cell(row[0], inputH)),
          const SizedBox(width: 12),
          Expanded(child: _cell(row[1], inputH)),
        ],
      );
    } else {
      // Lone half-width — render left-aligned at half width
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
            child: f.isDropdown
                ? _dropdown(f)
                : _input(f, inputH),
          ),
        ],
      );

  // ── Text / multiline input — NO prefix icon ────────────────────────────────
  Widget _input(FormFieldDef f, double inputH) => TextField(
    controller: _controllers[f.label],
    maxLines:          f.isMultiline ? null : 1,
    expands:           f.isMultiline,
    textAlignVertical: f.isMultiline
        ? TextAlignVertical.top : TextAlignVertical.center,
    keyboardType: f.type == FieldType.phone
        ? TextInputType.phone
        : f.type == FieldType.email
        ? TextInputType.emailAddress
        : f.type == FieldType.number
        ? TextInputType.number
        : TextInputType.text,
    style: const TextStyle(
        color: _C.textDark, fontSize: 13, fontWeight: FontWeight.w500),
    decoration: InputDecoration(
      hintText:  f.hint,
      hintStyle: const TextStyle(color: _C.textLight, fontSize: 12),
      // ── No prefixIcon ──────────────────────────────────────────────────
      filled:    true,
      fillColor: _C.bg,
      isDense:   true,
      contentPadding: f.isMultiline
          ? const EdgeInsets.fromLTRB(12, 10, 12, 8)
          : const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
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

  // ── Dropdown — keeps icon in hint & items ─────────────────────────────────
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
                  style:
                  const TextStyle(color: _C.textLight, fontSize: 12),
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

  // ── Save bar ──────────────────────────────────────────────────────────────
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
                Text('SAVE LEDGER',
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

  // ── List view ─────────────────────────────────────────────────────────────
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
              child: const Icon(Icons.account_balance_wallet_rounded,
                  color: _C.primary, size: 44),
            ),
            const SizedBox(height: 20),
            const Text('No Ledgers Yet',
                style: TextStyle(
                    color: _C.textDark,
                    fontSize: 18,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            const Text('Save a ledger to see it here',
                style: TextStyle(color: _C.textMid, fontSize: 14)),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => setState(() => _showList = false),
              icon: const Icon(Icons.add_rounded,
                  color: Colors.white, size: 18),
              label: const Text('Create Ledger',
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

  // ── Entry card ────────────────────────────────────────────────────────────
  Widget _entryCard(LedgerEntry e, int i) => Container(
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
          padding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [_C.primary, _C.primaryDk],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight)),
          child: Row(children: [
            _badge('LM-${_entries.length - i}'),
            const SizedBox(width: 10),
            Expanded(
                child: Text(e.ledgerName,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                    overflow: TextOverflow.ellipsis)),
            _badge(e.category),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(14),
          child: Column(children: [
            Row(children: [
              _statBox('GST Type', e.gstType, Icons.receipt_long_rounded),
              const SizedBox(width: 10),
              _statBox('Mobile',   e.mobile,  Icons.smartphone_rounded),
            ]),
            ...['GST', 'PAN', 'Email', 'Address']
                .where((k) => (e.data[k] ?? '').isNotEmpty)
                .map((k) => Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(children: [
                const Icon(Icons.chevron_right_rounded,
                    color: _C.primary, size: 14),
                const SizedBox(width: 4),
                Text('$k: ',
                    style: const TextStyle(
                        color: _C.textMid,
                        fontSize: 12,
                        fontWeight: FontWeight.w600)),
                Expanded(
                    child: Text(e.data[k]!,
                        style: const TextStyle(
                            color: _C.textDark,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis)),
              ]),
            )),
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
              const Spacer(),
              if ((e.data['Short Name'] ?? '').isNotEmpty)
                Text(e.data['Short Name']!,
                    style: const TextStyle(
                        color: _C.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w700)),
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