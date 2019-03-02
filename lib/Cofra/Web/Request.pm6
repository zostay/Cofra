use v6;

use Cofra::Context;

unit role Cofra::Web::Request does Cofra::Context;

use Cofra::Web::Response;

# TODO Decide what request methods are always standard here

method router-context(--> Hash:D) { %() }

method start-response(--> Cofra::Web::Response:D) { ... }

=begin pod

=head1 NAME

Cofra::Web::Request - not yet documented

=end pod
