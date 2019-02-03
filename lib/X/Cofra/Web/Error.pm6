use v6;

use Cofra::Web::Godly;
use X::Cofra::Error;

unit package X::Cofra::Web;

use HTTP::Status;

role Error[$status = 500] is X::Cofra::Error does Cofra::Web::Godly {
    use Cofra::Web::Request;

    has Cofra::Web::Request $.request;

    multi method new($web, $request) {
        self.bless(:$web, :$request);
    }

    method status(--> Int:D) { $status }
    method status-message(--> Str:D) { get_http_status_msg($status) }
}

class Error::BadReqeust does X::Cofra::Web::Error[400] { }
class Error::Unauthorized does X::Cofra::Web::Error[401] { }
class Error::Forbidden does X::Cofra::Web::Error[403] { }
class Error::NotFound does X::Cofra::Web::Error[404] { }

