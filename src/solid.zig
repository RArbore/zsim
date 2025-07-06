const std = @import("std");

const rl = @cImport(@cInclude("raylib.h"));

const Box = struct {
    center_x: f32,
    center_y: f32,
    theta: f32,
    width: f32,
    height: f32,
};

pub const SolidList = std.MultiArrayList(Box);

pub fn addRandomSolid(list: *SolidList, allocator: std.mem.Allocator) !void {
    const theta = @as(f32, @floatFromInt(rl.GetRandomValue(0, 359)));
    const width = @as(f32, @floatFromInt(rl.GetRandomValue(20, 80)));
    const height = @as(f32, @floatFromInt(rl.GetRandomValue(20, 80)));
    const center_x = @as(f32, @floatFromInt(rl.GetMouseX()));
    const center_y = @as(f32, @floatFromInt(rl.GetMouseY()));
    try list.append(allocator, .{
        .center_x = center_x,
        .center_y = center_y,
        .theta = theta,
        .width = width,
        .height = height,
    });
}

pub fn drawSolids(list: SolidList) void {
    const slice = list.slice();
    for (slice.items(.center_x), slice.items(.center_y), slice.items(.theta), slice.items(.width), slice.items(.height)) |center_x, center_y, theta, width, height| {
        rl.DrawRectanglePro(rl.Rectangle{ .x = center_x, .y = center_y, .width = width, .height = height }, rl.Vector2{ .x = width / 2.0, .y = height / 2.0 }, theta, rl.WHITE);
    }
}
