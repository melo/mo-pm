package Mo;require strict;require warnings;$Mo::VERSION='0.21';
sub import{strict->import;warnings->import;my$p=caller;@{$p.'::ISA'}=$_[0];*{$p.'::extends'}=sub{@{(caller).'::ISA'}=$_[0];eval"require($_)"for@_};*{$p.'::has'}=sub{my($n,%a)=@_;my($d,$b)=@a{qw(default builder)};*{(caller)."::$n"}=$d?sub{$#_?($_[0]{$n}=$_[1]):(exists$_[0]{$n})?$_[0]{$n}:($_[0]{$n}=$d->($_[0]))}:$b?sub{$#_?($_[0]{$n}=$_[1]):(exists$_[0]{$n})?$_[0]{$n}:($_[0]{$n}=$_[0]->$b)}:sub{$#_?$_[0]{$n}=$_[1]:$_[0]{$n}}}}sub new{my$c=shift;my$s=bless{@_},$c;my@c=$c;unshift@c,$c while$c=${$c."::ISA"}[0];do{&{$_."::BUILD"}($s)if defined&{$_."::BUILD"}}for@c;$s}