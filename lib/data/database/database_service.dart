import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final FirebaseFirestore _firestore;

  DatabaseService(this._firestore);

  User? get _user => FirebaseAuth.instance.currentUser;

  var usersCollection = FirebaseFirestore.instance.collection('users');

  Stream<QuerySnapshot> getSchedulesStream() {
    return usersCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('Schedules')
        .snapshots();
  }

  Future<void> createUser(String userId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('users').doc(userId).set(data);
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  Future<void> updateUser(Map<String, dynamic> data) async {
    try {
      await _firestore.collection('users').doc(_user!.uid).update(data);
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  Future<Map<String, dynamic>?> getUser(String userId) async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(userId)
          .get();
      return doc.data() as Map<String, dynamic>?;
    } catch (e) {
      throw Exception('Failed to get user: $e');
    }
  }

  Future<void> deleteUser() async {
    try {
      await _firestore.collection('users').doc(_user!.uid).delete();
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }

  Future<void> saveSession(Map<String, dynamic> sessionData) async {
    try {
      await usersCollection
          .doc(_user!.uid)
          .collection('Sessions')
          .add(sessionData);
    } catch (e) {
      throw Exception('Failed to save session: $e');
    }
  }

  Future<void> saveSchedule(Map<String, dynamic> scheduleData) async {
    try {
      await usersCollection
          .doc(_user!.uid)
          .collection('Schedules')
          .add(scheduleData);
    } catch (e) {
      throw Exception('Failed to save schedule: $e');
    }
  }
}
