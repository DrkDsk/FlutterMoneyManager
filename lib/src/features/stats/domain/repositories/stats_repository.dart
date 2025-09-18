import 'package:dartz/dartz.dart';
import 'package:flutter_money_manager/src/core/error/failure/failure.dart';
import 'package:flutter_money_manager/src/features/stats/domain/entities/stat_response.dart';

abstract interface class StatsRepository {
  Future<Either<Failure, StatResponse>> getStatMonth({int? year, int? month});
}
