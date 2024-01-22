import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lugo_customer/page/home/controller_home.dart';

class PageHome extends GetView<ControllerHome> {
  const PageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: IndexedStack(
            index: controller.currentPage.value,
            children: controller.pages,
          ),
          bottomNavigationBar: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: BottomNavigationBar(
              backgroundColor: const Color(0xFF3978EF),
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              currentIndex: controller.currentPage.value,
              onTap: (index) => controller.changePage(index),
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_rounded),
                    label: '',
                    backgroundColor: Colors.white),
                BottomNavigationBarItem(
                    icon: Icon(Icons.work_history_rounded),
                    label: '',
                    backgroundColor: Colors.white),
                BottomNavigationBarItem(
                    icon: Icon(Icons.grid_view_rounded),
                    label: '',
                    backgroundColor: Colors.white),
                BottomNavigationBarItem(
                    icon: Icon(Icons.chat_bubble_rounded),
                    label: '',
                    backgroundColor: Colors.white),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_pin),
                    label: '',
                    backgroundColor: Colors.white),
              ],
            ),
          ),
        ));
  }
}
