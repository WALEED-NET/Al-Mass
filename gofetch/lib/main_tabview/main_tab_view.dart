import 'package:flutter/material.dart';
import 'package:gofetch/screens/more/more_view.dart';
import 'package:gofetch/shared_wedget/tab_button.dart';

import '../screens/home/home_view..dart';



class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
  int selectTab = 1;
  // storageBucket يستخدم لتخزين حالة الصفحة والحفاظ عليها عند تغيير العلامات التبويب أو إعادة بناء الواجه
  PageStorageBucket storageBucket = PageStorageBucket();
  Widget selectPageView = const HomeView();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageStorage(
          bucket: storageBucket,
          child: selectPageView,
        ),
        
        bottomNavigationBar: BottomAppBar(
          shadowColor: Colors.black,
          // الظل حق الحلق لي حول الزر العائم
          elevation: 10,
          // المسافة بين الزر العائم والبوتوم بار او تقدر تقول المسافة او الحجم حق الحلق لي حول الزر العائم
          notchMargin: 15,
          height: 64,
          shape: const CircularNotchedRectangle(),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              TapButton(
                title: "invoices",
                icon: "assets/img/shopping_cart.png",
                onTap: () {
                  if (selectTab != 0) {
                    selectTab = 0;
                    selectPageView = const HomeView();
                    // here he want to display the view of the Order button instead of container 
                  }
                  if (mounted) {
                    setState(() {
                      
                    });
                  }
                },
                isSelected: selectTab == 0,
                )
                ,
              
                TapButton(
                title: "More",
                icon: "assets/img/tab_more.png",
                onTap: () {
                  if (selectTab != 3) {
                    selectTab = 3;
                    selectPageView = const MoreView();
                  }
                  if (mounted) {
                    setState(() {
                      
                    });
                  }
                },
                isSelected: selectTab == 3,
                ),
                
                ],
            ),
          ),
        ),
        );
  }
}
