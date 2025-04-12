# Output directories
CONFIG(debug, debug|release) {
    DESTDIR = $$PWD/build/debug
} else {
    DESTDIR = $$PWD/build/release
}

# Windows MinGW (g++)
win32-g++* {
    QMAKE_CFLAGS += -Wno-missing-field-initializers -Werror=format-security -Wno-unused-parameter
    QMAKE_CXXFLAGS += $$QMAKE_CFLAGS
}

# Linux (GCC/Clang)
unix:!macx {
    QMAKE_CFLAGS += -Wno-missing-field-initializers -Werror=format-security -Wno-unused-parameter
    QMAKE_CXXFLAGS += $$QMAKE_CFLAGS
}

# macOS (Clang)
unix:macx {
    QMAKE_CFLAGS += -Wno-missing-field-initializers -Werror=format-security -Wno-unused-parameter
    QMAKE_CXXFLAGS += $$QMAKE_CFLAGS
}

# Modern MSVC (VS2017–VS2022)
win32-msvc* {
    QMAKE_CXXFLAGS += /W4 /MP           # High warnings + multiprocessor build
    QMAKE_LFLAGS += /OPT:REF /OPT:ICF   # Link-time optimization
}

# Optional: Debug symbols flag
contains(DEFINES, CREATE_PDB) {
    QMAKE_CXXFLAGS += /Zi
    QMAKE_LFLAGS += /DEBUG 
}
