const std = @import("std");

pub const Node = struct {
    value: i8,
    allocator: std.heap.page_allocator,
    children: std.BoundedArray(Node, 6),

    pub fn init(value: i8, len: usize) Node {
        return Node{
            .value = value,
            .children = std.BoundedArray(Node).init(len),
        };
    }
};

pub fn GenerateAllNodesIterative(node: *Node) !void {
    var queue = std.DoublyLinkedList(*Node){};
    var list_node = std.DoublyLinkedList(*Node).Node{ .data = node };
    queue.append(&list_node);
    var current_node: *Node = node;
    while (queue.len != 0) {
        current_node = queue.first.?.data;
        //possible moves are [-17,-15,-10,-6,+6,+10,+15,+17]
        std.debug.print("node value is :{any}", .{node.*.value});
        if (current_node.*.value - 17 > 0 and current_node.*.value < 64) {
            var child_node_up_left = Node.init(current_node.value + 17, std.heap.page_allocator);
            current_node.*.children.?.append(&child_node_up_left) catch |err| {
                std.debug.print("{any} happend when trying to append childern to a node\n", .{err});
            };
            var new_node = std.DoublyLinkedList(*Node).Node{ .data = &child_node_up_left };
            queue.append(&new_node);
        }
        const head = queue.popFirst();
        std.debug.print("Head :{any}", .{head.?.data.*.value});
    }
}
pub fn PrintHashMap(map: std.AutoHashMap) !void {
    var it = map.iterator();
    while (it.next()) |entry| {
        std.debug.print("key:{any},value{any}\n", .{ entry.key_ptr.*, entry.value_ptr.* });
    }
}

pub fn main() !void {
    var buffer: [1024]u8 = undefined;
    var allocator = std.heap.FixedBufferAllocator.init(&buffer);
    const alloc = allocator.allocator();
    var nodes_visited = std.AutoHashMap(u8, u8).init(alloc);
    defer nodes_visited.deinit();
    var i: u8 = 0;
    for (0..63) |_| {
        nodes_visited.put(i, i) catch |err| {
            std.debug.print("this happend :{any}\n", .{err});
        };
        i += 1;
    }
    std.debug.print("nigga\n", .{});
    var node = Node.init(63);
    GenerateAllNodesIterative(&node) catch |err| {
        std.debug.print("{any}", .{err});
    };

    nodes_visited.put(i, i) catch |err| {
        std.debug.print("this happend :{any}\n", .{err});
    };
}
