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
		#@root = Node.new(@array[@array.size/2])
		#@array.slice!(@array.size/2)
		@root = Node.new(13)
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

	def dfs_rec(target, node=@root)
		return "not found" if node == nil
		if node.value == target
			puts node
			return
		end
		dfs_rec(target, node.children[:left])
		puts node.value
		dfs_rec(target, node.children[:right])
	end

	def to_s
		p @root
	end

	#reads in a weird backwards order... but it gets all nodes.
	def depth_first_search
		stack = []
		visited = []
		cnode = @root.children[:left]

		loop do
			#find left most node
			if cnode.children[:left] != nil && visited.include?(cnode.children[:left]) == false
				cnode = cnode.children[:left]
				redo

			#when left most node is found, add to stack, parent becomes cnode, add cnode (parent) to stack
			elsif cnode.children[:left] == nil && cnode.children[:right] == nil
				visited << cnode
				cnode = cnode.parent
				visited << cnode if visited.include?(cnode) == false
				redo

			#the left is done, now the right. once the parent has been visited, the following edge cases execute	
			elsif visited.include?(cnode)

				#case: right child exists and hasn't been read.
				#moves cnode to that right child.
				if cnode.children[:right] != nil && visited.include?(cnode.children[:right]) == false
					cnode = cnode.children[:right]
					redo

					 #cases where parent and all descendants have been read. now traverse upwards to cnodes parent.
				elsif(visited.include?(cnode.children[:right]) && visited.include?(cnode.children[:left])) ||
					 (visited.include?(cnode.children[:right]) && cnode.children[:left] == nil) ||
					 (visited.include?(cnode.children[:left]) && cnode.children[:right] == nil)

					cnode = cnode.parent
					visited << cnode if visited.include?(cnode) == false
					#return visited.each {|x| puts x.value} 
						if cnode.value == @root.value
							#cnode = @root.children[:right]
							return visited.each {|x| puts x.value}
						end
					redo

				end

			elsif cnode.children[:right] != nil
				cnode = cnode.children[:right]
			end
		end		
	end
end

treea = Tree.new([10,1,9,2,7,3,31])
treea.tree()
treea.depth_first_search
