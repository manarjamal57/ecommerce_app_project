import 'package:flutter/material.dart';

class EditAddressView extends StatefulWidget {
  const EditAddressView({super.key});
  static const routeName = '/edit-address';

  @override
  State<EditAddressView> createState() => _EditAddressViewState();
}

class _EditAddressViewState extends State<EditAddressView> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController fullName;
  late final TextEditingController phone;
  late final TextEditingController street;
  late final TextEditingController city;
  late final TextEditingController country;
  late final TextEditingController zip;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = (ModalRoute.of(context)?.settings.arguments as Map?) ?? {};

    fullName = TextEditingController(text: (args['fullName'] ?? '').toString());
    phone = TextEditingController(text: (args['phone'] ?? '').toString());
    street = TextEditingController(text: (args['street'] ?? '').toString());
    city = TextEditingController(text: (args['city'] ?? '').toString());
    country = TextEditingController(text: (args['country'] ?? '').toString());
    zip = TextEditingController(text: (args['zip'] ?? '').toString());
  }

  @override
  void dispose() {
    fullName.dispose();
    phone.dispose();
    street.dispose();
    city.dispose();
    country.dispose();
    zip.dispose();
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

    Navigator.pop(context, {
      'fullName': fullName.text.trim(),
      'phone': phone.text.trim(),
      'street': street.text.trim(),
      'city': city.text.trim(),
      'country': country.text.trim(),
      'zip': zip.text.trim(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Edit Address'),
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
                controller: fullName,
                decoration: _dec('Full Name'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: phone,
                decoration: _dec('Phone'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: street,
                decoration: _dec('Street'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: city,
                decoration: _dec('City'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: country,
                decoration: _dec('Country'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: zip,
                decoration: _dec('ZIP'),
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
