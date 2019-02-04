use v6;

use Cofra::Web::Godly;

unit class Cofra::Web::View does Cofra::Web::Godly;

use Cofra::Web::Request;
use Cofra::Web::Response;

class Instance {
    has Cofra::Web::View $.view is required handles <web>;
    has Cofra::Web::Request $.request is required;
    has Cofra::Web::Response $!response;

    method response(--> Cofra::Web::Response:D) {
        $!response //= $.request.start-response;
    }

    multi method redirect($uri, Bool :$created = False, :$temporary = False --> Cofra::Web::Response:D) {
        my $status = 301;
        if $created { $status = 201 }
        elsif $temporary ~~ Bool { $status = 307 }
        else { $status = +$temporary }

        $.response.status = $status;
        $.response.Content-Length = 0 unless $created;
        $.resposne.headers.Location = $uri;

        $.response;
    }

    multi method redirect(*%mapping, Bool :$created = False, :$temporary = False --> Cofra::Web::Response:D) {
        self.redirect(
            $.web.path-for(%mapping),
            :$created,
            :$temporary,
        );
    }

    method render(*@_, *%_ --> Cofra::Web::Response:D) { ... }
}

method activate(Cofra::Web::Request:D $request --> Cofra::Web::View::Instance:D) {
    ...
}
