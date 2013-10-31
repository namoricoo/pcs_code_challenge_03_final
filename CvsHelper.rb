require 'csv'

class CvsHelper
	
	def is_Exist(fileName)
		return File.exist?(fileName)
	end
	
	def create_content(fileName,hashFile)
		arrayValue = hashFile.values
		#wb will create the file
		CSV.open(fileName,"wb") do |csv|
		  csv << arrayValue	 
		end
	end
	
	def append_content(fileName,hashFile)
		lineOfData = ""
		arrayValue = hashFile.values
		#ab will append to the file
		CSV.open(fileName,"ab") do |csv|
			csv << arrayValue			
		end			
	end
	
	def get_Array_of_Hashes(fileName)
		array_hash = Array.new
		hash_input = Hash.new
		userIndex = 0
		CSV.foreach(fileName) do |row|			
			array = array_to_Hash(row,userIndex)
			array_hash.push(array)
			userIndex += 1
		  
		end
		
		return array_hash
		
	
	end
	
	def array_to_Hash(arrayData,userIndex)
		user_Hash = Hash.new
		systemKeys= ["name#{userIndex}", "email#{userIndex}","twitter#{userIndex}"]
		
		for i in 0..arrayData.length-1 do
			user_Hash[systemKeys[i]] = arrayData[i]  
		end
		return user_Hash
	end		
end