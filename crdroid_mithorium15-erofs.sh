#!/bin/bash

# Remove Local Manifests
# rm -rf .repo/local_manifests/ 
# rm -rf frameworks/base
# rm -rf kernel/xiaomi/mithorium-4.19/kernel
# rm -rf hardware/mithorium/

# Init Rom Manifest
# repo init -u https://github.com/crdroidandroid/android.git -b 15.0 --git-lfs

# Clone local_manifests repository
# git clone https://github.com/tavukkdoner/local_manifests.git --depth 1 -b a14-los-official-test .repo/local_manifests 
# git clone https://github.com/tavukkdoner/local_manifests.git --depth 1 -b a14-los-official-avc1-viperfx .repo/local_manifests
# git clone https://github.com/tavukkdoner/local_manifests1.git --depth 1 -b a15-crdroid-mithorium .repo/local_manifests 
# git clone https://github.com/tavukkdoner/local_manifests.git --depth 1 -b a15-qpr2-test .repo/local_manifests

# Original local_manifest Mi439 A15 QPR2 no modifications -> a15-qpr2-mithorium
# git clone https://github.com/tavukkdoner/local_manifests.git --depth 1 -b a15-qpr2-mithorium .repo/local_manifests

# git clone https://github.com/tavukkdoner/local_manifests.git --depth 1 -b a14-los-official-test .repo/local_manifests && 
# if [ ! $? == 0 ]
# then   curl -o .repo/local_manifests https://github.com/tavukkdoner/local_manifests.git
#  echo "Git clone failed, downloading through curl instead..."
# fi 

# Sync the repositories  
# /opt/crave/resync.sh 
# /opt/crave/resynctest.sh


cd frameworks/base
git remote add tmpRepofb https://github.com/tavukkdoner/android_frameworks_base
git fetch tmpRepofb 15.0-qpr2
git cherry-pick 175aa44
#git cherry-pick 4841960
#git cherry-pick 2423cf5
git remote remove tmpRepofb
cd ../../

# cd frameworks/av/media/libstagefright/data/
# curl -O https://raw.githubusercontent.com/tavukkdoner/patches/refs/heads/main/media_codecs_sw.xml
# cd ../../../../../

# Set up build environment
export BUILD_USERNAME=tavukkdoner 
export BUILD_HOSTNAME=crave

export TARGET_USES_EROFS=true

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
# lunch lineage_Mi439_4_19-ap4a-userdebug && make installclean && mka bacon
# lunch lineage_Mi439_4_19-ap4a-eng && make installclean && mka bacon

# https://android.googlesource.com/platform/hardware/interfaces/+/refs/tags/android-15.0.0_r23
# https://review.lineageos.org/c/LineageOS/android_vendor_lineage/+/421399
lunch lineage_Mi439_4_19-bp1a-userdebug && make installclean && mka bacon
# lunch lineage_Mi439_4_19-bp1a-eng && make installclean && mka bacon
