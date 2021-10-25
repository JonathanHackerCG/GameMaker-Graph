/// @description Test Code
event_inherited();

g = new Graph();

//Populate 5 nodes.
repeat(5) { g.add_node(); }

//Add edges between nodes.
g.add_edge(0, 1);
g.add_edge(1, 2);
g.add_edge(0, 3);
g.add_edge(3, 1);
g.add_edge(3, 2);
g.add_edge(3, 4);
g.add_edge(4, 1);
show_debug_message(g.print());

g.remove_node(0);
show_debug_message(g.print());

g.remove_node(1);
show_debug_message(g.print());

g.remove_node(0);
show_debug_message(g.print());

g.remove_node(0);
show_debug_message(g.print());

g.remove_node(0);
show_debug_message(g.print());