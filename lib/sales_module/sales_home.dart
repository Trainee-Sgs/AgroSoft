import 'dart:async';
import 'package:flutter/material.dart';

import '../sales_module/sales_order_screen.dart';
import '../sales_module/sales_delivery_screen.dart';
import '../sales_module/sales_invoice_screen.dart';

// ═══════════════════════════════════════════
//  COLORS
// ═══════════════════════════════════════════
class AC {
  static const green      = Color(0xFF2DAF82);
  static const greenDark  = Color(0xFF1C8F6A);
  static const greenLight = Color(0xFFE8F8F2);
  static const bgGrey     = Color(0xFFF5F5F5);
  static const textDark   = Color(0xFF1A1A1A);
  static const textGrey   = Color(0xFF888888);
}

// ═══════════════════════════════════════════
//  ASSET ICON PATHS
// ═══════════════════════════════════════════
const String _isSales        = 'assets/icons/sales.png';
const String _iSalesOrder    = 'assets/icons/sales_order.png';
const String _iOrderList     = 'assets/icons/order_list.png';
const String _iSalesDelivery = 'assets/icons/sales_delivery.png';
const String _iSalesInvoice  = 'assets/icons/sales_invoice.png';

// ═══════════════════════════════════════════
//  HOME SCREEN
// ═══════════════════════════════════════════
class SalesHomeScreen extends StatelessWidget {
  const SalesHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final w  = mq.size.width;
    final h  = mq.size.height;

    return Scaffold(
      backgroundColor: AC.bgGrey,
      appBar: _buildAppBar(context, w),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: h * 0.018),

            // ── Banner Carousel — full width, no side padding ──
            const _BannerCarousel(),

            SizedBox(height: h * 0.024),

