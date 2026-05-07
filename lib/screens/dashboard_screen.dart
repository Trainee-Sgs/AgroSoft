import 'dart:math' as math;
import '../sales_module/sales_home.dart';
import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../purchase_module/purchase_home.dart';
import '../product_module/product_screen.dart';
import '../screens/profile_screen.dart';

// ═══════════════════════════════════════════════════════
// DATA MODELS
// ═══════════════════════════════════════════════════════

class SummaryCardData {
  final String assetIcon;
  final String value;
  final String label;
  final Color  bgColor;
  const SummaryCardData({
    required this.assetIcon,
    required this.value,
    required this.label,
    required this.bgColor,
  });
}

class GridCardData {
  final String title;
  final String value;
  final String assetIcon;
  final String leafAsset;
  final Color  gradientStart;
  final Color  gradientEnd;
  final Color  iconBgColor;
  final Color  waveColor;

  const GridCardData({
    required this.title,
    required this.value,
    required this.assetIcon,
    required this.leafAsset,
    required this.gradientStart,
    required this.gradientEnd,
    required this.iconBgColor,
    required this.waveColor,
  });
}

// ═══════════════════════════════════════════════════════
// ASSET PATHS
// ═══════════════════════════════════════════════════════

const String _iMenu        = 'assets/icons/menu.png';
const String _iBell        = 'assets/icons/notification.png';
const String _iCash        = 'assets/icons/cash_balance.png';
const String _iCustomers   = 'assets/icons/customers.png';
const String _iSuppliers   = 'assets/icons/supplier_balance.png';
const String _iBank        = 'assets/icons/bank_balance.png';
const String _iSales       = 'assets/icons/total_sales.png';
const String _iCashSales   = 'assets/icons/cash_sales.png';
const String _iReceipt     = 'assets/icons/receipt.png';
const String _iCredit      = 'assets/icons/credit_sales.png';
const String _iPayment     = 'assets/icons/payment.png';
const String _iCustBal     = 'assets/icons/customer_balance.png';
const String _iSupBal      = 'assets/icons/supplier_balance.png';
const String _iSalesCnt    = 'assets/icons/sales_count.png';
const String _leafGreen    = 'assets/decorations/leaf_green.png';
const String _leafBlue     = 'assets/decorations/leaf_blue.png';
const String _leafPurple   = 'assets/decorations/leaf_purple.png';
const String _leafYellow   = 'assets/decorations/leaf_yellow.png';
const String _leafOrange   = 'assets/decorations/leaf_orange.png';
const String _leafPink     = 'assets/decorations/leaf_pink.png';

// ── Nav icon paths (shared) ───────────────────────────
const String kNavHome     = 'assets/icons/nav_home.png';
const String kNavSales    = 'assets/icons/nav_dashboard.png';
const String kNavPurchase = 'assets/icons/nav_purchase.png';
const String kNavProduct  = 'assets/icons/nav_product.png';
const String kNavProfile  = 'assets/icons/nav_profile.png';

// ═══════════════════════════════════════════════════════
// NAV ITEM MODEL  (shared across all screens)
// ═══════════════════════════════════════════════════════
class AppNavItem {
  final String   assetIcon;
  final IconData fallback;
  final String   label;
  const AppNavItem({
    required this.assetIcon,
    required this.fallback,
    required this.label,
  });
}

const List<AppNavItem> kNavItems = [
  AppNavItem(assetIcon: kNavHome,     fallback: Icons.home_rounded,         label: 'Home'),
  AppNavItem(assetIcon: kNavSales,    fallback: Icons.dashboard_rounded,    label: 'Sales'),
  AppNavItem(assetIcon: kNavPurchase, fallback: Icons.shopping_bag_rounded, label: 'Purchase'),
  AppNavItem(assetIcon: kNavProduct,  fallback: Icons.inventory_2_rounded,  label: 'Product'),
  AppNavItem(assetIcon: kNavProfile,  fallback: Icons.person_rounded,       label: 'Profile'),
];

// ═══════════════════════════════════════════════════════
// SHARED: tintedAsset helper
// ═══════════════════════════════════════════════════════
Widget buildTintedAsset({
  required String   path,
  required double   size,
  required Color    color,
  required IconData fallback,
}) {
  return ColorFiltered(
    colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    child: Image.asset(
      path,
      width:  size,
      height: size,
      fit:    BoxFit.contain,
      errorBuilder: (_, __, ___) => Icon(fallback, color: color, size: size),
    ),
  );
}

