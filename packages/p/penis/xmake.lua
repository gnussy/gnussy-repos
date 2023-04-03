package("penis")
    set_homepage("https://github.com/gnussy/penis")
    set_description("penis")

    add_urls("https://github.com/gnussy/penis.git")
    add_versions("v1.0.0", "b29cfb503971b0b30b4a7afe98877de792ae2a23")
    add_versions("v1.1.1", "0e01f703b54388d5e8294f18b5031d94d447e658")
    add_versions("v2.0.0", "62ef47aa2f3bbeba05e15c0940a78824a5b06367")

    on_install(function (package)
      local configs = {}
      io.writefile("xmake.lua", [[
          set_languages("c++20")
          add_rules("mode.release")

          add_includedirs("include")

          target("penis")
            set_kind("$(kind)")
            add_files("src/**/*.cpp")
            add_headerfiles("include/(**/*.hpp)")
      ]])

      if package:config("shared") then
        configs.kind = "shared"
      else
        configs.kind = "static"
      end

      import("package.tools.xmake").install(package, configs)
    end)

    on_test(function (package)
      assert(package:has_cxxincludes("penis/penis.hpp"))
    end)
