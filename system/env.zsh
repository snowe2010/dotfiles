export EDITOR='vim'
export ENCRYPTION_PW=1234
export ENCRYPTION_SALT=1234
export JWT_SIGNING_KEY=localKeyTellEverybody
export LOCAL_TOKEN=true

export JAVA_HOME=$(/usr/libexec/java_home)
export M2_HOME=/usr/local/Cellar/maven/3.5.2/
export GRADLE_HOME=~/Applications/ActiveVersions/Gradle
export PHANTOM_JS=~/Applications/ActiveVersions/PhantomJS

export PATH="$M2_HOME/bin:$GRADLE_HOME/bin:$PHANTOM_JS/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin" #:/usr/local/Cellar/elixir/1.5.1/bin"
export MAVEN_OPTS="-XX:+TieredCompilation -XX:TieredStopAtLevel=1"