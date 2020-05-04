class CompaniesController < ApplicationController
  before_action :set_company, except: [:index, :create, :new]

  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
  end

  def show
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to companies_path, notice: "Saved"
    else
      flash[:errors] = @company.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit
  end

  def update
    if @company.update(company_params)
      redirect_to companies_path, notice: "Changes Saved"
    else
      flash[:error] = @company.errors.full_messages.join(', ')
      render :edit
    end
  end

  # DELETE /companies/:id
  def destroy
    @company.destroy
    if @company.destroyed?
      redirect_to_path = companies_path
      flash[:notice] = "Company successfully destroyed."
    else
      redirect_to_path = company_path(@company)
      flash[:error] = @company.errors.full_messages.join(', ')
    end
    respond_to do |format|
      format.html { redirect_to redirect_to_path }
    end
  end

  private

  def company_params
    params.require(:company).permit(
      :name,
      :legal_name,
      :description,
      :zip_code,
      :phone,
      :email,
      :owner_id,
    )
  end

  def set_company
    @company = Company.find(params[:id])
  end
  
end
