use v6;

use Cofra::Web::Godly;

unit class Cofra::Web::Router does Cofra::Web::Godly;

use Cofra::Web::Match;
use Cofra::Web::Request;

method match(Cofra::Web::Request:D $request --> Cofra::Web::Match) { ... }

method path-for(%mapping --> Str) { ... }

