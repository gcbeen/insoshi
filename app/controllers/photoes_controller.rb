# -*- encoding : utf-8 -*-
class PhotoesController < ApplicationController
  
  def index
    @photoes = current_user.photoes.paginate :per_page => APP_CONFIG[:per_page], :page => params[:page]
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new params[:photo]
	@photo.user = current_user
	respond_to do |format|
	  if @photo.save
	    format.html { redirect_to photoes_path, notice: "相片上传成功" }
	  else
		format.html { render action: 'new' }
	  end
	end
  end

  def show
	@photo = Photo.find params[:id]
  end

  def destroy
	@photo = Photo.find params[:id]
	@photo.destroy
	respond_to do |format|
	  format.html { redirect_to photoes_path, notice: '相片删除成功' }
	end
  end

end

