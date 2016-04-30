class OrderDetailsController < ApplicationController
  before_action :set_order_detail, only: [:show, :edit, :update, :destroy]

  def index
    @order_details = OrderDetail.all
    @orderJoined = OrdersUser.countJoined(params[:order_id])
    @orderInvited = Order
    @order= Order.where(id: params[:order_id])
    
  end

  def show
  end

  # GET /order_details/new
  def new
    @order_detail = OrderDetail.new
  end

  # GET /order_details/1/edit
  def edit
  end


def create
  @order = Order.find(params[:order_id])
  @orderdetail= @order.order_details.create(orderdetail_params)
  redirect_to order_path(@order)  
end

  def update
    respond_to do |format|
      if @order_detail.update(order_detail_params)
        format.html { redirect_to @order_detail, notice: 'Order detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @order_detail }
      else
        format.html { render :edit }
        format.json { render json: @order_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_details/1
  # DELETE /order_details/1.json
  def destroy
    @order_detail.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_detail
      @order_detail = OrderDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_detail_params
      params.require(:order_detail).permit(:item, :price, :amount, :comment, :user_id, :order_id, :created_at, :updated_at)
    end

 
    def orderdetail_params
                        #if params.reguire(:order_detail)
      params.require(:order_detail).permit(:item,:amount,:price,:comment, :user_id)
    end
end
