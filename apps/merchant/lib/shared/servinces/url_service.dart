class QueryBuilder {
  final Map<String, String> _queryParameters = {};

  QueryBuilder addQuery(String key, String? value) {
    if (value == null || value == 'null') {
      return this;
    }
    _queryParameters[key] = value;
    return this;
  }

  toMap() {
    return _queryParameters;
  }
}
