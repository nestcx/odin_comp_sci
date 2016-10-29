class LinkedList
	attr_reader :head

	class Node
		attr_accessor :value, :next_node

		def initialize(value=nil,next_node=nil)
			@value = value
			@next_node = next_node
		end
	end

	def initialize
		@head = nil
		@tail = nil
		@current_node = nil
	end

	def prepend(value)
		if @head == nil
			node = Node.new(value)
			@head = node
		elsif @head != nil
			node = @head
			@head = Node.new(value, node)
		end
	end

	def append(value)
		if @head == nil
			@head = Node.new(value)
		elsif @head != nil && @head.next_node == nil
			node = Node.new(value)
			@head.next_node = node
			@tail = node
		elsif @head != nil && @head.next_node != nil
			node = Node.new(value)
			nil_node = find_nil_node(@head)
			nil_node.next_node = node
		end
	end

	def find_nil_node(node)
		return node if node.next_node == nil
		if node.next_node != nil
			@previous_node = node
			find_nil_node(node.next_node)
		end
	end

	def tail
		puts find_nil_node(@head).value
	end

	def head
		puts @head.value
	end

	def at(index)
		i = 0
		node = @head
		while true
			return node.value if i == index
			node = node.next_node
			i += 1
		end
	end

	def pop
		last_node = find_nil_node(@head)
		@previous_node.next_node = nil
	end

	def contains?(value)
		i = 0
		node = @head
		while true
			return true if value == node.value
			if node.next_node != nil
				node = node.next_node
			else
				return false
			end
			i += 1
		end
	end

	def find(data)
		i = 0
		node = @head
		while true
			return "data is at index #{i}" if data == node.value
			if node.next_node != nil
				node = node.next_node
			else
				return "could not find data"
			end
			i += 1	
		end
	end

	def size
		i = 0
		node = @head
		while node.next_node != nil
			i += 1
			node = node.next_node
		end
		puts "size: #{i}"
	end

	def to_s
		node = @head
		str = []
		while node != nil
			str << " #{node.value} -> "
			node = node.next_node
		end
		print str.join + "\n"
	end

	def find_nil_node(node)
		return node if node.next_node == nil
		if node.next_node != nil
			@previous_node = node
			find_nil_node(node.next_node)
		end
	end


	def insert_at(index,data=nil)
		if index == 0
			prepend(data)
			return
		end

		i = 1
		node = @head

		while true
			if i == index				
				@previous_node = node
				@past_node = node.next_node if node.next_node != nil
				new_node = Node.new(data)
				@previous_node.next_node = new_node
				new_node.next_node = @past_node
				return
			else
				node = node.next_node if node.next_node != nil
			end
			i += 1
		end
	end

	def remove_at(index)
		node = @head

		if index == 0
			@head = @head.next_node
			return
		end

		i = 1

		while true
			if i == index
				@previous_node = node
				@pasta_node = node.next_node.next_node if node.next_node.next_node != nil
				@previous_node.next_node = @pasta_node
				return
			end
			node = node.next_node
			i += 1
		end
		return
	end
end

list = LinkedList.new

list.append("Cheetah")
list.append("Puma")
list.prepend("Jaguar")
list.size
list.head
list.tail
list.to_s
list.at(1)
list.pop
list.append("Tiger")
list.append("Leopard")
list.contains?("Tiger")
list.contains?("Jamaica")
list.find("Jaguar")
list.to_s
list.insert_at(2,"Lion")
list.remove_at(3)
list.to_s










