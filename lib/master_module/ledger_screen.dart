import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../provider_module/ledger_provider.dart';

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

// ── Field types ───────────────────────────────────────────────────────────────
enum FieldType { text, dropdown, multiline, phone, email, number }
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

  bool get isMultiline => type == FieldType.multiline;
  bool get isFullWidth  => layoutWidth == LayoutWidth.fullWidth;
  bool get isDropdown   => type == FieldType.dropdown;
}

const double _kInputH   = 48.0;
const double _kMultiH   = 90.0;
const double _kLabelH   = 18.0;
const double _kLabelGap =  6.0;
const double _kRowGap   = 14.0;

class _SectionDef {
  final IconData           icon;
  final String             title;
  final List<FormFieldDef> fields;
  const _SectionDef({
    required this.icon,
    required this.title,
    required this.fields,
  });
}

// ── SECTIONS ──────────────────────────────────────────────────────────────────
const List<_SectionDef> _sections = [
  _SectionDef(
    icon: Icons.account_balance_wallet_rounded,
    title: 'Basic Information',
    fields: [
      FormFieldDef(
        label: 'Category',
        hint: 'Select Category',
        icon: Icons.category_rounded,
        type: FieldType.dropdown,
        options: ['Customer', 'Suppliers'],
        layoutWidth: LayoutWidth.fullWidth,
      ),
      FormFieldDef(
        label: 'Code',
        hint: 'Ledger Code',
        icon: Icons.tag_rounded,
        layoutWidth: LayoutWidth.fullWidth,
      ),
      FormFieldDef(
        label: 'Ledger Name',
        hint: 'Enter Ledger Name',
        icon: Icons.account_balance_wallet_rounded,
        layoutWidth: LayoutWidth.fullWidth,
      ),
      FormFieldDef(
        label: 'Display Name',
        hint: 'Enter Display Name',
        icon: Icons.label_rounded,
        layoutWidth: LayoutWidth.fullWidth,
      ),
      FormFieldDef(
        label: 'Short Name',
        hint: 'Enter Short Name',
        icon: Icons.short_text_rounded,
        layoutWidth: LayoutWidth.fullWidth,
      ),
      FormFieldDef(
        label: 'Contact Name',
        hint: 'Contact Person',
        icon: Icons.person_rounded,
      ),
      FormFieldDef(
        label: 'Phone',
        hint: '10-digit mobile number',
        icon: Icons.phone_rounded,
        type: FieldType.phone,
      ),
      FormFieldDef(
        label: 'Email',
        hint: 'Email Address',
        icon: Icons.email_rounded,
        type: FieldType.email,
        layoutWidth: LayoutWidth.fullWidth,
      ),
      FormFieldDef(
        label: 'Credit Limit',
        hint: 'Enter Credit Limit',
        icon: Icons.currency_rupee_rounded,
        type: FieldType.number,
        layoutWidth: LayoutWidth.fullWidth,
      ),
      FormFieldDef(
        label: 'Address',
        hint: 'Enter Address',
        icon: Icons.location_on_rounded,
        type: FieldType.multiline,
        layoutWidth: LayoutWidth.fullWidth,
      ),
      FormFieldDef(
        label: 'Pincode',
        hint: 'Pincode',
        icon: Icons.map_rounded,
        type: FieldType.number,
      ),
      FormFieldDef(
        label: 'Location',
        hint: 'Location',
        icon: Icons.place_rounded,
      ),
    ],
  ),

  _SectionDef(
    icon: Icons.receipt_long_rounded,
    title: 'Tax & Identity',
    fields: [
      FormFieldDef(
        label: 'GST',
        hint: 'GST Number',
        icon: Icons.numbers_rounded,
      ),
      FormFieldDef(
        label: 'PAN',
        hint: 'PAN Number',
        icon: Icons.badge_rounded,
      ),
      FormFieldDef(
        label: 'Aadhaar',
        hint: 'Aadhaar Number',
        icon: Icons.fingerprint_rounded,
        type: FieldType.number,
        layoutWidth: LayoutWidth.fullWidth,
      ),
    ],
  ),

  _SectionDef(
    icon: Icons.account_balance_rounded,
    title: 'Bank Details',
    fields: [
      FormFieldDef(
        label: 'Bank Name',
        hint: 'Enter Bank Name',
        icon: Icons.account_balance_rounded,
        layoutWidth: LayoutWidth.fullWidth,
      ),
      FormFieldDef(
        label: 'Bank Branch',
        hint: 'Enter Branch Name',
        icon: Icons.store_rounded,
        layoutWidth: LayoutWidth.fullWidth,
      ),
      FormFieldDef(
        label: 'IFSC',
        hint: 'IFSC Code (e.g. CNRB0001234)',
        icon: Icons.code_rounded,
      ),
      FormFieldDef(
        label: 'Account No',
        hint: 'Account Number',
        icon: Icons.credit_card_rounded,
        type: FieldType.number,
      ),
    ],
  ),

  _SectionDef(
    icon: Icons.folder_copy_rounded,
    title: 'Account Details',
    fields: [
      FormFieldDef(
        label: 'SL No',
        hint: 'SL Number',
        icon: Icons.format_list_numbered_rounded,
        type: FieldType.number,
      ),
      FormFieldDef(
        label: 'FL No',
        hint: 'FL Number',
        icon: Icons.format_list_numbered_rtl_rounded,
        type: FieldType.number,
      ),
      FormFieldDef(
        label: 'SL No 2',
        hint: 'SL Number 2',
        icon: Icons.format_list_numbered_rounded,
        type: FieldType.number,
      ),
      FormFieldDef(
        label: 'FMS',
        hint: 'FMS',
        icon: Icons.folder_special_rounded,
      ),
    ],
  ),
];

