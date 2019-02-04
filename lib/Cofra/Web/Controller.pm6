use v6;

use Cofra::Web::Godly;

unit role Cofra::Web::Controller does Cofra::Web::Godly;

use Cofra::Web::Request;
use Cofra::Web::Response;

multi method fire(Str:D $action, Cofra::Web::Request $r, |args --> Cofra::Web::Response) {
    self."$action"($r, |args);
}
