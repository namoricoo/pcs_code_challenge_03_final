require 'Minitest/autorun'
require "./CvsHelper"

class CvsHelperTest < Minitest::Unit::TestCase	
	

	def test_is_Exist
		fileName="demoFile.cvs"
		ch =nil
		ch = CvsHelper.new
		open = ch.is_Exist(fileName)		
		assert_equal(true , open)	
	end
	
	



end