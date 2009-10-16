# - Find HDF5, a library for reading and writing self describing array data.
#
FIND_PATH(HDF5_INCLUDE_DIR hdf5.h)

FIND_LIBRARY(HDF5_CORE_LIBRARY NAMES hdf5 hdf5dll )
FIND_LIBRARY(HDF5_HL_LIBRARY NAMES hdf5_hl hdf5_hldll )
FIND_LIBRARY(HDF5_Z_LIBRARY NAMES z zlib1 )
FIND_LIBRARY(HDF5_SZ_LIBRARY NAMES sz  szlibdll )

set(HDF5_SUFFICIENT_VERSION FALSE)
set(HDF5_COMPILED FALSE)
TRY_RUN(HDF5_SUFFICIENT_VERSION HDF5_COMPILED
        ${CMAKE_BINARY_DIR} ${PROJECT_SOURCE_DIR}/config/checkHDF5version.c
        COMPILE_DEFINITIONS "-I${HDF5_INCLUDE_DIR} -DMIN_MAJOR=1 -DMIN_MINOR=8") 
        
if(${HDF5_COMPILED} MATCHES TRUE AND ${HDF5_SUFFICIENT_VERSION} EQUAL 0)
    set(HDF5_SUFFICIENT_VERSION TRUE)
else()
    MESSAGE( STATUS "HDF5: need at least version 1.8" )
    set(HDF5_SUFFICIENT_VERSION FALSE)
endif()

# handle the QUIETLY and REQUIRED arguments and set HDF5_FOUND to TRUE if 
# all listed variables are TRUE
INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(HDF5 DEFAULT_MSG HDF5_CORE_LIBRARY HDF5_HL_LIBRARY HDF5_Z_LIBRARY HDF5_SZ_LIBRARY HDF5_INCLUDE_DIR HDF5_SUFFICIENT_VERSION)

IF(HDF5_FOUND)
  SET(HDF5_LIBRARIES ${HDF5_CORE_LIBRARY} ${HDF5_HL_LIBRARY} ${HDF5_Z_LIBRARY} ${HDF5_SZ_LIBRARY})
ENDIF(HDF5_FOUND)

MARK_AS_ADVANCED(HDF5_LIBRARIES HDF5_INCLUDE_DIR )
