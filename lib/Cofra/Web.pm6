use v6;

use Cofra::App::Godly;
use Cofra::WebObject;

unit class Cofra::Web does Cofra::WebObject does Cofra::App::Godly;

use Cofra::Logger;
use Cofra::Web::Controller;
use Cofra::Web::Controller::Error;
use Cofra::Web::Match;
use Cofra::Web::Request;
use Cofra::Web::Request::Match;
use Cofra::Web::Response;
use Cofra::Web::Router;
use Cofra::Web::View;
use X::Cofra::Web::Error;

has Cofra::Web::Controller %.controllers;
has Cofra::Web::View %.views;
has Cofra::Web::Router $.router handles <path-for>;
has Cofra::Web::Controller $.error-controller = Cofra::Web::Controller::Error.new;

method access-controller { $.app.access-controller }

method log-critical(|c) { $.logger.log-critical(|c) }
method log-error(|c) { $.logger.log-error(|c) }
method log-warn(|c) { $.logger.log-warn(|c) }
method log-info(|c) { $.logger.log-info(|c) }
method log-debug(|c) { $.logger.log-debug(|c) }

method check-access(Cofra::Web::Request:D $req --> Bool:D) {
    # TODO Figure out how this should be implemented.
    return True without $.access-controller;

    !!!
}

method controller(Str:D $name) {
    %!controllers{ $name } // die "no controller named $name";
}

multi method target(&target --> Callable:D) { &target }

multi method target(Str:D :$controller, Str:D :$action, |args --> Callable:D) {
    self.target($controller, $action, |args);
}

multi method target(Str:D $controller-name, Str:D $action, |args --> Callable:D) {
    my $c = self.controller($controller-name);
    sub (Cofra::Web::Request:D $r --> Cofra::Web::Response:D) {
        $c.fire($action, $r, |args);
    }
}

method view(Str:D $name, Cofra::Web::Request:D $request --> Cofra::Web::View::Instance:D) {
    my $view = %!views{ $name } // die "no view named $name";
    $view.activate($request);
}

method request-response-dispatch(Cofra::Web::Request:D $req --> Cofra::Web::Response:D) {
    my Cofra::Web::Match $match = self.router.match($req);

    return self.error-controller.fire('not-found', $req) without $match;

    my $match-req = $req but Cofra::Web::Request::Match[$match];

    return self.error-controller.fire('forbidden', $match-req)
        unless self.check-access($match-req);

    $match-req.target.($match-req);
}

