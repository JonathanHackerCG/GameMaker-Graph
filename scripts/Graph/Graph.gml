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
	
	#region Graph.add_node(index);
	/// @function add_node
	/// @param index
	/// @returns Node
	static add_node = function(i)
	{
		if (get_node(i) == noone)
		{
			var node = new _Node(i);
			node.graph = self;
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
		node.graph = self;
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
	//Graph.remove_node MUCH MORE DIFFICULT
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
		edge.graph = self;
		array_push(_edges, edge);
		#endregion
		#region Defining the Edge
		edge.A = A;
		edge.B = B;
		array_push(nodeA._edges, B);
		array_push(nodeB._edges, A);
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
	//Graph.remove_edge PROBABLY DIFFICULT
	
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
	///Graph.inc_matrix();
	
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
	// Graph.print_inc_matrix
}

//NOTES:
//Graph.nodes = list of Nodes.
//Graph.edges = list of Edges.
//Node.edges = list of Edge indices.
//Edge.A and Edge.B = source and target Node index.