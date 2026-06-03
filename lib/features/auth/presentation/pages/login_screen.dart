import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../routes/app_router.dart';
import '../../../../services/mock_data_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  final _cityController = TextEditingController();
  String? _selectedState;
  bool _isOtpSent = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _nameController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  void _sendOtp() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isOtpSent = true);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('OTP sent to your phone')));
    }
  }

  void _verifyOtp() {
    if (_formKey.currentState!.validate()) {
      context.go(Routes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login'), elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Welcome to AnimalMandi', style: TextStyle(fontFamily: 'Poppins', fontSize: 24, fontWeight: FontWeight.w700, color: Color(0xFF1F1F1F))),
              const SizedBox(height: 8),
              const Text('Sign in with your phone number', style: TextStyle(fontFamily: 'Poppins', fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF757575))),
              const SizedBox(height: 32),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Phone Number', prefixText: '+91 ', hintText: '10 digit mobile number'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter phone number';
                  if (value.length != 10) return 'Enter valid 10 digit number';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Full Name', hintText: 'Enter your full name'),
                validator: (value) => (value?.isEmpty ?? true) ? 'Please enter your name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(labelText: 'City', hintText: 'Enter your city'),
                validator: (value) => (value?.isEmpty ?? true) ? 'Please enter your city' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedState,
                decoration: const InputDecoration(labelText: 'State', hintText: 'Select your state'),
                items: MockDataService.indianStates.map((state) => DropdownMenuItem(value: state, child: Text(state))).toList(),
                onChanged: (value) => setState(() => _selectedState = value),
                validator: (value) => (value == null) ? 'Please select your state' : null,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isOtpSent ? _verifyOtp : _sendOtp,
                  child: Text(_isOtpSent ? 'Verify OTP' : 'Send OTP'),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.g_mobiledata),
                  label: const Text('Continue with Google'),
                  onPressed: () => context.go(Routes.home),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}