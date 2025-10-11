import 'package:flutter/material.dart';
import 'package:grocery_shop/pages/delivery_progress_page.dart';

/// Payment page with interactive credit card display
class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';

  void userTappedPay() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    
    _formKey.currentState!.save();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm payment"),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text("Card Number: $cardNumber"),
              Text("Expiry Date: $expiryDate"),
              Text("Card Holder name: $cardHolderName"),
              Text("CVV: $cvvCode"),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DeliveryProgressPage(),
                ),
              );
            },
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }

  String _formatCardNumber(String number) {
    // Remove spaces and format as groups of 4
    String cleaned = number.replaceAll(' ', '');
    String formatted = '';
    for (int i = 0; i < cleaned.length; i++) {
      if (i > 0 && i % 4 == 0) {
        formatted += ' ';
      }
      formatted += cleaned[i];
    }
    return formatted.padRight(19, '*'); // 16 digits + 3 spaces = 19 chars
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Credit Card Display
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [Color(0xFF4A5568), Color(0xFF2D3748)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Chip icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 50,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.amber[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.credit_card, color: Colors.black54),
                        ),
                        // Mastercard logo placeholder
                        Stack(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Positioned(
                              left: 15,
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.orange[400],
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    
                    // Card Number
                    Text(
                      cardNumber.isEmpty 
                          ? '**** **** **** ****' 
                          : _formatCardNumber(cardNumber),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    
                    // Expiry and Holder
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'VALID THRU',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 10,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              expiryDate.isEmpty ? '03/3' : expiryDate,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'CARD HOLDER',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 10,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              cardHolderName.isEmpty 
                                  ? 'YOUR NAME' 
                                  : cardHolderName.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Form
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Card Number',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: '2323 2323 2323 2323',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.normal,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      counterText: '',
                    ),
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black87,
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 19,
                    onChanged: (value) {
                      setState(() {
                        cardNumber = value;
                      });
                    },
                    onSaved: (v) => cardNumber = v ?? '',
                    validator: (v) => (v == null || v.replaceAll(' ', '').length < 12) 
                        ? 'Enter a valid card number' 
                        : null,
                  ),
                  
                  const SizedBox(height: 16),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Expiry Date',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: '03/3',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              keyboardType: TextInputType.datetime,
                              maxLength: 5,
                              onChanged: (value) {
                                setState(() {
                                  expiryDate = value;
                                });
                              },
                              onSaved: (v) => expiryDate = v ?? '',
                              validator: (v) => (v == null || v.trim().isEmpty) 
                                  ? 'Required' 
                                  : null,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'CVV',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: '123',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              maxLength: 3,
                              obscureText: true,
                              onChanged: (value) {
                                setState(() {
                                  cvvCode = value;
                                });
                              },
                              onSaved: (v) => cvvCode = v ?? '',
                              validator: (v) => (v == null || v.length < 3) 
                                  ? 'Required' 
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  const Text(
                    'Card Holder',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter your name',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    onChanged: (value) {
                      setState(() {
                        cardHolderName = value;
                      });
                    },
                    onSaved: (v) => cardHolderName = v ?? '',
                    validator: (v) => (v == null || v.trim().isEmpty) 
                        ? 'Enter card holder name' 
                        : null,
                  ),
                  
                  const SizedBox(height: 32),
                  
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: userTappedPay,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black87,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Pay now',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}