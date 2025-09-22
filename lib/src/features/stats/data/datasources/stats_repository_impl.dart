import 'package:dartz/dartz.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';
import 'package:flutter_money_manager/src/core/error/exceptions/unknown_exception.dart';
import 'package:flutter_money_manager/src/core/error/failure/failure.dart';
import 'package:flutter_money_manager/src/features/financial_summary/data/models/financial_summary_model.dart';
import 'package:flutter_money_manager/src/features/stats/domain/entities/stat_response.dart';
import 'package:flutter_money_manager/src/features/stats/domain/repositories/stats_repository.dart';
import 'package:flutter_money_manager/src/features/stats/domain/services/stat_service.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/services/financial_calculator_service.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/services/transaction_service.dart';

class StatsRepositoryImpl implements StatsRepository {
  final TransactionService _transactionService;
  final StatService _statService;

  StatsRepositoryImpl(
      {required TransactionService transactionService,
      required StatService statService})
      : _transactionService = transactionService,
        _statService = statService;

  @override
  Future<Either<Failure, StatResponse>> getStatMonth(
      {required TransactionTypEnum type, int? year, int? month}) async {
    try {
      final now = DateTime.now();
      year = year ?? now.year;
      month = month ?? now.month;

      final transactionsMonth = await _transactionService.getTransactionsMonth(
          year: year, month: month);

      if (transactionsMonth.isEmpty) {
        return const Right(StatResponse(stats: []));
      }

      final transactions =
          transactionsMonth.map((model) => model.toEntity()).toList();

      final summary = FinancialCalculatorService.getFinancialSummary(
          transactions: transactions);

      final summaryModel = FinancialSummaryModel.fromEntity(summary);

      final breakdown = _statService.calculateBreakdown(
          transactionsMonth, summaryModel, type);

      return Right(StatResponse(stats: breakdown));
    } on UnknownException catch (_) {
      return Left(GenericFailure());
    } catch (error) {
      return Left(GenericFailure());
    }
  }
}
