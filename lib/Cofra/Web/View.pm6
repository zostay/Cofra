use v6;

use Cofra::Web::Godly;

unit role Cofra::Web::View does Cofra::Web::Godly;

use Cofra::Web::Response;

method render(*@_, *%_ --> Cofra::Web::Response) { ... }

