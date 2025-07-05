const std = @import("std");
const rl = @cImport(@cInclude("raylib.h"));

pub fn main() !void {
    std.debug.print("Starting zsim.\n", .{});

    rl.InitWindow(1280, 720, "zsim");
    defer rl.CloseWindow();

    while (!rl.WindowShouldClose()) {
        rl.BeginDrawing();
        defer rl.EndDrawing();

        rl.ClearBackground(rl.Color{ .r = 0, .g = 0, .b = 0, .a = 255 });
    }
}
