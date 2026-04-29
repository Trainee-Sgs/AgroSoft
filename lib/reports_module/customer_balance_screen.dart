import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import '../theme/app_theme.dart';

// ─────────────────────────────────────────────────────────────────────────────
// DATA MODEL
// ─────────────────────────────────────────────────────────────────────────────
class CustomerBalanceEntry {
  final int    sno;
  final String id;
  final String name;

  final String mobile;
  final String address;
  final double amount;

  const CustomerBalanceEntry({
    required this.sno,
    required this.id,
    required this.name,

    required this.mobile,
    required this.address,

    required this.amount,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// SAMPLE DATA  (replace with your real API / DB call)
// ─────────────────────────────────────────────────────────────────────────────
final List<CustomerBalanceEntry> _sampleData = [
  CustomerBalanceEntry(sno: 1, id: 'C001', name: 'Arjun',       mobile: '9876543210', address: 'Coimbatore', amount: 12500),
  CustomerBalanceEntry(sno: 2, id: 'C002', name: 'Priya',      mobile: '9988776655', address: 'Tirupur',   amount: 8750),
  CustomerBalanceEntry(sno: 3, id: 'C003', name: 'Selvam',        mobile: '9123456780', address: 'Erode',       amount: 0),
  CustomerBalanceEntry(sno: 4, id: 'C004', name: 'Meena',           mobile: '9000111222', address: 'Salem',    amount: 3200),
  CustomerBalanceEntry(sno: 5, id: 'C005', name: 'Karthik',     mobile: '9444555666', address: 'Chennai',    amount: 0),
];


// ─────────────────────────────────────────────────────────────────────────────
// CUSTOMER BALANCE PAGE
// ─────────────────────────────────────────────────────────────────────────────
class CustomerBalancePage extends StatefulWidget {
  const CustomerBalancePage({super.key});
  @override
  State<CustomerBalancePage> createState() => _CustomerBalancePageState();
}

class _CustomerBalancePageState extends State<CustomerBalancePage>
    with SingleTickerProviderStateMixin {

  // ── Filter state ─────────────────────────────────────────────────────────
  String  _order          = 'Ascending';
  String? _balanceFilter;          // 'With Balance' | 'Without Balance' | null
  final   _dateController = TextEditingController();
  String? _ledgerType;
  String  _destination    = 'EXCEL';

  // ── Report state ─────────────────────────────────────────────────────────
  bool                          _showReport = false;
  List<CustomerBalanceEntry>    _reportData = [];
  late AnimationController      _animCtrl;
  late Animation<double>        _fadeAnim;

  final List<String> _ledgerOptions  = ['Select Option', 'Cash', 'Bank', 'Credit'];
  final List<String> _destOptions    = ['EXCEL', 'PDF', 'PRINT'];

  @override
  void initState() {
    super.initState();
    // Default date = today
    final now = DateTime.now();
    _dateController.text =
    '${now.day.toString().padLeft(2,'0')}-'
        '${now.month.toString().padLeft(2,'0')}-'
        '${now.year}';

    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    _dateController.dispose();
    super.dispose();
  }

  // ── Filter → Report ──────────────────────────────────────────────────────
  void _onDisplay() {
    List<CustomerBalanceEntry> data = List.from(_sampleData);

    // Balance filter
    if (_balanceFilter == 'With Balance') {
      data = data.where((e) => e.amount > 0).toList();
    } else if (_balanceFilter == 'Without Balance') {
      data = data.where((e) => e.amount == 0).toList();
    }

    // Order
    if (_order == 'Ascending') {
      data.sort((a, b) => a.name.compareTo(b.name));
    } else {
      data.sort((a, b) => b.name.compareTo(a.name));
    }

    setState(() {
      _reportData = data;
      _showReport = true;
    });
    _animCtrl.forward(from: 0);
  }

  void _onBack() {
    setState(() => _showReport = false);
    _animCtrl.reverse();
  }

  // ── Date picker ──────────────────────────────────────────────────────────
  Future<void> _pickDate() async {
    final parts = _dateController.text.split('-');
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
          colorScheme: const ColorScheme.light(primary: AppTheme.primaryGreen),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      _dateController.text =
      '${picked.day.toString().padLeft(2,'0')}-'
          '${picked.month.toString().padLeft(2,'0')}-'
          '${picked.year}';
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: <Widget>[
          _buildAppBar(),
      Expanded(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: _showReport
              ? _ReportView(
            key: const ValueKey('report'),
            data: _reportData,
            date: _dateController.text,
            fadeAnim: _fadeAnim,
            onBack: _onBack,
          )
              : _FilterForm(
            key: const ValueKey('form'),
            order: _order,
            balanceFilter: _balanceFilter,
            dateController: _dateController,
            ledgerType: _ledgerType,
            destination: _destination,
            ledgerOptions: _ledgerOptions,
            destOptions: _destOptions,
            onOrderChanged: (v) => setState(() => _order = v),
            onBalanceChanged: (v) => setState(() => _balanceFilter = v),
            onPickDate: _pickDate,
            onLedgerChanged: (v) => setState(() => _ledgerType = v),
            onDestChanged: (v) => setState(() => _destination = v!),
            onDisplay: _onDisplay,
          ),
        ),
      ),
        ],
      ),
    );
  }

