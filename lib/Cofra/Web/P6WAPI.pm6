use v6;

unit role Cofra::Web::P6WAPI;

use Cofra::Web::Response;
use Cofra::Web::Request::P6WAPI;
use Cofra::Web::Response::P6WAPI;
use X::Cofra::Web::Error;

method app { ... }
method log-error { ... }

method p6wapi-request-response-dispatch(%env --> List) {
    try {
        my $req = Cofra::Web::Request::P6WAPI.new(:%env, :$.app);

        # Just in case someone has some middleware that needs these
        %env<cofra.app>     = $.app;
        %env<cofra.web>     = self;
        %env<cofra.request> = $req;

        my $res = self.request-response-dispatch($req);
        $res does Cofra::Web::Response::P6WAPI;

        CATCH {
            when X::Cofra::Web::Error {
                $res = Cofra::Web::Response::P6WAPI.from-error($_);
                return $res.finalize;
            }
            default {
                self.log-error($_);
                $res = Cofra::Web::Response::P6WAPI.from-error(
                    X::Cofra::Web::Error.new(self, $req)
                );
                return $res.finalize;
            }
        }

        $res.finalize;
    }
}

