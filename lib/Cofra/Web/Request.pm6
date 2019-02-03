use v6;

use Cofra::Context;

unit role Cofra::Web::Request does Cofra::Context;

method router-context(--> Hash:D) { %() }
