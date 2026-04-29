import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

// ─────────────────────────────────────────────────────────────────────────────
// DATA MODELS
// ─────────────────────────────────────────────────────────────────────────────
class CustomerInfo {
  final String name;
  final String mobile;

  const CustomerInfo({required this.name, required this.mobile});
}

class StatementEntry {
  final int    sno;
  final String date;
  final String ref;
  final String type;
  final String particulars;
  final double debit;
  final double credit;
  final double balance;

  const StatementEntry({
    required this.sno,
    required this.date,
    required this.ref,
    required this.type,
    required this.particulars,
    required this.debit,
    required this.credit,
    required this.balance,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// SAMPLE CUSTOMERS  (replace with your real DB list)
// ─────────────────────────────────────────────────────────────────────────────
final List<CustomerInfo> _allCustomers = [
  CustomerInfo(name: 'Aakash R',        mobile: '9876500001'),
  CustomerInfo(name: 'Abirami Devi',    mobile: '9876500002'),
  CustomerInfo(name: 'Arjun Kumar',     mobile: '9876543210'),
  CustomerInfo(name: 'Babu S',          mobile: '9876500003'),
  CustomerInfo(name: 'Balamurugan V',   mobile: '9876500004'),
  CustomerInfo(name: 'Chandran M',      mobile: '9876500005'),
  CustomerInfo(name: 'Deepa P',         mobile: '9876500006'),
  CustomerInfo(name: 'Dinesh T',        mobile: '9876500007'),
  CustomerInfo(name: 'Eswari K',        mobile: '9876500008'),
  CustomerInfo(name: 'Geetha N',        mobile: '9876500009'),
  CustomerInfo(name: 'Gopal S',         mobile: '9876500010'),
  CustomerInfo(name: 'Harini R',        mobile: '9876500011'),
  CustomerInfo(name: 'Hari Prasad',     mobile: '9876500012'),
  CustomerInfo(name: 'Ilayaraja M',     mobile: '9876500013'),
  CustomerInfo(name: 'Jaya L',          mobile: '9876500014'),
  CustomerInfo(name: 'Karthik Vel',     mobile: '9444555666'),
  CustomerInfo(name: 'Kavitha S',       mobile: '9876500015'),
  CustomerInfo(name: 'Kumar A',         mobile: '9876500016'),
  CustomerInfo(name: 'Lakshmi P',       mobile: '9876500017'),
  CustomerInfo(name: 'Manoj K',         mobile: '9876500018'),
  CustomerInfo(name: 'Meena S',         mobile: '9000111222'),
  CustomerInfo(name: 'Muthu R',         mobile: '9876500019'),
  CustomerInfo(name: 'Nisha T',         mobile: '9876500020'),
  CustomerInfo(name: 'Pandi M',         mobile: '9876500021'),
  CustomerInfo(name: 'Priya Devi',      mobile: '9988776655'),
  CustomerInfo(name: 'Raja V',          mobile: '9876500022'),
  CustomerInfo(name: 'Ramesh C',        mobile: '9876500023'),
  CustomerInfo(name: 'Sathishkumar B',  mobile: '6379767308'),
  CustomerInfo(name: 'Selvam R',        mobile: '9123456780'),
  CustomerInfo(name: 'Senthil N',       mobile: '9876500024'),
  CustomerInfo(name: 'Shobana K',       mobile: '9876500025'),
  CustomerInfo(name: 'Suresh P',        mobile: '9876500026'),
  CustomerInfo(name: 'Tamil Selvan',    mobile: '9876500027'),
  CustomerInfo(name: 'Uma D',           mobile: '9876500028'),
  CustomerInfo(name: 'Vignesh A',       mobile: '9876500029'),
  CustomerInfo(name: 'Vijaya L',        mobile: '9876500030'),
  CustomerInfo(name: 'Yuvaraj S',       mobile: '9876500031'),
  CustomerInfo(name: 'Zarina B',        mobile: '9876500032'),
];

// ─────────────────────────────────────────────────────────────────────────────
// SAMPLE STATEMENT DATA  (replace with your real API / DB call)
// ─────────────────────────────────────────────────────────────────────────────
List<StatementEntry> _getStatementData(String customerName) {
  return [
    StatementEntry(
      sno: 1, date: '', ref: '', type: '',
      particulars: 'OPENING BALANCE',
      debit: 0, credit: 0, balance: 6097.80,
    ),
    StatementEntry(
      sno: 2, date: '18-Apr-2026', ref: 'INV001', type: 'Invoice',
      particulars: 'Sales - Product A',
      debit: 1500, credit: 0, balance: 7597.80,
    ),
    StatementEntry(
      sno: 3, date: '18-Apr-2026', ref: 'RCP001', type: 'Receipt',
      particulars: 'Payment Received',
      debit: 0, credit: 2000, balance: 5597.80,
    ),
  ];
}

// ─────────────────────────────────────────────────────────────────────────────
// CUSTOMER STATEMENT PAGE
// ─────────────────────────────────────────────────────────────────────────────
class CustomerStatementPage extends StatefulWidget {
  const CustomerStatementPage({super.key});
  @override
  State<CustomerStatementPage> createState() => _CustomerStatementPageState();
}

class _CustomerStatementPageState extends State<CustomerStatementPage>
    with SingleTickerProviderStateMixin {

  // ── Filter state ──────────────────────────────────────────────────────────
  final _fromDateCtrl     = TextEditingController();
  final _toDateCtrl       = TextEditingController();
  String  _reportType     = 'Simple';
  String? _ssFilter;               // 'Include SS' | 'Exclude SS' | null
  final _customerCtrl     = TextEditingController();
  String  _destination    = 'EXCEL';
  CustomerInfo? _selectedCustomer;

  // ── Report state ──────────────────────────────────────────────────────────
  bool                    _showReport = false;
  List<StatementEntry>    _reportData = [];
  late AnimationController _animCtrl;
  late Animation<double>   _fadeAnim;

  final List<String> _reportTypes = ['Simple', 'Detailed', 'Summary'];
  final List<String> _destOptions = ['EXCEL', 'PDF', 'PRINT'];

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final formatted =
        '${now.day.toString().padLeft(2, '0')}-'
        '${now.month.toString().padLeft(2, '0')}-'
        '${now.year}';
    _fromDateCtrl.text = formatted;
    _toDateCtrl.text   = formatted;

    _animCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    _fadeAnim =
        CurvedAnimation(parent: _animCtrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    _fromDateCtrl.dispose();
    _toDateCtrl.dispose();
    _customerCtrl.dispose();
    super.dispose();
  }

  // ── Date helpers ──────────────────────────────────────────────────────────
  Future<void> _pickDate(TextEditingController ctrl) async {
    final parts = ctrl.text.split('-');
    DateTime initial = DateTime.now();
    if (parts.length == 3) {
      initial = DateTime(
        int.tryParse(parts[2]) ?? initial.year,
        int.tryParse(parts[1]) ?? initial.month,
        int.tryParse(parts[0]) ?? initial.day,
      );
    }
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (ctx, child) => Theme(
        data: ThemeData.light().copyWith(
          colorScheme:
          const ColorScheme.light(primary: AppTheme.primaryGreen),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      ctrl.text =
      '${picked.day.toString().padLeft(2, '0')}-'
          '${picked.month.toString().padLeft(2, '0')}-'
          '${picked.year}';
    }
  }

  String get _dateRangeLabel =>
      '${_fromDateCtrl.text} - ${_toDateCtrl.text}';

  // ── Display ───────────────────────────────────────────────────────────────
  void _onDisplay() {
    setState(() {
      _reportData = _getStatementData(_selectedCustomer?.name ?? '');
      _showReport = true;
    });
    _animCtrl.forward(from: 0);
  }

  void _onBack() {
    setState(() => _showReport = false);
    _animCtrl.reverse();
  }

  // ─────────────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildAppBar(),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: _showReport
                  ? _ReportView(
                key: const ValueKey('report'),
                data: _reportData,
                customer: _selectedCustomer,
                fromDate: _fromDateCtrl.text,
                toDate: _toDateCtrl.text,
                fadeAnim: _fadeAnim,
                onBack: _onBack,
              )
                  : _buildFilterForm(),
            ),
          ),
        ],
      ),
    );
  }

  // ── AppBar ────────────────────────────────────────────────────────────────
  Widget _buildAppBar() {
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
        child: Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                   Icons.arrow_back_ios_new,

                  color: Colors.white,
                  size: _showReport ? 20 : 24,
                ),
              ),
              const SizedBox(width: 14),
              const Text(
                'Customer Statement',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  // ── Filter Form ───────────────────────────────────────────────────────────
  Widget _buildFilterForm() {
    return SingleChildScrollView(
      key: const ValueKey('form'),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),

          // ── Date Range ──────────────────────────────────────────────────
          _sectionCard(
            icon: Icons.date_range_outlined,
            title: 'Date',
            child: GestureDetector(
              onTap: () => _showDateRangePicker(),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 13),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceCard,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppTheme.lightGreen),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_month,
                        color: AppTheme.primaryGreen, size: 18),
                    const SizedBox(width: 10),
                    Text(
                      _dateRangeLabel,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textDark,
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.edit_calendar_outlined,
                        color: AppTheme.textMuted, size: 16),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 14),

          // ── Report Type ─────────────────────────────────────────────────
          _sectionCard(
            icon: Icons.description_outlined,
            title: 'Report Type',
            child: _styledDropdown(
              value: _reportType,
              items: _reportTypes,
              onChanged: (v) => setState(() => _reportType = v!),
            ),
          ),

          const SizedBox(height: 14),

          // ── Include / Exclude SS ────────────────────────────────────────
          _sectionCard(
            icon: Icons.filter_alt_outlined,
            title: 'SS Filter',
            child: Row(
              children: ['Include SS', 'Exclude SS'].map((opt) {
                final sel = _ssFilter == opt;
                return Expanded(
                  child: GestureDetector(
                    onTap: () =>
                        setState(() => _ssFilter = sel ? null : opt),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(vertical: 9),
                      decoration: BoxDecoration(
                        color: sel
                            ? AppTheme.primaryGreen
                            : AppTheme.surfaceCard,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: sel
                              ? AppTheme.deepGreen
                              : AppTheme.lightGreen,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            duration:
                            const Duration(milliseconds: 180),
                            width: 14,
                            height: 14,
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
                                size: 9, color: AppTheme.deepGreen)
                                : null,
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              opt,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: sel
                                    ? Colors.white
                                    : AppTheme.textDark,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
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

          // ── Customer Name Autocomplete ───────────────────────────────────
          _sectionCard(
            icon: Icons.person_search_outlined,
            title: 'Customer Name',
            child: Autocomplete<CustomerInfo>(
              optionsBuilder: (TextEditingValue textValue) {
                if (textValue.text.isEmpty) {
                  return _allCustomers; // show all when empty
                }
                return _allCustomers.where((c) => c.name
                    .toLowerCase()
                    .contains(textValue.text.toLowerCase()));
              },
              displayStringForOption: (c) => c.name,
              onSelected: (CustomerInfo c) {
                setState(() => _selectedCustomer = c);
              },
              fieldViewBuilder:
                  (ctx, ctrl, focusNode, onFieldSubmitted) {
                _customerCtrl.addListener(() {
                  if (_customerCtrl.text != ctrl.text) {
                    ctrl.text = _customerCtrl.text;
                  }
                });
                return TextField(
                  controller: ctrl,
                  focusNode: focusNode,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textDark,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Customer Name',
                    hintStyle: const TextStyle(
                        color: AppTheme.textMuted, fontSize: 14),
                    prefixIcon: const Icon(Icons.person_outline,
                        color: AppTheme.primaryGreen, size: 20),
                    suffixIcon: ctrl.text.isNotEmpty
                        ? GestureDetector(
                      onTap: () {
                        ctrl.clear();
                        setState(
                                () => _selectedCustomer = null);
                      },
                      child: const Icon(Icons.close,
                          color: AppTheme.textMuted,
                          size: 18),
                    )
                        : null,
                    filled: true,
                    fillColor: AppTheme.surfaceCard,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: AppTheme.lightGreen, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: AppTheme.primaryGreen, width: 1.5),
                    ),
                  ),
                );
              },
              optionsViewBuilder: (ctx, onSelected, options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    elevation: 8,
                    borderRadius: BorderRadius.circular(12),
                    shadowColor:
                    AppTheme.primaryGreen.withOpacity(0.2),
                    child: Container(
                      constraints: const BoxConstraints(
                          maxHeight: 220, maxWidth: 320),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: AppTheme.lightGreen
                                .withOpacity(0.4)),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: options.length,
                          separatorBuilder: (_, __) => Divider(
                            height: 1,
                            color: AppTheme.lightGreen
                                .withOpacity(0.3),
                          ),
                          itemBuilder: (ctx, i) {
                            final c = options.elementAt(i);
                            return InkWell(
                              onTap: () => onSelected(c),
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 10),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: AppTheme
                                            .primaryGreen
                                            .withOpacity(0.12),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          c.name[0].toUpperCase(),
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight:
                                            FontWeight.w700,
                                            color: AppTheme
                                                .deepGreen,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(c.name,
                                              style:
                                              const TextStyle(
                                                fontSize: 13,
                                                fontWeight:
                                                FontWeight.w600,
                                                color: AppTheme
                                                    .textDark,
                                              )),
                                          Text(c.mobile,
                                              style:
                                              const TextStyle(
                                                fontSize: 11,
                                                color: AppTheme
                                                    .textMuted,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Selected customer chip
          if (_selectedCustomer != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: AppTheme.primaryGreen.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle,
                      color: AppTheme.primaryGreen, size: 16),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_selectedCustomer!.name,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.deepGreen,
                          )),
                      Text(_selectedCustomer!.mobile,
                          style: const TextStyle(
                              fontSize: 11,
                              color: AppTheme.textMuted)),
                    ],
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 14),

          // ── Destination ─────────────────────────────────────────────────
          _sectionCard(
            icon: Icons.output_outlined,
            title: 'Destination',
            child: _styledDropdown(
              value: _destination,
              items: _destOptions,
              onChanged: (v) => setState(() => _destination = v!),
            ),
          ),

          const SizedBox(height: 28),

          // ── DISPLAY Button ──────────────────────────────────────────────
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
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.receipt_long, size: 20),
                  SizedBox(width: 10),
                  Text('DISPLAY',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                      )),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ── Date Range Picker dialog ───────────────────────────────────────────────
  Future<void> _showDateRangePicker() async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Select Date Range',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppTheme.textDark)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _datePickerRow('From', _fromDateCtrl),
            const SizedBox(height: 12),
            _datePickerRow('To', _toDateCtrl),
          ],
        ),
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

  Widget _datePickerRow(
      String label, TextEditingController ctrl) {
    return GestureDetector(
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
            labelStyle:
            const TextStyle(color: AppTheme.textMuted, fontSize: 13),
            prefixIcon: const Icon(Icons.calendar_today,
                color: AppTheme.primaryGreen, size: 18),
            filled: true,
            fillColor: AppTheme.surfaceCard,
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
              const BorderSide(color: AppTheme.lightGreen, width: 1),
            ),
          ),
        ),
      ),
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────
  Widget _sectionCard({
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryGreen.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child:
                Icon(icon, size: 16, color: AppTheme.deepGreen),
              ),
              const SizedBox(width: 8),
              Text(title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textMuted,
                    letterSpacing: 0.4,
                  )),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _styledDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
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
            color: AppTheme.textDark,
          ),
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
}

