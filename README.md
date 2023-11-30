# cmake-conan

This is branch of https://github.com/conan-io/cmake-conan/tree/develop2

## Differences betten this branch and conan-io/cmake-conan develop2 branch

* This branch does not require CMake 3.24 - it can run older cmake versions
* Usage does not require setting `CMAKE_PROJECT_TOP_LEVEL_INCLUDES` variable
* Script `conan-provider.cmake` can be included after first `project` call
* All conan arguments can be set with `CONAN_ARGS` variable


## To do

- [x] Does not require Conan 3.24
- [x] Does not require `CMAKE_PROJECT_TOP_LEVEL_INCLUDES` variable to work
- [x] Allow setting `conanfile.txt`/`conanfile.py` location
- [ ] Implement `find_program`, `find_library`, `find_path`, `find_file` functions 
- [ ] Write unit tests for added changes
- [ ] Test code with `pytest` to see if changes did not broke the code.

## Ideas

- [ ] `conan install` can be deduced from `conan install -h` command line

## Known limitations

For now the same limitations apply to this code as in orginal code.

## Development, contributors

There are some tests, you can run in python, with pytest, for example:

```bash
$ pytest -rA
```


### CMake

#### GLOBAL properties: 

* `CONAN_INSTALL_SUCCESS` - set to `TRUE` by `conan_install` if successful
* `CONAN_GENERATORS_FOLDER` - generator folder path set by `conan_install` if successful
* `CONAN_PROVIDE_DEPENDENCY_INVOKED` - set to true if `conan_provide_dependency` was called

#### Cache variables:

* `CONAN_COMMAND` - file path to conan command

#### Macros

* `conan_provide_dependency` - default handle for override find_package

#### Functions

* `conan_install` - invoke conan install command set `CONAN_INSTALL_SUCCESS` property, requires `CONAN_COMMAND` to be set