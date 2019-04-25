use v6;

use Cofra::Web::View;

unit class Cofra::Web::View::JSONMarshal is Cofra::Web::View;

use JSON::Marshal;
use Cofra::Web::Response;

class Instance is Cofra::Web::View::Instance {
    method render($content --> Cofra::Web::Response:D) {
        my $json = $content.&marshal;
        my $bjson = $json.encode('utf8');

        $.response.Content-Type = 'application/json; charset=utf8';
        $.response.Content-Length = $bjson.bytes;

        $.response.body = $bjson;

        $.response;
    }
}

method activate(Cofra::Web::Request:D $request --> Cofra::Web::View::JSONMarshal::Instance:D) {
    Cofra::Web::View::JSONMarshal::Instance.new(view => self, :$request);
}


