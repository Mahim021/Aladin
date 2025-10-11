import 'package:flutter/material.dart';

/// Simple payment stub page. The project previously contained duplicate
/// definitions and references to an external credit-card package.
/// This file provides a minimal payment form without extra dependencies.
class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String expiry = '';
  String cvv = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Card number'),
                keyboardType: TextInputType.number,
                onSaved: (v) => cardNumber = v ?? '',
                validator: (v) => (v == null || v.trim().length < 12) ? 'Enter a valid card number' : null,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'MM/YY'),
                      keyboardType: TextInputType.datetime,
                      onSaved: (v) => expiry = v ?? '',
                      validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter expiry' : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 120,
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'CVV'),
                      keyboardType: TextInputType.number,
                      onSaved: (v) => cvv = v ?? '',
                      validator: (v) => (v == null || v.trim().length < 3) ? 'Enter CVV' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final ok = _formKey.currentState?.validate() ?? false;
                        if (!ok) return;
                        _formKey.currentState?.save();
                        // This is a stub. Integrate a real payment gateway here.
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment submitted (stub)')));
                        Navigator.pop(context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        child: Text('Pay'),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}