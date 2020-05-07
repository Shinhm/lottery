import 'package:flutter/material.dart';
import 'package:lottery/screens/HomeScreen.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() => runApp(MyApp());

class Dog {
  final int id;
  final String name;
  final int age;

  Dog({this.id, this.name, this.age});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  // 각 dog 정보를 보기 쉽도록 print 문을 사용하여 toString을 구현하세요
  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void main() async {
    final database = openDatabase(
      // 데이터베이스 경로를 지정합니다. 참고: `path` 패키지의 `join` 함수를 사용하는 것이
      // 각 플랫폼 별로 경로가 제대로 생성됐는지 보장할 수 있는 가장 좋은 방법입니다.
      join(await getDatabasesPath(), 'doggie_database.db'),
      // 데이터베이스가 처음 생성될 때, dog를 저장하기 위한 테이블을 생성합니다.
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)",
        );
      },
      // 버전을 설정하세요. onCreate 함수에서 수행되며 데이터베이스 업그레이드와 다운그레이드를
      // 수행하기 위한 경로를 제공합니다.
      version: 1,
    );

    print(await getDatabasesPath());

    Future<void> insertDog(Dog dog) async {
      // 데이터베이스 reference를 얻습니다.
      final Database db = await database;

      // Dog를 올바른 테이블에 추가하세요. 또한
      // `conflictAlgorithm`을 명시할 것입니다. 본 예제에서는
      // 만약 동일한 dog가 여러번 추가되면, 이전 데이터를 덮어쓸 것입니다.
      await db.insert(
        'dogs',
        dog.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    Future<List<Dog>> dogs() async {
      // 데이터베이스 reference를 얻습니다.
      final Database db = await database;

      // 모든 Dog를 얻기 위해 테이블에 질의합니다.
      final List<Map<String, dynamic>> maps = await db.query('dogs');

      // List<Map<String, dynamic>를 List<Dog>으로 변환합니다.
      return List.generate(maps.length, (i) {
        return Dog(
          id: maps[i]['id'],
          name: maps[i]['name'],
          age: maps[i]['age'],
        );
      });
    }

    Future<void> updateDog(Dog dog) async {
      // 데이터베이스 reference를 얻습니다.
      final db = await database;

      // 주어진 Dog를 수정합니다.
      await db.update(
        'dogs',
        dog.toMap(),
        // Dog의 id가 일치하는 지 확인합니다.
        where: "id = ?",
        // Dog의 id를 whereArg로 넘겨 SQL injection을 방지합니다.
        whereArgs: [dog.id],
      );
    }

    Future<void> deleteDog(int id) async {
      // 데이터베이스 reference를 얻습니다.
      final db = await database;

      // 데이터베이스에서 Dog를 삭제합니다.
      await db.delete(
        'dogs',
        // 특정 dog를 제거하기 위해 `where` 절을 사용하세요
        where: "id = ?",
        // Dog의 id를 where의 인자로 넘겨 SQL injection을 방지합니다.
        whereArgs: [id],
      );
    }

    var fido = Dog(
      id: 0,
      name: 'Fido',
      age: 35,
    );

    // 데이터베이스에 dog를 추가합니다.
    await insertDog(fido);

    // dog 목록을 출력합니다. (지금은 Fido만 존재합니다.)
    print(await dogs());

    // Fido의 나이를 수정한 뒤 데이터베이스에 저장합니다.
    fido = Dog(
      id: fido.id,
      name: fido.name,
      age: fido.age + 7,
    );
    await updateDog(fido);

    // Fido의 수정된 정보를 출력합니다.
    print(await dogs());

    // Fido를 데이터베이스에서 제거합니다.
//    await deleteDog(fido.id);

    // dog 목록을 출력합니다. (비어있습니다.)
    print(await dogs());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'lottery-app',
      home: HomeScreen(),
      theme: ThemeData(
        primaryColor: Color.fromRGBO(236, 234, 234, 1),
        accentColor: Colors.cyan[600],
        scaffoldBackgroundColor: Color.fromRGBO(236, 234, 234, 1),
        // Define the default font family.
        fontFamily: 'SpoqaHanSans',
        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          body1: TextStyle(
              fontSize: 14.0,
              fontFamily: 'Hind',
              color: Color.fromRGBO(31, 26, 29, 1)),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
    );
  }
}
