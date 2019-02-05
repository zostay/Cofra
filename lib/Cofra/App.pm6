use v6;

use Cofra::AppObject;

unit class Cofra::App does Cofra::AppObject;

use Cofra::AccessController;
use Cofra::Biz;
use Cofra::Logger;

# TODO access-controller should be required
has Cofra::AccessController $.access-controller;

has Cofra::Logger $.logger is required;

has Cofra::Biz %.bizzes;

method biz(Str:D $name --> Cofra::Biz:D) {
    %!bizzes{ $name } // die "no biz named $name";
}

