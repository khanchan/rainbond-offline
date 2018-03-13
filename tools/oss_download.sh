#!/bin/bash

<<<<<<< HEAD
OSS_DOMAIN="http://pkg.goodrain.com"
OSS_PATH="releases/offline"
REPO_DIR="$PWD/repo"
RBDIMG_DIR="$PWD/rbdimg"

REPO_LIST_FILE="$PWD/tools/repo_list.ls"
RBD_IMG_LIST_FILE="$PWD/tools/rbd_img_list.ls"
=======
OSS_DOMAIN="https://dl.repo.goodrain.com"
OSS_PATH="releases/offline"
REPO_DIR="$PWD/repo"
ACPIMG_DIR="$PWD/rbdimg"

REPO_LIST_FILE="$PWD/tools/repo_list.ls"
ACP_IMG_LIST_FILE="$PWD/tools/rbd_img_list.ls"
>>>>>>> 442edba3145ab1f8fd196c4465ddc0ea7942a02a

function download_repo(){
    [ ! -d $REPO_DIR ] && mkdir -pv $REPO_DIR
    while read line
    do
        if [ "$line" == "repo/repodata" -o "$line" == "repo" ];then
            [ ! -d $line ] && mkdir -pv $line
            mkdir -pv $line
            continue
        fi
        [ ! -f $line ] && echo -n "Downloading $(basename $line) ... " \
        && curl -s $OSS_DOMAIN/$OSS_PATH/$line -o $line \
        && echo -e "\e[32mdone.\e[0m"
  done < $REPO_LIST_FILE
}

function download_rbdimg(){
    [ ! -d $RBDIMG_DIR ] && mkdir -pv $RBDIMG_DIR
    imgs_gz=$(cat $RBD_IMG_LIST_FILE | grep '.gz')
    for img_gz in $imgs_gz
    img_md5=$(echo $RBDIMG_DIR/$img_gz | sed 's/.gz/.md5/')
    img_id=$(echo $RBDIMG_DIR/$img_gz | sed 's/.gz/.id/')
    do
        if [ -f $RBDIMG_DIR/$img_gz ];then
            curl -s $OSS_DOMAIN/$OSS_PATH/$img_md5 -o $RBDIMG_DIR/$img_md5
            md5sum -c $RBDIMG_DIR/$img_gz > /dev/null 2>&1
                if [ $? -ne 0 ];then
                    curl -s $OSS_DOMAIN/$OSS_PATH/$img_gz -o $RBDIMG_DIR/$img_gz
                fi
        elif [ ! -f $RBDIMG_DIR/$img_id ];then
            curl -s $OSS_DOMAIN/$OSS_PATH/$img_id -o $RBDIMG_DIR/$img_id 
        else
            curl -s $OSS_DOMAIN/$OSS_PATH/$img_gz -o $RBDIMG_DIR/$img_gz
        fi
    done
}

# --- main -------
download_repo

<<<<<<< HEAD
download_rbdimg
=======
#download_acpimg
>>>>>>> 442edba3145ab1f8fd196c4465ddc0ea7942a02a
