const std = @import("std");

pub const Node = struct {
    value: i8,
    children: ?std.BoundedArray(*Node, 8),
    pub fn init(alloc: std.mem.Allocator, value: i8) !*Node {
        const node = try alloc.create(Node);
        node.* = Node{
            .value = value,
            .children = std.BoundedArray(*Node, 8){},
        };
        return node;
    }
    pub fn addChildren(self: *Node, child_node: *Node) !void {
        if (self.children.?.len != 8) {
            try self.children.?.append(child_node);
        }
    }
};

pub fn PrintQueue(queue: std.DoublyLinkedList(Node)) !void {
    var queue_new = queue;
    while (queue_new.len > 0) {
        std.debug.print("{any},", .{queue_new.first.?.data.value});
        _ = queue_new.popFirst();
    }
    std.debug.print("\n", .{});
}

pub fn GenerateAllNodesIterative(node: *Node, alloc: std.mem.Allocator) !void {
    std.debug.print("initial node value {any}\n", .{node.*.value});
    var queue = std.DoublyLinkedList(Node){};
    var list_node = std.DoublyLinkedList(Node).Node{ .data = node.* };
    queue.append(&list_node);
    var current_node: *Node = node;
    while (queue.len != 0) {
        try PrintQueue(queue);
        current_node = &queue.first.?.data;
        //possible moves are [-17,-15,-10,-6,+6,+10,+15,+17]
        std.debug.print("queue head node value is :{any}\n", .{current_node.*.value});
        if (current_node.*.value - 17 > 0 and current_node.*.value < 64) {
            const child_node_up_left_short = try Node.init(alloc, current_node.*.value - 17);
            try current_node.addChildren(child_node_up_left_short);
            const new_node = try alloc.create(std.DoublyLinkedList(Node).Node);
            new_node.* = std.DoublyLinkedList(Node).Node{ .data = child_node_up_left_short.* };
            std.debug.print("added Up left short node: {any}\n", .{new_node.data.value});
            queue.append(new_node);
        }
        if (current_node.*.value - 10 > 0 and current_node.*.value < 64) {
            const child_node_up_left_long = try Node.init(alloc, current_node.*.value - 10);
            current_node.addChildren(child_node_up_left_long) catch |err| {
                std.debug.print("{any} happend when trying to append childern to a node\n", .{err});
            };
            const new_node = try alloc.create(std.DoublyLinkedList(Node).Node);
            new_node.* = std.DoublyLinkedList(Node).Node{ .data = child_node_up_left_long.* };
            std.debug.print("added Up left long node: {any}\n", .{new_node.data.value});
            queue.append(new_node);
        }
        if (current_node.*.value - 15 > 0 and current_node.*.value < 64) {
            const child_node_up_right_short = try Node.init(alloc, current_node.*.value - 15);
            current_node.addChildren(child_node_up_right_short) catch |err| {
                std.debug.print("{any} happend when trying to append childern to a node\n", .{err});
            };
            const new_node = try alloc.create(std.DoublyLinkedList(Node).Node);
            new_node.* = std.DoublyLinkedList(Node).Node{ .data = child_node_up_right_short.* };
            std.debug.print("added Up right short node: {any}\n", .{new_node.data.value});
            queue.append(new_node);
        }
        if (current_node.*.value - 6 > 0 and current_node.*.value < 64) {
            const child_node_up_right_long = try Node.init(alloc, current_node.*.value - 6);
            current_node.addChildren(child_node_up_right_long) catch |err| {
                std.debug.print("{any} happend when trying to append childern to a node\n", .{err});
            };
            const new_node = try alloc.create(std.DoublyLinkedList(Node).Node);
            new_node.* = std.DoublyLinkedList(Node).Node{ .data = child_node_up_right_long.* };
            std.debug.print("added Up right long node :{any}\n", .{new_node.data.value});
            queue.append(new_node);
        }
        if (current_node.*.value + 17 < 64 and current_node.*.value < 64) {
            const child_node_down_left_short = try Node.init(alloc, current_node.*.value + 17);
            current_node.addChildren(child_node_down_left_short) catch |err| {
                std.debug.print("{any} happend when trying to append childern to a node\n", .{err});
            };
            const new_node = try alloc.create(std.DoublyLinkedList(Node).Node);
            new_node.* = std.DoublyLinkedList(Node).Node{ .data = child_node_down_left_short.* };
            std.debug.print("added Down left short node: {any}\n", .{new_node.data.value});
            queue.append(new_node);
        }
        if (current_node.*.value + 10 < 64 and current_node.*.value < 64) {
            const child_node_down_left_long = try Node.init(alloc, current_node.*.value + 10);
            current_node.addChildren(child_node_down_left_long) catch |err| {
                std.debug.print("{any} happend when trying to append childern to a node\n", .{err});
            };
            const new_node = try alloc.create(std.DoublyLinkedList(Node).Node);
            new_node.* = std.DoublyLinkedList(Node).Node{ .data = child_node_down_left_long.* };
            std.debug.print("added down left long node: {any}\n", .{new_node.data.value});
            queue.append(new_node);
        }
        if (current_node.*.value + 15 < 64 and current_node.*.value < 64) {
            const child_node_down_right_short = try Node.init(alloc, current_node.*.value + 15);
            current_node.addChildren(child_node_down_right_short) catch |err| {
                std.debug.print("{any} happend when trying to append childern to a node\n", .{err});
            };
            const new_node = try alloc.create(std.DoublyLinkedList(Node).Node);
            new_node.* = std.DoublyLinkedList(Node).Node{ .data = child_node_down_right_short.* };
            std.debug.print("added down right short node :{any}\n", .{new_node.data.value});
            queue.append(new_node);
        }
        if (current_node.*.value + 6 < 64 and current_node.*.value < 64) {
            const child_node_down_right_long = try Node.init(alloc, current_node.*.value + 6);
            current_node.addChildren(child_node_down_right_long) catch |err| {
                std.debug.print("{any} happend when trying to append childern to a node\n", .{err});
            };
            const new_node = try alloc.create(std.DoublyLinkedList(Node).Node);
            new_node.* = std.DoublyLinkedList(Node).Node{ .data = child_node_down_right_long.* };
            std.debug.print("added down right long node :{any}\n", .{new_node.data.value});
            queue.append(new_node);
        }
        std.debug.print("the first element of the queue is :{any}\n", .{queue.first.?.data.value});
        const head = queue.popFirst();
        std.debug.print("Head :{any} and the len of the queue is : {any}\n", .{ head.?.data.value, queue.len });
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
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const alloc_nodes = gpa.allocator();
    const node = try Node.init(alloc_nodes, 48);
    GenerateAllNodesIterative(node, alloc_nodes) catch |err| {
        std.debug.print("{any}\n", .{err});
    };

    nodes_visited.put(i, i) catch |err| {
        std.debug.print("this happend :{any}\n", .{err});
    };
}
