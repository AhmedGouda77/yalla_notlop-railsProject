class OrdersController < ApplicationController
	  before_action :authenticate_user!, only: [:index, :new, :show, :edit, :update, :destroy, :home]

  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index

   #     @orders = Order.user_id.where(is_joined: 1 ).page(params[:page]).per(5)
    @orders = Order.all.where(user_id: current_user.id )
   #  @orders = Order.all.page(params[:page]).per(5)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  def home
     @orders = Order.where(user_id: current_user.id).last(5)
     @activities = PublicActivity::Activity.all
  end

  # POST /orders
  # POST /orders.json
  def create
   # @order = Order.new(order_params)
  # @order = current_user.orders.build(order_params)
  #   respond_to do |format|
  #     if @order.save
  @order = Order.new(order_params)
    @order.user_id = current_user.id
    @order.status = 0
    users_arr = "[" + params[:users] + "]"
    users_ids = eval(users_arr)

    group_users_arr = "[" + params[:group_users] + "]"
    group_users_ids = eval(group_users_arr)

    users_ids.push(*group_users_ids)
    # abort()
    respond_to do |format|
      if @order.save
	      @order.create_activity :create, owner: current_user
        order_owner = OrdersUser.new( :order_id => @order.id , :user_id => current_user.id , :is_joined => true ).save
        users_ids.uniq.each do |id|
          orders_user = OrdersUser.new( :order_id => @order.id , :user_id => id , :is_joined => false ).save
          #Notification.create(recipient: User.find(id), actor: current_user, action: "invited", notifiable: @order)
        end
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update("status" => "finished")
         format.html { redirect_to :back }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:image, :for, :from)
    end
end
