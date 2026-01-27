import 'package:bodyflow/data/repos/workout_repo.dart';
import 'package:bodyflow/domain/models/session.dart';
import 'package:bodyflow/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SessionViewModel extends ChangeNotifier {
  final Session session;
  final WorkoutRepo repo;
  SessionViewModel({required this.session, required this.repo});

  bool isLoading = false;

  Future<void> deleteSession(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Session'),
          content: Text('Are you sure you want to delete this session?'),
          actions: [
            TextButton(
              onPressed: () async {
                await repo.deleteSession(session.id);
                isLoading = false;
                notifyListeners();
                if (context.mounted) context.go(Routes.home);
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                isLoading = false;
                notifyListeners();
                if (context.mounted) context.pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
