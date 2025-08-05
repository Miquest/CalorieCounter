import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'foodDataLoader.dart';


class FoodSearch extends StatefulWidget {

  final FoodDataLoader loader;
  const FoodSearch({super.key, required this.loader});

  @override
  State<FoodSearch> createState() => _FoodSearchState();
}

class _FoodSearchState extends State<FoodSearch>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
        child: Column(
          children: [
            SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Search",
                  style: TextStyle(
                    fontFamily: GoogleFonts.permanentMarker().fontFamily,
                    fontSize: 50,
                  ),
                ),

                ListenableBuilder(
                  listenable: widget.loader,
                  builder: (BuildContext context, Widget? child) {
                    return Badge(
                      label: Text("${widget.loader.selectedFoods.length}"),
                      child: Icon(Icons.table_bar, size: 35),
                    );
                  },
                ),
              ],
            ),

            SizedBox(height: 20),

            SearchBar(
              padding: WidgetStatePropertyAll(
                EdgeInsets.fromLTRB(20, 0, 10, 0),
              ),
              leading: Icon(Icons.search),
              trailing: [
                IconButton(onPressed: () {}, icon: Icon(Icons.qr_code_2)),
              ],
              hintText: "Search product...",
              onSubmitted: (String? searchString) {
                widget.loader.searchByString(searchString ?? "");
              },
            ),

            ListenableBuilder(
              listenable: widget.loader,
              builder: (BuildContext context, Widget? child) {
                return Flexible(
                  child: ListView(
                    controller: _scrollController,
                    children: widget.loader.results,
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
