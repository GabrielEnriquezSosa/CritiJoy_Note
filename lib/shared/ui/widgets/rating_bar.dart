import 'package:critijoy_note/shared/core/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RatingBar extends ConsumerStatefulWidget {
  final double initialRating;
  final void Function(double rating)? onRatingChanged;
  final int maxRating;

  const RatingBar({
    super.key,
    this.initialRating = 0.0,
    this.onRatingChanged,
    this.maxRating = 5,
  });

  @override
  ConsumerState<RatingBar> createState() => _RatingBarState();
}

class _RatingBarState extends ConsumerState<RatingBar> {
  late double _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(isDarkModeProvider);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.maxRating, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _currentRating = index + 1.0;
            });
            if (widget.onRatingChanged != null) {
              widget.onRatingChanged!(_currentRating);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Icon(
              Icons.star,
              color:
                  index < _currentRating
                      ? Colors.lightBlue
                      : isDarkMode
                      ? Colors.white24
                      : Colors.lightBlue.withOpacity(0.2),
              size: 32,
            ),
          ),
        );
      }),
    );
  }
}