// ── Data model ────────────────────────────────────────────────────────────────
class LedgerEntry {
  final String             id;
  final Map<String,String> data;
  final DateTime           createdAt;

  LedgerEntry({
    required this.id,
    required this.data,
    required this.createdAt,
  });

  String get ledgerName  => data['Ledger Name']  ?? '—';
  String get displayName => data['Display Name'] ?? '—';
  String get shortName   => data['Short Name']   ?? '—';
  String get code        => data['Code']         ?? '—';
  String get category    => data['Category']     ?? '—';
  String get bankName    => data['Bank Name']    ?? '—';
  String get bankBranch  => data['Bank Branch']  ?? '—';
  String get ifsc        => data['IFSC']         ?? '—';
  String get accountNo   => data['Account No']   ?? '—';
  String get contactName => data['Contact Name'] ?? '—';
  String get phone       => data['Phone']        ?? '—';
  String get email       => data['Email']        ?? '—';
  String get creditLimit => data['Credit Limit'] ?? '—';
}

List<FormFieldDef> get _allFields =>
    _sections.expand((s) => s.fields).toList();

// ── Phone sanitizer ───────────────────────────────────────────────────────────
String _sanitizePhoneDisplay(String raw) {
  final digits = raw.replaceAll(RegExp(r'\D'), '');
  return digits.length > 10 ? digits.substring(digits.length - 10) : digits;
}

// ── Screen ────────────────────────────────────────────────────────────────────
class LedgerMasterScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const LedgerMasterScreen({super.key, this.onBack});

  @override
  State<LedgerMasterScreen> createState() => _LedgerMasterScreenState();
}

