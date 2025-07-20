import 'package:critijoy_note/domain/entities/review.dart';
import 'package:critijoy_note/providers/review_controller.dart';
import 'package:critijoy_note/providers/usecases_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reviewControllerProvider =
    StateNotifierProvider<ReviewController, AsyncValue<List<Review>>>(
      (ref) => ReviewController(ref.watch(getReviewsByTypeProvider)),
    );
