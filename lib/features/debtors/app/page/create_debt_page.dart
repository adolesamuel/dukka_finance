import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateDebtPage extends StatefulWidget {
  const CreateDebtPage({super.key});

  @override
  State<CreateDebtPage> createState() => _CreateDebtPageState();
}

class _CreateDebtPageState extends State<CreateDebtPage> {
  final _formKey = GlobalKey<FormState>();

  final space = SizedBox(
    height: 30.0.h,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Debt')),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
