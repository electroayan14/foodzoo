import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodzoo/features/utils/enums/enums.dart';
import 'package:foodzoo/routes/constants.dart';

import '../../utils/colors.dart';
import 'bloc/meals_bloc.dart';
import 'domain/model/food_by_categoryModel.dart';

//ignore:must_be_immutable
class MealsScreen extends StatelessWidget {
  MealsScreen({super.key, this.categoryName});

  final String? categoryName;
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    getMeals(context, categoryName);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Meals",
          style: TextStyle(fontSize: 16.0),),
        actions: [
          InkWell(
            onTap: () => Navigator.pushNamed(context, cart),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.shopping_cart),
            ),
          )
        ],
      ),
      body: BlocConsumer<MealsBloc, MealsState>(
        listener: (context, state) {
          switch (state.stateStatus) {
            case StateStatus.loading:
            // TODO: Handle this case.
            case StateStatus.success:
              isClicked = state.isClicked;
            case StateStatus.failed:
            // TODO: Handle this case.
          }
        },
        builder: (context, state) {
          switch (state.stateStatus) {
            case StateStatus.loading:
              return const Center(
                  child: CircularProgressIndicator(color: Colors.cyan));
            case StateStatus.success:
              return _mealView(context, state.foodByCategoryModel?.meals ?? [],state.selectedIndex);
            case StateStatus.failed:
              return Center(child: Text(state.message.toString()));
          }
        },
      ),
    );
  }

  Widget _mealView(context, List<Meals>? meals,selectedIndex) {
    return ListView.builder(
        itemCount: meals?.length,
        itemBuilder: (BuildContext context, int index) {
          return _itemView(context, meals ?? [], index,selectedIndex);
        });
  }

  Widget _itemView(context, List<Meals> meals, index,selectedIndex) {
    return Container(
      height: 80,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.appThemeColor,
          width: 2,
        ),
      ),
      child: ListTile(
          title: SizedBox(
              width: 80,
              child: Text(
                meals[index].strMeal ?? '',
                overflow: TextOverflow.clip,
                maxLines: 1,
                style: const TextStyle(
                    fontSize: 12.0, fontWeight: FontWeight.w800),
              )),
          subtitle: Visibility(visible: false, child: _counterView()),
          trailing: selectedIndex==index
              ? InkWell(
                  onTap: () => addToCart(context, isClicked,meals[index],index),
                  child:
                      const Icon(Icons.remove_shopping_cart, color: Colors.red))
              : InkWell(
                  onTap: () => addToCart(context, isClicked,meals[index],index),
                  child: Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: Colors.black12,
                          width: 2,
                        ),
                      ),
                      child: const Text("Add to cart")),
                ),
          leading: Image.network(
            meals[index].strMealThumb ?? '',
          )),
    );
  }

  Widget _counterView() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black12,
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.remove, size: 16.0),
            onPressed: () => (),
            color: Colors.black,
          ),
          const Text(
            '0',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          IconButton(
            icon: const Icon(Icons.add, size: 16.0),
            onPressed: () => (),
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  getMeals(context, categoryName) {
    BlocProvider.of<MealsBloc>(context).add(FetchAllMeals(categoryName));
  }

  addToCart(context, isClicked,clickedItem,selectedIndex) {
    BlocProvider.of<MealsBloc>(context).add(CartPressed(isClicked,clickedItem,selectedIndex));
  }
}
