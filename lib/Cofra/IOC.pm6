use v6;

unit module Cofra::IOC;

my role Factory[&factory] {
    method compose(Mu $package) {
        callsame;

        my $attribute = self;
        if $attribute.has_accessor {

            my $name = self.name.substr(2);
            $package.^method_table.{$name}.wrap(
                method () {
                    # TODO It would be nice if we had a guarantee that this
                    # just ran once per object. As far as I know, though,
                    # there's no means for creating weak references or
                    # something like Java's WeakHashRef, which feels
                    # necessary to do that in a way that won't leak memory.
                    without $attribute.get_value(self) {
                        $attribute.set_value(
                            self,
                            self.&factory(
                                :$attribute,
                                :$name,
                            )
                        );
                    }

                    callsame;
                }
            );
        }

    }
}

# This is basically a poor person's IOC helper. It's not good but it will serve
# my purposes as an MVP solution in the short term.
multi trait_mod:<is> (Attribute $a, :$factory!) is export {
    $a does Factory[$factory];
}
