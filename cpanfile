requires "Class::Singleton" => "1.03";
requires "Cwd" => "3";
requires "File::Basename" => "0";
requires "File::Compare" => "0";
requires "File::Find" => "0";
requires "File::Spec" => "0";
requires "List::AllUtils" => "0";
requires "List::Util" => "0";
requires "Module::Runtime" => "0";
requires "Params::Validate" => "0.72";
requires "Try::Tiny" => "0";
requires "constant" => "0";
requires "parent" => "0";
requires "perl" => "5.006";
requires "strict" => "0";
requires "vars" => "0";
requires "warnings" => "0";

on 'test' => sub {
  requires "ExtUtils::MakeMaker" => "0";
  requires "File::Copy" => "0";
  requires "File::Path" => "0";
  requires "File::Spec" => "0";
  requires "File::Spec::Functions" => "0";
  requires "File::Temp" => "0";
  requires "Storable" => "0";
  requires "Sys::Hostname" => "0";
  requires "Test::Fatal" => "0";
  requires "Test::More" => "0.96";
  requires "Test::Requires" => "0";
  requires "base" => "0";
  requires "lib" => "0";
  requires "overload" => "0";
};

on 'test' => sub {
  recommends "CPAN::Meta" => "2.120900";
};

on 'configure' => sub {
  requires "ExtUtils::MakeMaker" => "0";
};

on 'develop' => sub {
  requires "Perl::Critic" => "1.123";
  requires "Perl::Tidy" => "20140711";
  requires "Pod::Coverage::TrustPod" => "0";
  requires "Test::EOL" => "0";
  requires "Test::More" => "0.88";
  requires "Test::NoTabs" => "0";
  requires "Test::Output" => "0";
  requires "Test::Pod" => "1.41";
  requires "Test::Pod::Coverage" => "1.08";
  requires "Test::Spelling" => "0.12";
  requires "Test::Taint" => "0";
};
