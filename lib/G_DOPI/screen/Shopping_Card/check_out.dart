import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  final String courseTitle;
  final String billingName;
  final String billingPhone;
  final String billingAddress;
  final double coursePrice;
  final double discount;
  final int courseCount;

  CheckoutScreen({
    Key? key,
    required this.courseTitle,
    required this.billingName,
    required this.billingPhone,
    required this.billingAddress,
    required this.coursePrice,
    required this.discount,
    required this.courseCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check Out'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (courseCount > 0)
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/mathematics.jpg',
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          courseTitle,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '\$${coursePrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            if (courseCount > 0) const SizedBox(height: 24),
            if (courseCount > 0)
              const Text(
                'Billing Information',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            if (courseCount > 0) const SizedBox(height: 8),
            if (courseCount > 0)
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        billingName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        billingPhone,
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        billingAddress,
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            if (courseCount > 0) const SizedBox(height: 24),
            if (courseCount > 0)
              const Text(
                'Order Summary',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            if (courseCount > 0) const SizedBox(height: 8),
            if (courseCount > 0)
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSummaryRow('Total Amount', coursePrice),
                      const SizedBox(height: 8),
                      _buildSummaryRow('Discount', discount),
                      const Divider(),
                      _buildSummaryRow(
                        'Grand Total',
                        coursePrice - discount,
                        isBold: true,
                      ),
                    ],
                  ),
                ),
              ),
            if (courseCount > 0) const Spacer(),
            ElevatedButton(
              onPressed: courseCount > 0
                  ? () {
                      _showPaymentPopup(context);
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: courseCount > 0 ? Colors.green : Colors.grey,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Payment',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (courseCount == 0)
              const Center(
                child: Text(
                  'No courses in your cart!',
                  style: TextStyle(fontSize: 18, color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showPaymentPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Payment Method',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildPaymentOption(
                context,
                icon: Icons.account_balance_wallet, 
                title: 'ABA PAY',
              ),
              const Divider(),
              _buildPaymentOption(
                context,
                icon: Icons.credit_card, 
                title: 'ACLEDA',
              ),
              const Divider(),
              _buildPaymentOption(
                context,
                icon: Icons.account_balance,
                title: 'Wing',
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPaymentOption(BuildContext context,
      {required IconData icon, required String title}) {
    return ListTile(
      leading: Icon(
        icon,
        size: 40,
        color: Colors.blue, 
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      onTap: () {
        Navigator.pop(context); 
        _showConfirmation(context, title);
      },
    );
  }

  void _showConfirmation(BuildContext context, String paymentMethod) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Payment Confirmation'),
          content: Text('You selected $paymentMethod. Do you want to proceed?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); 
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); 
                Navigator.pop(context); 
              },
              child: const Text('Proceed'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSummaryRow(String title, double amount, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
