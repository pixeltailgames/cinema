local meta = FindMetaTable("Vector")
if !meta then return end

function meta:InBox( vec1, vec2 )
	return self.x >= vec1.x && self.x <= vec2.x &&
		self.y >= vec1.y && self.y <= vec2.y &&
		self.z >= vec1.z && self.z <= vec2.z
end