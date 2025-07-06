const std = @import("std");

const solid = @import("solid.zig");

const GRAVITY = 100.0;

pub fn tick_solids(list: *solid.SolidList, dt: f32) void {
    const slice = list.slice();

    for (slice.items(.velocity_y)) |*velocity_y| {
        velocity_y.* += dt * GRAVITY;
    }

    for (slice.items(.center_y), slice.items(.velocity_y)) |*center_y, velocity_y| {
        center_y.* += dt * velocity_y;
    }
}
