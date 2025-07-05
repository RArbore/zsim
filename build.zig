const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const exe = b.addExecutable(.{
        .name = "zsim",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(exe);

    const raylib = b.dependency("raylib", .{
        .target = target,
        .optimize = optimize,
        .shared = true,
    });
    const libraylib = raylib.artifact("raylib");
    exe.linkLibrary(libraylib);

    const run_exe = b.addRunArtifact(exe);
    run_exe.step.dependOn(b.getInstallStep());
    const run_step = b.step("run", "Run zsim");
    run_step.dependOn(&run_exe.step);
}
