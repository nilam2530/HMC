import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_responsive_flutter/src/app_configs/app_colors.dart';
import 'package:web_responsive_flutter/src/app_configs/app_images.dart';
import 'package:web_responsive_flutter/src/themes/theme_provider.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final String imageUrl;
  final List<String> actionImages;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.actionImages,
  }) : super(key: key);

  @override
  CustomAppBarState createState() => CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomAppBarState extends State<CustomAppBar> {
  bool isExpanded = false;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  TextEditingController _searchController = TextEditingController();
  List<String> filteredTitles = [];
  List<String> titles = [
    'Inbound Logistics',
    'Employee Compliance Application',
    'HIRA system',
    'Injury Identification System',
    'Tag Redress System',
    'Kaizen System',
    'One Point Lesson',
    'Quality Alert System',
    'SOP System (SS & SC Function)',
    'SOP System (Project Engineering Department)',
  ];

  @override
  void initState() {
    super.initState();
    filteredTitles = titles; // Initialize with all items
    _searchController.addListener(_filterSearchResults);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterSearchResults() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredTitles = titles
          .where((title) => title.toLowerCase().contains(query))
          .toList();
    });
  }

  var themeProvider;
  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context,listen: false);
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.white),
          bottom: BorderSide(color: AppColors.lightGrey, width: 1),
        ),
      ),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColormain,
        leading: _buildMenuIcon(),
        title: _buildTitleRow(),
        actions: [
          ..._buildActionIcons(),

        ],
      ),
    );
  }

  Widget _buildMenuIcon() {
    return CompositedTransformTarget(
      link: _layerLink,
      child: IconButton(
        icon: Image.asset(AppImages.menuIconsDot, width: 20, height: 20),
        onPressed: () {
          setState(() {
            isExpanded ? _overlayEntry?.remove() : _showDropdown(context);
            isExpanded = !isExpanded;
          });
        },
      ),
    );
  }

  Widget _buildTitleRow() {
    return Row(
      children: [
        Image.network(
          widget.imageUrl,
          width: 120,
          height: 25,
          fit: BoxFit.cover,
        ),
        const SizedBox(width: 10),
        Text(
          widget.title,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.lightBlack,
          ),
        ),
        const SizedBox(width: 10),
        _buildSearchBox(),
      ],
    );
  }

  Widget _buildSearchBox() {
    return SizedBox(
      width: 200, // Set fixed width for the search bar
      height: 36, // Set fixed height
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.dark3Grey,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppColors.dark3Grey, width: 1),
        ),
        child: const Row(
          children: [
            Icon(Icons.search, size: 20),
            SizedBox(width: 8),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: 18),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    border: InputBorder.none,
                  ),
                  style: TextStyle(fontSize: 14), // Adjust font size if needed
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildActionIcons() {
    return widget.actionImages
        .map((imagePath) => IconButton(
      icon: Image.network(imagePath, width: 20, height: 20),
      onPressed: () {
        if(imagePath.toLowerCase().contains("profile")){
          showMenu(
            context: context,
            position: RelativeRect.fromLTRB(1, 50, 0, 0),
            items: [
              const PopupMenuItem(
                value: 1,
                child: Text("Dark Theme"),
              ),
              PopupMenuItem(
                value: 2,
                child: Text("Light Theme"),
              ),
            ],
            elevation: 8.0,
          ).then((value){
            //context.read<ThemeProvider>().setTheme(themeName)
            themeProvider!.toggleTheme(value!.isOdd?true:false);
          });
        }
      },
    ))
        .toList();
  }

  void _showDropdown(BuildContext context) {
    final overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: 335,
        top: kToolbarHeight + 8,
        left: 0,
        child: Material(
          elevation: 4,
          child: _buildDropdownContent(),
        ),
      ),
    );

    overlayState.insert(_overlayEntry!);
    Future.delayed(const Duration(seconds: 5), () {
      _overlayEntry?.remove();
      setState(() => isExpanded = false);
    });
  }

  Widget _buildDropdownContent() {
    final imagePaths = [
      'assets/images/inbound_logistics.png',
      'assets/images/employee_compliance.png',
      'assets/images/hira.png',
      'assets/images/injury_identification.png',
      'assets/images/tag_redressal.png',
      'assets/images/kaizen.png',
      'assets/images/opl.png',
      'assets/images/quality_alert.png',
      'assets/images/sop1.png',
      'assets/images/sop2.png',
    ];

    return Container(
      height: 488,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1),
      ),
      child: Column(
        children: [
          _buildDropdownHeader(),
          Expanded(
            child: ListView.builder(
              itemCount: filteredTitles.length,
              itemBuilder: (context, index) => ListTile(
                leading: Image.asset(imagePaths[index], width: 24, height: 24),
                title: Text(filteredTitles[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Applications',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {
            _overlayEntry?.remove();
            setState(() => isExpanded = false);
          },
          child: const Text(
            'View All',
            style: TextStyle(fontSize: 14, color: Colors.red),
          ),
        ),
      ],
    );
  }
}
