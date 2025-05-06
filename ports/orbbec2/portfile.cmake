vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO orbbec/OrbbecSDK_v2
    REF "v${VERSION}"
    SHA512 7aa0c25055004bb2e7d4f038c59be746b9d8d3088a828ad35fcd65b082789c0f4dc6af755d0f7a7fee683565967a393f8e44b230a2d60b23123ff5ce5f70da97
    HEAD_REF main
)

set(PLATFORM_OPTIONS)
if(VCPKG_TARGET_IS_ANDROID OR VCPKG_TARGET_IS_IOS)
    list(APPEND PLATFORM_OPTIONS -DOB_BUILD_SOVERSION=OFF)
endif()

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS ${FEATURE_OPTIONS}
        -DOB_BUILD_EXAMPLES=OFF
        -DOB_BUILD_TOOLS=OFF
        -DOB_BUILD_DOCS=OFF
        -DOB_BUILD_TESTS=OFF
        ${PLATFORM_OPTIONS}
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH lib)
# if(VCPKG_TARGET_IS_WINDOWS)

# endif()
vcpkg_copy_pdbs()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/examples")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/shared")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/lib/extensions")
file(REMOVE "${CURRENT_PACKAGES_DIR}/debug/bin/OrbbecSDKConfig.xml")
file(REMOVE "${CURRENT_PACKAGES_DIR}/debug/bin/OrbbecSDKConfig.md")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/examples")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/shared")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/lib/extensions")
file(REMOVE "${CURRENT_PACKAGES_DIR}/bin/OrbbecSDKConfig.xml")
file(REMOVE "${CURRENT_PACKAGES_DIR}/bin/OrbbecSDKConfig.md")


vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")
vcpkg_fixup_pkgconfig()