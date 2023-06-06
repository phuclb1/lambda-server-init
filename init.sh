ACCESS_KEY='x'
SECRET_KEY='x'
SUDO="sudo"

exec_cmd_nobail() {	
  echo "+ $2 bash -c \"$1\""	
  $2 bash -c "$1"	
}

print_status() {	
  echo "## $1"	
}

install_lib() {
    exec_cmd_nobail "apt install s3fs" $SUDO
}

mount_s3() {
    install_lib
    exec_cmd_nobail "echo $ACCESS_KEY:$SECRET_KEY > ~/.passwd-s3fs"
    exec_cmd_nobail "chmod 600 ~/.passwd-s3fs" 
    exec_cmd_nobail "mkdir ~/workspace"
    exec_cmd_nobail "s3fs openai-whisper-model ~/workspace -o passwd_file=~/.passwd-s3fs"
}
mount_s3