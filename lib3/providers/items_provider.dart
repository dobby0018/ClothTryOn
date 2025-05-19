import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../utils/helpers/helper_functions.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  User? _currentUser;
  String? _errorMessage;

  // Getters
  bool get isLoading => _isLoading;
  User? get currentUser => _currentUser;
  String? get errorMessage => _errorMessage;

  // Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Signup method
  Future<void> signup(User user) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final response = await _authService.registerUser(user);

      if (response['success'] == true) {
        _currentUser = user;
        THelperFunctions.showSnackBar(response['message']);
      } else {
        _errorMessage = response['message'];
        THelperFunctions.showSnackBar(response['message']);
      }
    } catch (e) {
      _errorMessage = 'Failed to connect to server';
      THelperFunctions.showSnackBar('Connection error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add other auth methods (login, logout, etc.) here
}
