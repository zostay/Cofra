use v6;

unit class X::Cofra::Error is Exception;

has $cause;

method message(--> Str:D) { $cause // 'unknown cause' }