class _LedgerMasterScreenState extends State<LedgerMasterScreen>
    with TickerProviderStateMixin {

  bool    _showList    = true;
  String? _openSection = _sections.first.title;

  final List<LedgerEntry>                 _entries     = [];
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, String>               _dropValues  = {};
  final Map<String, FocusNode>            _focusNodes  = {};

  @override
  void initState() {
    super.initState();
    for (final f in _allFields) {
      if (!f.isDropdown) {
        _controllers[f.label] = TextEditingController();
        _focusNodes[f.label]  = FocusNode();
      }
    }
  }

  @override
  void dispose() {
    for (final c in _controllers.values) c.dispose();
    for (final n in _focusNodes.values)  n.dispose();
    super.dispose();
  }

  String? _validatePhone() {
    final raw   = _controllers['Phone']?.text ?? '';
    final clean = _sanitizePhoneDisplay(raw);
    if (raw.isNotEmpty && clean.length != 10) return 'Phone must be 10 digits';
    return null;
  }

  bool get _isValid =>
      (_controllers['Ledger Name']?.text.trim() ?? '').isNotEmpty;

  void _toggleSection(String title) {
    HapticFeedback.lightImpact();
    setState(() {
      _openSection = _openSection == title ? null : title;
    });
  }

  // ── SAVE — passes ALL fields to provider ──────────────────────────────────
  Future<void> _save() async {

    final provider = context.read<LedgerProvider>();

    // ── Build complete data map matching Postman params ──
    final data = <String, String>{

      // Basic Info
      'Contact Name':  _controllers['Contact Name']?.text  ?? '',
      'Phone':         _controllers['Phone']?.text         ?? '',
      'Code':          _controllers['Code']?.text          ?? '',
      'Category':      _dropValues['Category']             ?? '',
      'Ledger Name':   _controllers['Ledger Name']?.text   ?? '',
      'Short Name':    _controllers['Short Name']?.text    ?? '',
      'Display Name':  _controllers['Display Name']?.text  ?? '',
      'Address':       _controllers['Address']?.text       ?? '',
      'Email':         _controllers['Email']?.text         ?? '',
      'Pincode':       _controllers['Pincode']?.text       ?? '',
      'Location':      _controllers['Location']?.text      ?? '',
      'Credit Limit':  _controllers['Credit Limit']?.text  ?? '',

      // Tax & Identity
      'GST':           _controllers['GST']?.text           ?? '',
      'Aadhaar':       _controllers['Aadhaar']?.text       ?? '',
      'PAN':           _controllers['PAN']?.text           ?? '',

      // Bank Details
      'Bank Name':     _controllers['Bank Name']?.text     ?? '',
      'Account No':    _controllers['Account No']?.text    ?? '',
      'IFSC':          _controllers['IFSC']?.text          ?? '',
      'Bank Branch':   _controllers['Bank Branch']?.text   ?? '',

      // Account Details
      'SL No':         _controllers['SL No']?.text         ?? '',
      'FL No':         _controllers['FL No']?.text         ?? '',
      'SL No 2':       _controllers['SL No 2']?.text       ?? '',
      'FMS':           _controllers['FMS']?.text           ?? '',
    };

    final ok = await provider.saveLedger(data);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(provider.message),
        backgroundColor: ok ? Colors.green : Colors.red,
      ),
    );

    // ── Add to local list on success ──────────────────────
    if (ok) {
      setState(() {
        _entries.insert(0, LedgerEntry(
          id:        DateTime.now().millisecondsSinceEpoch.toString(),
          data:      Map.from(data),
          createdAt: DateTime.now(),
        ));
        _showList = true;
      });
      _clearForm();
    }
  }

  // ── Clear form after save ─────────────────────────────────────────────────
  void _clearForm() {
    for (final c in _controllers.values) c.clear();
    setState(() => _dropValues.clear());
  }

  // ── Root ──────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<LedgerProvider>().isLoading;
    return Scaffold(
      backgroundColor: _C.bg,
      resizeToAvoidBottomInset: true,
      body: Stack(children: [
        Column(children: [
          _header(),
          Expanded(child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 260),
            child: _showList ? _listView() : _formView(),
          )),
        ]),
        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.35),
            child: const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          ),
      ]),
    );
  }

  // ── Header ────────────────────────────────────────────────────────────────
  Widget _header() => Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF1B8A3E), Color(0xFF136B2F)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(color: Color(0x441B8A3E), blurRadius: 16, offset: Offset(0, 6))
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
          padding: const EdgeInsets.fromLTRB(16, 2, 16, 10),
          child: Container(
            height: 48,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(22)),
            child: Row(children: [
              _tab('Ledger List', Icons.list_alt_rounded,
                  _showList, () => setState(() => _showList = true)),
              _tab('New Ledger', Icons.add_circle_outline_rounded,
                  !_showList, () => setState(() => _showList = false)),
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
                Icon(icon, size: 20,
                    color: active
                        ? _C.primary
                        : Colors.white.withOpacity(0.85)),
                const SizedBox(width: 8),
                Text(label,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                      color: active
                          ? _C.primary
                          : Colors.white.withOpacity(0.85),
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
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 14),
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
            secondChild: Column(children: [
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
            ]),
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
        rows.add([f]); i++;
      } else {
        if (i + 1 < fields.length && !fields[i + 1].isFullWidth) {
          rows.add([f, fields[i + 1]]); i += 2;
        } else {
          rows.add([f]); i++;
        }
      }
    }
    return rows;
  }

  Widget _renderRow(List<FormFieldDef> row) {
    if (row.length == 1 && row[0].isFullWidth) {
      return _cell(row[0], row[0].isMultiline ? _kMultiH : _kInputH,
          fullWidth: true);
    } else if (row.length == 2) {
      final h = (row[0].isMultiline || row[1].isMultiline)
          ? _kMultiH : _kInputH;
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _cell(row[0], h)),
          const SizedBox(width: 12),
          Expanded(child: _cell(row[1], h)),
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

  Widget _cell(FormFieldDef f, double inputH,
      {bool fullWidth = false}) =>
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

  Widget _input(FormFieldDef f, double inputH) {
    final isPhone = f.type == FieldType.phone;
    return TextField(
      controller:        _controllers[f.label],
      focusNode:         _focusNodes[f.label],
      maxLines:          f.isMultiline ? null : 1,
      expands:           f.isMultiline,
      textAlignVertical: f.isMultiline
          ? TextAlignVertical.top : TextAlignVertical.center,
      keyboardType: isPhone
          ? const TextInputType.numberWithOptions(
          signed: false, decimal: false)
          : f.type == FieldType.email
          ? TextInputType.emailAddress
          : f.type == FieldType.number
          ? TextInputType.number
          : TextInputType.text,
      inputFormatters: isPhone
          ? [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ]
          : f.type == FieldType.number
          ? [FilteringTextInputFormatter.digitsOnly]
          : null,
      autofillHints: isPhone ? const [] : null,
      style: const TextStyle(
          color: _C.textDark, fontSize: 13, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        hintText:  f.hint,
        hintStyle: const TextStyle(color: _C.textLight, fontSize: 12),
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
            borderSide:
            const BorderSide(color: _C.primary, width: 1.5)),
      ),
    );
  }

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
                  style: const TextStyle(
                      color: _C.textLight, fontSize: 12),
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
  Widget _saveBar() {
    final isLoading = context.watch<LedgerProvider>().isLoading;
    return Padding(
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
            onTap: isLoading ? null : _save,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: isLoading
                  ? const Center(
                child: SizedBox(
                  width: 22, height: 22,
                  child: CircularProgressIndicator(
                      color: Colors.white, strokeWidth: 2.5),
                ),
              )
                  : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.save_rounded,
                      color: Colors.white, size: 20),
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
  }

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
          padding: const EdgeInsets.symmetric(
              horizontal: 16, vertical: 12),
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
            if (e.code.isNotEmpty && e.code != '—') _badge(e.code),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(14),
          child: Column(children: [
            if (e.category.isNotEmpty && e.category != '—')
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                      color: _C.primaryLt,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: _C.primary.withOpacity(0.25))),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    const Icon(Icons.category_rounded,
                        color: _C.primary, size: 12),
                    const SizedBox(width: 4),
                    Text(e.category,
                        style: const TextStyle(
                            color: _C.primary,
                            fontSize: 11,
                            fontWeight: FontWeight.w700)),
                  ]),
                ),
              ),
            Row(children: [
              _statBox('Display Name', e.displayName,
                  Icons.label_rounded),
              const SizedBox(width: 10),
              _statBox('Short Name', e.shortName,
                  Icons.short_text_rounded),
            ]),
            if ((e.contactName.isNotEmpty && e.contactName != '—') ||
                (e.phone.isNotEmpty && e.phone != '—')) ...[
              const SizedBox(height: 10),
              Row(children: [
                if (e.contactName.isNotEmpty && e.contactName != '—')
                  Expanded(
                      child: _infoChip(
                          Icons.person_rounded, e.contactName)),
                if (e.contactName.isNotEmpty &&
                    e.contactName != '—' &&
                    e.phone.isNotEmpty &&
                    e.phone != '—')
                  const SizedBox(width: 8),
                if (e.phone.isNotEmpty && e.phone != '—')
                  Expanded(
                      child: _infoChip(Icons.phone_rounded, e.phone)),
              ]),
            ],
            if (e.email.isNotEmpty && e.email != '—') ...[
              const SizedBox(height: 8),
              _infoChipFull(Icons.email_rounded, e.email),
            ],
            if (e.creditLimit.isNotEmpty && e.creditLimit != '—') ...[
              const SizedBox(height: 8),
              _infoChipFull(Icons.currency_rupee_rounded,
                  'Credit Limit: ₹${e.creditLimit}'),
            ],
            const SizedBox(height: 10),
            ...['GST', 'PAN', 'Aadhaar', 'Address', 'Pincode', 'Location']
                .where((k) => (e.data[k] ?? '').isNotEmpty)
                .map((k) => Padding(
              padding: const EdgeInsets.only(top: 8),
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
            if ([e.bankName, e.bankBranch, e.ifsc, e.accountNo]
                .any((v) => v.isNotEmpty && v != '—')) ...[
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(10),
                  border:
                  Border.all(color: const Color(0xFFBFDBFE)),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(children: [
                        Icon(Icons.account_balance_rounded,
                            color: Color(0xFF2563EB), size: 13),
                        SizedBox(width: 5),
                        Text('Bank Details',
                            style: TextStyle(
                                color: Color(0xFF2563EB),
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.3)),
                      ]),
                      const SizedBox(height: 8),
                      Row(children: [
                        _bankStatBox('Bank', e.bankName,
                            Icons.account_balance_rounded),
                        const SizedBox(width: 8),
                        _bankStatBox(
                            'Branch', e.bankBranch, Icons.store_rounded),
                      ]),
                      if ((e.ifsc.isNotEmpty && e.ifsc != '—') ||
                          (e.accountNo.isNotEmpty &&
                              e.accountNo != '—')) ...[
                        const SizedBox(height: 8),
                        Row(children: [
                          if (e.ifsc.isNotEmpty && e.ifsc != '—')
                            _bankChip(Icons.code_rounded, 'IFSC', e.ifsc),
                          if (e.ifsc.isNotEmpty &&
                              e.ifsc != '—' &&
                              e.accountNo.isNotEmpty &&
                              e.accountNo != '—')
                            const SizedBox(width: 8),
                          if (e.accountNo.isNotEmpty && e.accountNo != '—')
                            _bankChip(Icons.credit_card_rounded, 'A/C',
                                e.accountNo),
                        ]),
                      ],
                    ]),
              ),
            ],
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
              ...['SL No', 'FL No', 'FMS']
                  .where((k) => (e.data[k] ?? '').isNotEmpty)
                  .map((k) => Padding(
                padding: const EdgeInsets.only(left: 6),
                child: _smallChip('$k: ${e.data[k]}'),
              )),
            ]),
          ]),
        ),
      ]),
    ),
  );

  // ── Reusable card widgets ─────────────────────────────────────────────────
  Widget _infoChip(IconData icon, String value) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    decoration: BoxDecoration(
        color: _C.primaryLt,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _C.primary.withOpacity(0.2))),
    child: Row(children: [
      Icon(icon, color: _C.primary, size: 13),
      const SizedBox(width: 5),
      Expanded(
          child: Text(value,
              style: const TextStyle(
                  color: _C.textDark,
                  fontSize: 11,
                  fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis)),
    ]),
  );

  Widget _infoChipFull(IconData icon, String value) => Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    decoration: BoxDecoration(
        color: _C.primaryLt,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _C.primary.withOpacity(0.2))),
    child: Row(children: [
      Icon(icon, color: _C.primary, size: 13),
      const SizedBox(width: 5),
      Expanded(
          child: Text(value,
              style: const TextStyle(
                  color: _C.textDark,
                  fontSize: 11,
                  fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis)),
    ]),
  );

  Widget _bankStatBox(String label, String value, IconData icon) =>
      Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border:
              Border.all(color: const Color(0xFFBFDBFE))),
          child: Row(children: [
            Icon(icon, color: const Color(0xFF2563EB), size: 13),
            const SizedBox(width: 5),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          value.isEmpty || value == '—' ? '—' : value,
                          style: const TextStyle(
                              color: Color(0xFF1E3A5F),
                              fontSize: 11,
                              fontWeight: FontWeight.w700),
                          overflow: TextOverflow.ellipsis),
                      Text(label,
                          style: const TextStyle(
                              color: Color(0xFF6B7280),
                              fontSize: 9,
                              fontWeight: FontWeight.w500)),
                    ])),
          ]),
        ),
      );

  Widget _bankChip(IconData icon, String label, String value) =>
      Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 8, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border:
              Border.all(color: const Color(0xFFBFDBFE))),
          child: Row(children: [
            Icon(icon, color: const Color(0xFF2563EB), size: 12),
            const SizedBox(width: 4),
            Expanded(
                child: Text('$label: $value',
                    style: const TextStyle(
                        color: Color(0xFF1E3A5F),
                        fontSize: 11,
                        fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis)),
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

  Widget _smallChip(String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
        color: _C.primaryLt, borderRadius: BorderRadius.circular(6)),
    child: Text(text,
        style: const TextStyle(
            color: _C.primary,
            fontSize: 10,
            fontWeight: FontWeight.w700)),
  );

  Widget _statBox(String label, String value, IconData icon) =>
      Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 10, vertical: 8),
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
                    ])),
          ]),
        ),
      );

  String _fmt(DateTime d) {
    const m = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${d.day} ${m[d.month]} ${d.year}';
  }
}