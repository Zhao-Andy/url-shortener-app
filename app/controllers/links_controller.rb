class LinksController < ApplicationController
  before_action :authenticate_user!

  def index
    @links = current_user.links
  end

  def new
    @link = Link.new
    render 'new.html.erb'
  end

  def create
    @link = Link.new(
      user_id: current_user.id,
      target_url: params[:target_url],
      slug: params[:slug]
    )
    if @link.valid?
      @link.save
      redirect_to '/links'
    else
      render 'new.html.erb'
    end
  end

  def show
    @link = Link.find_by(id: params[:id])
    raise ActionController::RoutingError.new('Not Found') if @link.nil?
  end

  def edit
    @link = Link.find_by(id: params[:id])
  end

  def update
    @link = Link.find_by(id: params[:id])
    @link.update(
      target_url: params[:target_url],
      slug: params[:slug]
    )
    if @link.valid?
      flash[:success] = "Updated to #{@link.slug}!"
      redirect_to '/links'
    else
      flash[:danger] = @product.errors.full_messages
      render 'edit.html.erb'
    end
  end

  def destroy
    @link = Link.find_by(id: params[:id])
    @link.destroy
    flash[:success] = "#{@link.slug} was deleted!"
    redirect_to '/links'
  end

  def standardize_target_url!
    target_url.gsub!("http://", "")
    target_url.gsub!("https://", "")
  end
end
