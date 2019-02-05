use v6;

use Cofra::Web::Godly;

unit class Cofra::Web::Controller does Cofra::Web::Godly;

use Cofra::Web::Request;
use Cofra::Web::Response;

role Action { }

multi method fire(Str:D $action, Cofra::Web::Request $request, |args --> Cofra::Web::Response) {
    my $method = self.^find_method($action);
    if $method ~~ Action {
        self."$action"($request, |args);
    }
    else {
        die X::Cofra::Web::Error::NotFound.new(
            :$.web, :$request,
            cause => qq[action method "$action" does not exist or is not marked as an action],
        );
    }
}

multi trait_mod:<is> (Method $m, :$action!) is export {
    $m does Action;
}