// ─────────────────────────────────────────────────────────────────────────────
// REPORT VIEW
// ─────────────────────────────────────────────────────────────────────────────
class _ReportView extends StatelessWidget {
  final List<StatementEntry> data;
  final CustomerInfo?        customer;
  final String               fromDate;
  final String               toDate;
  final Animation<double>    fadeAnim;
  final VoidCallback         onBack;

  const _ReportView({
    super.key,
    required this.data,
    required this.customer,
    required this.fromDate,
    required this.toDate,
    required this.fadeAnim,
    required this.onBack,
  });

  double get _totalDebit  =>
      data.where((e) => e.particulars != 'OPENING BALANCE')
          .fold(0, (s, e) => s + e.debit);
  double get _totalCredit =>
      data.where((e) => e.particulars != 'OPENING BALANCE')
          .fold(0, (s, e) => s + e.credit);
  double get _closingBalance =>
      data.isEmpty ? 0 : data.last.balance;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnim,
      child: Column(
        children: [
          // ── PRINT / EXCEL buttons ────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 12),
            child: Row(
              children: [
                _actionBtn(Icons.print_outlined, 'PRINT',
                    AppTheme.deepGreen),
                const SizedBox(width: 12),
                _actionBtn(Icons.table_chart_outlined, 'EXCEL',
                    AppTheme.primaryGreen),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              child: Column(
                children: [
                  // ── Company Header ───────────────────────────────────────
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
                          color:
                          AppTheme.deepGreen.withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: AppTheme.accentLime
                                    .withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.eco,
                                  color: AppTheme.accentLime,
                                  size: 18),
                            ),
                            const SizedBox(width: 10),
                            const Text('Demo Software',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.5,
                                )),
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
                            color: AppTheme.primaryGreen
                                .withOpacity(0.25),
                            borderRadius:
                            BorderRadius.circular(20),
                            border: Border.all(
                                color: AppTheme.lightGreen
                                    .withOpacity(0.4)),
                          ),
                          child: const Text('Customer Statement',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1,
                              )),
                        ),
                        const SizedBox(height: 10),
                        // Customer info block
                        if (customer != null) ...[
                          Text(customer!.name,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(height: 2),
                          Text(customer!.mobile,
                              style: TextStyle(
                                  color: Colors.white
                                      .withOpacity(0.75),
                                  fontSize: 12)),
                        ],
                        const SizedBox(height: 4),
                        Text(
                          'FROM: $fromDate  TO: $toDate',
                          style: TextStyle(
                              color:
                              Colors.white.withOpacity(0.65),
                              fontSize: 11),
                        ),
                      ],
                    ),
                  ),

                  // ── Table ────────────────────────────────────────────────
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
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Header
                        _StmtRow(
                          cells: const [
                            'SNO', 'DATE', 'REF', 'TYPE',
                            'PARTICULARS', 'DEBIT', 'CREDIT',
                            'BALANCE'
                          ],
                          isHeader: true,
                        ),

                        // Data
                        if (data.isEmpty)
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              children: [
                                Icon(Icons.inbox_outlined,
                                    size: 48,
                                    color: AppTheme.lightGreen),
                                const SizedBox(height: 8),
                                const Text('No records found',
                                    style: TextStyle(
                                        color: AppTheme.textMuted,
                                        fontSize: 14)),
                              ],
                            ),
                          )
                        else
                          ...data.asMap().entries.map((entry) {
                            final i = entry.key;
                            final e = entry.value;
                            final isOpening =
                                e.particulars == 'OPENING BALANCE';
                            return _StmtRow(
                              cells: [
                                e.sno.toString(),
                                e.date,
                                e.ref,
                                e.type,
                                e.particulars,
                                isOpening
                                    ? ''
                                    : e.debit == 0
                                    ? ''
                                    : e.debit
                                    .toStringAsFixed(2),
                                isOpening
                                    ? ''
                                    : e.credit == 0
                                    ? ''
                                    : e.credit
                                    .toStringAsFixed(2),
                                e.balance.toStringAsFixed(2),
                              ],
                              isEven: i.isEven,
                              isOpening: isOpening,
                            );
                          }),

                        // Total row
                        _StmtRow(
                          cells: [
                            '', '', '', 'TOTAL', '',
                            _totalDebit.toStringAsFixed(2),
                            _totalCredit.toStringAsFixed(2),
                            _closingBalance.toStringAsFixed(2),
                          ],
                          isTotal: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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
      ],
    ),
  );

  Widget _actionBtn(IconData icon, String label, Color color) =>
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
// STATEMENT TABLE ROW
// ─────────────────────────────────────────────────────────────────────────────
class _StmtRow extends StatelessWidget {
  final List<String> cells;
  final bool isHeader;
  final bool isEven;
  final bool isTotal;
  final bool isOpening;

