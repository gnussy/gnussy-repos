package("stx")
    set_homepage("https://lamarrr.github.io/STX")
    set_description("C++17 & C++ 20 error-handling and utility extensions. ")
    set_license("MIT")

    add_urls("https://github.com/lamarrr/STX/archive/refs/tags/$(version).tar.gz",
             "https://github.com/lamarrr/STX.git")
    add_versions("v1.0.2", "a34a886fd1aa23bccfa25e24dedebee30ced812f438c0e20fe2e4aed295e6485")

    add_deps("cmake")

    on_install(function (package)
        local configs = {}
        table.insert(configs, "-DCMAKE_BUILD_TYPE=" .. (package:debug() and "Debug" or "Release"))
        table.insert(configs, "-DBUILD_SHARED_LIBS=" .. (package:config("shared") and "ON" or "OFF"))
        import("package.tools.cmake").install(package, configs)
    end)

    on_test(function (package)
      -- Check for the stx::Option type
      assert(package:has_cxxfuncs("stx::Option<int> opt = stx::Some(42);", {configs = {languages = "c++17"}, includes = "stx/option.h"}))
    end)
