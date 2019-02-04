use v6;

use Cofra::Web::View;

unit class Cofra::Web::View::JSON is Cofra::Web::View;

use JSON::Fast;
use Cofra::Web::Response;

class Instance is Cofra::Web::View::Instance {
    method render($content --> Cofra::Web::Response:D) {
        my $json = $content.&to-json;
        my $bjson = $json.encode('utf8');

        $.response.Content-Type = 'application/json; charset=utf8';
        $.response.Content-Length = $bjson.bytes;

        $.response.body = $bjson;

        $.response;
    }
}

# TODO I hate this. This needs a fix.
method activate(Cofra::Web::Request:D $request --> Cofra::Web::View::JSON::Instance:D) {
    Cofra::Web::View::JSON::Instance.new(view => self, :$request);
}

