QT -= gui        # No GUI modules
QT += core       # Required for QObject and QString etc.

CONFIG += c++17 console
CONFIG -= app_bundle

TARGET = pdbripperc

TEMPLATE = app   # This ensures it's a CLI application

# Include shared build config
include(../build.pri)

# Source files
SOURCES += \
    ../pdbprocess.cpp \
    ../qwinpdb.cpp \
    main_console.cpp \
    consoleoutput.cpp \
    ../msdia/diaCreate.cpp

HEADERS += \
    ../pdbprocess.h \
    ../qwinpdb.h \
    ../qwinpdb_def.h \
    consoleoutput.h

INCLUDEPATH += ../msdia
