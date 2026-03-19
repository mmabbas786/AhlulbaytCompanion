import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/theme/glass_components.dart';

class KhumsScreen extends StatefulWidget {
  const KhumsScreen({super.key});

  @override
  State<KhumsScreen> createState() => _KhumsScreenState();
}

class _KhumsScreenState extends State<KhumsScreen> {
  final TextEditingController _cashController = TextEditingController();
  final TextEditingController _savingsController = TextEditingController();
  final TextEditingController _goldController = TextEditingController();
  final TextEditingController _expensesController = TextEditingController();
  
  double _totalKhums = 0.0;
  double _sahmImam = 0.0;
  double _sahmSadat = 0.0;

  void _calculateKhums() {
    double cash = double.tryParse(_cashController.text) ?? 0;
    double savings = double.tryParse(_savingsController.text) ?? 0;
    double gold = double.tryParse(_goldController.text) ?? 0;
    double expenses = double.tryParse(_expensesController.text) ?? 0;

    double netSavings = (cash + savings + gold) - expenses;
    
    setState(() {
      if (netSavings > 0) {
        _totalKhums = netSavings * 0.20;
        _sahmImam = _totalKhums / 2;
        _sahmSadat = _totalKhums / 2;
      } else {
        _totalKhums = 0;
        _sahmImam = 0;
        _sahmSadat = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: const Text('Khums Calculator'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 1.5,
            colors: [Color(0xFF145355), AppColors.darkBackground],
            stops: [0.0, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Enter all values in your local currency.',
                  style: TextStyle(color: AppColors.textMuted, fontSize: 14),
                ),
                const SizedBox(height: 24),
                
                GlassCard(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Assets', style: TextStyle(color: AppColors.islamicGold, fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      _buildTextField('Cash in Hand/Bank', _cashController),
                      _buildTextField('Business Inventory/Savings', _savingsController),
                      _buildTextField('Unused Gold/Silver', _goldController),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                
                GlassCard(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Deductions', style: TextStyle(color: Colors.redAccent, fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      _buildTextField('Pending Debts/Expenses', _expensesController),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                
                SizedBox(
                  width: double.infinity,
                  child: GlassButton(
                    onPressed: _calculateKhums,
                    child: const Text('Calculate 20%', style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
                const SizedBox(height: 32),
                
                if (_totalKhums > 0) ...[
                  GoldGlassCard(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        const Text('Total Khums Payable', style: TextStyle(color: Colors.white, fontSize: 16)),
                        const SizedBox(height: 8),
                        Text(
                          '\$${_totalKhums.toStringAsFixed(2)}',
                          style: const TextStyle(color: AppColors.darkBackground, fontSize: 36, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 24),
                        const Divider(color: Colors.black26),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                const Text('Sahm al-Imam', style: TextStyle(color: Colors.black54, fontSize: 14)),
                                Text('\$${_sahmImam.toStringAsFixed(2)}', style: const TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w600)),
                              ],
                            ),
                            Container(width: 1, height: 40, color: Colors.black26),
                            Column(
                              children: [
                                const Text('Sahm as-Sadat', style: TextStyle(color: Colors.black54, fontSize: 14)),
                                Text('\$${_sahmSadat.toStringAsFixed(2)}', style: const TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: AppColors.textMuted),
          enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.glassBorder)),
          focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.islamicGold)),
          prefixText: '\$ ', // A dynamic currency symbol could be used here
          prefixStyle: const TextStyle(color: AppColors.islamicGold),
        ),
      ),
    );
  }
}
