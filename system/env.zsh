export EDITOR='vim'
export ENCRYPTION_PW=1234
export ENCRYPTION_SALT=1234
export JWT_SIGNING_KEY=localKeyTellEverybody
export LOCAL_TOKEN=true

export JAVA_HOME=$(/usr/libexec/java_home)
export M2_HOME=/usr/local/Cellar/maven/3.5.2/
export GRADLE_HOME=~/Applications/ActiveVersions/Gradle
export PHANTOM_JS=~/Applications/ActiveVersions/PhantomJS

export PATH="/usr/local/share/dotnet:$HOME/.cargo/bin:$DOTFILES/bin:$M2_HOME/bin:$GRADLE_HOME/bin:$PHANTOM_JS/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
export MAVEN_OPTS="-XX:+TieredCompilation -XX:TieredStopAtLevel=1"
export GROOVY_HOME=/usr/local/opt/groovy/libexec
export MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$MANPATH"
# for ruby-build from brew
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

