import 'package:flutter/material.dart';
import 'edit_address_view.dart';

class ShippingAddressView extends StatefulWidget {
  const ShippingAddressView({super.key});
  static const routeName = '/shipping-address';

  @override
  State<ShippingAddressView> createState() => _ShippingAddressViewState();
}

class _ShippingAddressViewState extends State<ShippingAddressView> {
  // Dummy Address
  String fullName = 'Your Notice Name';
  String phone = '+970 59 000 0000';
  String street = 'Al-Quds St, Building 10';
  String city = 'Hebron';
  String country = 'Palestine';
  String zip = '00000';

  Future<void> _edit() async {
    final result = await Navigator.pushNamed(
      context,
      EditAddressView.routeName,
      arguments: {
        'fullName': fullName,
        'phone': phone,
        'street': street,
        'city': city,
        'country': country,
        'zip': zip,
      },
    );

    if (result is Map) {
      setState(() {
        fullName = result['fullName'] ?? fullName;
        phone = result['phone'] ?? phone;
        street = result['street'] ?? street;
        city = result['city'] ?? city;
        country = result['country'] ?? country;
        zip = result['zip'] ?? zip;
      });
    }
  }

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFEDEDED)),
        boxShadow: const [
          BoxShadow(
            blurRadius: 18,
            offset: Offset(0, 10),
            color: Color(0x14000000),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _row(String k, String v) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(k, style: const TextStyle(color: Colors.black54)),
          ),
          Expanded(
            child: Text(
              v,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Shipping Address'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _edit,
            child: const Text(
              'Edit',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Default Address',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
              const SizedBox(height: 12),
              _row('Name', fullName),
              _row('Phone', phone),
              _row('Street', street),
              _row('City', city),
              _row('Country', country),
              _row('ZIP', zip),
            ],
          ),
        ),
      ),
    );
  }
}
