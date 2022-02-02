require "mdeval".setup({
  require_confirmation=false,
  eval_options = {
    -- Set custom configuration for C++
    cpp = {
      command = {"clang++", "-std=c++20", "-O0"},
      default_header = [[
        #include <iostream>
        #include <vector>
        using namespace std;
      ]]
    },
  },
})
