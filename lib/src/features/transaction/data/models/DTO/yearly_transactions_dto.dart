import 'package:flutter_money_manager/src/features/transaction/data/models/DTO/monthly_transaction_dto.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/yearly_transactions_model.dart';

class YearlyTransactionsDto {
  final int year;

  final List<MonthlyTransactionDto> months;

  YearlyTransactionsDto({required this.year, required this.months});

  factory YearlyTransactionsDto.initial({required int year}) {
    return YearlyTransactionsDto(year: year, months: []);
  }

  YearlyTransactionsModel toModel() {
    return YearlyTransactionsModel(
        year: year, months: months.map((month) => month.toModel()).toList());
  }

  factory YearlyTransactionsDto.fromModel(YearlyTransactionsModel model) {
    return YearlyTransactionsDto(
        year: model.year,
        months: model.months
            .map((monthTransactionModel) =>
                MonthlyTransactionDto.fromModel(monthTransactionModel))
            .toList());
  }
}
