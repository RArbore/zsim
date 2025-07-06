const std = @import("std");

const physics = @import("physics.zig");
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

        const dt = rl.GetFrameTime();
        physics.tick_solids(&solids, dt);

        rl.BeginDrawing();
        rl.ClearBackground(rl.BLACK);
        solid.drawSolids(solids);
        rl.DrawFPS(0, 0);
        rl.EndDrawing();
    }
}
