void assertKey(String key) {
  assert(key.isNotEmpty, 'Key cannot be empty');
  assert(key != '.' && key != '..', 'Key cannot be . or ..');
}
