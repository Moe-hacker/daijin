#!/data/data/com.termux/files/usr/bin/bash
# Copyright 2024 moe-hacker
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
function check_if_succeed() {
  if [[ $1 -ne 0 ]]; then
    echo -e "\033[31mDaijin got an error\033[0m"
    exit 1
  fi
}
function select_range() {
  read -p "$1" range
  if [[ "" == $range ]]; then
    echo $(select_range "$1" $2 $3)
    return
  fi
  if [[ $range -lt $2 || $range -gt $3 ]]; then
    echo $(select_range "$1" $2 $3)
    return
  fi
  echo $range
}
function rurima_pull_lxc() {
  rootfslist=$(rurima lxc list -q | awk '{print $1}' | uniq | tr '\n' ' ')
  check_if_succeed $?
  j=1
  for i in $(echo $rootfslist); do
    echo -e "[$j] $i "
    j=$((j + 1))
  done
  num=$(select_range "Select a distro: " 1 $((j - 1)))
  check_if_succeed $?
  distro=$(echo $rootfslist | cut -d " " -f $num)
  versionlist=$(rurima lxc search -q -o $distro | awk '{print $3}' | uniq)
  check_if_succeed $?
  j=1
  for i in $(echo $versionlist); do
    echo -e "[$j] $i "
    j=$((j + 1))
  done
  num=$(select_range "Select the version: " 1 $((j - 1)))
  check_if_succeed $?
  version=$(echo $versionlist | cut -d " " -f $num)
  export distro=$distro
  export version=$version
  export CONTAINER_DIR=/data/data/com.termux/files/home/$distro-$version-$TIME
  rurima lxc pull -o $distro -v $version -s ${CONTAINER_DIR}
}
function docker_search() {
  read -p "Enter the string you want to search: " NAME
  check_if_succeed $?
  imagelist=$(rurima docker search -i $NAME -q | grep -v "Description:" | awk '{print $1}')
  imagelist+=" continue"
  j=1
  for i in $(echo $imagelist); do
    echo -e "[$j] $i "
    j=$((j + 1))
  done
  num=$(select_range "Select an image, or continue search: " 1 $((j - 1)))
  check_if_succeed $?
  image=$(echo $imagelist | cut -d " " -f $num)
  if [[ $image == "continue" ]]; then
    docker_search
  else
    export image=$image
  fi
}
function docker_search_tag() {
  taglist=$(rurima docker tag -i $image -q | awk '{print $2}')
  j=1
  for i in $(echo $taglist); do
    echo -e "[$j] $i "
    j=$((j + 1))
  done
  num=$(select_range "Select a tag: " 1 $((j - 1)))
  check_if_succeed $?
  num=$(echo $num | cut -d "[" -f 2 | cut -d "]" -f 1)
  tag=$(echo $taglist | cut -d " " -f $num)
  export tag=$tag
}
function rurima_pull_docker() {
  docker_search
  docker_search_tag
  export distro="$(echo $image | sed -e "s/\//_/g")"
  export version=$tag
  export CONTAINER_DIR=/data/data/com.termux/files/home/$distro-$version-$TIME
  rurima docker pull -i $image -t $tag -s ${CONTAINER_DIR}
  check_if_succeed $?
}
function rurima_pull_rootfs() {
  echo -e "[1] dockerhub\n[2] LXC"
  SOURCE=$(select_range "choose the source of rootfs: " 1 2)
  check_if_succeed $?
  export TIME=$(date +%s)
  if [[ ${SOURCE} == "1" ]]; then
    rurima_pull_docker
  else
    rurima_pull_lxc
  fi
  export NAME=$distro-$version-$TIME
}
