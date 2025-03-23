#!/bin/bash

# Remove Local Manifests
# rm -rf .repo/local_manifests/ 
# rm -rf hardware/mithorium/

# Init Rom Manifest
# repo init -u https://github.com/crdroidandroid/android.git -b 15.0 --git-lfs

# Clone local_manifests repository
# git clone https://github.com/tavukkdoner/local_manifests.git --depth 1 -b a14-los-official-test .repo/local_manifests 
# git clone https://github.com/tavukkdoner/local_manifests.git --depth 1 -b a15-qpr1 .repo/local_manifests

# git clone https://github.com/tavukkdoner/local_manifests.git --depth 1 -b a14-los-official-test .repo/local_manifests && 
# if [ ! $? == 0 ]
# then   curl -o .repo/local_manifests https://github.com/tavukkdoner/local_manifests.git
#  echo "Git clone failed, downloading through curl instead..."
# fi 

# crdroid qpr2 wip
# Sync the repositories  
# /opt/crave/resync.sh 
# /opt/crave/resynctest.sh

# Ty Crave 
cd frameworks/base
git remote add tmpRepo https://github.com/tavukkdoner/android_frameworks_base
git fetch tmpRepo 15.0
git cherry-pick 73148d9
git remote remove tmpRepo
cd ../../

cd lineage-sdk
git remote add tmpRepo1 https://github.com/tavukkdoner/android_lineage-sdk
git fetch tmpRepo1 15.0
git cherry-pick 5f2ee1b
git remote remove tmpRepo1
cd ../

cd vendor/lineage
git remote add tmpRepo2 https://github.com/tavukkdoner/android_vendor_crdroid
git fetch tmpRepo2 15.0
git cherry-pick 7af373d
git remote remove tmpRepo2
#git remote add tmpRepo4 https://github.com/LineageOS/android_vendor_lineage
#git fetch tmpRepo4 lineage-22.0
#git cherry-pick d6777fa
#git remote remove tmpRepo4
cd ../../



# cd frameworks/av/media/libstagefright/data/
# curl -O https://raw.githubusercontent.com/tavukkdoner/patches/refs/heads/main/media_codecs_sw.xml
# cd ../../../../../

# Set up build environment
export BUILD_USERNAME=tavukkdoner 
export BUILD_HOSTNAME=crave

source build/envsetup.sh

if [ ! -e "vendor/lineage-priv" ]; then
    curl -O https://raw.githubusercontent.com/tavukkdoner/crDroid-build-signed-script/crdroid/create-signed-env.sh
    chmod +x create-signed-env.sh
    ./create-signed-env.sh
fi
 
# Build the ROM
# lunch lineage_Mi439-ap2a-userdebug && make installclean && mka bacon

# Build the ROM
# lunch lineage_Mi439_4_19-ap2a-userdebug && make installclean && mka bacon

# https://review.lineageos.org/c/LineageOS/android_vendor_lineage/+/402103
# lunch lineage_Mi439_4_19-ap3a-userdebug && make installclean && mka bacon
# lunch lineage_Mi439_4_19-ap3a-eng && make installclean && mka bacon

# https://review.lineageos.org/c/LineageOS/android_vendor_lineage/+/411251
lunch lineage_Mi439_4_19-ap4a-userdebug && make installclean && mka bacon
# lunch lineage_Mi439_4_19-ap4a-eng && make installclean && mka bacon

# https://android.googlesource.com/platform/hardware/interfaces/+/refs/tags/android-15.0.0_r23
# https://review.lineageos.org/c/LineageOS/android_vendor_lineage/+/421399
# lunch lineage_Mi439_4_19-bp1a-userdebug && make installclean && mka bacon
# lunch lineage_Mi439_4_19-bp1a-eng && make installclean && mka bacon
