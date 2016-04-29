class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy, :group_members]
  # before_create(:remove_attribute)

  # private

  # def remove_attribute
  #   @attributes.delete('unwanted_attribute')
  # end

  # GET /groups
  # GET /groups.json
  def index
    @group = Group.new
    @groups = Group.all_group(current_user.id)
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)
    respond_to do |format|
      if group_params[:name].blank?
        format.html { redirect_to mygroups_url, notice: "Group name cann't be empty" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
        
      else
        if @group.save
        # render 'mygroups'
        format.html { redirect_to mygroups_url, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
        
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
   users= @group.followers

   users.each { |user|
    user.stop_following(@group)
      }
    @group.destroy
    respond_to do |format|
      format.html { redirect_to mygroups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def group_members
    @members = @group.user_followers
    @groupName= @group.name
    @group_id=@group.id 

      if @members
          respond_to do |format|               
          format.js { render 'group_members.js.erb' }
        end  
      else
        # respond_to do |format|               
        #   format.js { render 'group_members.js.erb' }
        # end  
        
      end

          

    # render partial: "groups/friendsingroup"
    # @users = current_user.following_users
    
  end
  # <input type="hidden" name="groupid[{:value=>2}]" id="groupid_{:value=>2}">

  def addFriendsToGroup

    @user =User.searchByName(params[:username ])
    # id=params[:groupid].map {|x| x[/\d+/]}

    # id= params[:groupid].scan(/\d+/).map(&:to_i)
    id= params[:groupid ]
    # puts @user[0].name
    # puts id

    if !@user.empty?

        if current_user.following?(@user[0])
          
          redirect_to group_members_path(:id => id)
          get_group(id)
            if @user[0].following?(@group)
                # puts "yesssssaaaaaaaaaaaaaaasssss"
                
            else
              # puts "Noooooooooaaaaaaaaaaaaoo"
              @user[0].follow(@group)
            end
          # redirect_to :controller => 'groups', :action => 'group_members', :id => id

          # respond_to do |format|               
          #     format.js { render 'addFriendsToGroup.js.erb' }
          #   end
            # # format.js { render 'group_members.js.erb' }
            # redirect_to group_members_path
        else
          # puts "xxxxxxxxxxxxxxxxx"
          redirect_to group_members_path(:id => id)
        end
    else  
      # puts "mmmmmmmmmmmmmmmmmmmm"
          redirect_to group_members_path(:id => id)
        # redirect_to group_members_path, flash[:error] = "errorrrr"
      
    end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    def get_group(id)
         @group = Group.find(id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name, :user_id)
    end
end
