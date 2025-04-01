
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/effectiveness.dart';
import '../models/volunteer.dart';
import '../widget/drawrer_body.dart';
import 'home_taps/certificates_info_tab.dart';
import 'home_taps/certificates_tap.dart';
import 'home_taps/current_effectiveness_tap.dart';
import 'home_taps/effectiveness_info_tap.dart';
import 'home_taps/home_tap.dart';
import 'home_taps/joint_effectiveness_tap.dart';

Effectiveness selectedEffectiveness = Effectiveness.static();


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {

  int _currentIndexBottomNavigationBarItem = 2;

  late TabController tabController;

  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();
  List <String> titles = [
    'الفعاليات المسجلة',
    'الشهادات',
    'الصفحة الرئيسية',
    'الفعاليات الحالية'
  ];


  @override
  void initState() {
    super.initState();
    tabController = TabController(
        length: 7,
        vsync: this,
        initialIndex: 2,
        animationDuration: const Duration(milliseconds: 0));
    tabController.addListener(handleTabSelection);
  }

  void handleTabSelection() {
    setState(() {
      if (tabController.index < 4) {
        _currentIndexBottomNavigationBarItem = tabController.index;
      }
    });
  }

  void handleBackButton() {
    setState(() {
      switch (tabController.index){
        case 4:
          tabController.animateTo(3);
          return;
        case 5:
          tabController.animateTo(1);
          return;
        case 6:
          tabController.animateTo(1);
          return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: Drawer(
          width: 200,
          child: DrawerBody(scaffold:_scaffoldKey,),

        ),
        appBar:(_currentIndexBottomNavigationBarItem == 2)?AppBar(
          actions: [
            IconButton(
              onPressed: (){
                _scaffoldKey.currentState!.openEndDrawer();
              },
              icon: const Icon(Icons.menu , color: Colors.white,),),          ],
          centerTitle: true,
          backgroundColor:  Colors.indigoAccent,
          title: Text(titles[_currentIndexBottomNavigationBarItem] ,maxLines: 1,textAlign: TextAlign.center,  style:const TextStyle(color: Colors.white,fontSize: 24 ,fontWeight: FontWeight.bold ,),),

        ) : AppBar(
          leading: Visibility(
            visible: tabController.index >3,
            child: IconButton(
              onPressed: handleBackButton,
              icon: const Icon(Icons.chevron_left , color: Colors.black,),),
          ),
          actions: [
            Visibility(
              visible: _currentIndexBottomNavigationBarItem== 2,
              child: IconButton(
                onPressed: (){
                  _scaffoldKey.currentState!.openEndDrawer();
                },
                icon: const Icon(Icons.menu , color: Colors.black,),),
            ),
          ],
          centerTitle: true,
          backgroundColor:  const Color(0xFFA0dbf1),
          shadowColor: Colors.transparent,
          title:  Text(titles[_currentIndexBottomNavigationBarItem] ,maxLines: 1,textAlign: TextAlign.center,  style: const TextStyle(color: Colors.indigoAccent,fontSize: 24 ,fontWeight: FontWeight.bold ,),),

        ),
        backgroundColor:  const Color(0xFFA0dbf1),
        resizeToAvoidBottomInset: true,
        body: SizedBox(
          height: height,
          width: width,

          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: tabController,
            children: <Widget>[
              JointEffectivenessTap(tabController: tabController,),
              CertificatesTap(tabController: tabController,),
              const HomeTapScreen(),
              CurrentEffectivenessTap(tabController: tabController,),
              EffectivenessInfoTap(effectiveness: selectedEffectiveness, tabController: tabController ,),
              EffectivenessInfoTap(effectiveness: selectedEffectiveness, tabController: tabController ,),
              CertificatesInfoTap(effectiveness: selectedEffectiveness, tabController: tabController ,),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 65,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: BottomNavigationBar(
            unselectedFontSize: 0,
            selectedFontSize: 0,

            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.person), label: "",),
              BottomNavigationBarItem(icon: Icon(Icons.folder_special), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.description), label: ""),
            ],
            onTap: onTapedBottomsNavigationBarItem,
            currentIndex: _currentIndexBottomNavigationBarItem,
            backgroundColor: Colors.indigoAccent,
            type: BottomNavigationBarType.fixed,
            iconSize: 32,
            // Fixed
            selectedItemColor: Colors.grey,
            unselectedItemColor: Colors.white,
          ),
        ),
      ),
    );
  }

  void onTapedBottomsNavigationBarItem(int value) {
    setState(() {
      tabController.animateTo(value);
    });
  }


}
