import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

import '../sales_module/sales_order_screen.dart';
import '../sales_module/sales_delivery_screen.dart';
import '../sales_module/sales_invoice_screen.dart';

import '../reports_module/customer_balance_screen.dart';
import '../reports_module/customer_statement_screen.dart';
import '../reports_module/product_wise_sales_screen.dart';

// Purchase screens
import '../purchase_module/purchase_order_screen.dart';
// import '../purchase_module/purchase_order_list_screen.dart';
import '../purchase_module/grn_screen.dart';
import '../purchase_module/purchase_invoice_screen.dart';
//
// // Master screens
import '../master_module/ledger_screen.dart';
import '../master_module/product_screen.dart';
import '../master_module/batch_lots_screen.dart';

// Transaction screens
import '../transaction_module/receipt_screen.dart';
import '../transaction_module/payment_screen.dart';
// import '../transaction_module/credit_screen.dart';
// import '../transaction_module/debit_screen.dart';


class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool _salesExpanded    = false;
  bool _purchaseExpanded = false;
  bool _reportsExpanded  = false;
  bool _masterExpanded = false;
  bool _transactionExpanded = false;

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
                  width: 68,
                  height: 68,
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
                    child: Icon(
                      Icons.eco_rounded,
                      color: AppTheme.primaryGreen,
                      size: 38,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'AGROSOFT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.4,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppTheme.accentLime,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'uma',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
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
                _buildExpandableItem(
                  icon: Icons.inventory_2_rounded,
                  title: 'Master',
                  isExpanded: _masterExpanded,
                  onTap: () => setState(() => _masterExpanded = !_masterExpanded),
                ),

                if (_masterExpanded) ...[
                  _buildSubItem('Ledger'),
                  _buildSubItem('Product'),
                  _buildSubItem('Batch & Lots'),

                ],
                const _DrawerDivider(),
                _buildExpandableItem(
                  icon: Icons.point_of_sale_rounded,
                  title: 'Sales',
                  isExpanded: _salesExpanded,
                  onTap: () =>
                      setState(() => _salesExpanded = !_salesExpanded),
                ),
                if (_salesExpanded) ...[
                  _buildSubItem('Sales Order'),
                  _buildSubItem('Order List'),
                  _buildSubItem('Direct Delivery'),
                  _buildSubItem('Sales Invoice'),
                ],
                const _DrawerDivider(),
                _buildExpandableItem(
                  icon: Icons.shopping_cart_rounded,
                  title: 'Purchase',
                  isExpanded: _purchaseExpanded,
                  onTap: () =>
                      setState(() => _purchaseExpanded = !_purchaseExpanded),
                ),
                if (_purchaseExpanded) ...[
                  _buildSubItem('Purchase Order'),
                  _buildSubItem('Purchase Order List'),  // ← key name updated
                  _buildSubItem('GRN'),
                  _buildSubItem('Purchase Invoice'),
                ],
                const _DrawerDivider(),
                _buildExpandableItem(
                  icon: Icons.account_balance_wallet_rounded,
                  title: 'Transaction',
                  isExpanded: _transactionExpanded,
                  onTap: () =>
                      setState(() => _transactionExpanded = !_transactionExpanded),
                ),

                if (_transactionExpanded) ...[
                  _buildSubItem('Receipt'),
                  _buildSubItem('Payment'),
                  _buildSubItem('Credit'),
                  _buildSubItem('Debit'),
                ],
                const _DrawerDivider(),
                _buildExpandableItem(
                  icon: Icons.bar_chart_rounded,
                  title: 'Reports',
                  isExpanded: _reportsExpanded,
                  onTap: () =>
                      setState(() => _reportsExpanded = !_reportsExpanded),
                ),
                if (_reportsExpanded) ...[
                  _buildSubItem('Customer Balance'),
                  _buildSubItem('Customer Statement'),
                  _buildSubItem('Product Wise Sales'),
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
              icon: const Icon(Icons.logout_rounded, color: Colors.white, size: 18),
              label: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.deepGreen,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 4,
                shadowColor: AppTheme.deepGreen.withOpacity(0.4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: AppTheme.primaryGreen.withOpacity(0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppTheme.primaryGreen, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
          color: AppTheme.textDark,
        ),
      ),
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
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: isExpanded
              ? AppTheme.primaryGreen.withOpacity(0.18)
              : AppTheme.primaryGreen.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: isExpanded ? AppTheme.deepGreen : AppTheme.primaryGreen,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isExpanded ? FontWeight.w700 : FontWeight.w600,
          fontSize: 15,
          color: isExpanded ? AppTheme.deepGreen : AppTheme.textDark,
        ),
      ),
      trailing: AnimatedRotation(
        turns: isExpanded ? 0.5 : 0,
        duration: const Duration(milliseconds: 220),
        child: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: isExpanded ? AppTheme.primaryGreen : Colors.grey.shade400,
        ),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
    );
  }

  Widget _buildSubItem(String title) {
    final Map<String, Widget> _routes = {
      // // MASTER
      'Ledger': const LedgerMasterScreen(),
      'Product': const ProductMasterScreen(),
      'Batch & Lots': const BatchLotsScreen(),


      // Sales
      'Sales Order': const SalesOrderScreen(),
      // 'Order List': const OrderListScreen();
      'Direct Delivery' : const SalesDeliveryScreen(),
      'Sales Invoice' : const SalesInvoiceScreen(),

      //purchase
      'Purchase Order':      const PurchaseOrderScreen(),
      // 'Purchase Order List': const PurchaseOrderListScreen(),
      'GRN':                 const GRNScreen(),
      'Purchase Invoice':    const PurchaseInvoiceScreen(),

      // TRANSACTION
      'Receipt': const ReceiptScreen(),
      'Payment': const PaymentScreen(),
      // 'Credit': const CreditScreen(),
      // 'Debit': const DebitScreen(),

      //Reports
      'Customer Balance' : const CustomerBalancePage (),
      'Customer Statement' : const CustomerStatementPage(),
      'Product Wise Sales' : const ProductWiseSalesPage(),


    };

    return Padding(
      padding: const EdgeInsets.only(left: 74, right: 20),
      child: InkWell(
        onTap: () {
          final screen = _routes[title];
          if (screen != null) {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => screen),
            );
          }
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 11),
          child: Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: AppTheme.accentLime,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
                width: 76,
                height: 76,
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
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Icon(Icons.person_rounded, color: Colors.white, size: 40),
              ),
              const SizedBox(height: 20),
              const Text(
                'Are you sure want to logout?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 24),
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  side: const BorderSide(color: AppTheme.primaryGreen, width: 1.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                child: const Text(
                  'YES',
                  style: TextStyle(
                    color: AppTheme.primaryGreen,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryGreen,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  shadowColor: AppTheme.primaryGreen.withOpacity(0.4),
                  elevation: 4,
                ),
                child: const Text(
                  'NO',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
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
      indent: 20,
      endIndent: 20,
      color: AppTheme.primaryGreen.withOpacity(0.1),
      height: 1,
    );
  }
}