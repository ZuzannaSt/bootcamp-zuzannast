class Article
	def title
		@title
	end
	def body
		@body
	end
	def author
		@author
	end
	def created_at
		@created_at
	end
	def likes(value)
		@likes = value
	end
	def dislikes(value)
		@dislikes = value
	end
end