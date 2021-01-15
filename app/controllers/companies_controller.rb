class CompaniesController < ApplicationController
  before_action :set_company, except: [:index, :create, :new, :destroy]

  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
    if @company.color.nil?
      @company.color = Rails.configuration.default_background_color
    end
  end

  def show
    if !@company.zip_code.nil?
      @zip_code_params = ZipCodes.identify(@company.zip_code)
      @company.city = @zip_code_params && @zip_code_params[:city]
      @company.state = @zip_code_params && @zip_code_params[:state_code] + " or " + @zip_code_params[:state_name]
    end
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to companies_path, notice: "Saved"
    else
      render :new, notice: "Oops, Something went wrong!"
    end
  end

  def edit
  end

  def update
    if @company.update(company_params)
      redirect_to companies_path, notice: "Changes Saved"
    else
      render :edit, notice: "Oops, Something went wrong!"
    end
  end  

  # Deleting a company with an ID being passed
  def destroy
    @company = Company.find(params[:id])
    @company_name = @company.name
    @company.destroy
    redirect_to companies_path, notice: "Company: #{@company_name} was successfully deleted!"
  end

  private

  def company_params
    params.require(:company).permit(
      :name,
      :legal_name,
      :description,
      :zip_code,
      :color,
      :phone,
      :email,
      :owner_id,
      services: []
    )
  end

  def set_company
    @company = Company.find(params[:id])
    if @company.color.nil?
      @company.color = Rails.configuration.default_background_color
    end
  end
  
end
