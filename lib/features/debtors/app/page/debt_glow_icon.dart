import 'package:dukka_finance/features/debtors/models/debt.dart';
import 'package:flutter/material.dart';

/// The reusable widget button used for the App Wide Navigation
/// Can be called on differnt pages for easy navigation

class DebtGlowIcon extends StatefulWidget {
  final Debt debt;
  const DebtGlowIcon({
    Key? key,
    required this.debt,
  }) : super(key: key);

  @override
  State<DebtGlowIcon> createState() => _DebtGlowIconState();
}

class _DebtGlowIconState extends State<DebtGlowIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController iconGlowController;
  late Animation<double> animation;

  Color _determineColor() {
    //
    final totalDays =
        widget.debt.dueDate.difference(widget.debt.date).inDays + 1;
    final daysElapsed = DateTime.now().difference(widget.debt.date).inDays + 1;
    final fraction = daysElapsed / totalDays;

    if (widget.debt.isPaid) {
      return Colors.blue;
    } else if (fraction < 0.3) {
      return Colors.green;
    } else if (0.6 > fraction && fraction > 0.3) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }

  @override
  void initState() {
    super.initState();
    iconGlowController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
      animationBehavior: AnimationBehavior.normal,
    );

    animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: iconGlowController, curve: Curves.bounceIn))
      ..addListener(() {
        setState(() {});
      });
    iconGlowController.repeat(reverse: true);
  }

  @override
  void dispose() {
    iconGlowController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: 50.0,
      decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
        BoxShadow(
            color: _determineColor(),
            blurRadius: 30 * animation.value,
            spreadRadius: 30 * animation.value)
      ]),
      child: const Icon(
        Icons.light,
        size: 50,
      ),
    );
  }
}
