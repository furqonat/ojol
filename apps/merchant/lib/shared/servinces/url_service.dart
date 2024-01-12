class QueryBuilder {
  final String startWith;
  final Map<String, String> _queryParameters = {};

  QueryBuilder(this.startWith, {Map<String, String>? queryParameters}) {
    if (queryParameters != null) {
      _queryParameters.addAll(queryParameters);
    }
  }

  QueryBuilder addQuery(String key, String? value) {
    if (value == null || value == 'null') {
      return this;
    }
    _queryParameters[key] = value;
    return this;
  }

  Uri build() {
    return Uri.parse(startWith).replace(queryParameters: _queryParameters);
  }
}
