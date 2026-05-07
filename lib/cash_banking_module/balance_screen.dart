import 'package:flutter/material.dart';

// ── Data model ────────────────────────────────────────────────────────────────
class _BalanceEntry {
  final String name;
  final double balance;
  const _BalanceEntry({required this.name, required this.balance});
}

// ── Screen ────────────────────────────────────────────────────────────────────
class CashBankBalanceScreen extends StatefulWidget {
  const CashBankBalanceScreen({super.key});

  @override
  State<CashBankBalanceScreen> createState() => _CashBankBalanceScreenState();
}

class _CashBankBalanceScreenState extends State<CashBankBalanceScreen> {
  // ── Colors ────────────────────────────────────────────────────────────────
  static const Color _primary    = Color(0xFF1E8B3E);
  static const Color _bgPage     = Color(0xFFF4F7F4);
  static const Color _cardBg     = Color(0xFFFFFFFF);
  static const Color _labelColor = Color(0xFF2D4A35);
  static const Color _textMid    = Color(0xFF6B7280);
  static const Color _headerBg   = Color(0xFFF1F5F1);
  static const Color _borderClr  = Color(0xFFDDE3DD);
  static const Color _negative   = Color(0xFFD32F2F);

  // ── Sample data ───────────────────────────────────────────────────────────
  final List<_BalanceEntry> _allData = const [
    _BalanceEntry(name: 'Loan amount', balance: 10000.00),
    _BalanceEntry(name: 'PETTY CASH',  balance: 43157250.30),
    _BalanceEntry(name: 'SBI',         balance: -25828.00),
  ];

  final _searchController = TextEditingController();
  List<_BalanceEntry> _filtered = [];

  bool? _nameSortAsc;
  bool? _balanceSortAsc;

