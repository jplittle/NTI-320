Name:		helloworld
##want to increase to keep up
Version: 	0.1
Release:	1%{?dist}
Summary: 	A program that prints 'Hello World'

Group:		NTI-320	
License:	GPL2+
URL:		https://github.com/nic-instruction/NTI-320
Source0:	https://github.com/nic-instruction/NTI-320/blob/master/rpm-info/helloworld-0.1.tar.gz

BuildRequires:	gcc, python >= 1.3
Requires:	bash

%description
'hello' will print 'hello cruel world' at each of your users when they log in.

install 'hello' if you would like a program to print 'hello cruel world' to you and 
other users of your system upon login.

##instructions for things to happen before rpm build
%prep					
			
##things to happen during setup
%setup -q	
		
%build					
%configure			
make %{?_smp_mflags}	
##copy shell script into compiled code
##go to source section and copy shell script
cp /root/rpmbuild/SOURCES/helloworld.sh /root/rpmbuild/BUILD/helloworld-0.1/

%install
##clears root directory
rm -rf %{buildroot}
##mk directories
mkdir -p %{buildroot}/%{_bindir}
mkdir -p %{buildroot}/%{_sysconfdir}/profile.d


make install DESTDIR=%{buildroot}
install -m 0755 %{name} %{buildroot}/%{_bindir}/%{name}
##copy helloword script into profile
cp /root/rpmbuild/SOURCES/helloworld.sh %{buildroot}/%{_sysconfdir}/profile.d/
%clean

%files					
%defattr(-,root,root)
##name listed above of rpm
/usr/bin/%{name}

%config
/etc/profile.d/%{name}.sh	

##docs for running program
##go in man section
%doc			

%post
##postscripts
##run after install
##rpms can run whatever they want
##troubleshooting good place to start
touch /thisworked


%postun
rm /thisworked

%changelog				# changes you (and others) have made and why
© 2019 GitHub, Inc.
