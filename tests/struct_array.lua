local ffi = require("cffi")

ffi.cdef [[
    struct foo {
        int x;
        size_t pad1;
        size_t pad2;
        struct {
            char y;
            size_t pad3;
            size_t pad4;
            short z;
        };
        size_t pad5;
        size_t pad6;
        char const *w;
    };
]]

local x = ffi.new("struct foo")

local s = "hello"
x.x = 150
x.y = 30
x.z = 25
x.w = s

assert(x.x == 150)
assert(x.y == 30)
assert(x.z == 25)
assert(ffi.string(x.w) == "hello")

local ox = ffi.offsetof("struct foo", "x")
local oy = ffi.offsetof("struct foo", "y")
local oz = ffi.offsetof("struct foo", "z")
local ow = ffi.offsetof("struct foo", "w")

assert(ox == 0)
assert(oy > ox)
assert(oz > oy)
assert(ow > oy)

local x = ffi.new("int[3]")
assert(ffi.sizeof(x) == ffi.sizeof("int") * 3)

x[0] = 5
x[1] = 10
x[2] = 15

assert(x[0] == 5)
assert(x[1] == 10)
assert(x[2] == 15)
