const std = @import("std");

pub const Node = struct {
    value: u8,
    children: ?std.ArrayList(*Node),

    pub fn init(value: u8) Node {
        return Node{
            .value = value,
            .children = null,
        };
    }
};
pub fn GenerateAllNodesRecursive(node: *Node, nodes_visited: std.AutoHashMap) !void {
pub fn GenerateAllNodesRecursive(node: *Node, nodes_visited: std.AutoHashMap) !void {
    if (nodes_visited.put()) {
        //possible moves are [-17,-15,-10,-6,+6,+10,+15,+17]
        if (node.value - 17 > 0) {
            const child_node = Node.init(node.value - 17, null);
            node.children.?.append(child_node);
            GenerateAllNodesRecursive(child_node, nodes_visited);
            GenerateAllNodesRecursive(child_node, nodes_visited);
        }
        if (node.value - 15 > 0) {
            const child_node = Node.init(node.value - 15, null);
            node.children.?.append();
            node.children.?.append(child_node);
            GenerateAllNodesRecursive(child_node, nodes_visited);
            GenerateAllNodesRecursive(child_node, nodes_visited);
        }
        if (node.value - 10 > 0) {
            const child_node = Node.init(node.value - 10, null);
            node.children.?.append(child_node);
            GenerateAllNodesRecursive(child_node, nodes_visited);
            GenerateAllNodesRecursive(child_node, nodes_visited);
        }
        if (node.value - 6 > 0) {
            const child_node = Node.init(node.value - 6, null);
            node.children.?.append(child_node);
            GenerateAllNodesRecursive(child_node, nodes_visited);
            GenerateAllNodesRecursive(child_node, nodes_visited);
        }
        if (node.value + 6 > 0) {
            const child_node = Node.init(node.value + 6, null);
            node.children.?.append(child_node);
            GenerateAllNodesRecursive(child_node, nodes_visited);
            GenerateAllNodesRecursive(child_node, nodes_visited);
        }
        if (node.value + 10 > 0) {
            const child_node = Node.init(node.value + 10, null);
            node.children.?.append(child_node);
            GenerateAllNodesRecursive(child_node, nodes_visited);
            GenerateAllNodesRecursive(child_node, nodes_visited);
        }
        if (node.value + 15 > 0) {
            const child_node = Node.init(node.value + 15, null);
            node.children.?.append(child_node);
            GenerateAllNodesRecursive(child_node, nodes_visited);
            GenerateAllNodesRecursive(child_node, nodes_visited);
        }
        if (node.value + 17 > 0) {
            const child_node = Node.init(node.value + 17, null);
            node.children.?.append(child_node);
            GenerateAllNodesRecursive(child_node, nodes_visited);
            GenerateAllNodesRecursive(child_node, nodes_visited);
        }
    } else {
        return node;
    }
}

pub fn GenerateAllNodesIterative(node: *Node) !void {
    var queue = std.DoublyLinkedList(*Node){};
    var list_node = std.DoublyLinkedList(*Node).Node{ .data = node };
    queue.append(&list_node);
    var current_node: *Node = node;
    while (queue.len != 0) {
        std.debug.print("node value is :{any}", .{node.*.value});
        if (current_node.*.value + 17 > 0) {
            var child_node = Node.init(current_node.value + 17);
            var new_node = std.DoublyLinkedList(*Node).Node{ .data = &child_node };
            queue.append(&new_node);
            current_node = &child_node;
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
    std.debug.print("nigga", .{});
    var node = Node.init(5);
    GenerateAllNodesIterative(&node) catch |err| {
        std.debug.print("{any}", .{err});
    };

    nodes_visited.put(i, i) catch |err| {
        std.debug.print("this happend :{any}\n", .{err});
    };
}
