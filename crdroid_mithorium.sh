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
git fetch tmpRepo 14.0
git cherry-pick 75c8e07
git cherry-pick 7ecc750
# https://github.com/crdroidandroid/android_packages_apps_Settings/commit/8ae1b733443d0aecacef1f64f2e020c95e42ca22
git revert 8ae1b73
git remote remove tmpRepo
cd ../../../

cd lineage-sdk
git remote add tmpRepo1 https://github.com/tavukkdoner/android_lineage-sdk
git fetch tmpRepo1 14.0
git cherry-pick 89ef794
git remote remove tmpRepo1
cd ../

cd vendor/lineage
git remote add tmpRepo2 https://github.com/tavukkdoner/android_vendor_crdroid
git fetch tmpRepo2 14.0
git cherry-pick 40fe82e
git remote remove tmpRepo2
cd ../../

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
lunch lineage_Mi439_4_19-ap2a-userdebug && make installclean && mka bacon

# https://review.lineageos.org/c/LineageOS/android_vendor_lineage/+/402103
# lunch lineage_Mi439_4_19-ap3a-userdebug && make installclean && mka bacon
