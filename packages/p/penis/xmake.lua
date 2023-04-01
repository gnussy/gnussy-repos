package("penis")
    set_homepage("https://github.com/gnussy/penis")
    set_description("penis")

    add_urls("https://github.com/gnussy/penis.git")
    add_versions("v1.0.0", "b29cfb503971b0b30b4a7afe98877de792ae2a23")

    on_install(function (package)
      local configs = {}
      table.insert(configs, "-DCMAKE_BUILD_TYPE=" .. (package:debug() and "Debug" or "Release"))
      table.insert(configs, "-DBUILD_SHARED_LIBS=" .. (package:config("shared") and "ON" or "OFF"))
      import("package.tools.cmake").install(package, configs)

      -- Copy the header files
      os.cp("include/**/*.hpp", package:installdir(path.join("include", "penis")))
      os.cp("build/linux/x86_64/release/*", package:installdir(path.join("lib")))
    end)

    on_test(function (package)
      assert(true)
    end)