            // ── Sales Section ────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              child: _SectionCard(
                w: w, h: h,
                assetIcon: _isSales,
                title:     'Sales',
                subtitle:  'Manage orders, delivery & invoices',
                items: [
                  _MenuItem(
                    assetIcon:   _iSalesOrder,
                    label:       'Sales Order',
                    badge:       'New',
                    destination: const SalesOrderScreen(),
                  ),
                  _MenuItem(
                    assetIcon:   _iOrderList,
                    label:       'Order List',
                    destination: null,
                  ),
                  _MenuItem(
                    assetIcon:   _iSalesDelivery,
                    label:       'Direct Delivery',
                    destination: const SalesDeliveryScreen(),
                  ),
                  _MenuItem(
                    assetIcon:   _iSalesInvoice,
                    label:       'Sales Invoice',
                    destination: const SalesInvoiceScreen(),
                  ),
                ],
              ),
            ),

            SizedBox(height: h * 0.030),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, double w) {
    return AppBar(
      backgroundColor: AC.green,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'Sales',
        style: TextStyle(
          color:      Colors.white,
          fontSize:   w * 0.055,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════
//  BANNER DATA MODEL
// ═══════════════════════════════════════════
class _BannerData {
  final String  imagePath;
  final String? logo;
  final String? subtitle;
  final String? buttonText;

  const _BannerData({
    required this.imagePath,
    this.logo, this.subtitle, this.buttonText,
  });
}

// ═══════════════════════════════════════════
//  BANNER CAROUSEL  — full screen width
// ═══════════════════════════════════════════
class _BannerCarousel extends StatefulWidget {
  const _BannerCarousel();
  @override
  State<_BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<_BannerCarousel> {
  final _controller  = PageController();
  int   _currentPage = 0;
  Timer? _timer;

  static const _banners = [
    _BannerData(imagePath: 'assets/banners/banner1.png'),
    _BannerData(
      imagePath:  'assets/banners/banner2.jpg',
      logo:       'AgroSoft',
      subtitle:   'Grow Smarter, Earn Better',
      buttonText: 'Track your crops & profits in real-time',
    ),
    _BannerData(imagePath: 'assets/banners/banner3.jpg'),
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      final next = (_currentPage + 1) % _banners.length;
      _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 500),
        curve:    Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w       = MediaQuery.of(context).size.width;
    final h       = MediaQuery.of(context).size.height;
    // ✅ FIX: full screen width — no horizontal padding, taller height
    final bannerH = h * 0.26;

    return SizedBox(
      width:  w,          // full screen width
      height: bannerH,
      child: Stack(
        children: [
          PageView.builder(
            controller:    _controller,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemCount:     _banners.length,
            itemBuilder:   (_, i) => _BannerSlide(
              data: _banners[i], w: w, h: bannerH,
            ),
          ),
          // Dot indicators
          Positioned(
            bottom: h * 0.016, left: 0, right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_banners.length, (i) {
                final active = i == _currentPage;
                return AnimatedContainer(
                  duration:   const Duration(milliseconds: 300),
                  margin:     EdgeInsets.symmetric(horizontal: w * 0.010),
                  width:      active ? w * 0.060 : w * 0.022,
                  height:     w * 0.022,
                  decoration: BoxDecoration(
                    color:        active ? Colors.white : Colors.white54,
                    borderRadius: BorderRadius.circular(w * 0.011),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
//  BANNER SLIDE
// ═══════════════════════════════════════════
class _BannerSlide extends StatelessWidget {
  final _BannerData data;
  final double w, h;
  const _BannerSlide({required this.data, required this.w, required this.h});

  @override
  Widget build(BuildContext context) {
    final hasCaption = data.logo != null;
    return Stack(
      fit: StackFit.expand,
      children: [
        // ✅ Image fills full width with BoxFit.cover
        Image.asset(data.imagePath, fit: BoxFit.cover, width: w),
        if (hasCaption)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft, end: Alignment.centerRight,
                colors: [Colors.black.withOpacity(0.62), Colors.transparent],
              ),
            ),
          ),
        if (hasCaption)
          Positioned(
            top: h * 0.12, left: w * 0.06,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Icon(Icons.eco, color: AC.green, size: w * 0.068),
                  SizedBox(width: w * 0.015),
                  Text(data.logo!,
                      style: TextStyle(
                          color:         Colors.white,
                          fontSize:      w * 0.075,
                          fontWeight:    FontWeight.bold,
                          letterSpacing: 0.5)),
                ]),
                if (data.subtitle != null) ...[
                  SizedBox(height: h * 0.008),
                  Text(data.subtitle!,
                      style: TextStyle(
                          color:    Colors.white,
                          fontSize: w * 0.040)),
                ],
                if (data.buttonText != null) ...[
                  SizedBox(height: h * 0.018),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: w * 0.038, vertical: h * 0.010),
                    decoration: BoxDecoration(
                        color:        AC.green,
                        borderRadius: BorderRadius.circular(w * 0.020)),
                    child: Text(data.buttonText!,
                        style: TextStyle(
                            color:      Colors.white,
                            fontSize:   w * 0.030,
                            fontWeight: FontWeight.w600)),
                  ),
                ],
              ],
            ),
          ),
      ],
    );
  }
}

// ═══════════════════════════════════════════
//  MENU ITEM MODEL
// ═══════════════════════════════════════════
class _MenuItem {
  final String  assetIcon;
  final String  label;
  final String? badge;
  final Widget? destination;

  const _MenuItem({
    required this.assetIcon,
    required this.label,
    this.badge,
    required this.destination,
  });
}

// ═══════════════════════════════════════════
//  SECTION CARD
// ═══════════════════════════════════════════
class _SectionCard extends StatefulWidget {
  final double          w, h;
  final String          assetIcon;
  final String          title;
  final String          subtitle;
  final List<_MenuItem> items;

  const _SectionCard({
    super.key,
    required this.w,
    required this.h,
    required this.assetIcon,
    required this.title,
    required this.subtitle,
    required this.items,
  });

  @override
  State<_SectionCard> createState() => _SectionCardState();
}

class _SectionCardState extends State<_SectionCard>
    with SingleTickerProviderStateMixin {
  static const int _alwaysVisible = 3;
  bool _expanded = false;
  late final AnimationController _anim;
  late final Animation<double>   _rotate;

  @override
  void initState() {
    super.initState();
    _anim   = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _rotate = Tween<double>(begin: 0, end: 0.5).animate(
        CurvedAnimation(parent: _anim, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _expanded = !_expanded);
    _expanded ? _anim.forward() : _anim.reverse();
  }

  List<_MenuItem> get _visibleItems =>
      widget.items.take(_alwaysVisible).toList();
  List<_MenuItem> get _hiddenItems =>
      widget.items.length > _alwaysVisible
          ? widget.items.skip(_alwaysVisible).toList()
          : [];
  bool get _hasMore => _hiddenItems.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final w = widget.w;
    final h = widget.h;

    return Container(
      decoration: BoxDecoration(
        color:        Colors.white,
        borderRadius: BorderRadius.circular(w * 0.050),
        boxShadow: [
          BoxShadow(
            color:      Colors.black.withOpacity(0.07),
            blurRadius: 16,
            offset:     const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          // ══════════════════════════════════
          // GRADIENT HEADER BANNER
          // ══════════════════════════════════
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin:  Alignment.topLeft,
                end:    Alignment.bottomRight,
                colors: [Color(0xFF2DAF82), Color(0xFF1C8F6A)],
              ),
              borderRadius: BorderRadius.only(
                topLeft:  Radius.circular(w * 0.050),
                topRight: Radius.circular(w * 0.050),
              ),
            ),
            padding: EdgeInsets.fromLTRB(
              w * 0.05, h * 0.018, w * 0.05, h * 0.018,
            ),
            child: Row(
              children: [
                // Icon box
                Container(
                  width:  w * 0.130,
                  height: w * 0.130,
                  decoration: BoxDecoration(
                    color:        Colors.white.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(w * 0.030),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.35),
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Image.asset(
                      widget.assetIcon,
                      width:  w * 0.075,
                      height: w * 0.075,
                      errorBuilder: (_, __, ___) => Icon(
                        Icons.bar_chart_rounded,
                        color: Colors.white,
                        size:  w * 0.065,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: w * 0.038),

                // Title + subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize:      w * 0.060,
                          fontWeight:    FontWeight.w800,
                          color:         Colors.white,
                          letterSpacing: 0.3,
                        ),
                      ),
                      SizedBox(height: h * 0.004),
                      Text(
                        widget.subtitle,
                        style: TextStyle(
                          fontSize: w * 0.030,
                          color:    Colors.white.withOpacity(0.82),
                        ),
                      ),
                    ],
                  ),
                ),


              ],
            ),
          ),

          // ══════════════════════════════════
          // ALWAYS-VISIBLE FIRST 3 ITEMS
          // ══════════════════════════════════
          Padding(
            padding: EdgeInsets.fromLTRB(
              w * 0.035, h * 0.018, w * 0.035, h * 0.010,
            ),
            child: _buildTileGrid(_visibleItems, w, h),
          ),

          // ══════════════════════════════════
          // HIDDEN ITEMS (animated expand)
          // ══════════════════════════════════
          if (_hasMore)
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve:    Curves.easeInOut,
              child: _expanded
                  ? Padding(
                padding: EdgeInsets.fromLTRB(
                  w * 0.035, 0, w * 0.035, h * 0.010,
                ),
                child: Column(
                  children: [
                    _DashedDivider(color: AC.green.withOpacity(0.25)),
                    SizedBox(height: h * 0.012),
                    _buildTileGrid(_hiddenItems, w, h),
                  ],
                ),
              )
                  : const SizedBox.shrink(),
            ),

          // ══════════════════════════════════
          // SHOW MORE / LESS FOOTER
          // ══════════════════════════════════
          if (_hasMore) ...[
            Container(
              margin: EdgeInsets.fromLTRB(
                w * 0.035, 0, w * 0.035, h * 0.016,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AC.green.withOpacity(0.08),
                    AC.green.withOpacity(0.14),
                  ],
                ),
                borderRadius: BorderRadius.circular(w * 0.030),
                border: Border.all(
                  color: AC.green.withOpacity(0.25), width: 1,
                ),
              ),
              child: InkWell(
                onTap:        _toggle,
                borderRadius: BorderRadius.circular(w * 0.030),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: h * 0.013),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RotationTransition(
                        turns: _rotate,
                        child: Container(
                          width:  w * 0.070,
                          height: w * 0.070,
                          decoration: const BoxDecoration(
                            color: AC.green,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Colors.white,
                            size:  w * 0.048,
                          ),
                        ),
                      ),
                      SizedBox(width: w * 0.025),
                      Text(
                        _expanded ? 'Show Less' : 'Show More',
                        style: TextStyle(
                          fontSize:   w * 0.038,
                          fontWeight: FontWeight.w700,
                          color:      AC.greenDark,
                        ),
                      ),
                      SizedBox(width: w * 0.018),
                      if (!_expanded)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: w * 0.022, vertical: h * 0.003,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ] else
            SizedBox(height: h * 0.012),
        ],
      ),
    );
  }

  // ── Grid builder ────────────────────────
  Widget _buildTileGrid(List<_MenuItem> items, double w, double h) {
    final rows = <List<_MenuItem>>[];
    for (int i = 0; i < items.length; i += 3) {
      rows.add(items.sublist(i, (i + 3).clamp(0, items.length)));
    }

    return Column(
      children: rows.asMap().entries.map((entry) {
        final rowIndex = entry.key;
        final row      = entry.value;
        return Column(
          children: [
            if (rowIndex > 0) ...[
              Divider(height: 1, color: Colors.grey.shade100),
              SizedBox(height: h * 0.004),
            ],
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < 3; i++) ...[
                  if (i > 0)
                    Container(
                      width:  1,
                      height: h * 0.135,
                      color:  Colors.grey.shade100,
                      margin: EdgeInsets.only(top: h * 0.008),
                    ),
                  Expanded(
                    child: i < row.length
                        ? _MenuTile(item: row[i], w: w, h: h)
                        : const SizedBox(),
                  ),
                ],
              ],
            ),
          ],
        );
      }).toList(),
    );
  }
}

