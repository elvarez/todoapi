class Api::ItemsController < ApiController

  def create
    item = Item.new(item_params)
    item.list_id = params[:list_id]
    if item.save
      render json: item
    else
      render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    begin
    item = Item.find(params[:id])
    item.destroy
    render json: {}, status: :no_content

    rescue ActiveRecod::RecordNotFound
      render :json => {}, :status => :not_found
    end    
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      render json: item
    else
      render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:description, :done)
  end

  def current_resource
    @current_resource = Item.find(params[:id]) if params[:id]
  end
  
end
