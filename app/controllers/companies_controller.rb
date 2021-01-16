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
    
    update_location
    if @company.valid_email? && @company.save
      redirect_to companies_path(@company), notice: "Saved"
    else
      redirect_back fallback_location: new_company_path, alert: (@company.errors.messages.map { |k,v| "#{k} #{v[0]}" }&.first.presence || t('invalid_email'))
    end
  end

  def edit
  end

  def update
    update_location unless @company.zip_code == company_params[:zip_code]
    if @company.update(company_params) && @company.valid_email? 
      redirect_to companies_path, notice: "Changes Saved"
    else
      redirect_back fallback_location: edit_company_path(@company), alert: (@company.errors.messages.map { |k,v| "#{k} #{v[0]}" }&.first.presence || t('invalid_email'))
    end
  end  

  def destroy
    if @company.destroy
      respond_to do |format|
        format.html { redirect_to companies_path, notice: 'Company was successfully deleted' }
      end
    else
      respond_to do |format|
        format.html { redirect_to companies_path, notice: 'Unable to delete' }
      end  
    end
  end

  private

  def update_location
    location = ZipCodes.identify(company_params[:zip_code])
    if location
      @company.state = location[:state_name]
      @company.city = location[:city]
    end
  end

  def company_params
    params.require(:company).permit(
      :name,
      :legal_name,
      :description,
      :zip_code,
      :phone,
      :email,
      :color,
      :owner_id,
      services: []
    )
  end

  def set_company
    @company = Company.find(params[:id])
  end
  
end
