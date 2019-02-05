use v6;

unit role Cofra::App::Godly;

use Cofra::AppObject;

has Cofra::AppObject $.app is rw handles <logger biz>;
