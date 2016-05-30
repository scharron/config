prefix=$1
test -z "$prefix" && prefix=$HOME/local


function die()
{
  echo "** error: $*"
  exit 1
}

function warn()
{
  echo "** warning: $*"
}

function try()
{
  $@ || die "$@"
}

function link()
{
  file=$1
  test ! -e $HOME/$file &&
    ln -sf $prefix/config/$file $HOME/ ||
    warn "$HOME/$file already exists"
}


# Create prefix
try mkdir -p $prefix
cd $prefix

# Check if repository exists
test ! -e config -o -d config || die "$prefix/config already exist but it's not a directory."
test -d config || (git clone git@github.com:scharron/config.git && git submodule update -i)

# Create symlinks
cd $prefix/config
link .bash_profile
link .bashrc
link .vimrc
link .vim
link .gitconfig
