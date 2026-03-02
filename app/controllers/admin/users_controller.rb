class Admin::UsersController < Admin::BaseController
  def index
  @users = User.all
  if params[:role].present?
    @users = User.where(role: params[:role])
    render :list
  else
    @roles = User.distinct.pluck(:role)
    render :index
  end
  end

  def show
    @user = User.find(params[:id])
    @orders = @user.orders.order(created_at: :desc)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "User updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "User deleted."
  end

  private

  def user_params
    params.require(:user).permit(:email, :role)
  end
end
