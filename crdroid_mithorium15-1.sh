#!/bin/bash

# Remove Local Manifests
rm -rf .repo/local_manifests/ 

# Init Rom Manifest
repo init -u https://github.com/crdroidandroid/android.git -b 15.0 --git-lfs

# Clone local_manifests repository
# git clone https://github.com/tavukkdoner/local_manifests.git --depth 1 -b a14-los-official-test .repo/local_manifests 
# git clone https://github.com/tavukkdoner/local_manifests.git --depth 1 -b a14-los-official-avc1-viperfx .repo/local_manifests
git clone https://github.com/tavukkdoner/local_manifests.git --depth 1 -b a15 .repo/local_manifests 

# git clone https://github.com/tavukkdoner/local_manifests.git --depth 1 -b a14-los-official-test .repo/local_manifests && 
# if [ ! $? == 0 ]
# then   curl -o .repo/local_manifests https://github.com/tavukkdoner/local_manifests.git
#  echo "Git clone failed, downloading through curl instead..."
# fi 

# Sync the repositories  
# /opt/crave/resync.sh 
/opt/crave/resynctest.sh

cd device/xiaomi/Mi439
git remote add tmpRepo3 https://github.com/tavukkdoner/android_device_xiaomi_Mi439
git fetch tmpRepo3 a15/master1
git cherry-pick bfbe607
git remote remove tmpRepo3
cd ../../../


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

