# AOSP Builder
Build aosp project in docker with Ubuntu 20.04 via ci environments (by [Apon77](https://github.com/Apon77)), **edited**

Thanks [Cirrus CI](https://cirrus-ci.com/) for their awesome service!

I tried to explian every steps by comments! Try to read those throughly!

[ You can use your own creativity for this whole process, what i did is used the normal process, collected the cache, redownloaded and reused it, and for overcoming time limit first build was done with a timeout from our side to get ccache uploaded. You can do these processes manually too! But I like ci! Let's a ci be ci, hehe. ]

## Steps:

1. Fork this repo
2. Go to https://github.com/marketplace/cirrus-ci
3. Pricing and setup > Public Repositories > Install it for free
4. In next page click Complete order and begin installation
5. In next page select All repositories or only selected repository (select aosp-builder) > Install
6. In next page give password and Confirm password
7. Setup is done for cirrus ci in your account! You can close the tab now!
8. Now use "ccache" branch to generate ccache: edit only "sync" and "build", place your rom sync and device sauce and edit build instructions respectively
9. Build should start on cirrus, after 2 hrs, ccache will complete(build will be incomplete, only ccache generated) now mirror that ccahce in any gdrive mirror group with the extension .tar.gz   example: ccache1.tar.gz
10. Now use "build" branch and edit "build" and "sync" again (with your device sauce and rom manifest), this time also edit "ccache_upload" branch and place your download link and edit the extract name respectively(depending on what name you've given while mirroring)
Build should be done, if time remains, even new ccache can be uploaded(not needed tho)

11. **optional:** If your build fails due to kernel issues, then use prebuilt kernel
12. see "example" branch to see how stuff is done, **if you know what youre doing**, you can edit other vaules too
