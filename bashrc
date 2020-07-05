# Preparation for development environment.

#export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
export JAVA_HOME=$HOME/sdk/java/home

# WARNING: Please note that the whitespace at the beginning and ends of each of
# the following lines matters. Don't include it. Edit carefully.
export PATH=\
$HOME/bin:\
$HOME/go/bin:\
$HOME/var/bin:\
$HOME/.cargo/bin:\
$JAVA_HOME/bin:\
/usr/local/bin:\
/usr/bin:\
/bin:\
/usr/local/sbin:\
/usr/sbin:\
/sbin:\
$PATH
