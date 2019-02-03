use v6;

use Smack::Response;
use Cofra::Web::Response;
use HTTP::Headers;
use X::Cofra::Web::Error;

unit class Cofra::Web::Response::P6WAPI does Cofra::Web::Response;

has Smack::Response $.response handles <
    status headers header Content-Length Content-Type body
    redirect finalize to-app
>;

method from-error(Cofra::Web::Response::P6WAPI:U: Exception $error --> Cofra::Web::Response::P6WAPI) {
    my $response = do given $error {
        when X::Cofra::Web::Error {
            my $headers = HTTP::Headers.new;
            my @body = '<h1>', .status-message, '</h1>';

            $headers.Content-Type   = 'text/html; charset=ascii';
            $headers.Content-Length = @body.join.chars;

            Smack::Response.new(
                status  => .status,
                :$headers, :@body,
            );
        }

        default {
            my @body = "Internal Server Error";

            my $headers = HTTP::Headers.new;
            $headers.Content-Type   = 'text/plain; charset=ascii';
            $headers.Content-Length = @body.join.chars;

            Smack::Response.new(
                status  => 500,
                :$headers, :@body,
            );
        }
    }

    Cofra::Web::Response::P6WAPI.new(:$response);
}
