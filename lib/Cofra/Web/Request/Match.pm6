use v6;

use Cofra::Web::Match;

unit role Cofra::Web::Request::Match[Cofra::Web::Match:D $match];

method match(--> Cofra::Web::Match:D) { $match }

method path-parameters(--> Hash:D) { $match.path-parameters }
method target(--> Callable:D) { $match.target }
