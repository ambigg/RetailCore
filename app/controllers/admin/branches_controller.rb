class Admin::BranchesController < Admin::BaseController
  before_action :set_branch, only: [ :show, :edit, :update, :destroy ]

  def index
    @branches = Branch.all
  end

  def show
    @inventories = @branch.inventories.includes(product_variant: :product)
  end

  def new
    @branch = Branch.new
  end

  def edit
  end

  def create
    if @branch.save
      redirect_to admin_branches_path, notice: "Branch created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
      if @branch.update(branch_params)
        redirect_to admin_branches_path, notice: "Branch updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
  end

  def destroy
    @branch.destroy
    redirect_to admin_branches_path, notice: "Branch deleted."
  end

  private
  def branch_params
    params.require(:branch).permit(:name, :address, :phone, :status)
  end
  def set_branch
    @branch = Branch.find(params[:id])
  end
end
