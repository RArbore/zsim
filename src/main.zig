const std = @import("std");

const solid = @import("solid.zig");

const rl = @cImport(@cInclude("raylib.h"));

pub fn main() !void {
    std.debug.print("Starting zsim.\n", .{});

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var solids = solid.SolidList{};
    defer solids.deinit(allocator);

    rl.InitWindow(1280, 720, "zsim");
    defer rl.CloseWindow();

    while (!rl.WindowShouldClose()) {
        if (rl.IsCursorOnScreen() and rl.IsMouseButtonPressed(rl.MOUSE_BUTTON_LEFT)) {
            try solid.addRandomSolid(&solids, allocator);
        }

        rl.BeginDrawing();
        defer rl.EndDrawing();

        rl.ClearBackground(rl.BLACK);
        solid.drawSolids(solids);
    }
}
