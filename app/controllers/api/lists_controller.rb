class Api::ListsController < ApiController

  def show
    @items = List.find(params[:id]).items
    render json: @items
  end
  
  def create
    list = List.new(list_params)
    list.user_id = current_user.id
    if list.save
      render json: list
    else
      render json: { errors: list.errors.full_messages }, status: :unprocessable_entity
    end    
  end

  def destroy
    begin
    list = List.find(params[:id])
    list.destroy
    render json: {}, status: :no_content

    rescue ActiveRecod::RecordNotFound
      render :json => {}, :status => :not_found
    end
  end

  def update
    list = List.find(params[:id])
    if list.update(list_params)
      render json: list
    else
      render json: { errors: list.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def list_params
    params.require(:list).permit(:name, :permission)
  end

  def current_resource
    @current_resource = List.find(params[:id]) if params[:id]
  end
  
end
