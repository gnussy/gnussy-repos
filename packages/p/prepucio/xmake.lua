package("prepucio")
    set_kind("library", {headeronly = true})
    set_homepage("https://gnussy.org")
    set_description("PREPUC.io - a Portable REPL with Embedded Plugin Utility for C++")

    add_urls("https://github.com/gnussy/prepucio.git")
    add_versions("v1.0.0", "3bf1cd9b3078360d2d99c4a8228e7b726d59cef8")
    add_versions("v1.1.0", "11f82633cb5d441ca387f8a8b23716a1e8fce7ae")
    add_versions("v1.1.1", "67f8b264014583f397fcdbb54826101f19847538")

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
              set_kind("headeronly")
              add_headerfiles("include/(**/*.hpp)")
              add_packages(table.unpack(libs))
        ]])
        import("package.tools.xmake").install(package, configs)
    end)

    on_test(function (package)
      assert(package:has_cxxincludes("prepucio/repl.hpp"))
    end)
