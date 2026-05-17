// Real World Problem
// Without Chain of Responsibility, route checking and permission logic
// are tightly coupled and become unmaintainable as more concerns
// (auth, logging, rate limiting, etc.) are added.

enum CORUserType { admin, member, guest }

class CORUser {
  final String name;
  final CORUserType type;

  CORUser({required this.name, required this.type});
}

class CORRequest {
  final String url;
  final CORUser user;

  CORRequest({required this.url, required this.user});
}

// Handler
// Defines the interface for handling requests and chaining handlers.

abstract class Middleware {
  Middleware? _next;

  Middleware setNext(Middleware handler) {
    _next = handler;
    return handler;
  }

  void handle(CORRequest request);
}

// Concrete Handlers
// Each handler decides whether to process the request and/or pass it on.

class RouteHandler extends Middleware {
  @override
  void handle(CORRequest request) {
    if (request.url.contains('/hello')) {
      print("RouteHandler: Route matched '/hello'");
      _next?.handle(request);
    } else {
      print('RouteHandler: 404 Not Found');
    }
  }
}

class AuthHandler extends Middleware {
  @override
  void handle(CORRequest request) {
    if (request.user.type != CORUserType.guest) {
      print("AuthHandler: User '${request.user.name}' is authenticated");
      _next?.handle(request);
    } else {
      print('AuthHandler: Unauthorized - Guest access denied');
    }
  }
}

class PermissionHandler extends Middleware {
  @override
  void handle(CORRequest request) {
    if (request.user.type == CORUserType.admin) {
      print('PermissionHandler: Admin access granted - Success');
      _next?.handle(request);
    } else {
      print("PermissionHandler: Sorry, you don't have permission");
    }
  }
}

// Entry point that kicks off the chain.

class MiddlewareHandler {
  Middleware? _handler;

  void setHandler(Middleware handler) {
    _handler = handler;
  }

  void handle(CORRequest request) {
    _handler?.handle(request);
  }
}

// Usage
// Build a chain: Route -> Auth -> Permission, then send requests through.

void chainOfResponsibilityExample() {
  final routeHandler = RouteHandler();
  final authHandler = AuthHandler();
  final permissionHandler = PermissionHandler();

  routeHandler.setNext(authHandler).setNext(permissionHandler);

  final middleware = MiddlewareHandler();
  middleware.setHandler(routeHandler);

  // Case 1: Admin with valid route - passes all handlers
  print('Case 1: Admin + valid route');
  final adminUser = CORUser(name: 'Alice', type: CORUserType.admin);
  middleware.handle(
    CORRequest(url: 'http://www.example.com/hello', user: adminUser),
  );

  // Case 2: Member with valid route - blocked at permission
  print('Case 2: Member + valid route');
  final memberUser = CORUser(name: 'Bob', type: CORUserType.member);
  middleware.handle(
    CORRequest(url: 'http://www.example.com/hello', user: memberUser),
  );

  // Case 3: Guest with valid route - blocked at auth
  print('Case 3: Guest + valid route');
  final guestUser = CORUser(name: 'Charlie', type: CORUserType.guest);
  middleware.handle(
    CORRequest(url: 'http://www.example.com/hello', user: guestUser),
  );

  // Case 4: Admin with invalid route - blocked at route
  print('Case 4: Admin + invalid route');
  middleware.handle(
    CORRequest(url: 'http://www.example.com/unknown', user: adminUser),
  );
}

void main() {
  chainOfResponsibilityExample();
}
