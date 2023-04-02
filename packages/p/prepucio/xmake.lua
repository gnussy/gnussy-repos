package("prepucio")
    set_homepage("https://gnussy.org")
    set_description("PREPUC.io - a Portable REPL with Embedded Plugin Utility for C++")

    add_urls("https://github.com/gnussy/prepucio.git")
    add_versions("v1.0.0", "d284baf6b204e8b4f4f49aafc34ba48fdad4a238")

    add_deps("cmake", "fmt", "penis", "tabulate")

    on_install(function (package)
      local configs = {}
      table.insert(configs, "-DCMAKE_BUILD_TYPE=" .. (package:debug() and "Debug" or "Release"))
      table.insert(configs, "-DBUILD_SHARED_LIBS=" .. (package:config("shared") and "ON" or "OFF"))
      import("package.tools.cmake").install(package, configs)

      -- Copy the header files
      os.cp("include/**/*.hpp", package:installdir(path.join("include", "prepucio")))
      os.cp("build/linux/x86_64/release/*", package:installdir(path.join("lib")))
    end)

    on_test(function (package)
      assert(true)
    end)
