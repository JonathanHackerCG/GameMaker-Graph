function Graph() constructor
{
	_nodes = array_create(0);
	_edges = array_create(0);
	#region Graph._Node(index) constructor
	/// @function _Node
	/// @param index
	/// @returns Node
	static _Node = function(_index) constructor
	{
		index = _index;
		_edges = array_create(0);
		#region _Node.num_edges();
		static num_edges = function()
		{
			return array_length(_edges);
		}
		#endregion
	}
	#endregion
	#region Graph._Edge(index) constructor
	/// @function _Edge
	/// @param index
	/// @returns Edge
	static _Edge = function(_index) constructor
	{
		index = _index;
	}
	#endregion
	
	//Node Methods
	#region Graph.add_node(index);
	/// @function add_node
	/// @param index
	/// @returns Node
	static add_node = function(i)
	{
		if (get_node(i) == noone)
		{
			var node = new _Node(i);
			if (i < array_length(_nodes))
			{
				array_resize(_nodes, i - 1);
			}
			_nodes[i] = node;
			return node;
		}
		return noone;
	}
	#endregion
	#region Graph.push_node();
	/// @function push_node
	/// @returns Node
	static push_node = function()
	{
		var i = array_length(_nodes);
		var node = new _Node(i);
		array_push(_nodes, node);
		return node;
	}
	#endregion
	#region Graph.get_node(index);
	/// @function get_node
	/// @param index
	/// @returns Node
	static get_node = function(i)
	{
		if (i >= 0 && i < array_length(_nodes))
		{
			return _nodes[i];
		}
		return noone;
	}
	#endregion
	#region WIP Graph.remove_node(index);
	/// @function remove_node
	/// @param index
	/// @param returns Node
	static remove_node = function(i)
	{
		var node = get_node(i);
		if (node != noone)
		{
			
		}
		return noone;
	}
	#endregion
	#region Graph.num_nodes();
	static num_nodes = function()
	{
		return array_length(_nodes);
	}
	#endregion
	#region Graph.adjacent(indexA, indexB);
	/// @function adjacent
	/// @param indexA
	/// @param indexB
	/// @returns Edge
	static adjacent = function(A, B)
	{
		//Get the node we are checking edges.
		var nodeA = get_node(A);
		var nodeB = get_node(B);
		#region Error Checking
		if (nodeA == noone || nodeB == noone)
		{
			var error = "Cannot check for edges between " + string(A) + " and " + string(B) + ".\n";
			if (nodeA == noone) { error += "Node " + string(A) + " is not defined.\n"; }
			if (nodeB == noone) { error += "Node " + string(B) + " is not defined.\n"; }
			show_error(error, false);
		}
		#endregion
		
		//Check every edge associated with node A.
		var size = array_length(nodeA._edges);
		for (var i = 0; i < size; i++)
		{
			//Check if that edge is also associated with B.
			var edge = get_edge(nodeA._edges[i]);
			if (edge.A == B || edge.B == B)
			{
				return edge;
			}
		}
		//Return noone if there is no edge between those nodes.
		return noone;
	}
	#endregion
	#region Graph.neighbors(index);
	/// @function neighbors
	/// @param index
	static neighbors = function(i)
	{
		var node = get_node(i);
		#region Error Checking
		if (node == noone)
		{
			var error = "Cannot find neighbors for node " + string(i) + ".\n";
			error += "Node " + string(i) + " is not defined.\n";
			show_error(error, false);
		}
		#endregion
		
		//Check every edge associated with selected node.
		var arr = array_create(0);
		var size = array_length(node._edges);
		for (var e = 0; e < size; e++)
		{
			var edge = get_edge(node._edges[e]);
			if (edge.A == i) { array_push(arr, edge.B); }
			if (edge.B == i) { array_push(arr, edge.A); }
		}
		return arr;
	}
	#endregion
	
	//Edge Methods
	#region Graph.add_edge(indexA, indexB);
	/// @function add_edge
	/// @param indexA
	/// @param indexB
	/// @returns Edge
	static add_edge = function(A, B)
	{
		var nodeA = get_node(A);
		var nodeB = get_node(B);
		#region Error Checking
		if (nodeA == noone || nodeB == noone)
		{
			//TODO Make this more detailed/explicit. Includes OOB and undefined errors.
			show_error("Cannot add edge between nodes " + string(A) + " and " + string(B) + ".", false);
		}
		#endregion
		#region Creating the Edge
		var i = array_length(_edges);
		var edge = new _Edge(i);
		array_push(_edges, edge);
		#endregion
		#region Defining the Edge
		edge.A = A;
		edge.B = B;
		array_push(nodeA._edges, i);
		array_push(nodeB._edges, i);
		#endregion
		return edge;
	}
	#endregion
	#region Graph.get_edge(index);
	/// @function get_edge
	/// @param index
	/// @returns Edge
	static get_edge = function(i)
	{
		if (i >= 0 && i < array_length(_edges))
		{
			return _edges[i];
		}
		return noone;
	}
	#endregion
	#region Graph.remove_edge(indexA, indexB);
	/// @function remove_edge
	/// @param indexA
	/// @param indexB
	/// @returns Edge
	static remove_edge = function(A, B)
	{
		//Get the node we are checking edges.
		var nodeA = get_node(A);
		var nodeB = get_node(B);
		#region Error Checking
		if (nodeA == noone || nodeB == noone)
		{
			var error = "Cannot removed edges between " + string(A) + " and " + string(B) + ".\n";
			if (nodeA == noone) { error += "Node " + string(A) + " is not defined.\n"; }
			if (nodeB == noone) { error += "Node " + string(B) + " is not defined.\n"; }
			show_error(error, false);
		}
		#endregion
		
		//Check every edge associated with node A.
		var sizeA = nodeA.num_edges();
		var sizeB = nodeB.num_edges();
		for (var i = 0; i < sizeA; i++)
		{
			//Check if that edge is also associated with B.
			var edge_index = nodeA._edges[i];
			var edge = get_edge(edge_index);
			if (edge.A == B || edge.B == B)
			{
				//Remove the edge.
				array_delete(_edges, edge_index, 1);	//Remove the edge from the graph.
				array_delete(nodeA._edges, i, 1);			//Remove the edge from nodeA.
				for (var j = 0; j < sizeB; j++)				//Remove the edge from nodeB.
				{
					if (nodeB._edges[j] == edge_index)
					{
						array_delete(nodeB._edges, j, 1);
						break;
					}
				}
				
				//Update all nodes to account for the removed edge.
				if (edge_index != num_edges() - 1) //Skip if it was the final edge.
				{
					var sizeN = num_nodes();
					for (var j = 0; j < sizeN; j++)
					{
						var node = get_node(j);
						var sizeE = node.num_edges();
						for (var k = 0; k < sizeE; k++)
						{
							if (node._edges[k] >= edge_index)
							{
								node._edges[k] --;
							}
						}
					}
				}
				
				//Return the edge that was deleted.
				return edge;
			}
		}
		//Return noone if there is no edge between those nodes.
		return noone;
	}
	#endregion
	#region Graph.num_edges();
	static num_edges = function()
	{
		return array_length(_edges);
	}
	#endregion
	
	//Graph Properties
	#region Graph.adj_matrix();
	/// @function adj_matrix
	/// @return Array 2D
	static adj_matrix = function()
	{
		var n = array_length(_nodes);
		var e = array_length(_edges);
		var matrix = array_create(n, array_create(n, 0));
		
		for (var i = 0; i < e; i++)
		{
			var edge = get_edge(i);
			if (edge != noone)
			{
				matrix[edge.A][edge.B] = 1;
				matrix[edge.B][edge.A] = 1;
			}
		}
		return matrix;
	}
	#endregion
	//Graph.inc_matrix();
	
	//Graph Printing
	#region Graph.print();
	/// @function print
	/// @returns String
	static print = function()
	{
		output = "";
		#region Getting all Nodes.
		output += "N = { ";
		var size = array_length(_nodes);
		for (var i = 0; i < size; i++)
		{
			var node = get_node(i);
			if (node != noone) { output += string(i) + " "; }
		}
		output += "}\n";
		#endregion
		#region Getting all Edges.
		output += "E = { ";
		size = array_length(_edges);
		for (var i = 0; i < size; i++)
		{
			var edge = get_edge(i);
			if (edge != noone) { output += "{" + string(edge.A) + " " + string(edge.B) + "} "; }
		}
		output += "}";
		#endregion
		return output;
	}
	#endregion
	#region Graph.print_adj_matrix();
	/// @function print_adj_matrix
	/// @returns String
	static print_adj_matrix = function()
	{
		var output = "";
		var matrix = adj_matrix();
		var n = array_length(_nodes);
		for (var yy = 0; yy < n; yy++) {
		for (var xx = 0; xx < n; xx++)
		{
			output += string(matrix[xx][yy]) + " ";
		} output += "\n"; }
		return output;
	}
	#endregion
	//TODO: Graph.print_inc_matrix
}

//NOTES:
//Graph.nodes = list of Nodes.
//Graph.edges = list of Edges.
//Node.edges = list of Edge indices.
//Edge.A and Edge.B = source and target Node index.