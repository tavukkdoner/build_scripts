#!/bin/bash

# Remove Local Manifests
rm -rf .repo/local_manifests/ 

# Init Rom Manifest
repo init -u https://github.com/crdroidandroid/android.git -b 14.0 --git-lfs

# Clone local_manifests repository
# git clone https://github.com/tavukkdoner/local_manifests.git --depth 1 -b a14-los-official-test .repo/local_manifests 
# git clone https://github.com/tavukkdoner/local_manifests.git --depth 1 -b a14-los-official-avc1-viperfx .repo/local_manifests
git clone https://github.com/tavukkdoner/local_manifests.git --depth 1 -b a14-crdroid-mithorium .repo/local_manifests 

# git clone https://github.com/tavukkdoner/local_manifests.git --depth 1 -b a14-los-official-test .repo/local_manifests && 
# if [ ! $? == 0 ]
# then   curl -o .repo/local_manifests https://github.com/tavukkdoner/local_manifests.git
#  echo "Git clone failed, downloading through curl instead..."
# fi 

# Sync the repositories  
# /opt/crave/resync.sh 
/opt/crave/resynctest.sh

# Ty Crave 
cd packages/apps/Settings
git remote add tmpRepo https://github.com/tavukkdoner/android_packages_apps_Settings
git fetch tmpRepo
git cherry-pick 75c8e07
git cherry-pick 7ecc750
git remote remove tmpRepo
cd ../../../

# Set up build environment
export BUILD_USERNAME=tavukkdoner 
export BUILD_HOSTNAME=crave 

source build/envsetup.sh

# Signing (call this once first time to generate keys and comment those lines for other times) 
# (call again if /vendor/lineage-priv is not exist)
# change with your values before using this script from country code until email 
# curl -O https://raw.githubusercontent.com/tavukkdoner/crDroid-build-signed-script/crdroid/create-signed-env.sh
# chmod +x create-signed-env.sh
# ./create-signed-env.sh

# after second and more time no need to generate again and again keys connect your storage
# copy that folder to keep prevent if removed somehow
# run in crave ssh 
# cp -r /vendor/lineage-priv .
# then you can call below command otherwise you won't find that folder since you didn't copy
# cp -r lineage-priv/ vendor
 
# Build the ROM
# lunch lineage_Mi439-ap2a-userdebug && make installclean && mka bacon

# Build the ROM
lunch lineage_Mi439_4_19-ap2a-userdebug && make installclean && mka bacon

# https://review.lineageos.org/c/LineageOS/android_vendor_lineage/+/402103
# lunch lineage_Mi439_4_19-ap3a-userdebug && make installclean && mka bacon
