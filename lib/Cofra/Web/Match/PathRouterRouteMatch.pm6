use v6;

use Cofra::Web::Match;

unit class Cofra::Web::Match::PathRouterRouteMatch does Cofra::Web::Match;

use Path::Router;

has Path::Router::Route::Match $.match is required;

method path-parameters(--> Hash:D) { $.match.path-parameters }
method route(--> Path::Router::Route:D) { $.match.route }
method target(--> Callable:D) { $.match.target }
