use v6;

use Cofra::Web::Router;

unit class Cofra::Web::Router::PathRouter is Cofra::Web::Router;

use Path::Router;

has $.router-class;
has $.router;

submethod BUILD(:$!router-class = Path::Router, :$!router) {
    $!router = $!router-class.new without $!router;
}

submethod TWEAK(Cofra::Web::Router:D:) {
    self.initialize-routes;
}

method initialize-routes(Cofra::Web::Router:D:) {
    my $*ROUTE = self;

    for self.^mro.reverse {
        .ROUTE if .^find_method('ROUTE', :no_fallback);
    }

    True;
}

multi method add-route(Str:D $REQUEST_METHOD, Str:D $path, %options --> True) {
    my %conditions = %( :$REQUEST_METHOD );
    $.router.add-route($path, %( |%options, :%conditions ));
}

multi method add-route(|c --> True) {
    $.router.add-route(|c);
}

method match(Cofra::Web::Request:D $request --> Cofra::Web::Match) {
    my $match = $.router.match($request.path, context => $request.router-context);
    return Nil without $match;
    Cofra::Web::Match::PathRouterRouteMatch.new(:$match);
}

method path-for(%path-parameters --> Str) {
    $.router.path-for(%path-parameters);
}

sub get(*%route --> True) is export {
    $*ROUTER.add-route('GET', .key, .value) for %route;
}

sub put(*%route --> True) is export {
    $*ROUTER.add-route('PUT', .key, .value) for %route;
}

sub post(*%route --> True) is export {
    $*ROUTER.add-route('POST', .key, .value) for %route;
}

sub delete(*%route --> True) is export {
    $*ROUTER.add-route('DELETE', .key, .value) for %route;
}

