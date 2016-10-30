class Node
	attr_accessor :value, :parent, :children

	def initialize(value)
		@value = value
		@parent = nil
		@children = {:right => nil, :left => nil}
	end
end

class Tree
	def initialize(array)
		@array = array
	end

	def tree
		@root = Node.new(@array[@array.size/2])
		@array.each do |x|
			build_tree(@root, Node.new(x))
		end
	end

	def build_tree(parent, node)
		if node.value <= parent.value
			if parent.children[:left] != nil
				build_tree(parent.children[:left], node)
			else
				parent.children[:left] = node
				node.parent = parent
				parent.children[:left].value
				return
			end
		elsif node.value >= parent.value
			if parent.children[:right] != nil
				build_tree(parent.children[:right], node)
			else
				parent.children[:right] = node
				node.parent = parent
				parent.children[:right].value
				return
			end
		end
	end

	#level by level
	#array acts as queue
	def breadth_first_search(target)
		queue = []
		queue << @root
		while true
			return "not found" if queue[0] == nil
			return queue[0] if queue[0].value == target
			queue << queue[0].children[:left] if queue[0].children[:left]
			queue << queue[0].children[:right] if queue[0].children[:right]
			queue.slice!(0)
		end
	end

	#array acts as stack
	#going to finish on halloween!
	def depth_first_search
		stack = []
	end

	def dfs_rec(target, node=@root)
		return "not found" if node == nil
		if node.value == target
			puts node
			return
		end
		dfs_rec(target, node.children[:left])
		dfs_rec(target, node.children[:right])
	end

	def to_s
		@root
	end
end

treea = Tree.new([1,5,3,2,18,15,21,1,2,412,123,12])
treea.tree()
p treea.to_s