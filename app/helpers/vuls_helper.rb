module VulsHelper

	def createcode(file)
		return if file.nil?
		code = File.read(file)
		if File.extname(file) == '.rb'
			CodeRay.scan(code, :ruby).div(:tab_width => 2).html_safe
		else
			CodeRay.scan(code, :json).div(:tab_width => 2).html_safe
		end
	end


	

end
