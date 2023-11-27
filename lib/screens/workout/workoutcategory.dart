import 'package:fitnessapplication/database/workoutdb/workoutmodel.dart';
import 'package:fitnessapplication/screens/workout/exercises.dart';
import 'package:fitnessapplication/screens/workout/functionsforworkout.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryScrn extends StatefulWidget {
  const CategoryScrn({super.key});

  @override
  State<CategoryScrn> createState() => _CategoryScrnState();
}

class _CategoryScrnState extends State<CategoryScrn> {
  List<CategoryModel> categories = [];
  int pageindex = 1;
  List<CategoryModel> predefinedCategories = [];
  TextEditingController categoryNameController = TextEditingController();
  @override
  void initState() {
    loadCategories();
    super.initState();
  }

//function to load the categories and join the predifined categories and user defined categories
  Future<void> loadCategories() async {
    predefinedCategories = [
      CategoryModel(name: "CHEST", categoryKey:'1'),
      CategoryModel(name: "TRICEPS", categoryKey:'2'),
      CategoryModel(name: "BACK", categoryKey: '3'),
      CategoryModel(name: "BICEPS", categoryKey: '4'),
      CategoryModel(name: "SHOULDERS", categoryKey:'5'),
      CategoryModel(name: "LEGS", categoryKey: '6'),
    ];
    // get the categories which are made by user
    final userdefinedcategoryList = await getCategories();
    // saving the predifined and user defined into a single category
    setState(() {
      categories = [
        ...userdefinedcategoryList,
        ...predefinedCategories,
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Workout Categories',
            style: GoogleFonts.openSans(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            )),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      // to add new category
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: screenWidth * .12),
        child: FloatingActionButton(
          onPressed: () {
            // function to show a dialouguebox to save the new category
            showCategoryDialog();
          },
          child: const Icon(Icons.add),
        ),
      ),
      body: Container(
        color: Colors.white,
        // builder to add new categories
        child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            // saving the current category which is on the index build it
            final category = categories.toList()[index];
            // checking if the category is predefined
            final isPredefined = predefinedCategories.contains(category);
            return Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 234, 232, 237),
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 214, 208, 225),
                    Color.fromARGB(255, 205, 188, 237)
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade400,
                        offset: const Offset(2.0, 2.0),
                        blurRadius: 10,
                        spreadRadius: 1),
                    BoxShadow(
                        color: Colors.grey.shade400,
                        offset: const Offset(-2.0, -2.0),
                        blurRadius: 10,
                        spreadRadius: 1),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * .035),
                  child: ListTile(
                    title: Text(
                      category.name.toUpperCase(),
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * .045,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: isPredefined
                        ? null
                        // No edit/delete buttons for predefined categories as its not editable
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  // to edit a category
                                  editCategory(category, index);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  // to delete a  category
                                  deleteCategory(category,category.categoryKey??'');
                                  loadCategories();
                                },
                              ),
                            ],
                          ),
                    onTap: () {
                      // after creating a category when we touch that category we have to go the exercise screen of that category
                      navigateToExercisesScreen(category);
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  //functions

//to show the a showdialougue to add a new category
  void showCategoryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: categoryNameController,
                decoration: const InputDecoration(labelText: 'Category Name'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // to cancel and to clear the name in the  controller
                Navigator.of(context).pop();
                categoryNameController.clear();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // to save the new category after pressing yes
                String categoryName = categoryNameController.text;
                if (categoryName.isNotEmpty) {
                  addCategory(CategoryModel(name: categoryName));
                  Navigator.of(context).pop();
                  categoryNameController.clear();
                  loadCategories();
                  print(categories);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

// to show  a show dialougue to to edit the category name
  void editCategory(CategoryModel category, int index) {
    // asigning category name to a variable
    String newName = category.name;
    String categoryKey = category.categoryKey.toString();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  newName = value;
                },
                decoration: const InputDecoration(labelText: 'Category Name'),
                controller: TextEditingController(text: category.name),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (newName.isNotEmpty) {
                  // to update the name of category and also the passing the category key .
                  CategoryModel updatedCategory = CategoryModel(
                      name: newName, categoryKey: category.categoryKey);
                  updateCategory(updatedCategory, index,categoryKey);
                  loadCategories();
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

// navigate to exercise screen after pressing a category
  void navigateToExercisesScreen(CategoryModel category) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ExerciseListScreen(
        category: category,
      ),
    ));
  }
}
