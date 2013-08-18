class String
	def shuffle
		self.split('')
		self.shuffle
		self.join
	end
end
