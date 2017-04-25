class PortscansController < ApplicationController
  
  def index
    @scans = Port.all
  end

  def new
    @portscan = Port.new
  end
  
  def create
    @portscan = Port.new(scan_params)
    @portscan.status = 0
    if @portscan.save
      Portscanasync.perform_async(@portscan.id)
      redirect_to portscan_path(@portscan)
    else
      render 'new'
    end
  end
  
  def show
    @scan = Port.find(params[:id])
    @result = redis.get(@scan.id)
  end

	def destroy
		@scan = Port.find(params[:id])
		FileUtils.rm Dir.glob(PortScan.configuration.output_dir + @scan.id.to_s + '.*')
		redis.del @scan.id
		@scan.destroy
		redirect_to portscans_path
	end

  private
    def scan_params
      params.require(:port).permit(:title, :target)
    end
    
    def redis
      @redis ||= Redis.new
    end

end
