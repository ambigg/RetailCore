class Inventory::BranchesController < Inventory::BaseController
  before_action :set_branch, only: [ :show, :edit, :update ]

  def index
    @branches = Branch.all
  end
  def show
    @branch = Branch.find(params[:id])
    @inventories = @branch.inventories.includes(product_variant: :product)
  end
  def edit
    @branch = Branch.find(params[:id])
  end
  def update
      @branch = Branch.find(params[:id])
      if @branch.update(branch_params)
        redirect_to admin_branches_path, notice: "Branch updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
  end

  private
  def branch_params
    params.require(:branch).permit(:name, :address, :phone, :active)
  end

  def set_branch
    @branch = Branch.find(params[:id])
  end
end