// ═══════════════════════════════════════════
//  DASHED DIVIDER
// ═══════════════════════════════════════════
class _DashedDivider extends StatelessWidget {
  final Color color;
  const _DashedDivider({required this.color});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        const dashW = 6.0;
        const gapW  = 4.0;
        final count = (constraints.maxWidth / (dashW + gapW)).floor();
        return Row(
          children: List.generate(
            count,
                (_) => Padding(
              padding: const EdgeInsets.only(right: gapW),
              child: Container(width: dashW, height: 1, color: color),
            ),
          ),
        );
      },
    );
  }
}

// ═══════════════════════════════════════════
//  MENU TILE
// ═══════════════════════════════════════════
class _MenuTile extends StatelessWidget {
  final _MenuItem item;
  final double w, h;
  const _MenuTile({required this.item, required this.w, required this.h});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (item.destination != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => item.destination!),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:  Text('${item.label} coming soon'),
            duration: const Duration(seconds: 1),
          ));
        }
      },
      borderRadius: BorderRadius.circular(w * 0.030),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical:   h * 0.013,
          horizontal: w * 0.010,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Icon with badge ──────────────
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Outer soft ring
                Container(
                  width:  w * 0.170,
                  height: w * 0.170,
                  decoration: BoxDecoration(
                    color: AC.green.withOpacity(0.10),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    // Inner solid circle
                    child: Container(
                      width:  w * 0.130,
                      height: w * 0.130,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin:  Alignment.topLeft,
                          end:    Alignment.bottomRight,
                          colors: [Color(0xFF2DAF82), Color(0xFF1C8F6A)],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Image.asset(
                          item.assetIcon,
                          width:  w * 0.068,
                          height: w * 0.068,
                          errorBuilder: (_, __, ___) => Icon(
                            Icons.touch_app_rounded,
                            color: Colors.white,
                            size:  w * 0.068,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),


              ],
            ),
            SizedBox(height: h * 0.010),

            // ── Label ────────────────────────
            Text(
              item.label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize:   w * 0.032,
                color:      AC.textDark,
                fontWeight: FontWeight.w600,
                height:     1.25,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}