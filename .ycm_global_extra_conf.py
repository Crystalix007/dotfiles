def FlagsForFile( filename, **kwargs ):
    if (filename[-2:] == ".c"):
        return {
        'flags' : [ '-x', 'c', '-Wall', '-Wextra', '-Werror' ],
        }
    else:
        return {
        'flags': [ '-x', 'c++', '-std=c++14', '-Wall', '-Wextra', '-Werror' ],
        }

