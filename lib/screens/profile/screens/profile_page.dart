import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Controllers for editable fields
  final nameController = TextEditingController(text: 'Anusha K S');
  final emailController = TextEditingController(text: 'anusha@example.com');
  final phoneController = TextEditingController(text: '9876543210');
  final locationController = TextEditingController(text: 'USA');

  String? _userName;       // will hold the loaded user_name
  File? _profileImage;     // for the picked image
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadUserName();       // fetch user_name from SharedPreferences
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('user_name') ?? 'Guest';
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() => _profileImage = File(pickedFile.path));
    }
  }

  void _showImageSourcePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
              icon: const Icon(Icons.camera_alt),
              label: const Text("Camera"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
              icon: const Icon(Icons.photo_library),
              label: const Text("Gallery"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            ),
          ],
        ),
      ),
    );
  }

  void _saveDetails() {
    ScaffoldMessenger.of(context)
      .showSnackBar(const SnackBar(content: Text('Profile updated!')));
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();                    // remove all stored keys
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Card(
          elevation: 8,
          color: Colors.grey.shade900,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Profile image + edit icon
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : const AssetImage('assets/profile/ppanu.jpg')
                                as ImageProvider,
                      ),
                      GestureDetector(
                        onTap: _showImageSourcePicker,
                        child: const CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.white,
                          child:
                              Icon(Icons.edit, size: 14, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Dynamic welcome message
                  Text(
                    'Welcome ${_userName ?? ''}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.tealAccent,
                    ),
                  ),

                  const SizedBox(height: 8),
                  // Static email display (or you can load email similarly)
                  Text(
                    emailController.text,
                    style: const TextStyle(color: Colors.grey),
                  ),

                  const Divider(height: 30, color: Colors.grey),

                  // Editable fields
                  _buildEditableField('Name', nameController),
                  _buildEditableField('Email', emailController),
                  _buildEditableField('Mobile Number', phoneController),
                  _buildEditableField('Location', locationController),

                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _saveDetails,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Save Changes'),
                  ),

                  const SizedBox(height: 30),
                  const Divider(height: 20, color: Colors.grey),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Your Orders',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildOrderTile('Order #1234', 'Delivered on April 10, 2025'),
                  _buildOrderTile('Order #5678', 'Shipped - Expected Apr 22'),

                  const Divider(height: 30, color: Colors.grey),
                  TextButton.icon(
                    onPressed: _logout,
                    icon: const Icon(Icons.logout, color: Colors.red),
                    label: const Text('Logout'),
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEditableField(
      String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.teal),
          ),
        ),
      ),
    );
  }

  Widget _buildOrderTile(String title, String subtitle) {
    return ListTile(
      leading: const Icon(Icons.shopping_bag, color: Colors.teal),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: () {},
    );
  }
}