  // ── Gradient AppBar ───────────────────────────────────────────────────────
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [

              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back_ios_new,
                    color: Colors.white, size: 20),
              ),
              const SizedBox(width: 14),
              const Text(
                'Customer Balance',
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
}

// ─────────────────────────────────────────────────────────────────────────────
// FILTER FORM WIDGET
// ─────────────────────────────────────────────────────────────────────────────
class _FilterForm extends StatelessWidget {
  final String  order;
  final String? balanceFilter;
  final TextEditingController dateController;
  final String? ledgerType;
  final String  destination;
  final List<String> ledgerOptions;
  final List<String> destOptions;
  final ValueChanged<String>  onOrderChanged;
  final ValueChanged<String?>  onBalanceChanged;
  final VoidCallback onPickDate;
  final ValueChanged<String?> onLedgerChanged;
  final ValueChanged<String?> onDestChanged;
  final VoidCallback onDisplay;

  const _FilterForm({
    super.key,
    required this.order,
    required this.balanceFilter,
    required this.dateController,
    required this.ledgerType,
    required this.destination,
    required this.ledgerOptions,
    required this.destOptions,
    required this.onOrderChanged,
    required this.onBalanceChanged,
    required this.onPickDate,
    required this.onLedgerChanged,
    required this.onDestChanged,
    required this.onDisplay,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),

          // ── Order ──────────────────────────────────────────────────────
          _sectionCard(
            icon: Icons.sort,
            title: 'Order',
            child: Row(
              children: ['Ascending', 'Descending'].map((opt) {
                final selected = order == opt;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => onOrderChanged(opt),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: selected
                            ? AppTheme.primaryGreen
                            : AppTheme.surfaceCard,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: selected
                              ? AppTheme.deepGreen
                              : AppTheme.lightGreen,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            opt == 'Ascending'
                                ? Icons.arrow_upward
                                : Icons.arrow_downward,
                            size: 14,
                            color: selected
                                ? Colors.white
                                : AppTheme.textMuted,
                          ),
                          const SizedBox(width: 6),
                          Text(opt,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: selected
                                    ? Colors.white
                                    : AppTheme.textDark,
                              )),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 14),

          // ── Balance Filter ─────────────────────────────────────────────
          _sectionCard(
            icon: Icons.account_balance_wallet_outlined,
            title: 'Balance Filter',
            child: Column(
              children: ['With Balance', 'Without Balance'].map((opt) {
                final selected = balanceFilter == opt;
                return GestureDetector(
                  onTap: () => onBalanceChanged(selected ? null : opt),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: selected
                          ? AppTheme.primaryGreen.withOpacity(0.12)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: selected
                            ? AppTheme.primaryGreen
                            : AppTheme.lightGreen.withOpacity(0.5),
                      ),
                    ),
                    child: Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 18, height: 18,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: selected
                                ? AppTheme.primaryGreen
                                : Colors.transparent,
                            border: Border.all(
                              color: selected
                                  ? AppTheme.deepGreen
                                  : AppTheme.textMuted,
                              width: 2,
                            ),
                          ),
                          child: selected
                              ? const Icon(Icons.check,
                              size: 11, color: Colors.white)
                              : null,
                        ),
                        const SizedBox(width: 12),
                        Text(opt,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: selected
                                  ? AppTheme.deepGreen
                                  : AppTheme.textDark,
                            )),
                        if (selected) ...[
                          const Spacer(),
                          Icon(
                            opt == 'With Balance'
                                ? Icons.trending_up
                                : Icons.trending_flat,
                            color: AppTheme.primaryGreen,
                            size: 18,
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 14),

          // ── Date ───────────────────────────────────────────────────────
          _sectionCard(
            icon: Icons.calendar_today_outlined,
            title: 'Date',
            child: GestureDetector(
              onTap: onPickDate,
              child: AbsorbPointer(
                child: TextField(
                  controller: dateController,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textDark,
                  ),
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.calendar_month,
                        color: AppTheme.primaryGreen),
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
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 14),

          // ── Ledger Type ────────────────────────────────────────────────
          _sectionCard(
            icon: Icons.book_outlined,
            title: 'Ledger Type',
            child: _styledDropdown(
              value: ledgerType ?? ledgerOptions.first,
              items: ledgerOptions,
              onChanged: onLedgerChanged,
            ),
          ),

          const SizedBox(height: 14),

          // ── Destination ────────────────────────────────────────────────
          _sectionCard(
            icon: Icons.output_outlined,
            title: 'Destination',
            child: _styledDropdown(
              value: destination,
              items: destOptions,
              onChanged: onDestChanged,
            ),
          ),

          const SizedBox(height: 28),

          // ── DISPLAY Button ─────────────────────────────────────────────
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: onDisplay,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryGreen,
                foregroundColor: Colors.white,
                elevation: 4,
                shadowColor: AppTheme.deepGreen.withOpacity(0.4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.bar_chart_rounded, size: 20),
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
                child: Icon(icon, size: 16, color: AppTheme.deepGreen),
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
          items: items.map((s) => DropdownMenuItem(
            value: s,
            child: Text(s),
          )).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// REPORT VIEW WIDGET
// ─────────────────────────────────────────────────────────────────────────────
class _ReportView extends StatelessWidget {
  final List<CustomerBalanceEntry> data;
  final String date;
  final Animation<double> fadeAnim;
  final VoidCallback onBack;

  const _ReportView({
    super.key,
    required this.data,
    required this.date,
    required this.fadeAnim,
    required this.onBack,
  });

  double get _total => data.fold(0, (sum, e) => sum + e.amount);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnim,
      child: Column(
        children: [
          // ── Action buttons (PRINT / EXCEL) ─────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              children: [
                _actionBtn(Icons.print_outlined, 'PRINT', AppTheme.deepGreen),
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
                  // ── Company Header ──────────────────────────────────────
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          AppTheme.darkCard1,
                          AppTheme.darkCard3,
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
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: AppTheme.accentLime.withOpacity(0.2),
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
                                  letterSpacing: 0.5,
                                )),
                          ],
                        ),
                        const SizedBox(height: 6),
                        _headerLine(
                            Icons.payment, 'GPAY : 9047099444 / 9047099447'),
                        const SizedBox(height: 2),
                        _headerLine(Icons.receipt_long,
                            'GSTIN: PL.NO:CBE/PL/0001  FL.NO:FL 2025-2030\nSL.NO: CBE/SL/0003'),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryGreen.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: AppTheme.lightGreen.withOpacity(0.4)),
                          ),
                          child: const Text('Customer Balance',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1,
                              )),
                        ),
                        const SizedBox(height: 8),
                        Text('Report Date: $date',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.65),
                              fontSize: 12,
                            )),
                      ],
                    ),
                  ),

                  // ── Table ───────────────────────────────────────────────
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(14)),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryGreen.withOpacity(0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Header row
                        _TableRow(
                          cells: const [
                            'SNO', 'ID', 'NAME',
                            'MOBILE', 'ADDRESS', 'AMOUNT',
                          ],
                          isHeader: true,
                        ),

                        // Data rows
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
                            final idx = entry.key;
                            final e   = entry.value;
                            return _TableRow(
                              cells: [
                                e.sno.toString(),
                                e.id,
                                e.name,
                                e.mobile,
                                e.address,
                                e.amount == 0
                                    ? '0'
                                    : e.amount.toStringAsFixed(0),
                              ],
                              isHeader: false,
                              isEven: idx.isEven,
                              hasBalance: e.amount > 0,
                            );
                          }),

                        // Total row
                        Container(
                          decoration: const BoxDecoration(
                            color: AppTheme.surfaceCard,
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(14)),
                          ),
                          child: _TableRow(
                            cells: [
                              '', '', '', '', '', '', 'TOTAL',
                              _total.toStringAsFixed(0),
                            ],
                            isHeader: false,
                            isTotal: true,
                          ),
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

  Widget _headerLine(IconData icon, String text) => Padding(
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
                  color: Colors.white.withOpacity(0.75), fontSize: 11)),
        ),
      ],
    ),
  );

  Widget _actionBtn(IconData icon, String label, Color color) => Expanded(
    child: ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 16),
      label: Text(label,
          style: const TextStyle(
              fontSize: 13, fontWeight: FontWeight.w700, letterSpacing: 0.8)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 3,
        shadowColor: color.withOpacity(0.4),
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// TABLE ROW WIDGET
// ─────────────────────────────────────────────────────────────────────────────
class _TableRow extends StatelessWidget {
  final List<String> cells;
  final bool isHeader;
  final bool isEven;
  final bool isTotal;
  final bool hasBalance;

  const _TableRow({
    required this.cells,
    this.isHeader = false,
    this.isEven   = false,
    this.isTotal  = false,
    this.hasBalance = false,
  });

  @override
  Widget build(BuildContext context) {
    Color rowBg = Colors.transparent;
    if (isHeader) rowBg = AppTheme.deepGreen;
    else if (isTotal) rowBg = AppTheme.surfaceCard;
    else if (isEven) rowBg = AppTheme.scaffoldBg;

    // Column flex weights
    const List<int> flex = [1, 1, 2, 2, 2, 2, 1, 2];

    return Container(
      color: rowBg,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Row(
        children: List.generate(cells.length, (i) {
          final text = cells[i];
          final isAmt = i == 7;
          final isPvOrTotal = i == 6;

          Color textColor = isHeader
              ? Colors.white
              : (isTotal
              ? AppTheme.deepGreen
              : (hasBalance && isAmt
              ? AppTheme.deepGreen
              : AppTheme.textDark));

          return Expanded(
            flex: flex[i],
            child: Text(
              text,
              textAlign: (isAmt || isPvOrTotal)
                  ? TextAlign.right
                  : TextAlign.left,
              style: TextStyle(
                fontSize: isHeader ? 11 : 12,
                fontWeight: (isHeader || isTotal)
                    ? FontWeight.w700
                    : FontWeight.w400,
                color: textColor,
                letterSpacing: isHeader ? 0.3 : 0,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          );
        }),
      ),
    );
  }
}