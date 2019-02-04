use v6;

unit class Cofra::App;

use Cofra::AccessController;
use Cofra::Logger;

# TODO access-controller should be required
has Cofra::AccessController $.access-controller;

has Cofra::Logger $.logger is required
