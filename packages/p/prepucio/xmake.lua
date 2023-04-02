package("prepucio")
    set_kind("library", {headeronly = true})
    set_homepage("https://gnussy.org")
    set_description("PREPUC.io - a Portable REPL with Embedded Plugin Utility for C++")

    add_urls("https://github.com/gnussy/prepucio.git")
    add_versions("v1.0.0", "adeab6bb99b226e4134d5e8d22d25875d5bce2ab")

    add_deps("fmt", "penis", "tabulate")

    on_install(function (package)
        local configs = {}
        io.writefile("xmake.lua", [[
            set_languages("c++20")
            add_rules("mode.debug", "mode.release")

            local libs = { "fmt", "penis", "tabulate" }

            add_includedirs("include")
            add_requires(table.unpack(libs))

            target("prepucio")
              set_kind("static")
              add_headerfiles("include/(**/*.hpp)")
              add_packages(table.unpack(libs))
        ]])
        import("package.tools.xmake").install(package, configs)
    end)

    on_test(function (package)
      assert(package:has_cxxincludes("prepucio/repl.hpp"))
    end)
