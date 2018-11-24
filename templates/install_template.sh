#!/usr/bin/env bash

#声明：本脚本模板取自SpaceVim的安装脚本 
#=============================================================================
# install.sh --- bootstrap script for 项目名称
# Copyright (c) 2018-2018 版权所有者
# Author: 用户名 < 邮件 >
# URL: <项目URL>
# License: <项目协议>
#=============================================================================

# Init option {{{
Color_off='\033[0m'       # Text Reset

# terminal color template {{{
# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White

# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White

# High Intensity
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White

# Bold High Intensity
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\033[0;100m'   # Black
On_IRed='\033[0;101m'     # Red
On_IGreen='\033[0;102m'   # Green
On_IYellow='\033[0;103m'  # Yellow
On_IBlue='\033[0;104m'    # Blue
On_IPurple='\033[0;105m'  # Purple
On_ICyan='\033[0;106m'    # Cyan
On_IWhite='\033[0;107m'   # White
# }}}

# version
Version='0.0.1'
#System name
System="$(uname -s)"

# }}}

# need_cmd {{{
need_cmd () {
  if ! hash "$1" &>/dev/null; then
    error "需要 '$1' （找不到命令）"
    exit 1
  fi
}
# }}}

# head of success/info/error/warn  {{{
msg() {
  printf '%b\n' "$1" >&2
}

success() {
  msg "${Green}[✔]${Color_off} ${1}${2}"
}

info() {
  msg "${Blue}[➭]${Color_off} ${1}${2}"
}

error() {
  msg "${Red}[✘]${Color_off} ${1}${2}"
  exit 1
}

warn () {
  msg "${Red}[✘]${Color_off} ${1}${2}"
}
# }}}

# echo_with_color {{{
echo_with_color () {
  printf '%b\n' "$1$2$Color_off" >&2
}
# }}}

# fetch_repo {{{
fetch_repo () {
  if [[ -d "$HOME/.SpaceVim" ]]; then
    info "正在更新 SpaceVim..."
    cd "$HOME/.SpaceVim"
    git pull
    cd - > /dev/null 2>&1
    success "SpaceVim 更新已完成"
  else
    info "正在安装 SpaceVim..."
    git clone https://github.com/SpaceVim/SpaceVim.git "$HOME/.SpaceVim"
    success "SpaceVim 安装已完成"
  fi
}
# }}}

# install_vim {{{
install_vim () {
  if [[ -f "$HOME/.vimrc" ]]; then
    mv "$HOME/.vimrc" "$HOME/.vimrc_back"
    success "备份 $HOME/.vimrc 至 $HOME/.vimrc_back"
  fi

  if [[ -d "$HOME/.vim" ]]; then
    if [[ "$(readlink $HOME/.vim)" =~ \.SpaceVim$ ]]; then
      success "已为 vim 安装了 SpaceVim"
    else
      mv "$HOME/.vim" "$HOME/.vim_back"
      success "备份 $HOME/.vim 至 $HOME/.vim_back"
      ln -s "$HOME/.SpaceVim" "$HOME/.vim"
      success "已为 vim 安装了 SpaceVim"
    fi
  else
    ln -s "$HOME/.SpaceVim" "$HOME/.vim"
    success "已为 vim 安装了 SpaceVim"
  fi
}
# }}}









# check_requirements {{{
check_requirements () {
  info "正在检测 SpaceVim 依赖环境..."
  if hash "git" &>/dev/null; then
    git_version=$(git --version)
    success "检测 git 版本：${git_version}"
  else
    warn "缺少依赖：git"
  fi
  info "正在检测终端真色支持..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/JohnMorales/dotfiles/master/colors/24-bit-color.sh)"
}
# }}}

# usage {{{
usage () {
  echo_with_color ${BWhite} "TaceyShell 安装脚本 : V ${Version}"
  echo_with_color ""
  echo_with_color ${Color_off} "  这是 TaceyShell 初始化脚本，可用于定制安装、更新及卸载 TaceyShell。"
  echo_with_color ""
  echo_with_color "使用"
  echo_with_color ""
  echo_with_color "  curl -sLf https://xxxx.com/install.sh | bash -s -- [选项] [对象]"
  echo_with_color ""
  echo_with_color "所有选项"
  echo_with_color ""
  echo_with_color " -i, --install            安装"
  echo_with_color " -v, --version            显示当前安装脚本的版本"
  echo_with_color " -u, --uninstall          卸载 TaceyShell"
  echo_with_color " -c, --checkRequirements  检测环境依赖"
  echo_with_color ""
  echo_with_color "使用示例"
  echo_with_color ""
  echo_with_color "    缺省安装"
  echo_with_color ""
  echo_with_color "        curl -sLf https://xxx.com/install.sh | bash"
  echo_with_color ""
  echo_with_color "    精简方案一安装"
  echo_with_color ""
  echo_with_color "        curl -sLf https://xxx.com/install.sh | bash -s -- --install simple1"
  echo_with_color ""
  echo_with_color "    卸载 TaceyShell"
  echo_with_color ""
  echo_with_color "        curl -sLf https://xxx.com/cn/install.sh | bash -s -- --uninstall"
}
# }}}

# install_done {{{

install_done () {
  echo_with_color ${Yellow} ""
  echo_with_color ${Yellow} "安装已完成!"
  echo_with_color ${Yellow} "=============================================================================="
  echo_with_color ${Yellow} "==                         打开 TacyeShell/ts,Enjoy it!                      =="
  echo_with_color ${Yellow} "=============================================================================="
  echo_with_color ${Yellow} ""
  echo_with_color ${Yellow} "感谢支持 TaceyShell，欢迎反馈"
  echo_with_color ${Yellow} "https://xxx.com"
  echo_with_color ${Yellow} ""
}

# }}}

# welcome {{{


welcome () {
    echo_with_color ${Yellow} " _____                    ____  _          _ _ "
    echo_with_color ${Yellow} "|_   _|_ _  ___ ___ _   _/ ___|| |__   ___| | |"
    echo_with_color ${Yellow} "  | |/ _  |/ __/ _ \ | | \___ \| '_ \ / _ \ | |"
    echo_with_color ${Yellow} "  | | (_| | (_|  __/ |_| |___) | | | |  __/ | |"
    echo_with_color ${Yellow} "  |_|\__,_|\___\___|\__, |____/|_| |_|\___|_|_|"
    echo_with_color ${Yellow} "                    |___/                      "
    echo_with_color ${Yellow} "                版本:${Version}  https://xxx.com"
    
}

# }}}

# download_font {{{
download_sth () {
  url="https://xxx.com/$1"
  path="$HOME/.local/xxx/$1"
  if [[ -f "$path" ]]
  then
    success "已下载 $1"
  else
    info "正在下载 $1"
    curl -s -o "$path" "$url"
    success "已下载 $1"
  fi
}

# }}}

# install_sth {{{
install_sth () {
  if [[ ! -d "$HOME/.local/share/fonts" ]]; then
    mkdir -p $HOME/.local/share/fonts
  fi
  download_sth "1.sh"
  download_sth "2.sh"
  download_sth "3.sh"
  info "正在构建&安装，请稍等..."
  if [ $System == "Darwin" ];then
    info "执行Mac OS操作"
  else
    info "执行Linux&Unix操作"
  fi
  success "安装已完成!"
}

# }}}

### main {{{
main () {
  if [ $# -gt 0 ] #如果参数大于零
  then
    case $1 in
      --uninstall|-u)
        info "正在卸载 TaceyShel..."
        echo_with_color ${BWhite} "感谢体验 TaceyShell，期待再次回来..."
        exit 0
        ;;
      --checkRequirements|-c)
        check_requirements
        exit 0
        ;;
      --install|-i)
        welcome
        need_cmd 'git'
        #do git clone
        if [ $# -eq 2 ] #如果有两个参数
        then
          case $2 in
            simple1)
              exit 0
              ;;
            simple2)
              exit 0
          esac
        fi
        exit 0
        ;;
      --help|-h)
        usage
        exit 0
        ;;
      --version|-v)
        msg "${Version}"
        exit 0
    esac
  else
    welcome
    need_cmd 'git'
  fi
}

# }}}

main $@

