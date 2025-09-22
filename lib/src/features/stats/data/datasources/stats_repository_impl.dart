import 'package:dartz/dartz.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';
import 'package:flutter_money_manager/src/core/error/exceptions/unknown_exception.dart';
import 'package:flutter_money_manager/src/core/error/failure/failure.dart';
import 'package:flutter_money_manager/src/core/helpers/hive_helper.dart';
import 'package:flutter_money_manager/src/features/financial_summary/domain/services/financial_summary_service.dart';
import 'package:flutter_money_manager/src/features/stats/domain/entities/stat_response.dart';
import 'package:flutter_money_manager/src/features/stats/domain/repositories/stats_repository.dart';
import 'package:flutter_money_manager/src/features/stats/domain/services/stat_service.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/services/transaction_service.dart';

class StatsRepositoryImpl implements StatsRepository {
  final TransactionService _transactionService;
  final FinancialSummaryService _financialSummaryService;
  final StatService _statService;

  StatsRepositoryImpl(
      {required TransactionService transactionService,
      required FinancialSummaryService financialSummaryService,
      required StatService statService})
      : _transactionService = transactionService,
        _financialSummaryService = financialSummaryService,
        _statService = statService;

  @override
  Future<Either<Failure, StatResponse>> getStatMonth(
      {required TransactionTypEnum type, int? year, int? month}) async {
    try {
      final now = DateTime.now();
      year = year ?? now.year;
      month = month ?? now.month;
      final yearlyBalanceKey = HiveHelper.generateYearlyBalanceKey(year: year);

      const emptyResponse = StatResponse(stats: []);

      return const Right(emptyResponse);

      /*final summary = await _financialSummaryService.getSummaryWithTransactions(
          key: yearlyBalanceKey, month: month);

      final monthTransactions = await _transactionService.getTransactionsMonth(
          month: month, year: year);

      if (monthTransactions.isEmpty || summary == null) {
        return const Right(emptyResponse);
      }

      final breakdown =
          _statService.calculateBreakdown(monthTransactions, summary, type);

      return Right(StatResponse(stats: breakdown));*/
    } on UnknownException catch (_) {
      return Left(GenericFailure());
    } catch (error) {
      return Left(GenericFailure());
    }
  }
}
