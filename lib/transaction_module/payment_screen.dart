import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ── Data model ────────────────────────────────────────────────────────────────
class _PaymentEntry {
  final String id;
  final String date;
  final String customerName;
  final String balance;
  final String amount;
  final String remark;
  final String chequeDate;
  final String payType;
  final String payAccount;
  final DateTime createdAt;

  _PaymentEntry({
    required this.id,
    required this.date,
    required this.customerName,
    required this.balance,
    required this.amount,
    required this.remark,
    required this.chequeDate,
    required this.payType,
    required this.payAccount,
    required this.createdAt,
  });
}

// ── Screen ────────────────────────────────────────────────────────────────────
class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  // Tab: 0 = Payment form, 1 = View List
  int _activeTab = 0;

  // Saved payments
  final List<_PaymentEntry> _payments = [];

  // Controllers
  final _dateController         = TextEditingController();
  final _customerNameController = TextEditingController();
  final _balanceController      = TextEditingController();
  final _amountController       = TextEditingController();
  final _remarkController       = TextEditingController();
  final _chequeDateController   = TextEditingController();

  String _selectedPayType    = 'CASH';
  String _selectedPayAccount = 'SBI Bank';

  final List<String> _payTypes    = ['CASH', 'CHEQUE', 'UPI', 'NEFT', 'RTGS'];
  final List<String> _payAccounts = [
    'SBI Bank', 'HDFC Bank', 'ICICI Bank', 'Axis Bank', 'Canara Bank',
  ];

  late AnimationController _saveAnim;

  // ── Colors ────────────────────────────────────────────────────────────────
  static const Color _primary     = Color(0xFF1E8B3E);
  static const Color _primaryDk   = Color(0xFF156B2F);
  static const Color _bgPage      = Color(0xFFF4F7F4);
  static const Color _cardBg      = Color(0xFFFFFFFF);
  static const Color _labelColor  = Color(0xFF2D4A35);
  static const Color _borderColor = Color(0xFFB8DEC3);
  static const Color _focusBorder = Color(0xFF1E8B3E);
  static const Color _inputBg     = Color(0xFFF8FDF9);
  static const Color _hintColor   = Color(0xFFAABBAD);
  static const Color _textMid     = Color(0xFF6B7280);
  static const Color _textLight   = Color(0xFFB0B8C5);

  @override
  void initState() {
    super.initState();
    _saveAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.96,
      upperBound: 1.0,
      value: 1.0,
    );
    _setTodayDate();
  }

  void _setTodayDate() {
    final now = DateTime.now();
    final formatted =
        '${now.day.toString().padLeft(2, '0')}-'
        '${now.month.toString().padLeft(2, '0')}-'
        '${now.year}';
    _dateController.text = formatted;
  }

  @override
  void dispose() {
    _dateController.dispose();
    _customerNameController.dispose();
    _balanceController.dispose();
    _amountController.dispose();
    _remarkController.dispose();
    _chequeDateController.dispose();
    _saveAnim.dispose();
    super.dispose();
  }

  // ── Save payment ──────────────────────────────────────────────────────────
  void _savePayment() {
    if (!_formKey.currentState!.validate()) return;

    final entry = _PaymentEntry(
      id: 'PAY-${DateTime.now().millisecondsSinceEpoch}',
      date: _dateController.text,
      customerName: _customerNameController.text.trim(),
      balance: _balanceController.text.trim(),
      amount: _amountController.text.trim(),
      remark: _remarkController.text.trim(),
      chequeDate: _chequeDateController.text.trim(),
      payType: _selectedPayType,
      payAccount: _selectedPayAccount,
      createdAt: DateTime.now(),
    );

    // Clear form
    _customerNameController.clear();
    _balanceController.clear();
    _amountController.clear();
    _remarkController.clear();
    _chequeDateController.clear();
    _selectedPayType    = 'CASH';
    _selectedPayAccount = 'SBI Bank';
    _setTodayDate();

    setState(() {
      _payments.insert(0, entry);
      _activeTab = 1;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(children: [
          Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
          SizedBox(width: 10),
          Text('Payment saved successfully!',
              style: TextStyle(fontWeight: FontWeight.w600)),
        ]),
        backgroundColor: _primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  // ── Build ─────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgPage,
      body: Column(children: [
        _buildAppBar(context),
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 260),
            child: _activeTab == 0 ? _buildForm() : _buildList(),
          ),
        ),
      ]),
      bottomNavigationBar: _activeTab == 0 ? _buildSaveButton() : null,
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
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(
            height: 60,
            child: Row(children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded,
                    color: Colors.white, size: 22),
                onPressed: () => Navigator.of(context).maybePop(),
              ),
              const SizedBox(width: 4),
              const Text('Payment',
                  style: TextStyle(color: Colors.white, fontSize: 20,
                      fontWeight: FontWeight.w700, letterSpacing: 0.3)),
              const Spacer(),
              if (_payments.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${_payments.length} saved',
                    style: const TextStyle(color: Colors.white,
                        fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
              Container(
                margin: const EdgeInsets.only(right: 12),
                width: 36, height: 36,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.more_vert_rounded,
                    color: Colors.white, size: 20),
              ),
            ]),
          ),

          // Tab toggle
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
            child: Container(
              height: 44,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(children: [
                _tab('Payment', Icons.payments_rounded, 0),
                _tab('View List', Icons.list_alt_rounded, 1),
              ]),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _tab(String label, IconData icon, int index) {
    final active = _activeTab == index;
    return Expanded(child: GestureDetector(
      onTap: () => setState(() => _activeTab = index),
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
              color: active ? _primary : Colors.white.withOpacity(0.75)),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(
            fontSize: 13,
            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
            color: active ? _primary : Colors.white.withOpacity(0.75),
          )),
        ]),
      ),
    ));
  }

  // ── Form ──────────────────────────────────────────────────────────────────
  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: ListView(
        key: const ValueKey('form'),
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
        children: [
          Container(
            decoration: BoxDecoration(
              color: _cardBg,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [BoxShadow(
                color: _primary.withOpacity(0.08),
                blurRadius: 24, offset: const Offset(0, 8),
              )],
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDateField(
                  label: 'Date',
                  controller: _dateController,
                ),
                _divider(),
                _buildTextField(
                  label: 'Customer Name',
                  hint: 'Enter customer name',
                  controller: _customerNameController,
                  icon: Icons.person_outline_rounded,
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                _divider(),
                _buildTextField(
                  label: 'Balance',
                  hint: '₹ 0.00',
                  controller: _balanceController,
                  icon: Icons.account_balance_wallet_outlined,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[\d.]'))
                  ],
                  readOnly: true,
                ),
                _divider(),
                _buildTextField(
                  label: 'Amount',
                  hint: '₹ 0.00',
                  controller: _amountController,
                  icon: Icons.currency_rupee_rounded,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[\d.]'))
                  ],
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                _divider(),
                _buildTextField(
                  label: 'Remark',
                  hint: 'Enter remark',
                  controller: _remarkController,
                  icon: Icons.comment_outlined,
                ),
                _divider(),
                _buildDateField(
                  label: 'Cheque Date',
                  controller: _chequeDateController,
                  hint: 'DD-MM-YYYY',
                  optional: true,
                ),
                _divider(),
                _buildDropdown(
                  label: 'Pay Type',
                  icon: Icons.payment_rounded,
                  value: _selectedPayType,
                  items: _payTypes,
                  onChanged: (v) => setState(() => _selectedPayType = v!),
                ),
                _divider(),
                _buildDropdown(
                  label: 'Pay Account',
                  icon: Icons.account_balance_rounded,
                  value: _selectedPayAccount,
                  items: _payAccounts,
                  onChanged: (v) => setState(() => _selectedPayAccount = v!),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── View List ─────────────────────────────────────────────────────────────
  Widget _buildList() {
    if (_payments.isEmpty) {
      return Center(
        key: const ValueKey('empty'),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            width: 90, height: 90,
            decoration: const BoxDecoration(
              color: Color(0xFFE8F5ED), shape: BoxShape.circle,
            ),
            child: const Icon(Icons.payments_rounded,
                color: _primary, size: 44),
          ),
          const SizedBox(height: 20),
          const Text('No Payments Yet',
              style: TextStyle(color: _labelColor, fontSize: 18,
                  fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          const Text('Save a payment to see it here',
              style: TextStyle(color: _textMid, fontSize: 14)),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => setState(() => _activeTab = 0),
            icon: const Icon(Icons.add_rounded, color: Colors.white, size: 18),
            label: const Text('New Payment',
                style: TextStyle(color: Colors.white,
                    fontWeight: FontWeight.w700)),
            style: ElevatedButton.styleFrom(
              backgroundColor: _primary,
              padding: const EdgeInsets.symmetric(
                  horizontal: 28, vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
            ),
          ),
        ]),
      );
    }

    return ListView.builder(
      key: const ValueKey('list'),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      physics: const BouncingScrollPhysics(),
      itemCount: _payments.length,
      itemBuilder: (_, i) => _paymentCard(_payments[i], i),
    );
  }

  Widget _paymentCard(_PaymentEntry e, int i) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 16, offset: const Offset(0, 4),
        )],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(children: [
          // Gradient header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [_primary, _primaryDk],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Row(children: [
              _badge('PAY-${_payments.length - i}'),
              const SizedBox(width: 10),
              Expanded(child: Text(e.customerName,
                  style: const TextStyle(color: Colors.white, fontSize: 15,
                      fontWeight: FontWeight.w700),
                  overflow: TextOverflow.ellipsis)),
              _badge(e.payType),
            ]),
          ),

          // Body
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(children: [
              Row(children: [
                _statBox('Amount',
                    e.amount.isEmpty ? '—' : '₹${e.amount}',
                    Icons.currency_rupee_rounded),
                const SizedBox(width: 10),
                _statBox('Date', e.date, Icons.calendar_today_rounded),
                const SizedBox(width: 10),
                _statBox('Account', e.payAccount,
                    Icons.account_balance_rounded),
              ]),
              if (e.balance.isNotEmpty)
                _detailRow('Balance', '₹${e.balance}'),
              if (e.chequeDate.isNotEmpty)
                _detailRow('Cheque Date', e.chequeDate),
              if (e.remark.isNotEmpty)
                _detailRow('Remark', e.remark),
              const SizedBox(height: 10),
              const Divider(height: 1, color: Color(0xFFE2E8F0)),
              const SizedBox(height: 10),
              Row(children: [
                const Icon(Icons.access_time_rounded,
                    color: _textLight, size: 12),
                const SizedBox(width: 4),
                Text('Saved ${_fmt(e.createdAt)}',
                    style: const TextStyle(color: _textLight,
                        fontSize: 11, fontWeight: FontWeight.w500)),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5ED),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(e.payType,
                      style: const TextStyle(color: _primary,
                          fontSize: 11, fontWeight: FontWeight.w700)),
                ),
              ]),
            ]),
          ),
        ]),
      ),
    );
  }

  // ── Shared helpers ────────────────────────────────────────────────────────
  Widget _detailRow(String k, String v) => Padding(
    padding: const EdgeInsets.only(top: 8),
    child: Row(children: [
      const Icon(Icons.chevron_right_rounded, color: _primary, size: 14),
      const SizedBox(width: 4),
      Text('$k: ', style: const TextStyle(color: _textMid,
          fontSize: 12, fontWeight: FontWeight.w600)),
      Expanded(child: Text(v, style: const TextStyle(color: _labelColor,
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
        color: const Color(0xFFE8F5ED),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(children: [
        Icon(icon, color: _primary, size: 13),
        const SizedBox(width: 5),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value.isEmpty ? '—' : value,
                style: const TextStyle(color: _primary,
                    fontSize: 11, fontWeight: FontWeight.w800),
                overflow: TextOverflow.ellipsis),
            Text(label, style: const TextStyle(color: _textMid,
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

  // ── Date field (reusable for Date + Cheque Date) ───────────────────────────
  Widget _buildDateField({
    required String label,
    required TextEditingController controller,
    String hint = 'DD-MM-YYYY',
    bool optional = false,
  }) {
    return _fieldWrapper(
      label: label,
      icon: Icons.calendar_today_rounded,
      child: GestureDetector(
        onTap: () async {
          final now = DateTime.now();
          // Parse existing value if any, else use today
          DateTime initial = now;
          if (controller.text.isNotEmpty) {
            final parts = controller.text.split('-');
            if (parts.length == 3) {
              initial = DateTime(
                int.tryParse(parts[2]) ?? now.year,
                int.tryParse(parts[1]) ?? now.month,
                int.tryParse(parts[0]) ?? now.day,
              );
            }
          }
          final picked = await showDatePicker(
            context: context,
            initialDate: initial,
            firstDate: DateTime(2020),
            lastDate: DateTime(2035),
            builder: (context, child) => Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: _primary,
                  onPrimary: Colors.white,
                  surface: Colors.white,
                ),
              ),
              child: child!,
            ),
          );
          if (picked != null) {
            setState(() {
              controller.text =
              '${picked.day.toString().padLeft(2, '0')}-'
                  '${picked.month.toString().padLeft(2, '0')}-'
                  '${picked.year}';
            });
          }
        },
        child: AbsorbPointer(
          child: TextFormField(
            controller: controller,
            style: const TextStyle(fontSize: 15,
                fontWeight: FontWeight.w600, color: _labelColor),
            validator: optional
                ? null
                : (v) => (v == null || v.isEmpty) ? 'Required' : null,
            decoration: _inputDecoration(hint: hint).copyWith(
              suffixIcon: const Icon(Icons.arrow_drop_down_rounded,
                  color: _primary, size: 26),
            ),
          ),
        ),
      ),
    );
  }

  // ── Text field ────────────────────────────────────────────────────────────
  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    bool readOnly = false,
    String? Function(String?)? validator,
  }) {
    return _fieldWrapper(
      label: label,
      icon: icon,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        readOnly: readOnly,
        validator: validator,
        style: const TextStyle(fontSize: 15,
            fontWeight: FontWeight.w500, color: _labelColor),
        decoration: _inputDecoration(hint: hint).copyWith(
          fillColor: readOnly ? const Color(0xFFF0F7F2) : _inputBg,
        ),
      ),
    );
  }

  // ── Dropdown field ────────────────────────────────────────────────────────
  Widget _buildDropdown({
    required String label,
    required IconData icon,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return _fieldWrapper(
      label: label,
      icon: icon,
      child: DropdownButtonFormField<String>(
        value: value,
        onChanged: onChanged,
        style: const TextStyle(fontSize: 15,
            fontWeight: FontWeight.w500, color: _labelColor),
        icon: const Icon(Icons.arrow_drop_down_rounded,
            color: _primary, size: 26),
        decoration: _inputDecoration(hint: '').copyWith(
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 16, vertical: 14),
        ),
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(16),
        items: items.map((e) => DropdownMenuItem(
          value: e,
          child: Text(e, style: const TextStyle(
              fontSize: 14, color: _labelColor,
              fontWeight: FontWeight.w500)),
        )).toList(),
      ),
    );
  }

  // ── Field wrapper ─────────────────────────────────────────────────────────
  Widget _fieldWrapper({
    required String label,
    required IconData icon,
    required Widget child,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(
            width: 28, height: 28,
            decoration: BoxDecoration(
              color: _primary.withOpacity(0.10),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: _primary, size: 15),
          ),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 13,
              fontWeight: FontWeight.w600, color: _labelColor,
              letterSpacing: 0.2)),
        ]),
        const SizedBox(height: 8),
        child,
      ]),
    );
  }

  // ── Input decoration ──────────────────────────────────────────────────────
  InputDecoration _inputDecoration({required String hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: _hintColor, fontSize: 14,
          fontWeight: FontWeight.w400),
      filled: true,
      fillColor: _inputBg,
      contentPadding: const EdgeInsets.symmetric(
          horizontal: 16, vertical: 15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: _borderColor, width: 1.2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: _borderColor, width: 1.2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: _focusBorder, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE53935), width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE53935), width: 2),
      ),
    );
  }

  // ── Divider ───────────────────────────────────────────────────────────────
  Widget _divider() => Divider(
    color: _primary.withOpacity(0.08), height: 1, thickness: 1,
  );

  // ── Save button ───────────────────────────────────────────────────────────
  Widget _buildSaveButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      decoration: BoxDecoration(
        color: _bgPage,
        boxShadow: [BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 12, offset: const Offset(0, -4),
        )],
      ),
      child: GestureDetector(
        onTapDown: (_) => _saveAnim.reverse(),
        onTapUp: (_) {
          _saveAnim.forward();
          _savePayment();
        },
        onTapCancel: () => _saveAnim.forward(),
        child: ScaleTransition(
          scale: _saveAnim,
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1A7A36), Color(0xFF25A34A)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(
                color: _primary.withOpacity(0.40),
                blurRadius: 16, offset: const Offset(0, 6),
              )],
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.save_rounded, color: Colors.white, size: 22),
                SizedBox(width: 10),
                Text('SAVE', style: TextStyle(color: Colors.white,
                    fontSize: 16, fontWeight: FontWeight.w800,
                    letterSpacing: 1.5)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}