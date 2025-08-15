import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('educational_center.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    // جدول المدرسين
    await db.execute('''
    CREATE TABLE teachers (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      subject TEXT NOT NULL
    )
    ''');

    // جدول الطلاب
    await db.execute('''
    CREATE TABLE students (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      group_name TEXT NOT NULL,
      teacher_id INTEGER,
      FOREIGN KEY (teacher_id) REFERENCES teachers (id)
    )
    ''');

    // جدول الحضور
    await db.execute('''
    CREATE TABLE attendance (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      student_id INTEGER NOT NULL,
      date TEXT NOT NULL,
      status TEXT NOT NULL,
      FOREIGN KEY (student_id) REFERENCES students (id)
    )
    ''');

    // جدول المدفوعات
    await db.execute('''
    CREATE TABLE payments (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      student_id INTEGER NOT NULL,
      amount REAL NOT NULL,
      date TEXT NOT NULL,
      FOREIGN KEY (student_id) REFERENCES students (id)
    )
    ''');
  }

  // ------------------ عمليات المدرسين ------------------
  Future<int> addTeacher(String name, String subject) async {
    final db = await instance.database;
    return await db.insert('teachers', {
      'name': name,
      'subject': subject,
    });
  }

  Future<List<Map<String, dynamic>>> getTeachers() async {
    final db = await instance.database;
    return await db.query('teachers');
  }

  Future<int> updateTeacher(int id, String name, String subject) async {
    final db = await instance.database;
    return await db.update(
      'teachers',
      {'name': name, 'subject': subject},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteTeacher(int id) async {
    final db = await instance.database;
    return await db.delete(
      'teachers',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ------------------ عمليات الطلاب ------------------
  Future<int> addStudent(String name, String group, int teacherId) async {
    final db = await instance.database;
    return await db.insert('students', {
      'name': name,
      'group_name': group,
      'teacher_id': teacherId,
    });
  }

  Future<List<Map<String, dynamic>>> getStudents({int? teacherId}) async {
    final db = await instance.database;
    if (teacherId != null) {
      return await db.query('students',
          where: 'teacher_id = ?', whereArgs: [teacherId]);
    }
    return await db.query('students');
  }

  // ------------------ عمليات الحضور ------------------
  Future<int> markAttendance(int studentId, String date, String status) async {
    final db = await instance.database;
    return await db.insert('attendance', {
      'student_id': studentId,
      'date': date,
      'status': status,
    });
  }

  Future<List<Map<String, dynamic>>> getAttendance(int studentId) async {
    final db = await instance.database;
    return await db.query(
      'attendance',
      where: 'student_id = ?',
      whereArgs: [studentId],
    );
  }

  // ------------------ عمليات المدفوعات ------------------
  Future<int> addPayment(int studentId, double amount, String date) async {
    final db = await instance.database;
    return await db.insert('payments', {
      'student_id': studentId,
      'amount': amount,
      'date': date,
    });
  }

  Future<List<Map<String, dynamic>>> getPayments(int studentId) async {
    final db = await instance.database;
    return await db.query(
      'payments',
      where: 'student_id = ?',
      whereArgs: [studentId],
    );
  }

  // ------------------ حذف قاعدة البيانات ------------------
  Future<void> deleteDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'educational_center.db');
    await deleteDatabase(path);
  }
}
