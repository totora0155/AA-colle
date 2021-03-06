#encoding: utf-8

class TagsController < ApplicationController
  skip_before_filter :authorize
  # GET /tags
  # GET /tags.json
  def index
    @search = params[:tag]
    tags = Tag.select('aa_id').where("tag LIKE ?", "%#{@search}%").order('updated_at desc')
    @asciiArts = Aa.page(params[:page]).per(50).where(id: tags).order("updated_at desc")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tags }
    end
  end

  # GET /tags/1
  # GET /tags/1.json
  def show
    @tag = Tag.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tag }
    end
  end

  # GET /tags/new
  # GET /tags/new.json
  def new
    @tag = Tag.new
    @tags = Tag.where(:aa_id => params[:aa_id])
    @aa_id = Aa.find(params[:aa_id])
    #session[:return_to] ||= request.referer
    #@return = session[:return_to]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tag }
    end
  end

  # GET /tags/1/edit
  def edit
    @tag = Tag.find(params[:id])
  end

  # POST /tags
  # POST /tags.json
  def create
    @tag = Tag.new(params[:tag])

    respond_to do |format|
      if @tag.save
        format.html { redirect_to :back, notice: "タグ[#{@tag.tag}]を登録しました。" }
        format.json { render json: @tag, status: :created, location: @tag }
      else
        format.html { render action: "new" }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tags/1
  # PUT /tags/1.json
  def update
    @tag = Tag.find(params[:id])

    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        format.html { redirect_to @tag, notice: 'Tag was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.json
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy

    respond_to do |format|
      format.html { redirect_to :back, notice: "タグ#{@tag.tag}を削除しました"}
      format.json { head :no_content }
    end
  end
end
