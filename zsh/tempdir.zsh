function today() {
    date_dir=`date +"20%y/%m/%d"`
    src_dir="$HOME/Source/"
    full_dir="$src_dir$date_dir"
    if ! [ -d $full_dir ]; then
        mkdir -p $full_dir
    fi
    cd $full_dir
}

function tempdir_d() {
    dir=$HOME/Temporary/daily
    if ! [ -d $dir ]; then
        mkdir $dir
    fi
    cd $dir
}
function tempdir_w() {
    dir=$HOME/Temporary/weekly
    if ! [ -d $dir ]; then
        mkdir $dir
    fi
    cd $dir
}
alias tempdir=tempdir_d

