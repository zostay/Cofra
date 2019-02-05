use v6;

use Smack::Request;
use Cofra::Web::Request;

unit class Cofra::Web::Request::P6WAPI does Cofra::Web::Request;

use Smack::Response;
use Cofra::Web::Response::P6WAPI;

# handles * would be nice, but rakudo 2018.10 barfs on it
has Smack::Request $.request handles <
    protocol method host port user request-uri path-info
    path query-string script-name scheme secure body
    input session session_options cookies
    query-parameters raw-content content headers
    body-parameters parameters param
>;

has %.env;

submethod BUILD(:%!env) {
    $!request .= new(%!env);
}

method router-context(--> Hash:D) {
    %(
        REQUEST_METHOD => %.env<REQUEST_METHOD>,
    )
}

method start-response(--> Cofra::Web::Response::P6WAPI:D) {
    my $response = Smack::Response.new(:200status);
    Cofra::Web::Response::P6WAPI.new(:$response);
}
