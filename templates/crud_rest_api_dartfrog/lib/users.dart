final users = [
  {"name": 'tobi'},
  {"name": 'loki'},
  {"name": 'jane'}
];

bool userExists(String username) {
  return users.any((user) => user['name'] == username);
}
