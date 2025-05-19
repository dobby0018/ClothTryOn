import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../services/api_service.dart';
import './utils/constants/sizes.dart';
import './utils/constants/text_strings.dart';
import './utils/helpers/helper_functions.dart';
import './utils/validators/validation.dart';
import 'package:iconsax/iconsax.dart';
import './login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authService = ApiService();
  bool _isLoading = false;
  bool _termsAccepted = false;
  bool _registrationSuccess = false;
  User? _registeredUser;
  String _userType = 'user';

  // Controllers
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_termsAccepted) {
      THelperFunctions.showSnackBar('Please accept terms & conditions');
      return;
    }

    setState(() => _isLoading = true);

    final user = User(
      id: '',
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      username: _usernameController.text.trim(),
      email: _emailController.text.trim(),
      phoneNo: _phoneController.text.trim(),
      password: _passwordController.text.trim(),
      userType: _userType,
    );

    try {
      final response = await _authService.registerUser(user);

      setState(() => _isLoading = false);

      if (response['success'] ?? false) {
        // On success, navigate directly to login page
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        THelperFunctions.showSnackBar(
          response['message'] ?? 'Registration failed',
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      THelperFunctions.showSnackBar('Registration failed: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: TSizes.appBarHeight,
            left: TSizes.defaultSpace,
            bottom: TSizes.defaultSpace,
            right: TSizes.defaultSpace,
          ),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                Text(
                  TTexts.signupTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: TSizes.sm),

                // Form Fields
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _firstNameController,
                            validator: TValidator.validateEmptyText,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Iconsax.user),
                              labelText: TTexts.firstName,
                            ),
                          ),
                        ),
                        const SizedBox(width: TSizes.spaceBtwInputFields),
                        Expanded(
                          child: TextFormField(
                            controller: _lastNameController,
                            validator: TValidator.validateEmptyText,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Iconsax.user),
                              labelText: TTexts.lastName,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    TextFormField(
                      controller: _usernameController,
                      validator: TValidator.validateEmptyText,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.user_edit),
                        labelText: TTexts.username,
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Account Type',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: RadioListTile<String>(
                                title: const Text('User'),
                                value: 'user',
                                groupValue: _userType,
                                onChanged:
                                    (value) => setState(() => _userType = value!),
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<String>(
                                title: const Text('Admin'),
                                value: 'admin',
                                groupValue: _userType,
                                onChanged:
                                    (value) => setState(() => _userType = value!),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    TextFormField(
                      controller: _emailController,
                      validator: TValidator.validateEmail,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.direct),
                        labelText: TTexts.email,
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    TextFormField(
                      controller: _phoneController,
                      validator: TValidator.validatePhoneNumber,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.call),
                        labelText: TTexts.phoneNo,
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      validator: TValidator.validatePassword,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.password_check),
                        labelText: TTexts.password,
                        suffixIcon: Icon(Iconsax.eye_slash),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),

                    Row(
                      children: [
                        Checkbox(
                          value: _termsAccepted,
                          onChanged:
                              (value) => setState(
                                () => _termsAccepted = value ?? false,
                              ),
                        ),
                        const SizedBox(width: TSizes.spaceBtwItems),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${TTexts.agreeTo} ',
                                  style:
                                      Theme.of(context).textTheme.bodySmall,
                                ),
                                TextSpan(
                                  text: TTexts.privacyPolicy,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodySmall!.copyWith(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                const TextSpan(text: ' and '),
                                TextSpan(
                                  text: TTexts.termsOfUse,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodySmall!.copyWith(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _submitForm,
                        child: _isLoading
                            ? const CircularProgressIndicator()
                            : const Text(TTexts.createAccount),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwItems / 2),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: TSizes.spaceBtwItems),
          Expanded(child: Text(value ?? '')),   
        ],
      ),
    );
  }
}
