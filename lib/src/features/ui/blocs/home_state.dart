class NavigationState {

  final int pageIndex;
  final int tabIndex;

  const NavigationState({this.pageIndex = 0, this.tabIndex = 0});

  NavigationState copyWith({
    int? tabIndex,
    int? pageIndex
  }) {
    return NavigationState(
      tabIndex: tabIndex ?? this.tabIndex,
      pageIndex: pageIndex ?? this.pageIndex
    );
  }
}

