/// @description Test Code
event_inherited();

g = new Graph();

//Populate 5 nodes.
repeat(5) { g.push_node(); }
show_debug_message(g.print());

//Add edges between nodes.
g.add_edge(0, 1);
g.add_edge(1, 2);
g.add_edge(0, 3);
g.add_edge(3, 1);
g.add_edge(3, 2);
g.add_edge(3, 4);
g.add_edge(4, 1);
show_debug_message(g.print());
show_debug_message(g.print_adj_matrix());

show_debug_message(g.adjacent(0, 1));
show_debug_message(g.adjacent(0, 4));

show_debug_message(g.neighbors(0));
show_debug_message(g.neighbors(3));