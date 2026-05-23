// Subject

abstract class DatabaseDAO {
  void query();
}

// Real Subject

class DatabaseDAOImpl implements DatabaseDAO {
  @override
  void query() {
    print('QUERY');
  }
}

// Cache Proxy

class CacheProxyDatabase implements DatabaseDAO {
  final DatabaseDAO _dao;

  CacheProxyDatabase({required DatabaseDAO dao}) : _dao = dao;

  @override
  void query() {
    print('Cache:: Query from Cache');
    _dao.query();
  }
}

// Logging Proxy

class LoggingProxy implements DatabaseDAO {
  final DatabaseDAO _dao;

  LoggingProxy({required DatabaseDAO dao}) : _dao = dao;

  @override
  void query() {
    print('Log:: Start Query');
    _dao.query();
    print('Log:: End Query');
  }
}

// Usage

void main() {
  final db = DatabaseDAOImpl();
  final cache = CacheProxyDatabase(dao: db);
  final logProxy = LoggingProxy(dao: cache);

  logProxy.query();
}
