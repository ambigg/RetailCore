class Admin::BranchesController < Admin::BaseController
  def index
    @branches = Branch.all
  end
  def show
  end
  def new
    @branch = Branch.new
  end
  def edit
      @branch = Branch.find(params[:id])
  end
  def create
    @branch = Branch.new(branch_params)
    if @branch.save
      redirect_to admin_branches_path, notice: "Branch created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end
  def update
      @branch = Branch.find(params[:id])
      if @branch.update(branch_params)
        redirect_to admin_branches_path, notice: "Branch updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
  end
  def destroy
  end

  private
  def branch_params
    params.require(:branch).permit(:name, :address, :phone, :active)
  end
end
