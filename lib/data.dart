// Class stores a dictionary of all the recipes, with the Recipe ID as the key
// and Recipe Title and Image URL as the values
class Recipes {
  Map<String, List<String>> recipes;

  Recipes({
    required this.recipes,
  });

  // Returns all the stored recipes
  getRecipes() {
    return recipes;
  }

  // Stores the JSON response from HTTP GET Request as a dictionary entry
  factory Recipes.fromJson(List<dynamic> json) {
    Map<String, List<String>> recipes = {};
    for (int i = 0; i < json.length; i++) {
      recipes['${json[i]['id']}'] = [
        json[i]['title'],
        json[i]['image'][0]['url']
      ];
    }
    return Recipes(recipes: recipes);
  }
}
