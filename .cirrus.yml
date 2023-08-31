env:
    CIRRUS_CLONE_DEPTH: 1
    BUILD_HOSTNAME: "cirrus-ci.org"
    bot_api: "ENCRYPTED[d5f8289d835b201789b2b31e728d0cd82a100f1b47ddec69dd6ba49a3712fcfa2719b220fc6a8894865df517a78332ca]"
    one: "ENCRYPTED[267097e8096e1e12efc9c6e71626703ddc8ae1c6730511b6207586a045e2dd3bd59dd0b9d632642fc58d89913cc539a8]"
    two: "ENCRYPTED[7aa062112fa8a4acebe3b71432937334ed3fa05f2d8eaa044d7976e01cbf3fdff7f01f8c91a9e723304aa8b45816c459]"
    three: "ENCRYPTED[799a19ef34b1bd39bd174dbc5b2044e1fd4124b0bf9436ed68a3a197e68be303e15a59b4b448a4f58c44b0faa3c3892b]"
    four: "ENCRYPTED[9e0496c7d952b248073be75b1c017479eaf1e341786b6210025800b5d2f4d40b82452928bd6cc43ed1bc1065ee915363]"

task:
  name: Test
  skip: $CIRRUS_BRANCH == 'main'
  only_if: $CIRRUS_REPO_OWNER == 'ROM-builders'
  timeout_in: 2m
  persistent_worker:
    labels:
      name: AX61-2
    isolation:
      container:
        image: apon77/aosp:cirrus
        cpu: 2
        memory: 4G
  env_script: env
  show_script: cat $CIRRUS_WORKING_DIR/build_rom.sh
  notify_script: curl -s https://raw.githubusercontent.com/ROM-builders/temporary/main/ci/notify.sh | bash
  test_script: curl -s https://raw.githubusercontent.com/ROM-builders/temporary/main/ci/test.sh | bash

task:
  name: Build
  skip: $CIRRUS_BRANCH == 'main'
  only_if: $CIRRUS_REPO_OWNER == 'ROM-builders'
  depends_on: Test
  timeout_in: 4h
  persistent_worker:
    labels:
      name: AX61-1
    isolation:
      container:
        image: apon77/aosp:cirrus
        cpu: 24
        memory: 120G
        volumes:
          - /home/cirrus/roms:/home/cirrus/roms
          - /home/cirrus/ccache:/home/cirrus/ccache
          - /home/cirrus/.config:/home/cirrus/.config
  show_script: cat $CIRRUS_WORKING_DIR/build_rom.sh
  test_script: curl -s https://raw.githubusercontent.com/ROM-builders/temporary/main/ci/test.sh | bash
  sync_script: curl -s https://raw.githubusercontent.com/ROM-builders/temporary/main/ci/sync.sh | bash
  tsync_script: curl -s https://raw.githubusercontent.com/ROM-builders/temporary/main/ci/tsync.sh | bash
  build_script: curl -s https://raw.githubusercontent.com/ROM-builders/temporary/main/ci/build.sh | bash
  ccache_stats_script: curl -s https://raw.githubusercontent.com/ROM-builders/temporary/main/ci/ccache_stats.sh | bash
  upload_script: curl -s https://raw.githubusercontent.com/ROM-builders/temporary/main/ci/upload.sh | bash
  remove_script: curl -s https://raw.githubusercontent.com/ROM-builders/temporary/main/ci/remove.sh | bash

task:
  name: Post Build
  skip: $CIRRUS_BRANCH == 'main'
  only_if: $CIRRUS_REPO_OWNER == 'ROM-builders'
  skip_notifications: true
  depends_on: Build
  timeout_in: 2m
  persistent_worker:
    labels:
      name: AX61-2
    isolation:
      container:
        image: apon77/aosp:cirrus
        cpu: 2
        memory: 4G
  test_script: curl -s https://raw.githubusercontent.com/ROM-builders/temporary/main/ci/test.sh | bash
  post_build_script: curl -s https://raw.githubusercontent.com/ROM-builders/temporary/main/ci/post_build.sh | bash
