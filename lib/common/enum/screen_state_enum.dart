enum ScreenState {
  init,
  idle,
  loading,
  error,
  success,
  empty,
  search;

  bool isLoading() {
    return this == ScreenState.loading;
  }
}
