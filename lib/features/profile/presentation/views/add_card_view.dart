import 'package:flutter/material.dart';

class AddCardView extends StatefulWidget {
  const AddCardView({super.key});
  static const routeName = '/add-card';

  @override
  State<AddCardView> createState() => _AddCardViewState();
}

class _AddCardViewState extends State<AddCardView> {
  final _formKey = GlobalKey<FormState>();

  final brand = TextEditingController(text: 'VISA');
  final number = TextEditingController();
  final exp = TextEditingController(text: '12/28');
  final cvv = TextEditingController();

  @override
  void dispose() {
    brand.dispose();
    number.dispose();
    exp.dispose();
    cvv.dispose();
    super.dispose();
  }

  InputDecoration _dec(String label) => InputDecoration(
        labelText: label,
        filled: true,
        fillColor: const Color(0xFFF3F3F3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      );

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final last4 = number.text.trim().replaceAll(' ', '');
    final safeLast4 = last4.length >= 4 ? last4.substring(last4.length - 4) : last4;

    Navigator.pop(context, {
      'brand': brand.text.trim(),
      'last4': safeLast4,
      'exp': exp.text.trim(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Add Card'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: brand,
                decoration: _dec('Brand (VISA/MasterCard)'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: number,
                decoration: _dec('Card Number'),
                keyboardType: TextInputType.number,
                validator: (v) =>
                    (v == null || v.trim().length < 4) ? 'Enter number' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: exp,
                decoration: _dec('Expiry (MM/YY)'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: cvv,
                decoration: _dec('CVV'),
                keyboardType: TextInputType.number,
                obscureText: true,
                validator: (v) =>
                    (v == null || v.trim().length < 3) ? 'Invalid' : null,
              ),
              const SizedBox(height: 18),
              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text('Save',
                      style: TextStyle(fontWeight: FontWeight.w800)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