  @override
  void initState() {
    super.initState();
    _filtered = List.from(_allData);
    _searchController.addListener(_onSearch);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ── Search ────────────────────────────────────────────────────────────────
  void _onSearch() {
    final q = _searchController.text.trim().toLowerCase();
    setState(() {
      _filtered = q.isEmpty
          ? List.from(_allData)
          : _allData.where((e) => e.name.toLowerCase().contains(q)).toList();
    });
  }

  // ── Sort ──────────────────────────────────────────────────────────────────
  void _sortByName() {
    setState(() {
      _nameSortAsc    = !(_nameSortAsc ?? false);
      _balanceSortAsc = null;
      _filtered.sort((a, b) => _nameSortAsc!
          ? a.name.compareTo(b.name)
          : b.name.compareTo(a.name));
    });
  }

  void _sortByBalance() {
    setState(() {
      _balanceSortAsc = !(_balanceSortAsc ?? false);
      _nameSortAsc    = null;
      _filtered.sort((a, b) => _balanceSortAsc!
          ? a.balance.compareTo(b.balance)
          : b.balance.compareTo(a.balance));
    });
  }

  double get _total => _filtered.fold(0, (sum, e) => sum + e.balance);

  // ── Number formatter ──────────────────────────────────────────────────────
  String _fmt(double v) {
    final abs   = v.abs();
    final parts = abs.toStringAsFixed(2).split('.');
    final whole = parts[0];
    final dec   = parts[1];
    final buf   = StringBuffer();
    int count   = 0;
    for (int i = whole.length - 1; i >= 0; i--) {
      if (count > 0 && count % 3 == 0) buf.write(',');
      buf.write(whole[i]);
      count++;
    }
    return '${v < 0 ? '-' : ''}${buf.toString().split('').reversed.join()}.$dec';
  }

  // ── Build ─────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgPage,
      body: Column(children: [
        _buildAppBar(context),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                _buildSearchBar(),
                const SizedBox(height: 12),
                _buildTable(),
                const SizedBox(height: 10),
                Text(
                  'Showing 1 to ${_filtered.length} of ${_allData.length} rows',
                  style: const TextStyle(color: _textMid, fontSize: 13),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  // ── AppBar ────────────────────────────────────────────────────────────────
  Widget _buildAppBar(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF43A873), Color(0xFF256D47)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 60,
          child: Row(children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.white, size: 22),
              onPressed: () => Navigator.of(context).maybePop(),
            ),
            const SizedBox(width: 4),
            const Text('Balance',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3)),
            const Spacer(),
          ]),
        ),
      ),
    );
  }

  // ── Full-width Search Bar ─────────────────────────────────────────────────
  Widget _buildSearchBar() {
    return SizedBox(
      height: 44,
      width: double.infinity,
      child: TextField(
        controller: _searchController,
        style: const TextStyle(fontSize: 14, color: _labelColor),
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(color: _textMid.withOpacity(0.6), fontSize: 14),
          prefixIcon: Icon(Icons.search_rounded,
              color: _textMid.withOpacity(0.6), size: 20),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
            icon: Icon(Icons.clear_rounded,
                color: _textMid.withOpacity(0.6), size: 18),
            onPressed: () {
              _searchController.clear();
              _onSearch();
            },
          )
              : null,
          filled: true,
          fillColor: _cardBg,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: _borderClr, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: _borderClr, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: _primary, width: 1.5),
          ),
        ),
      ),
    );
  }

  // ── Table ─────────────────────────────────────────────────────────────────
  Widget _buildTable() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderClr, width: 1),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4))
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(children: [

          // Header
          Container(
            color: _headerBg,
            child: Row(children: [
              _headerCell('S.No', flex: 2, center: true, onSort: null),
              _colDivider(),
              _headerCell('NAME', flex: 3, center: false,
                  onSort: _sortByName, sortAsc: _nameSortAsc),
              _colDivider(),
              _headerCell('BALANCE', flex: 4, center: true,
                  onSort: _sortByBalance, sortAsc: _balanceSortAsc),
            ]),
          ),

          const Divider(height: 1, color: _borderClr),

          // Data rows
          if (_filtered.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Center(
                child: Text('No results found',
                    style: TextStyle(
                        color: _textMid.withOpacity(0.6), fontSize: 14)),
              ),
            )
          else
            ..._filtered.asMap().entries.map((entry) {
              final i      = entry.key;
              final e      = entry.value;
              final isEven = i % 2 == 0;
              return Column(children: [
                Container(
                  color: isEven ? _cardBg : const Color(0xFFF9FCF9),
                  child: Row(children: [
                    _dataCell('${i + 1}',
                        flex: 2,
                        center: true,
                        style: const TextStyle(
                            fontSize: 14,
                            color: _textMid,
                            fontWeight: FontWeight.w500)),
                    _colDivider(),
                    _dataCell(e.name,
                        flex: 5,
                        center: false,
                        style: const TextStyle(
                            fontSize: 14,
                            color: _labelColor,
                            fontWeight: FontWeight.w500)),
                    _colDivider(),
                    _dataCell(_fmt(e.balance),
                        flex: 4,
                        center: true,
                        style: TextStyle(
                            fontSize: 14,
                            color: e.balance < 0 ? _negative : _labelColor,
                            fontWeight: FontWeight.w500)),
                  ]),
                ),
                if (i < _filtered.length - 1)
                  const Divider(height: 1, color: _borderClr),
              ]);
            }),

          // Total row
          const Divider(height: 1, color: _borderClr),
          Container(
            color: const Color(0xFFF1F5F1),
            child: Row(children: [
              Expanded(flex: 2, child: const SizedBox(height: 52)),
              _colDivider(),
              Expanded(
                flex: 5,
                child: Container(
                  height: 52,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  alignment: Alignment.centerLeft,
                  child: const Text('Total',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: _labelColor,
                          letterSpacing: 0.3)),
                ),
              ),
              _colDivider(),
              Expanded(
                flex: 4,
                child: Container(
                  height: 52,
                  alignment: Alignment.center,
                  child: Text(_fmt(_total),
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: _total < 0 ? _negative : _labelColor)),
                ),
              ),
            ]),
          ),

        ]),
      ),
    );
  }

  Widget _headerCell(String label,
      {required int flex,
        required bool center,
        required VoidCallback? onSort,
        bool? sortAsc}) {
    return Expanded(
      flex: flex,
      child: InkWell(
        onTap: onSort,
        child: Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          alignment: center ? Alignment.center : Alignment.centerLeft,
          child: Row(
            mainAxisSize:
            center ? MainAxisSize.min : MainAxisSize.max,
            mainAxisAlignment: center
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              Flexible(
                child: Text(label,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: _labelColor,
                        letterSpacing: 0.5)),
              ),
              if (onSort != null) ...[
                const SizedBox(width: 4),
                Column(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.arrow_drop_up_rounded,
                      size: 16,
                      color: sortAsc == true
                          ? _primary
                          : _textMid.withOpacity(0.4)),
                  Icon(Icons.arrow_drop_down_rounded,
                      size: 16,
                      color: sortAsc == false
                          ? _primary
                          : _textMid.withOpacity(0.4)),
                ]),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _dataCell(String text,
      {required int flex, required bool center, required TextStyle style}) {
    return Expanded(
      flex: flex,
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        alignment: center ? Alignment.center : Alignment.centerLeft,
        child: Text(text, style: style, overflow: TextOverflow.ellipsis),
      ),
    );
  }

  Widget _colDivider() => Container(width: 1, color: _borderClr);
}