use v6;

use Cofra::App::Godly;
use Cofra::WebObject;

unit class Cofra::Web does Cofra::WebObject does Cofra::App::Godly;

use Cofra::Web::Controller;
use Cofra::Web::Match;
use Cofra::Web::Request;
use Cofra::Web::Request::Match;
use Cofra::Web::Response;
use Cofra::Web::Router;
use Cofra::Web::View;
use X::Cofra::Web::Error;

has Cofra::Web::Controller %.controllers;
has Cofra::Web::View %.views;
has Cofra::Web::Router $.router;

method access-controller { $.app.access-controller }
method logger { $.app.logger }

method log-error(|c) { $.app.logger.log-error(|c) }

method check-access(Cofra::Web::Request:D $req --> Bool:D) {
    return True without $.access-controller;

    !!!
}

method controller(Str:D $name) {
    %!controllers{ $name } // die "no controller named $name";
}

method target(Str:D $controller-name, Str:D $action, |args) {
    my $c = self.controller($controller-name);
    sub (Cofra::Web::Request $r --> Cofra::Web::Response) {
        $c.fire($action, $r, |args);
    }
}

method view(Str:D $name) {
    %!views{ $name } // die "no view named $name";
}

method request-response-dispatch(Cofra::Web::Request:D $req --> Cofra::Web::Response:D) {
    my $res;

    try {
        my Cofra::Web::Match $match = self.router.match($req);

        die X::Cofra::Web::Error::NotFound.new(self, $req) without $match;

        my $match-req = $req but Cofra::Web::Request::Match[$match];

        die X::Cofra::Web::Error::Forbidden.new(self, $match-req)
            unless self.check-access($match-req);

        $res = $match-req.target.($match-req).finalize;

        CATCH {
            when X::Cofra::Web::Error {
                .rethrow;
            }

            default {
                self.log-error($_);
                X::Cofra::Web::Error.new(self, $match-req);
            }
        }
    }

    $res;
}

