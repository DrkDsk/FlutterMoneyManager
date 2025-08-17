
enum RedirectionStatus {initial, loading, home, login}

class HomeRedirectionState {
  final RedirectionStatus status;

  const HomeRedirectionState({this.status = RedirectionStatus.loading});

  HomeRedirectionState copyWith({
    RedirectionStatus? status,
  }) {
    return HomeRedirectionState(
      status: status ?? this.status,
    );
  }
}

