import 'package:caloriecounter/components/foodDataLoader.dart';
import 'package:caloriecounter/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zxing/flutter_zxing.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

import 'searchLoader.dart';

class FoodSearch extends StatefulWidget {
  final FoodDataLoader foodLoader;

  const FoodSearch({super.key, required this.foodLoader});

  @override
  State<FoodSearch> createState() => _FoodSearchState();
}

class _FoodSearchState extends State<FoodSearch>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late FoodSearchLoader searchLoader;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_animationController);

    _scrollController.addListener(() {
      if (_scrollController.offset > 0) {
        _animationController.forward();
      }

      if (_scrollController.offset <= 1) {
        _animationController.animateBack(0);
      }
    });

    searchLoader = FoodSearchLoader(
      context: context,
      foodLoader: widget.foodLoader,
    );

    super.initState();
  }

  Future<void> _scanBarcode() async {
    await Permission.camera.request();
    await zx.startCameraProcessing();

    final String barcode = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 250,
            width: 250,
            child: ReaderWidget(
              onScan: (Code code) {
                Navigator.of(context).pop(code.text ?? "");
              },
            ),
          ),
        );
      },
    );

    searchLoader.searchByBarcode(barcode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),

            Text(
              S.of(context).search,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: GoogleFonts.permanentMarker().fontFamily,
                fontSize: 50,
              ),
            ),

            SizedBox(height: 20),

            SearchBar(
              padding: WidgetStatePropertyAll(
                EdgeInsets.fromLTRB(20, 0, 10, 0),
              ),
              leading: Icon(Icons.search),
              trailing: [
                IconButton(
                  onPressed: _scanBarcode,
                  icon: Icon(Icons.qr_code_2),
                ),
              ],
              hintText: S.of(context).searchProduct,
              onSubmitted: (String? searchString) {
                searchLoader.searchByString(searchString ?? "");
              },
            ),

            SizedBox(height: 10),

            /*
            ListenableBuilder(
              listenable: searchLoader,
              builder: (BuildContext context, Widget? child) {
                return SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      FilterChip(
                        label: Text(S.of(context).name),
                        selected: searchLoader.field == ProductField.NAME,
                        onSelected: (value) {
                          searchLoader.field = ProductField.NAME;
                        },
                      ),
                      SizedBox(width: 10),
                      FilterChip(
                        label: Text(S.of(context).brand),
                        selected: searchLoader.field == ProductField.BRANDS,
                        onSelected: (value) {
                          searchLoader.field = ProductField.BRANDS;
                        },
                      ),
                      SizedBox(width: 10),
                      FilterChip(
                        label: Text(S.of(context).type),
                        selected:
                            searchLoader.field == ProductField.PRODUCT_TYPE,
                        onSelected: (value) {
                          searchLoader.field = ProductField.PRODUCT_TYPE;
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            */
            ListenableBuilder(
              listenable: searchLoader,
              builder: (BuildContext context, Widget? child) {
                if (searchLoader.loading) {
                  return Flexible(
                    child: Center(
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                }

                return Flexible(
                  child: ListView(
                    controller: _scrollController,
                    children: searchLoader.searchResults,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: AnimatedBuilder(
        animation: _opacityAnimation,
        builder: (BuildContext context, Widget? child) {
          return Opacity(
            opacity: _opacityAnimation.value,
            child: FloatingActionButton(
              onPressed: () async {
                _scrollController.animateTo(
                  0,
                  duration: Duration(seconds: 1),
                  curve: Curves.easeInOut,
                );
              },
              child: Icon(Icons.keyboard_arrow_up),
            ),
          );
        },
      ),
    );
  }
}