  const _StmtRow({
    required this.cells,
    this.isHeader  = false,
    this.isEven    = false,
    this.isTotal   = false,
    this.isOpening = false,
  });

  @override
  Widget build(BuildContext context) {
    Color bg = Colors.transparent;
    if (isHeader)  bg = AppTheme.deepGreen;
    else if (isTotal)   bg = AppTheme.surfaceCard;
    else if (isOpening) bg = AppTheme.primaryGreen.withOpacity(0.06);
    else if (isEven)    bg = AppTheme.scaffoldBg;

    // flex: SNO,DATE,REF,TYPE,PARTICULARS,DEBIT,CREDIT,BALANCE
    const flex = [1, 2, 2, 2, 3, 2, 2, 2];

    return Container(
      color: bg,
      padding:
      const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Row(
        children: List.generate(cells.length, (i) {
          final rightAlign = i >= 5; // DEBIT, CREDIT, BALANCE
          Color textColor = isHeader
              ? Colors.white
              : isTotal
              ? AppTheme.deepGreen
              : AppTheme.textDark;

          // highlight balance in opening row
          if (isOpening && i == 7) {
            textColor = AppTheme.deepGreen;
          }

          return Expanded(
            flex: flex[i],
            child: Text(
              cells[i],
              textAlign: rightAlign
                  ? TextAlign.right
                  : TextAlign.left,
              style: TextStyle(
                fontSize: isHeader ? 10 : 11,
                fontWeight: (isHeader || isTotal || isOpening)
                    ? FontWeight.w700
                    : FontWeight.w400,
                color: textColor,
                letterSpacing: isHeader ? 0.2 : 0,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          );
        }),
      ),
    );
  }
}