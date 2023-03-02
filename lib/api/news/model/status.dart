enum Status {
  ok(),
  error();

  const Status();
  static Status parseToEnum(String value) {
    if (value == 'ok') return Status.ok;
    return Status.error;
  }
}
