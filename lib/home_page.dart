import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tang_tem_pao_mb/core/constant/dimension_constant.dart';
import 'package:tang_tem_pao_mb/feature/balance/view/page/balance_page.dart';
import 'package:tang_tem_pao_mb/feature/budget/view/page/budget_page.dart';
import 'package:tang_tem_pao_mb/feature/category/view/page/category_page.dart';
import 'package:tang_tem_pao_mb/feature/dashboard/view/pages/dashboard_page.dart';
import 'package:tang_tem_pao_mb/feature/menu/view/page/menu_page.dart';
import 'package:tang_tem_pao_mb/feature/transaction/view/pages/transaction_page.dart';

/// This is the main screen of the app after a user is logged in.
/// It contains the BottomNavigationBar and manages the currently displayed page.
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _selectedIndex = 0;

  // List of pages to be displayed in the body.
  static final List<Widget> _widgetOptions = <Widget>[
    const DashboardPage(),
    const TransactionPage(),
    const CategoryPage(),
    const BudgetPage(),
    const BalancePage(),
    const MenuPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _widgetOptions),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_rounded),
            label: 'แดชบอร์ด',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz_rounded),
            label: 'ธุรกรรม',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.layers),
            label: 'หมวดหมู่',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.flag_rounded),
            label: 'เป้าหมาย',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            label: 'การเงิน',
          ),
          const BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'เมนู'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 5,
        iconSize: DimensionConstant.responsiveFont(context, 24),
        selectedIconTheme: IconThemeData(size: DimensionConstant.responsiveFont(context, 30)),
        selectedLabelStyle: TextStyle(
          fontSize: DimensionConstant.responsiveFont(context, DimensionConstant.isMobile(context) ? 13 : 20),
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: DimensionConstant.responsiveFont(
            context,
            DimensionConstant.isMobile(context) ? 11 : 18,
          ),
        ),
      ),
    );
  }
}
