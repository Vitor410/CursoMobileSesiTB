import 'package:flutter/material.dart';
import '../services/company_service.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

class CompanySelectionScreen extends StatefulWidget {
  const CompanySelectionScreen({super.key});

  @override
  _CompanySelectionScreenState createState() => _CompanySelectionScreenState();
}

class _CompanySelectionScreenState extends State<CompanySelectionScreen> {
  final CompanyService _companyService = CompanyService();
  final AuthService _authService = AuthService();
  List<Company> _companies = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCompanies();
  }

  Future<void> _loadCompanies() async {
    List<Company> companies = await _companyService.getCompanies();
    setState(() {
      _companies = companies;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Company'),
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: _logout),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _companies.length,
              itemBuilder: (context, index) {
                Company company = _companies[index];
                return ListTile(
                  title: Text(company.name),
                  subtitle: Text(
                    'Lat: ${company.latitude}, Lon: ${company.longitude}',
                  ),
                  onTap: () => _selectCompany(company),
                );
              },
            ),
    );
  }

  void _selectCompany(Company company) async {
    // For now, just navigate to login with company selected
    // In a real app, you might store selected company temporarily
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  void _logout() async {
    await _authService.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }
}
