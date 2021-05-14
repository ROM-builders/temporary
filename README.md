Getting Started
---------------

To get started with Android, you'll need to get
familiar with [Git and Repo](https://source.android.com/source/using-repo.html).

1.Set up your environment

    sudo apt-get install git-core
    git clone https://github.com/akhilnarang/scripts
    cd scripts
    bash setup/android_build_env.sh

2.Then run these commands to get git all working:

     git config --global user.email "you@example.com"
     git config --global user.name "Your Name"

3.Then Create a folder for LineageOS and open it

    mkdir los
    cd los

4.To initialize your local repository using the LineageOS trees, use a command like this:

    repo init -u git://github.com/LineageOS/android.git -b lineage-18.1 --depth=1
     

5.Now create a local_manifests dir and Copy the required manifests in that folder.

    mkdir .repo/local_manifests

    wget -O .repo/local_manifests/MSM8916.xml 'https://raw.githubusercontent.com/MOTO-M8916/android_manifest/lineage-18.1/MSM8916.xml'
    
6.Then to sync up:

    repo sync -c -f --force-sync

OR, for those with limited bandwidth/storage:

    repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
    
7.Run this command if you used the automatic method of setup above (50GB ccache (onetime requirement))

    ccache -M 50G
    
8.Run this to enable ccache

    export USE_CCACHE=1
    export CCACHE_EXEC=$(command -v ccache)

9.To start the build once everything is ready , Run to prepare our devices list

    . build/envsetup.sh

10.Now build (codename: osprey/lux/surnia/harpia/merlin)

    brunch codename  

Please see the [LineageOS Wiki](https://wiki.lineageos.org/) for building instructions.

