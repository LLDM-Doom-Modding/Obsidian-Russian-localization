##########################################
# physfs
##########################################

option(PHYSFS_ARCHIVE_ZIP "Enable ZIP support" ON)
if(NOT PHYSFS_ARCHIVE_ZIP)
    add_definitions(-DPHYSFS_SUPPORTS_ZIP=0)
endif()

option(PHYSFS_ARCHIVE_7Z "Enable 7zip support" OFF)
if(NOT PHYSFS_ARCHIVE_7Z)
    add_definitions(-DPHYSFS_SUPPORTS_7Z=0)
endif()

option(PHYSFS_ARCHIVE_GRP "Enable Build Engine GRP support" OFF)
if(NOT PHYSFS_ARCHIVE_GRP)
    add_definitions(-DPHYSFS_SUPPORTS_GRP=0)
endif()

option(PHYSFS_ARCHIVE_WAD "Enable Doom WAD support" OFF)
if(NOT PHYSFS_ARCHIVE_WAD)
    add_definitions(-DPHYSFS_SUPPORTS_WAD=0)
endif()

option(PHYSFS_ARCHIVE_HOG "Enable Descent I/II HOG support" OFF)
if(NOT PHYSFS_ARCHIVE_HOG)
    add_definitions(-DPHYSFS_SUPPORTS_HOG=0)
endif()

option(PHYSFS_ARCHIVE_MVL "Enable Descent I/II MVL support" OFF)
if(NOT PHYSFS_ARCHIVE_MVL)
    add_definitions(-DPHYSFS_SUPPORTS_MVL=0)
endif()

option(PHYSFS_ARCHIVE_QPAK "Enable Quake I/II QPAK support" OFF)
if(NOT PHYSFS_ARCHIVE_QPAK)
    add_definitions(-DPHYSFS_SUPPORTS_QPAK=0)
endif()

option(PHYSFS_ARCHIVE_SLB "Enable I-War / Independence War SLB support" OFF)
if(NOT PHYSFS_ARCHIVE_SLB)
    add_definitions(-DPHYSFS_SUPPORTS_SLB=0)
endif()

option(PHYSFS_ARCHIVE_ISO9660 "Enable ISO9660 support" OFF)
if(NOT PHYSFS_ARCHIVE_ISO9660)
    add_definitions(-DPHYSFS_SUPPORTS_ISO9660=0)
endif()

option(PHYSFS_ARCHIVE_VDF "Enable Gothic I/II VDF archive support" OFF)
if(NOT PHYSFS_ARCHIVE_VDF)
    add_definitions(-DPHYSFS_SUPPORTS_VDF=0)
endif()

add_library(physfs
    src/physfs.c
    src/physfs_byteorder.c
    src/physfs_unicode.c
    src/physfs_platform_posix.c
    src/physfs_platform_unix.c
    src/physfs_platform_windows.c
    src/physfs_platform_os2.c
    src/physfs_platform_qnx.c
    src/physfs_platform_android.c
    src/physfs_archiver_dir.c
    src/physfs_archiver_unpacked.c
    src/physfs_archiver_grp.c
    src/physfs_archiver_hog.c
    src/physfs_archiver_7z.c
    src/physfs_archiver_mvl.c
    src/physfs_archiver_qpak.c
    src/physfs_archiver_wad.c
    src/physfs_archiver_zip.c
    src/physfs_archiver_slb.c
    src/physfs_archiver_iso9660.c
    src/physfs_archiver_vdf.c
)

target_include_directories(physfs PUBLIC ./src)