import 'package:central_perk/models/recipe.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class RecipeDatabase {
  static final RecipeDatabase instance = RecipeDatabase._init();
  static Database? _database;

  RecipeDatabase._init();

  // Get database or initialize if there is no database.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('recetas.db');
    return _database!;
  }

  // Initialize database.
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // Create database.
  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE recipes (
        id $idType,
        name $textType,
        description $textType,
        image $textType
        )
    ''');
  }

  // Add recipe to database.
  Future<Recipe> createRecipe(Recipe recipe) async {
    final db = await instance.database;
    final id = await db.insert('recipes', recipe.toMap());
    return recipe.copy(id: id);
  }

  // Search for a recipe and convert from JSON to Recipe.
  Future<Recipe> readRecipe(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      'recipes',
      columns: ['id', 'name', 'description', 'image'],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Recipe.fromMap(maps.first);
    } else {
      throw Exception('ID $id no encontrado');
    }
  }

  // Convert recipes JSON file to list of recipes.
  Future<List<Recipe>> readAllRecipes() async {
    final db = await instance.database;

    final result = await db.query('recipes');

    return result.map((json) => Recipe.fromMap(json)).toList();
  }

  // Update recipe in database.
  Future<int> updateRecipe(Recipe recipe) async {
    final db = await instance.database;

    return db.update(
      'recipes',
      recipe.toMap(),
      where: 'id = ?',
      whereArgs: [recipe.id],
    );
  }

  // Delete an specific recipe from database.
  Future<int> deleteRecipe(int id) async {
    final db = await instance.database;

    return db.delete(
      'recipes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete all data in database.
  Future<int> clearDatabase() async {
    final db = await instance.database;
    return db.delete('recipes');
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
