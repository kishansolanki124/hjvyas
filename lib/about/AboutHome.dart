import 'package:flutter/material.dart';
import 'package:hjvyas/api/models/StaticPageResponse.dart';
import 'package:hjvyas/utils/CommonAppProgress.dart';

import '../api/services/HJVyasApiService.dart';
import '../injection_container.dart';
import '../menu/CategoryController.dart';
import '../repositories/HJVyasRepository.dart';
import '../splash/NoIntternetScreen.dart';
import 'AboutWidgets.dart';
import 'ContactUs.dart';

class AboutHome extends StatefulWidget {
  final CategoryController categoryController = CategoryController(
    getIt<HJVyasApiService>(),
  );

  final HJVyasRepository _userRepo = HJVyasRepository(
    getIt<HJVyasApiService>(),
  );

  AboutHome({super.key});

  @override
  State<AboutHome> createState() => _AboutHomeState();
}

class _AboutHomeState extends State<AboutHome>
    with SingleTickerProviderStateMixin {
  // void _onBackPressed(BuildContext context) {
  //   Navigator.of(context).pop();
  // }

  void _changeIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int _selectedIndex = 0;

  // -1 indicates no item is selected
  final List<String> _imagePaths = [
    'icons/about_us_icon.png',
    'icons/contact_us_icon.png',
    'icons/refund_icon.png',
    'icons/privecy_policy_icon.png',
    'icons/term_icon.png',
  ];

  // -1 indicates no item is selected
  final List<String> _tabNames = [
    'About Us',
    'Contact Us',
    'Refund Policy',
    'Privacy Policy',
    'Terms',
  ];

  final List<String> _imagePathsSelected = [
    'icons/about_us_icon_a.png',
    'icons/contact_us_icon_a.png',
    'icons/refund_icon_a.png',
    'icons/privecy_policy_icon_a.png',
    'icons/term_icon_a.png',
  ];

  Future<StaticPageResponse> fetchData() async {
    return await widget._userRepo.getStaticpage();
  }

  late Future<StaticPageResponse> _dataFuture;

  // Method to refresh data
  void _refreshData() {
    setState(() {
      _dataFuture = fetchData(); // Create new Future when needed
    });
  }

  late final AnimationController _animationController;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, -3.0), // Much higher above the screen
      end: Offset.zero, // End at normal position
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutQuad),
    );

    // Stagger the animations based on index
    Future.delayed(Duration(milliseconds: 500), () {
      if (mounted) {
        _animationController.forward();
      }
    });

    _dataFuture = widget._userRepo.getStaticpage();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StaticPageResponse>(
      future: _dataFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return staticPageMainContent(
            _animationController,
            _slideAnimation,
            widget.categoryController,
            _tabNames,
            _imagePaths,
            _imagePathsSelected,
            _selectedIndex,
            _changeIndex,
            snapshot.data!.staticpageList,
          );
        } else if (snapshot.hasError) {
          return NoInternetScreen(
            onRetry: () {
              _refreshData();
            },
          );
        }
        return getCommonProgressBarFullScreen();
      },
    );
  }
}

Widget staticPageMainContent(
  AnimationController _animationController,
  Animation<Offset> _slideAnimation,
  categoryController,
  _tabNames,
  _imagePaths,
  _imagePathsSelected,
  _selectedIndex,
  _changeIndex,
  List<StaticpageListItem> staticpageList,
) {
  return Scaffold(
    body: Stack(
      children: <Widget>[
        //Background Image
        Image.asset(
          'images/bg.jpg', // Replace with your image path
          fit: BoxFit.cover, // Cover the entire screen
          width: double.infinity,
          height: double.infinity,
        ),

        //square border on top
        SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _animationController,
            child: IgnorePointer(
              child: Container(
                height: 80,
                margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 0),
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: Color.fromARGB(255, 123, 138, 195),
                      width: 2.0,
                    ),
                    bottom: BorderSide(
                      color: Color.fromARGB(255, 123, 138, 195),
                      width: 2.0,
                    ),
                    right: BorderSide(
                      color: Color.fromARGB(255, 123, 138, 195),
                      width: 2.0,
                    ),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                ),
              ),
            ),
          ),
        ),

        //backButton(() => _onBackPressed(context)),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 40.0),

              SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _animationController,
                  child: Center(
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          // Distribute items evenly
                          children: List.generate(_imagePaths.length, (index) {
                            return _buildSelectItem(
                              _tabNames,
                              _imagePaths,
                              _imagePathsSelected,
                              index,
                              _selectedIndex,
                              _changeIndex,
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              if (_selectedIndex == 0)
                AboutUsContentWidget("About Us", staticpageList),

              if (_selectedIndex == 1)
                ContactUs(categoryController: categoryController),

              if (_selectedIndex == 2)
                AboutUsContentWidget("Refund Policy", staticpageList),

              if (_selectedIndex == 3)
                AboutUsContentWidget("Privacy Policy", staticpageList),

              if (_selectedIndex == 4)
                AboutUsContentWidget("Terms", staticpageList),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildSelectItem(
  _tabNames,
  _imagePaths,
  _imagePathsSelected,
  int index,
  _selectedIndex,
  _changeIndex,
) {
  final isSelected = _selectedIndex == index;
  return GestureDetector(
    onTap: () {
      _changeIndex(index);
    },
    child: Column(
      children: [
        Container(
          width: 50,
          height: 50,
          // Fixed width for the square
          //height: 50,
          // Fixed height for the square
          decoration: BoxDecoration(
            color:
                isSelected
                    ? Color.fromARGB(225, 255, 255, 255)
                    : Color.fromARGB(
                      255,
                      31,
                      47,
                      80,
                    ), // Change background color
            border: Border.all(
              color:
                  isSelected
                      ? Color.fromARGB(225, 255, 255, 255)
                      : Color.fromARGB(255, 123, 138, 195), // Square border
              width: 1.0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0), // Padding inside the container
            child: Image.asset(
              width: 50,
              // Fixed width for the square
              height: 50,
              (isSelected) ? _imagePathsSelected[index] : _imagePaths[index],
              fit: BoxFit.contain, // Make the image fit within the square
            ),
          ),
        ),

        SizedBox(
          width: 50,
          child: Center(
            child: Text(
              _tabNames[index],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.0,
                fontFamily: "Montserrat",
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
