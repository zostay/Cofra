use v6;

use Smack::Request;
use Cofra::Web::Request;

unit class Cofra::Web::Request::P6WAPI does Cofra::Web::Request;

# handles * would be nice, but rakudo 2018.10 barfs on it
has Smack::Request $.request handles <
    protocol method host port user request-uri path-info
    path query-string script-name scheme secure body
    input session session_options logger cookies
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
