import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

import '../sales_module/sales_order_screen.dart';
import '../sales_module/sales_delivery_screen.dart';
import '../sales_module/sales_invoice_screen.dart';
import '../sales_module/sales_quotation_screen.dart';
import '../sales_module/sales_return_invoice_screen.dart';

import '../reports_module/customer_balance_screen.dart';
import '../reports_module/customer_statement_screen.dart';
import '../reports_module/product_wise_sales_screen.dart';

import '../purchase_module/purchase_order_screen.dart';
import '../purchase_module/grn_screen.dart';
import '../purchase_module/purchase_invoice_screen.dart';
import '../purchase_module/purchase_return_invoice_screen.dart';

import '../master_module/ledger_screen.dart';
import '../master_module/product_screen.dart';
import '../master_module/batch_lots_screen.dart';

import '../transaction_module/receipt_screen.dart';
import '../transaction_module/payment_screen.dart';
import '../transaction_module/credit_screen.dart';
import '../transaction_module/debit_screen.dart';

import '../price_list_module/sales_price_screen.dart';
import '../price_list_module/purchase_price_screen.dart';

import '../screens/login_screen.dart';

import '../cash_banking_module/fund_transfer_screen.dart';
import '../cash_banking_module/balance_screen.dart';


class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool _salesExpanded       = false;
  bool _purchaseExpanded    = false;
  bool _reportsExpanded     = false;
  bool _masterExpanded      = false;
  bool _transactionExpanded = false;
  bool _cashBankingExpanded = false;
  bool _settingsExpanded    = false; // ← NEW

  // ── Settings state ────────────────────────────────────────────────────────
  bool _isDarkMode         = false;
  String _selectedLanguage = 'English';

  final List<String> _languages = ['English', 'Tamil', 'Hindi', 'Malayalam'];

  void _toggleDropdown(String dropdownName) {
    setState(() {
      if (dropdownName == 'master') {
        _masterExpanded = !_masterExpanded;
        if (_masterExpanded) {
          _salesExpanded = _purchaseExpanded = _transactionExpanded =
              _reportsExpanded = _cashBankingExpanded = _settingsExpanded = false;
        }
      } else if (dropdownName == 'sales') {
        _salesExpanded = !_salesExpanded;
        if (_salesExpanded) {
          _masterExpanded = _purchaseExpanded = _transactionExpanded =
              _reportsExpanded = _cashBankingExpanded = _settingsExpanded = false;
        }
      } else if (dropdownName == 'purchase') {
        _purchaseExpanded = !_purchaseExpanded;
        if (_purchaseExpanded) {
          _masterExpanded = _salesExpanded = _transactionExpanded =
              _reportsExpanded = _cashBankingExpanded = _settingsExpanded = false;
        }
      } else if (dropdownName == 'transaction') {
        _transactionExpanded = !_transactionExpanded;
        if (_transactionExpanded) {
          _masterExpanded = _salesExpanded = _purchaseExpanded =
              _reportsExpanded = _cashBankingExpanded = _settingsExpanded = false;
        }
      } else if (dropdownName == 'cashbanking') {
        _cashBankingExpanded = !_cashBankingExpanded;
        if (_cashBankingExpanded) {
          _masterExpanded = _salesExpanded = _purchaseExpanded =
              _reportsExpanded = _transactionExpanded = _settingsExpanded = false;
        }
      } else if (dropdownName == 'reports') {
        _reportsExpanded = !_reportsExpanded;
        if (_reportsExpanded) {
          _masterExpanded = _salesExpanded = _purchaseExpanded =
              _transactionExpanded = _cashBankingExpanded = _settingsExpanded = false;
        }
      } else if (dropdownName == 'settings') { // ← NEW
        _settingsExpanded = !_settingsExpanded;
        if (_settingsExpanded) {
          _masterExpanded = _salesExpanded = _purchaseExpanded =
              _transactionExpanded = _cashBankingExpanded = _reportsExpanded = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // ── Header ─────────────────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 52, 20, 28),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.appBarGradStart, AppTheme.appBarGradEnd],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 68, height: 68,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.18),
                        blurRadius: 14,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(Icons.eco_rounded,
                        color: AppTheme.primaryGreen, size: 38),
                  ),
                ),
                const SizedBox(height: 14),
                const Text('AGROSOFT',
                    style: TextStyle(
                        color: Colors.white, fontSize: 20,
                        fontWeight: FontWeight.w800, letterSpacing: 1.4)),
                const SizedBox(height: 4),
                Row(children: [
                  Container(
                    width: 8, height: 8,
                    decoration: const BoxDecoration(
                        color: AppTheme.accentLime, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 6),
                  const Text('uma',
                      style: TextStyle(
                          color: Colors.white70, fontSize: 13,
                          fontWeight: FontWeight.w400)),
                ]),
              ],
            ),
          ),

          // ── Menu Items ─────────────────────────────────────────────────
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _buildNavItem(
                  icon: Icons.dashboard_rounded,
                  title: 'Dashboard',
                  onTap: () => Navigator.pop(context),
                ),
                const _DrawerDivider(),

                // Master
                _buildExpandableItem(
                  icon: Icons.inventory_2_rounded, title: 'Master',
                  isExpanded: _masterExpanded,
                  onTap: () => _toggleDropdown('master'),
                ),
                if (_masterExpanded) ...[
                  _buildSubItem('Ledger', Icons.book_rounded),
                  _buildSubItem('Product', Icons.shopping_bag_rounded),
                  _buildSubItem('Batch & Lots', Icons.layers_rounded),
                  _buildSubItem('Sales Price', Icons.trending_up_rounded),
                  _buildSubItem('Purchase Price', Icons.trending_down_rounded),
                ],
                const _DrawerDivider(),

                // Sales
                _buildExpandableItem(
                  icon: Icons.point_of_sale_rounded, title: 'Sales',
                  isExpanded: _salesExpanded,
                  onTap: () => _toggleDropdown('sales'),
                ),
                if (_salesExpanded) ...[
                  _buildSubItem('Sales Quotation', Icons.request_quote_rounded),
                  _buildSubItem('Sales Order', Icons.receipt_rounded),
                  _buildSubItem('Direct Delivery', Icons.local_shipping_rounded),
                  _buildSubItem('Sales Invoice', Icons.article_rounded),
                  _buildSubItem('Sales Return Invoice', Icons.article_rounded),
                ],
                const _DrawerDivider(),

                // Purchase
                _buildExpandableItem(
                  icon: Icons.shopping_cart_rounded, title: 'Purchase',
                  isExpanded: _purchaseExpanded,
                  onTap: () => _toggleDropdown('purchase'),
                ),
                if (_purchaseExpanded) ...[
                  _buildSubItem('Purchase Order', Icons.shopping_cart_checkout_rounded),
                  _buildSubItem('GRN', Icons.assignment_turned_in_rounded),
                  _buildSubItem('Purchase Invoice', Icons.assignment_rounded),
                  _buildSubItem('Return Invoice', Icons.assignment_rounded),
                ],
                const _DrawerDivider(),

                // Transaction
                _buildExpandableItem(
                  icon: Icons.account_balance_wallet_rounded, title: 'Transaction',
                  isExpanded: _transactionExpanded,
                  onTap: () => _toggleDropdown('transaction'),
                ),
                if (_transactionExpanded) ...[
                  _buildSubItem('Receipt', Icons.receipt_long_rounded),
                  _buildSubItem('Payment', Icons.payment_rounded),
                  _buildSubItem('Credit & note', Icons.add_circle_rounded),
                  _buildSubItem('Debit & note', Icons.remove_circle_rounded),
                ],
                const _DrawerDivider(),

                // Cash & Banking
                _buildExpandableItem(
                  icon: Icons.account_balance_wallet_rounded,
                  title: 'Cash & Banking',
                  isExpanded: _cashBankingExpanded,
                  onTap: () => _toggleDropdown('cashbanking'),
                ),
                if (_cashBankingExpanded) ...[
                  _buildSubItem('Fund Transfer', Icons.receipt_long_rounded),
                  _buildSubItem('Balance', Icons.payment_rounded),
                  _buildSubItem('Cheque Issue', Icons.add_circle_rounded),
                  _buildSubItem('Cheque Received', Icons.remove_circle_rounded),
                ],
                const _DrawerDivider(),

                // Reports
                _buildExpandableItem(
                  icon: Icons.bar_chart_rounded, title: 'Reports',
                  isExpanded: _reportsExpanded,
                  onTap: () => _toggleDropdown('reports'),
                ),
                if (_reportsExpanded) ...[
                  _buildSubItem('Customer Balance', Icons.account_balance_rounded),
                  _buildSubItem('Customer Statement', Icons.description_rounded),
                  _buildSubItem('Product Wise Sales', Icons.show_chart_rounded),
                ],
                const _DrawerDivider(),

                // ── Settings (now a dropdown) ───────────────────────────
                _buildExpandableItem(
                  icon: Icons.settings_rounded,
                  title: 'Settings',
                  isExpanded: _settingsExpanded,
                  onTap: () => _toggleDropdown('settings'),
                ),
                if (_settingsExpanded) ...[
                  _buildSettingsDarkModeSubItem(),
                  _buildSettingsLanguageSubItem(),
                  _buildSettingsHelpSubItem(),
                ],
                const _DrawerDivider(),
              ],
            ),
          ),

          // ── Logout Button ───────────────────────────────────────────────
          Container(
            margin: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            child: ElevatedButton.icon(
              onPressed: () => _showLogoutDialog(context),
              icon: const Icon(Icons.logout_rounded,
                  color: Colors.white, size: 18),
              label: const Text('Logout',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700, fontSize: 15)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.deepGreen,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                elevation: 4,
                shadowColor: AppTheme.deepGreen.withOpacity(0.4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Settings Sub-Items (inside dropdown) ──────────────────────────────────

  Widget _buildSettingsDarkModeSubItem() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 54, right: 4),
        leading: Icon(
          _isDarkMode ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
          color: AppTheme.primaryGreen,
          size: 16,
        ),
        title: Text(
          _isDarkMode ? 'Dark Mode' : 'Light Mode',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppTheme.textMuted,
          ),
        ),
        trailing: Transform.scale(
          scale: 0.78,
          child: Switch.adaptive(
            value: _isDarkMode,
            activeColor: AppTheme.primaryGreen,
            onChanged: (val) => setState(() => _isDarkMode = val),
          ),
        ),
        visualDensity: const VisualDensity(vertical: -2),
      ),
    );
  }

  Widget _buildSettingsLanguageSubItem() {
    return Padding(
      padding: const EdgeInsets.only(left: 74, right: 20),
      child: InkWell(
        onTap: () => _showLanguagePicker(),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 11),
          child: Row(children: [
            const Icon(Icons.language_rounded,
                color: AppTheme.primaryGreen, size: 16),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Language',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textMuted,
                ),
              ),
            ),
            Text(
              _selectedLanguage,
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.textDark.withOpacity(0.45),
              ),
            ),
            const SizedBox(width: 4),
            Icon(Icons.keyboard_arrow_right_rounded,
                color: Colors.grey.shade400, size: 16),
          ]),
        ),
      ),
    );
  }

  Widget _buildSettingsHelpSubItem() {
    return Padding(
      padding: const EdgeInsets.only(left: 74, right: 20),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          _showHelpSupportSheet(context);
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 11),
          child: Row(children: [
            const Icon(Icons.help_outline_rounded,
                color: AppTheme.primaryGreen, size: 16),
            const SizedBox(width: 12),
            const Text(
              'Help & Support',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppTheme.textMuted,
              ),
            ),
          ]),
        ),
      ),
    );
  }

  // ── Language Picker ────────────────────────────────────────────────────────

  void _showLanguagePicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40, height: 4,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2)),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Select Language',
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w700,
                    color: AppTheme.textDark)),
            const SizedBox(height: 12),
            ..._languages.map((lang) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.translate_rounded,
                color: _selectedLanguage == lang
                    ? AppTheme.primaryGreen
                    : Colors.grey.shade400,
                size: 20,
              ),
              title: Text(lang,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: _selectedLanguage == lang
                          ? FontWeight.w700
                          : FontWeight.w500,
                      color: _selectedLanguage == lang
                          ? AppTheme.primaryGreen
                          : AppTheme.textDark)),
              trailing: _selectedLanguage == lang
                  ? const Icon(Icons.check_circle_rounded,
                  color: AppTheme.primaryGreen, size: 20)
                  : null,
              onTap: () {
                setState(() => _selectedLanguage = lang);
                Navigator.pop(context);
              },
            )),
          ],
        ),
      ),
    );
  }

  // ── Help & Support Sheet ───────────────────────────────────────────────────

  void _showHelpSupportSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40, height: 4,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2)),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Help & Support',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w700,
                    color: AppTheme.textDark)),
            const SizedBox(height: 16),
            _helpTile(Icons.chat_bubble_outline_rounded,
                'Chat with Us', 'Get instant help from our team'),
            _helpTile(Icons.email_outlined,
                'Email Support', 'support@agrosoft.com'),
            _helpTile(Icons.phone_outlined,
                'Call Us', '+91 98765 43210'),
            _helpTile(Icons.menu_book_rounded,
                'User Guide', 'Browse FAQs and tutorials'),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen.withOpacity(0.07),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: AppTheme.primaryGreen.withOpacity(0.2)),
              ),
              child: Row(children: [
                const Icon(Icons.info_outline_rounded,
                    color: AppTheme.primaryGreen, size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Text('Version 1.0.0 • © 2024 Agrosoft',
                      style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.textDark.withOpacity(0.6))),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _helpTile(IconData icon, String title, String subtitle) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      leading: Container(
        width: 42, height: 42,
        decoration: BoxDecoration(
          color: AppTheme.primaryGreen.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: AppTheme.primaryGreen, size: 20),
      ),
      title: Text(title,
          style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14, color: AppTheme.textDark)),
      subtitle: Text(subtitle,
          style: TextStyle(
              fontSize: 12, color: AppTheme.textDark.withOpacity(0.5))),
      trailing: Icon(Icons.arrow_forward_ios_rounded,
          size: 14, color: Colors.grey.shade400),
      onTap: () {},
    );
  }

  // ── Nav / Expandable / Sub Widgets ─────────────────────────────────────────

  Widget _buildNavItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        width: 38, height: 38,
        decoration: BoxDecoration(
          color: AppTheme.primaryGreen.withOpacity(0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppTheme.primaryGreen, size: 20),
      ),
      title: Text(title,
          style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15, color: AppTheme.textDark)),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
    );
  }

  Widget _buildExpandableItem({
    required IconData icon,
    required String title,
    required bool isExpanded,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        width: 38, height: 38,
        decoration: BoxDecoration(
          color: isExpanded
              ? AppTheme.primaryGreen.withOpacity(0.18)
              : AppTheme.primaryGreen.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon,
            color: isExpanded ? AppTheme.deepGreen : AppTheme.primaryGreen,
            size: 20),
      ),
      title: Text(title,
          style: TextStyle(
              fontWeight: isExpanded ? FontWeight.w700 : FontWeight.w600,
              fontSize: 15,
              color: isExpanded ? AppTheme.deepGreen : AppTheme.textDark)),
      trailing: AnimatedRotation(
        turns: isExpanded ? 0.5 : 0,
        duration: const Duration(milliseconds: 220),
        child: Icon(Icons.keyboard_arrow_down_rounded,
            color: isExpanded
                ? AppTheme.primaryGreen
                : Colors.grey.shade400),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
    );
  }

  Widget _buildSubItem(String title, IconData icon) {
    final Map<String, Widget> routes = {
      'Ledger'              : const LedgerMasterScreen(),
      'Product'             : const ProductScreen(),
      'Batch & Lots'        : const BatchLotsScreen(),
      'Sales Price'         : const SalesPriceScreen(),
      'Purchase Price'      : const PurchasePriceScreen(),
      'Sales Quotation'     : const SalesQuotationScreen(),
      'Sales Order'         : const SalesOrderScreen(),
      'Direct Delivery'     : const SalesDeliveryScreen(),
      'Sales Invoice'       : const SalesInvoiceScreen(),
      'Sales Return Invoice': const SalesReturnInvoiceScreen(),
      'Purchase Order'      : const PurchaseOrderScreen(),
      'GRN'                 : const GRNScreen(),
      'Purchase Invoice'    : const PurchaseInvoiceScreen(),
      'Return Invoice'      : const PurchaseReturnInvoiceScreen(),
      'Receipt'             : const ReceiptScreen(),
      'Payment'             : const PaymentScreen(),
      'Credit'              : const CreditScreen(),
      'Debit'               : const DebitScreen(),
      'Fund Transfer'       : const FundTransferScreen(),
      'Balance'             : const CashBankBalanceScreen(),
      'Cheque Issue'        : const Scaffold(body: Center(child: Text('Cheque Issue'))),
      'Cheque Received'     : const Scaffold(body: Center(child: Text('Cheque Received'))),
      'Customer Balance'    : const CustomerBalancePage(),
      'Customer Statement'  : const CustomerStatementPage(),
      'Product Wise Sales'  : const ProductWiseSalesPage(),
    };

    return Padding(
      padding: const EdgeInsets.only(left: 74, right: 20),
      child: InkWell(
        onTap: () {
          final screen = routes[title];
          if (screen != null) {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => screen));
          }
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 11),
          child: Row(children: [
            Icon(icon, color: AppTheme.primaryGreen, size: 16),
            const SizedBox(width: 12),
            Text(title,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textMuted)),
          ]),
        ),
      ),
    );
  }

  // ── Logout Dialog ──────────────────────────────────────────────────────────

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 76, height: 76,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppTheme.appBarGradStart, AppTheme.appBarGradEnd],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: AppTheme.primaryGreen.withOpacity(0.35),
                        blurRadius: 20, offset: const Offset(0, 6)),
                  ],
                ),
                child: const Icon(Icons.person_rounded,
                    color: Colors.white, size: 40),
              ),
              const SizedBox(height: 20),
              const Text('Are you sure want to logout?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,
                      color: AppTheme.textDark)),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                        (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryGreen,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  shadowColor: AppTheme.primaryGreen.withOpacity(0.4),
                  elevation: 4,
                ),
                child: const Text('YES',
                    style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.w700, fontSize: 15)),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  side: const BorderSide(color: AppTheme.primaryGreen, width: 1.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                child: const Text('NO',
                    style: TextStyle(color: AppTheme.primaryGreen,
                        fontWeight: FontWeight.w700, fontSize: 15)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerDivider extends StatelessWidget {
  const _DrawerDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      indent: 20, endIndent: 20,
      color: AppTheme.primaryGreen.withOpacity(0.1),
      height: 1,
    );
  }
}