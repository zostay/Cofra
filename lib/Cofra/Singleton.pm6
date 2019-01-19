use v6;

unit role Cofra::Singleton[Str $key];

my %SINGLETONS;

method instance(::?CLASS:) {
    %SINGLETONS{ $key } //= self.new;
}
