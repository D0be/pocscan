class VulsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]
	before_action :corrent_user, only: :destroy

	def index
		@vuls = Vul.paginate(page: params[:page], per_page: 9)
	end

	def show
		@vul = Vul.find(params[:id])
	end

	def new
		@vul = Vul.new
		@vultype = Vultype.all
		@vullevel = Vullevel.all
	end

	def create
		vul = current_user.vuls.build(vul_params)
		if params[:vul][:format] == "json"
			file = save_json_poc(params[:poc],vul)
			puts file
			File.open(file) do |f|
				vul.file = f
			end
		end
		if vul.save
			flash[:success] = "New vulnerability created!"
			redirect_to vul
		else
			render newvul_path
		end
	end

	def edite
	end

	def update
	end

	def destroy
		@vul.destroy
		flash[:success] = "Vul deleted"
		redirect_to request.referrer || root_url
	end
  
	  private

	    #params security
	    def vul_params
	      params.require(:vul).permit(:name, :description, :search_key,
	                                    :type_id, :level_id, :file, :format )
	    end

		def corrent_user
			@vul = current_user.vuls.find_by(id: params[:id])
			redirect_to root_url if @vul.nil?
		end
		

		def save_json_poc(plugin,vul)
			poc = {}
			poc[:info] = vul.description
			poc[:name] = vul.name
			poc[:search_key] = vul.search_key
			poc[:type] = vul.type.typename
			poc[:level] = vul.level.levelname
			poc[:plugin] = {}
			poc[:plugin][:method] = plugin[:method]
			poc[:plugin][:getdata] = plugin[:getdata]
			poc[:plugin][:postdata] = plugin[:postdata]
			poc[:plugin][:keyword] = plugin[:keyword]
			filename = Time.now.to_a[0..-3].join + rand(10000).to_s+'.json'
			file = "/tmp/mypoc/"+filename
			File.open(file, "w+") do |f|
				f.write(JSON.pretty_generate(poc))
			end
			return file
		end

end
