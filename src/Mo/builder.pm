package Mo::builder;package Mo;$MoPKG = __PACKAGE__;
$VERSION = 0.24;

*{$MoPKG.'::builder::e'} = sub {
    my $caller_pkg = shift;
    my %exports = @_;
    my $old_export = $exports{has};
    $exports{has} = sub {
        my ( $name, %args ) = @_;
        my $builder = $args{builder};
        *{ $caller_pkg . "::".$name } = $builder
            ? sub {
                $#_
                  ? $_[0]{$name} = $_[1]
                    : ! exists $_[0]{$name}
                      ? $_[0]{$name} = $_[0]->$builder
                      : $_[0]{$name}
            }
            : $old_export->(@_);
    };
    %exports;
};
