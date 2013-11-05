class AssetsController < ApplicationController
  # GET ../assets
  # GET ../assets.json
  def index
    @assets = Asset.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @assets }
    end
  end

  # GET ../assets/1
  # GET ../assets/1.json
  def show
    @asset = Asset.find(params[:id])
	send_file asset.data.path, :type => asset.data_content_type
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @asset }
    end
  end

  # GET ../assets/new
  # GET ../assets/new.json
  def new
    @asset = Asset.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @asset }
    end
  end

  # GET ../assets/1/edit
  def edit
    @asset = Asset.find(params[:id])
  end

  # POST ../assets
  # POST ../assets.json
  def create
    @asset = Asset.new(params[:asset])

    respond_to do |format|
      if @asset.save
        format.html { redirect_to @asset, :notice => 'Asset was successfully created.' }
        format.json { render :json => @asset, :status => :created, :location => @asset }
      else
        format.html { render :action => "new" }
        format.json { render :json => @asset.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT ../assets/1
  # PUT ../assets/1.json
  def update
    @asset = Asset.find(params[:id])

    respond_to do |format|
      if @asset.update_attributes(params[:asset])
        format.html { redirect_to @asset, :notice => 'Asset was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @asset.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE ../assets/1
  # DELETE ../assets/1.json
  def destroy
	asset = Asset.find(params[:id])
	@allowed = Asset::Max_Attachments - asset.attachable.assets.count
 
	@attachable = asset.attachable
 
	if asset.destroy
		respond_to do |format|
			format.html do
				if request.xhr?
					#get attachable item again to ensure we get the new asset list
					render :partial => "attachments", :collection => Attachable.find(@attachable.id).assets
				end
			end
		end
	else
		respond_to do |format|
			format.html do
				if request.xhr?
					render :json => asset.errors
				end
			end
		end
	end
  end
end

