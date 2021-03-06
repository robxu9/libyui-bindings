#
# spec file for package libyui-bindings
# generates:
#  libyui-ruby
#  libyui-python
#  perl-libyui (Perl naming convention)
#
# Copyright (c) 2012 SUSE LINUX Products GmbH, Nuernberg, Germany.
#
# All modifications and additions to the file contributed by third parties
# remain the property of their copyright owners, unless otherwise agreed
# upon. The license for this file, and modifications and additions to the
# file, is the same license as for the pristine package itself (unless the
# license for the pristine package is not an Open Source License, in which
# case the license is the MIT License). An "Open Source License" is a
# license that conforms to the Open Source Definition (Version 1.9)
# published by the Open Source Initiative.

# Please submit bugfixes or comments via http://bugs.opensuse.org/
#
# nodebuginfo

Name:           @PACKAGE@
Version:        @VERSION@
Release:        0
License:        GPL-2.0
Summary:        Bindings for libyui
Group:          Development/Sources
URL:            https://github.com/libyui/libyui-bindings
BuildRoot:      %{_tmppath}/%{name}-%{version}-build
BuildRequires:  cmake
BuildRequires:  gcc-c++
BuildRequires:  libyui-devel >= 2.21.5
BuildRequires:  perl
BuildRequires:  python-devel
BuildRequires:  ruby-devel
BuildRequires:  swig
Source:         %{name}-%{version}.tar.bz2
Prefix:         /usr

%description
This package provides Ruby language bindings to access functions of
libyui - An User Interface engine that provides the
abstraction from graphical user interfaces (Qt, Gtk) and text based
user interfaces (ncurses).

Authors:
---------
-    kkaempf@suse.de
-    dmacvicar@suse.de

%prep
%setup -q

%build
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=%{prefix} \
      -DLIB=%{_lib} \
      -DPYTHON_SITEDIR=%{py_sitedir} \
      -DCMAKE_VERBOSE_MAKEFILE=TRUE \
      -DCMAKE_C_FLAGS_RELEASE:STRING="%{optflags}" \
      -DCMAKE_CXX_FLAGS_RELEASE:STRING="%{optflags}" \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_SKIP_RPATH=1 \
      -DBUILD_RUBY_GEM=no \
      ..
make %{?jobs:-j %jobs}

%install
cd build
make install DESTDIR=$RPM_BUILD_ROOT

%clean
%{__rm} -rf %{buildroot}

%package -n ruby-yui
Summary:        Ruby bindings for libyui
Group:          Development/Languages/Ruby

%description -n ruby-yui
This package provides Ruby language bindings to access functions of
libyui - An User Interface engine that provides the
abstraction from graphical user interfaces (Qt, Gtk) and text based
user interfaces (ncurses).

Authors:
---------
-    kkaempf@suse.de
-    dmacvicar@suse.de

%package -n python-yui
%py_requires
Summary:        Python bindings for libyui
Group:          Development/Languages/Python

%description -n python-yui
This package provides Python language bindings to access functions of
yast2-libyui - An User Interface engine that provides the
abstraction from graphical user interfaces (Qt, Gtk) and text based
user interfaces (ncurses).

Authors:
---------
-    kkaempf@suse.de
-    dmacvicar@suse.de


%package -n perl-yui
%{perl_requires}
Summary:        Perl bindings for libyui
Group:          Development/Languages/Perl

%description -n perl-yui
This package provides Perl language bindings to access functions of
yast2-libyui - An User Interface engine that provides the
abstraction from graphical user interfaces (Qt, Gtk) and text based
user interfaces (ncurses).

Authors:
---------
-    kkaempf@suse.de
-    dmacvicar@suse.de


%files -n ruby-yui
%defattr(-,root,root,-)
%doc swig/ruby/examples/*.rb
%{_libdir}/ruby/vendor_ruby/%{rb_ver}/%{rb_arch}/_yui.so

%files -n python-yui
%defattr(-,root,root,-)
%doc swig/python/examples/*.py
%{py_sitedir}/_yui.so
%{py_sitedir}/yui.py

%files -n perl-yui
%defattr(-,root,root,-)
%doc swig/perl/examples/*.pl
%{perl_vendorarch}/yui.so
%{perl_vendorlib}/yui.pm

%changelog
