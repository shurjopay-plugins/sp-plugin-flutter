import 'package:flutter/material.dart';
import 'package:shurjopay/models/payment_verification_model.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final ShurjopayVerificationModel verification;

  const PaymentSuccessScreen({super.key, required this.verification});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Payment Successful", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 80),
                  const SizedBox(height: 8),
                  const Text(
                    "Payment Verified!",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    verification.spMessage ?? "Transaction successful",
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildSection("SP Details", [
              _buildRow("SP Code", verification.spCode),
              _buildRow("SP Message", verification.spMessage),
              _buildRow("Transaction Status", verification.transactionStatus),
              _buildRow("Bank Status", verification.bankStatus),
            ]),
            _buildSection("Order Info", [
              _buildRow("Order ID", verification.orderId),
              _buildRow("Customer Order ID", verification.customerOrderId),
              _buildRow("Invoice No", verification.invoiceNo),
              _buildRow("Bank Trx ID", verification.bankTrxId),
              _buildRow("Method", verification.method),
              _buildRow("Date & Time", verification.dateTime),
            ]),
            _buildSection("Payment Details", [
              _buildRow("Currency", verification.currency),
              _buildRow("Amount", verification.amount),
              _buildRow("Payable Amount", verification.payableAmount),
              _buildRow("Received Amount", verification.receivedAmount),
              _buildRow("Discount Amount", verification.discsountAmount),
              _buildRow("Discount %", verification.discPercent?.toString()),
              _buildRow("USD Amount", verification.usdAmt),
              _buildRow("USD Rate", verification.usdRate?.toString()),
            ]),
            _buildSection("Customer Details", [
              _buildRow("Name", verification.name),
              _buildRow("Email", verification.email),
              _buildRow("Phone", verification.phoneNo),
              _buildRow("Address", verification.address),
              _buildRow("City", verification.city),
            ]),
            _buildSection("Card Details", [
              _buildRow("Card Holder", verification.cardHolderName),
              _buildRow("Card Number", verification.cardNumber),
            ]),
            if (_hasValues(verification))
              _buildSection("Extra Values", [
                _buildRow("Value 1", verification.value1),
                _buildRow("Value 2", verification.value2),
                _buildRow("Value 3", verification.value3),
                _buildRow("Value 4", verification.value4),
              ]),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text("Done", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  bool _hasValues(ShurjopayVerificationModel v) {
    return (v.value1 != null && v.value1!.isNotEmpty) ||
        (v.value2 != null && v.value2!.isNotEmpty) ||
        (v.value3 != null && v.value3!.isNotEmpty) ||
        (v.value4 != null && v.value4!.isNotEmpty);
  }

  Widget _buildSection(String title, List<Widget> rows) {
    final visible = rows.whereType<_InfoRow>().where((r) => r.value != null && r.value!.isNotEmpty).toList();
    if (visible.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8),
            border: const Border(left: BorderSide(color: Colors.green, width: 4)),
          ),
          child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.green)),
        ),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(children: rows),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildRow(String label, String? value) {
    return _InfoRow(label: label, value: value);
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String? value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    if (value == null || value!.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value!,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
