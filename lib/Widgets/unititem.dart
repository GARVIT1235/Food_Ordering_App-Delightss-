import 'package:Delightss/Services/catcartService.dart';
import 'package:Delightss/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const int MAX_VALUE = 20;
const int MIN_VALUE = 0;

class UnitPriceWidget extends StatefulWidget {
  @override
  State<UnitPriceWidget> createState() => _UnitPriceWidgetState();
}

class _UnitPriceWidgetState extends State<UnitPriceWidget> {
  Color themeColor;
  int amount = 0;
  double price = 0.0;
  double cost = 0.0;

  @override
  Widget build(BuildContext context) {
    CategorySelectionService catSelection =
        Provider.of<CategorySelectionService>(context);

    return Column(children: [
      Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      offset: Offset.zero,
                      color: Colors.black.withOpacity(0.1))
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: catSelection.subCategoryAmount < MAX_VALUE
                      ? () {
                          setState(() {});
                          print("button");
                          catSelection.incrementSubCategoryAmount(context);
                        }
                      : null,
                  child: Icon(Icons.add_circle_outline,
                      color: catSelection.subCategoryAmount < MAX_VALUE
                          ? AppColors.main_color
                          : Colors.deepPurple.withOpacity(0.2)),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Consumer<CategorySelectionService>(
                      builder: (context, cat, child) {
                        return Center(
                          child: Text.rich(TextSpan(children: [
                            TextSpan(
                              text: catSelection.subCategoryAmount.toString(),
                            ),
                          ])),
                        );
                      },
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: catSelection.subCategoryAmount > MIN_VALUE
                      ? () {
                          setState(() {});
                          catSelection.decrementSubCategoryAmount(context);
                        }
                      : null,
                  child: Icon(Icons.remove_circle_outline,
                      color: catSelection.subCategoryAmount > MIN_VALUE
                          ? Colors.grey
                          : Colors.grey[100]),
                )
              ],
            ),
          ))
    ]);
  }
}
