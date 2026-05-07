import 'package:flutter/material.dart';
import '../product_module/product_screen.dart';
import '../screens/dashboard_screen.dart';


// ═══════════════════════════════════════════════════════
// PROFILE SCREEN
// ═══════════════════════════════════════════════════════

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // ── Controllers ───────────────────────────────────────
  final _nameController        = TextEditingController(text: 'Demo Software');
  final _shortNameController   = TextEditingController(text: 'Demo Software');
  final _addressController     = TextEditingController(text: 'Varatharajapuram,irugur,coimbator');
  final _phoneController       = TextEditingController(text: '9894889810');
  final _whatsupController     = TextEditingController(text: '9894889810');
  final _smsKeyController      = TextEditingController(text: '8510C01D51F26');
  final _whatsupKeyController  = TextEditingController(text: '');

  final _emailController       = TextEditingController(text: 'demo@demo.com');
  final _plNoController        = TextEditingController(text: 'CBE/PL/0001');
  final _gstinController       = TextEditingController(text: '');
  final _bankNameController    = TextEditingController(text: 'HDFC  Bank');
  final _bankBranchController  = TextEditingController(text: 'Varatharajapuram');
  final _accountNoController   = TextEditingController(text: '0012345698');
  final _ifscController        = TextEditingController(text: '');
  final _slNoController        = TextEditingController(text: 'CBE/SL/0003');
  final _flNoController        = TextEditingController(text: 'FL 2025- 2030');

  @override
  void dispose() {
    _nameController.dispose();
    _shortNameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _whatsupController.dispose();
    _smsKeyController.dispose();
    _whatsupKeyController.dispose();
    _emailController.dispose();
    _plNoController.dispose();
    _gstinController.dispose();
    _bankNameController.dispose();
    _bankBranchController.dispose();
    _accountNoController.dispose();
    _ifscController.dispose();
    _slNoController.dispose();
    _flNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      bottomNavigationBar: buildAppBottomNav(context, 4),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 15, 12, 20),
              child: Column(
                children: [
                  _buildSection(
                    title: 'Basic Details',
                    icon: Icons.person_outline_rounded,
                    rows: [
                      _RowData('Short Name', _shortNameController),
                      _RowData('Phone',      _phoneController),
                      _RowData('Whatsup',    _whatsupController),
                      _RowData('Email',      _emailController),
                      _RowData('sms key',    _smsKeyController),
                      _RowData('Whatsup key',_whatsupKeyController),
                    ],
                  ),

                  const SizedBox(height: 16),

                  _buildSection(
                    title: 'Address Details',
                    icon: Icons.location_on_outlined,
                    rows: [
                      _RowData('Address', _addressController, maxLines: 3),
                    ],
                  ),

                  const SizedBox(height: 16),

                  _buildSection(
                    title: 'Tax & License Details',
                    icon: Icons.receipt_long_outlined,
                    rows: [
                      _RowData('GSTIN',  _gstinController),
                      _RowData('PL NO',  _plNoController),
                      _RowData('SL NO',  _slNoController),
                      _RowData('FL NO',  _flNoController),
                    ],
                  ),

                  const SizedBox(height: 16),

                  _buildSection(
                    title: 'Bank Details',
                    icon: Icons.account_balance_outlined,
                    rows: [
                      _RowData('Bank Name',   _bankNameController),
                      _RowData('Bank Branch', _bankBranchController),
                      _RowData('Account No',  _accountNoController),
                      _RowData('IFSC',        _ifscController),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────────────────────────────────────────
  // HEADER
  // ───────────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF38C87E), Color(0xFF1D8A55)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(36),
          bottomRight: Radius.circular(36),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 10, 18, 30),
          child: Column(
            children: [
              // ── Top bar ──
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const ProductScreen()),
                          (route) => false,
                    ),
                    child: Container(
                      width: 40,
                      height: 35,
                      child: const Icon(Icons.arrow_back_ios_new_rounded,
                          color: Colors.white, size: 20),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Profile',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 210),
                ],
              ),

              const SizedBox(height: 20),

              // ── Avatar ──
              Container(
                width: 70,
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Icon(Icons.store_rounded,
                    color: Colors.white, size: 42),
              ),

              const SizedBox(height: 12),

              // ── Name ──
              Text(
                _nameController.text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.1,
                ),
              ),

              const SizedBox(height: 5),

              // ── Address ──
              Text(
                _addressController.text,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ───────────────────────────────────────────────────
  // SECTION CARD
  // ───────────────────────────────────────────────────
  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<_RowData> rows,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF2CA36C).withOpacity(0.08),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2CA36C),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Icon(icon, color: Colors.white, size: 17),
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1D8A55),
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),

          ...List.generate(rows.length, (i) {
            final isLast = i == rows.length - 1;
            return Column(
              children: [
                _buildRow(rows[i]),
                if (!isLast)
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey.shade100,
                    indent: 16,
                    endIndent: 16,
                  ),
              ],
            );
          }),

          const SizedBox(height: 6),
        ],
      ),
    );
  }

  // ───────────────────────────────────────────────────
  // SINGLE ROW  —  Label : Value
  // ───────────────────────────────────────────────────
  Widget _buildRow(_RowData row) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              row.label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          Text(
            ' : ',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Colors.grey.shade400,
            ),
          ),
          Expanded(
            child: Text(
              row.controller.text.isEmpty ? '—' : row.controller.text,
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                color: row.controller.text.isEmpty
                    ? Colors.grey.shade400
                    : const Color(0xFF1A1A1A),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// ROW DATA MODEL
// ═══════════════════════════════════════════════════════
class _RowData {
  final String label;
  final TextEditingController controller;
  final int maxLines;

  const _RowData(
      this.label,
      this.controller, {
        this.maxLines = 1,
      });
}