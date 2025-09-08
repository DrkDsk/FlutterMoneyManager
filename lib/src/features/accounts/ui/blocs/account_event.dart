sealed class AccountEvent {
  const AccountEvent();
}

class LoadTransactionsSource extends AccountEvent {}

class GetGlobalBalance extends AccountEvent {
  const GetGlobalBalance();
}
