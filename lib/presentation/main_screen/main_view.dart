import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:reports/app/app_prefs.dart';
import 'package:reports/app/di.dart';
import 'package:reports/presentation/common/state_render/state_renderer_imp.dart';
import 'package:reports/presentation/main_screen/add-column/view.dart';
import 'package:reports/presentation/main_screen/ended-column/view.dart';
import 'package:reports/presentation/main_screen/finished-column/view.dart';
import 'package:reports/presentation/main_screen/finished-column/view_model.dart';
import 'package:reports/presentation/main_screen/main_view_model.dart';
import 'package:reports/presentation/resources/color_manager.dart';
import 'package:reports/presentation/resources/routes_manager.dart';
import 'package:reports/presentation/resources/string_manager.dart';
import 'package:reports/presentation/resources/values_manager.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final MainViewModel _viewModel = instance<MainViewModel>();

  final AppPreferences appPreferences = instance<AppPreferences>();
  final FinishedColumnViewModel _finishedColumnViewModel =
      instance<FinishedColumnViewModel>();
  final PersistentTabController _controller = PersistentTabController();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  List<String> appBarTitle = [
    AppStrings.addColumn,
    AppStrings.nonFinishedColumn,
    AppStrings.finishedColumn,
  ];

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  List<PersistentBottomNavBarItem> navBarItems = [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.add),
      title: AppStrings.addColumn,
      activeColorPrimary: ColorManager.primary,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.edit_document),
      title: AppStrings.nonFinishedColumn,
      activeColorPrimary: ColorManager.primary,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.menu),
      title: AppStrings.finishedColumn,
      activeColorPrimary: ColorManager.primary,
      inactiveColorPrimary: Colors.grey,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    _controller.addListener(() {
      _viewModel.setIndex(_controller.index);
      // Perform actions based on the selected tab index
    });
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(AppSize.s55),
          child: Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              color: Colors.transparent,
              boxShadow: [
                BoxShadow(
                    blurRadius: AppSize.s16,
                    offset: const Offset(0, 6),
                    color: ColorManager.grey)
              ],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(AppSize.s10.w),
                bottomRight: Radius.circular(AppSize.s10.w),
              ),
            ),
            child: AppBar(
              bottomOpacity: 10,
              automaticallyImplyLeading: false,
              actions: [
                Center(
                    child: Text(
                  appPreferences.getToken(),
                  style: Theme.of(context).textTheme.labelSmall,
                )),
                IconButton(
                  onPressed: () {
                    appPreferences.setPressKeyLoginScreen(false);
                    Navigator.pushReplacementNamed(context, Routes.loginScreen);
                  },
                  icon: Icon(
                    Icons.logout,
                    color: ColorManager.white,
                  ),
                ),
              ],
              title: StreamBuilder<int>(
                stream: _viewModel.outputIndex,
                builder: (context, snapshot) {
                  return Text(
                    appBarTitle[_controller.index],
                  );
                },
              ),
            ),
          ),
        ),
        body: StreamBuilder<StateFlow>(
            stream: _viewModel.outputState,
            builder: (context, snapshot) {
              print("** main **${snapshot.data.runtimeType}");
              return snapshot.data?.getScreenWidget(
                    context,
                    _getContent(),
                    () {
                      _viewModel.start();
                    },
                  ) ??
                  _getContent();
            }),
      ),
    );
  }

  Widget _getContent() {
    return PersistentTabView(
      context,
      controller: _controller,
      items: navBarItems,
      screens: const [
        AddColumnView(),
        FinishedColumnView(),
        EndedColumnView(),
      ],
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      navBarHeight: AppSize.s65,
      // Customize as needed
      onItemSelected: (index) {
        if (index == 1) {
          _finishedColumnViewModel.start();
        }
      },
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      // hideNavigationBar: true,
    );
  }
}
