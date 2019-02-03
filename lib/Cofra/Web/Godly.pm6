use v6;

use Cofra::WebObject;

role Cofra::Web::Godly {
    has Cofra::WebObject $.web is rw handles <app>;
}

