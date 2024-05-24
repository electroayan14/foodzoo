import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodzoo/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:foodzoo/features/utils/enums/enums.dart';
import 'package:foodzoo/routes/constants.dart';

import 'model/food_model.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    List<Categories> foodCategories = [];
    List<Categories> categories = [];
    getPosts(context, '', []);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Dashboard"),
      ),
      body:
          dashboardView(context, searchController, foodCategories, categories),
    );
  }

  Widget dashboardView(context, TextEditingController? searchController,
      List<Categories> foodCategories, List<Categories> categories) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextFormField(
            controller: searchController,
            onChanged: (value) => {
              if (value.isNotEmpty)
                {
                  print("foodModelListLength!! ${foodCategories.length}"),
                  getPosts(context, value, foodCategories)
                }
              else
                getPosts(context, 'no value', foodCategories)
            },
            decoration: const InputDecoration(
              hintText: "Search....",
              labelText: 'Search',
              border: OutlineInputBorder(),
            ),
            style: const TextStyle(color: Colors.black),
          ),
          const SizedBox(height: 12.0),
          BlocConsumer<DashboardBloc, FoodDashboardState>(
            listener: (context, state) {
              switch (state.stateStatus) {
                case StateStatus.loading:
                // TODO: Handle this case.
                case StateStatus.success:
                  state.foodModel?.categories?.forEach((element) {
                    categories.add(element);
                  });
                case StateStatus.failed:
                // TODO: Handle this case.
              }
            },
            builder: (context, state) {
              switch (state.stateStatus) {
                case StateStatus.loading:
                  return const CircularProgressIndicator(
                      color: Colors.cyanAccent);
                case StateStatus.success:
                  if (foodCategories.isEmpty) {
                    foodCategories.addAll(categories);
                  }
                  checkSearchResult(searchController, state.searchQuery,
                      state.categories ?? [], categories ?? []);
                  print("objectLength!!!${state.categories?.length}");
                  return categories.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: categories.length,
                            itemBuilder: (BuildContext context, int index) {
                              var productIndex = categories[index];
                              return GestureDetector(
                                onTap: () => Navigator.pushNamed(context, meals,
                                    arguments:
                                        productIndex.strCategory.toString()),
                                child: Card(
                                    color: Theme.of(context).indicatorColor,
                                    child: ListTile(
                                        title: Text(
                                          '${productIndex.strCategory}',
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        subtitle: SizedBox(
                                          height: 80.0,
                                          child: Text(
                                            '${productIndex.strCategoryDescription}',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        ),
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              productIndex.strCategoryThumb ??
                                                  ''),
                                        ))),
                              );
                            },
                          ),
                        )
                      : Center(child: Text(state.message.toString()));
                case StateStatus.failed:
                  return const Center(child: Text("Error fetching data"));
              }
            },
          ),
        ],
      ),
    );
  }

  checkSearchResult(searchController, query, List<Categories> foodCategories,
      List<Categories> categories) {
    if (searchController.text.isNotEmpty) {
      categories.clear();
      categories.addAll(foodCategories);
    } else if (query == 'no value') {
      categories.clear();
      categories.addAll(foodCategories);
    }
  }

  getPosts(context, query, List<Categories>? categories) {
    BlocProvider.of<DashboardBloc>(context)
        .add(FetchPost(query, categories ?? []));
  }
}