// ═══════════════════════════════════════════════════════
// SHARED: buildAppBottomNav  ← USE THIS IN ALL 5 SCREENS
// selectedIndex: 0=Home, 1=Sales, 2=Purchase, 3=Product, 4=Profile
// ═══════════════════════════════════════════════════════
Widget buildAppBottomNav(BuildContext context, int selectedIndex) {
  const activeColor   = Color(0xFFB0B8C1);
  const inactiveColor = Colors.white;

  void onTap(int i) {
    if (i == selectedIndex) return; // Already here

    Widget dest;
    switch (i) {
      case 0: dest = const DashboardScreen();   break;
      case 1: dest = const SalesHomeScreen();   break;
      case 2: dest = const PurchaseHomeScreen(); break;
      case 3: dest = const ProductScreen();     break;
      case 4: dest = const ProfileScreen();     break;
      default: return;
    }

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => dest,
        transitionDuration:        Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFF2CA36C),
      boxShadow: [
        BoxShadow(
          color:      Colors.black.withOpacity(0.07),
          blurRadius: 14,
          offset:     const Offset(0, -4),
        ),
      ],
    ),
    child: SafeArea(
      top: false,
      child: SizedBox(
        height: 66,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(kNavItems.length, (i) {
            final selected = i == selectedIndex;
            final color    = selected ? activeColor : inactiveColor;

            return GestureDetector(
              onTap:    () => onTap(i),
              behavior: HitTestBehavior.opaque,
              child: SizedBox(
                width: 62,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width:  selected ? 22 : 0,
                      height: selected ? 4  : 0,
                      margin: const EdgeInsets.only(bottom: 3),
                      decoration: BoxDecoration(
                        color:        activeColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    buildTintedAsset(
                      path:     kNavItems[i].assetIcon,
                      size:     24,
                      color:    color,
                      fallback: kNavItems[i].fallback,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      kNavItems[i].label,
                      style: TextStyle(
                        fontSize:   10,
                        fontWeight: selected ? FontWeight.w900 : FontWeight.w700,
                        color:      color,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════════
// DASHBOARD SCREEN
// ═══════════════════════════════════════════════════════
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static const List<SummaryCardData> _summaryCards = [
    SummaryCardData(assetIcon: _iCash,      value: '₹3.57 Cr', label: 'Cash Balance', bgColor: Color(0xFF1B6644)),
    SummaryCardData(assetIcon: _iCustomers, value: '56',        label: 'Customers',    bgColor: Color(0xFF1B6644)),
    SummaryCardData(assetIcon: _iSuppliers, value: '20',        label: 'Suppliers',    bgColor: Color(0xFF1B6644)),
    SummaryCardData(assetIcon: _iBank,      value: '₹1.37 Cr', label: 'Bank Balance', bgColor: Color(0xFF1B6644)),
  ];

  static const List<GridCardData> _gridCards = [
    GridCardData(title: 'Total Sales',        value: '₹1,25,000', assetIcon: _iSales,    leafAsset: _leafGreen,  gradientStart: Color(0xFFCEEDD9), gradientEnd: Color(0xFFEAF7F0), iconBgColor: Color(0xFF2CA36C), waveColor: Color(0xFF9ED4B2)),
    GridCardData(title: 'Total Cash Sales',   value: '₹75,000',    assetIcon: _iCashSales,leafAsset: _leafBlue,   gradientStart: Color(0xFFBDD6F0), gradientEnd: Color(0xFFDEECFA), iconBgColor: Color(0xFF1A5FA8), waveColor: Color(0xFF8BBDE6)),
    GridCardData(title: 'Total Receipt',      value: '₹90,000',   assetIcon: _iReceipt,  leafAsset: _leafPurple, gradientStart: Color(0xFFDDD0F0), gradientEnd: Color(0xFFEEE6F8), iconBgColor: Color(0xFF6A3DAB), waveColor: Color(0xFFBEA8DA)),
    GridCardData(title: 'Total Credit Sales', value: '₹50,000',   assetIcon: _iCredit,   leafAsset: _leafYellow, gradientStart: Color(0xFFEDE5B8), gradientEnd: Color(0xFFF6F1D6), iconBgColor: Color(0xFFB8860B), waveColor: Color(0xFFD8C078)),
    GridCardData(title: 'Total Payment',      value: '45',    assetIcon: _iPayment,  leafAsset: _leafOrange, gradientStart: Color(0xFFF5D8B8), gradientEnd: Color(0xFFFAECD8), iconBgColor: Color(0xFFCC5500), waveColor: Color(0xFFE8B088)),
    GridCardData(title: 'Customer Balance',   value: '₹25,000',  assetIcon: _iCustBal,  leafAsset: _leafPink,   gradientStart: Color(0xFFF5C8D8), gradientEnd: Color(0xFFFAE2EC), iconBgColor: Color(0xFFC2185B), waveColor: Color(0xFFE898B8)),
    GridCardData(title: 'Supplier Balance',   value: '₹18,000',   assetIcon: _iSupBal,   leafAsset: _leafGreen,  gradientStart: Color(0xFFBEE8CA), gradientEnd: Color(0xFFDEF4E6), iconBgColor: Color(0xFF388E3C), waveColor: Color(0xFF90CCA0) ),
    GridCardData(title: 'Total Sales Count',  value: '320', assetIcon: _iSalesCnt, leafAsset: _leafBlue,   gradientStart: Color(0xFFB0E8E4), gradientEnd: Color(0xFFD8F4F2), iconBgColor: Color(0xFF00796B), waveColor: Color(0xFF78CCC8) ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:             _scaffoldKey,
      backgroundColor: const Color(0xFFF4F6F9),
      drawer:          const AppDrawer(),
      // ✅ index=0 for Home/Dashboard
      bottomNavigationBar: buildAppBottomNav(context, 0),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(14, 18, 14, 20),
              child: GridView.builder(
                physics:     const NeverScrollableScrollPhysics(),
                shrinkWrap:  true,
                itemCount:   _gridCards.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:   2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing:  14,
                  childAspectRatio: 0.97,
                ),
                itemBuilder: (_, i) => DashboardCard(data: _gridCards[i]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin:  Alignment.topCenter,
          end:    Alignment.bottomCenter,
          colors: [Color(0xFF38C87E), Color(0xFF1D8A55)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft:  Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 10, 18, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => _scaffoldKey.currentState!.openDrawer(),
                    child: Container(
                      width: 42, height: 40,
                      child: Center(
                        child: buildTintedAsset(
                          path: _iBell, size: 28,
                          color: Colors.white, fallback: Icons.menu_rounded,
                        ),
                      ),
                    ),
                  ),
                  const Expanded(

                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Dashboard',
                          style: TextStyle(color: Colors.white, fontSize: 20,
                              fontWeight: FontWeight.w700, letterSpacing: 0.2),
                        ),
                      ),
                  ),
                  buildTintedAsset(
                    path: _iMenu, size: 26,
                    color: Colors.white, fallback: Icons.notifications_rounded,
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const Text('Welcome Back, Uma 👋',
                style: TextStyle(color: Colors.white, fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 18),
              Row(
                children: _summaryCards.map((card) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: _SummaryCard(data: card),
                  ),
                )).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// SUMMARY CARD
// ═══════════════════════════════════════════════════════
class _SummaryCard extends StatelessWidget {
  final SummaryCardData data;
  const _SummaryCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      decoration: BoxDecoration(
        color: data.bgColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: data.bgColor.withOpacity(0.40),
              blurRadius: 8, offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ColorFiltered(
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            child: Image.asset(data.assetIcon, width: 22, height: 22,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) =>
              const Icon(Icons.attach_money_rounded, color: Colors.white, size: 22),
            ),
          ),
          const SizedBox(height: 5),
          Text(data.value,
            style: const TextStyle(color: Colors.white, fontSize: 11.5,
                fontWeight: FontWeight.w800),
            textAlign: TextAlign.center, maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 3),
          Text(data.label,
            style: TextStyle(color: Colors.white.withOpacity(0.82),
                fontSize: 8.5, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center, maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// DASHBOARD GRID CARD
// ═══════════════════════════════════════════════════════
class DashboardCard extends StatelessWidget {
  final GridCardData data;
  const DashboardCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft, end: Alignment.bottomRight,
          colors: [data.gradientStart, data.gradientEnd],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: data.gradientStart.withOpacity(0.55),
              blurRadius: 12, offset: const Offset(0, 5)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned(
              bottom: 0, left: 0, right: 0,
              child: SizedBox(height: 62,
                child: CustomPaint(painter: WavePainter(color: data.waveColor)),
              ),
            ),
            Positioned(
              bottom: 8, left: 6,
              child: Opacity(
                opacity: 0.50,
                child: Image.asset(data.leafAsset, width: 42, height: 42,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => CustomPaint(
                    size: const Size(42, 42),
                    painter: _FallbackLeafPainter(color: data.waveColor),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 14, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(data.title,
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900,
                              color: Colors.grey.shade700, height: 1.45),
                          maxLines: 2,
                        ),
                      ),
                      const SizedBox(width: 1),
                      Container(
                        width: 45, height: 60,
                        decoration: BoxDecoration(
                          color: data.iconBgColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: data.iconBgColor.withOpacity(0.45),
                                blurRadius: 8, offset: const Offset(0, 3)),
                          ],
                        ),
                        child: Center(
                          child: ColorFiltered(
                            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                            child: Image.asset(data.assetIcon, width: 20, height: 20,
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) =>
                              const Icon(Icons.bar_chart_rounded, color: Colors.white, size: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 0.001),
                  Text(data.value,
                    style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800,
                        color: Color(0xFF1A1A1A), letterSpacing: -0.3),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// WAVE PAINTER
// ═══════════════════════════════════════════════════════
class WavePainter extends CustomPainter {
  final Color color;
  const WavePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paintA = Paint()..color = color.withOpacity(0.28)..style = PaintingStyle.fill;
    final pathA = Path()
      ..moveTo(0, size.height * 0.50)
      ..cubicTo(size.width * 0.25, size.height * 0.22, size.width * 0.75, size.height * 0.60, size.width, size.height * 0.35)
      ..lineTo(size.width, size.height)..lineTo(0, size.height)..close();
    canvas.drawPath(pathA, paintA);

    final paintB = Paint()..color = color.withOpacity(0.55)..style = PaintingStyle.fill;
    final pathB = Path()
      ..moveTo(0, size.height * 0.70)
      ..cubicTo(size.width * 0.28, size.height * 0.42, size.width * 0.72, size.height * 0.42, size.width, size.height * 0.68)
      ..lineTo(size.width, size.height)..lineTo(0, size.height)..close();
    canvas.drawPath(pathB, paintB);

    final paintC = Paint()..color = Colors.white.withOpacity(0.30)..style = PaintingStyle.fill;
    final pathC = Path()
      ..moveTo(0, size.height * 0.82)
      ..cubicTo(size.width * 0.30, size.height * 0.58, size.width * 0.70, size.height * 0.58, size.width, size.height * 0.78)
      ..lineTo(size.width, size.height)..lineTo(0, size.height)..close();
    canvas.drawPath(pathC, paintC);
  }

  @override
  bool shouldRepaint(WavePainter old) => old.color != color;
}

// ═══════════════════════════════════════════════════════
// FALLBACK LEAF PAINTER
// ═══════════════════════════════════════════════════════
class _FallbackLeafPainter extends CustomPainter {
  final Color color;
  const _FallbackLeafPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()..color = color.withOpacity(0.65)..style = PaintingStyle.fill;
    final p1 = Path()
      ..moveTo(size.width * 0.30, size.height * 0.95)
      ..cubicTo(0, size.height * 0.58, size.width * 0.06, size.height * 0.14, size.width * 0.52, size.height * 0.04)
      ..cubicTo(size.width * 0.68, size.height * 0.36, size.width * 0.56, size.height * 0.70, size.width * 0.30, size.height * 0.95);
    canvas.drawPath(p1, paint1);

    final paint2 = Paint()..color = color.withOpacity(0.38)..style = PaintingStyle.fill;
    canvas.save();
    canvas.translate(size.width * 0.52, size.height * 0.52);
    canvas.rotate(-0.65);
    final p2 = Path()
      ..moveTo(0, size.height * 0.38)
      ..cubicTo(-size.width * 0.24, size.height * 0.10, -size.width * 0.09, -size.height * 0.22, size.width * 0.18, -size.height * 0.27)
      ..cubicTo(size.width * 0.32, 0, size.width * 0.22, size.height * 0.24, 0, size.height * 0.38);
    canvas.drawPath(p2, paint2);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_FallbackLeafPainter old) => old.color != color;
}