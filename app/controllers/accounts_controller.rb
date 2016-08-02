class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = Account.includes(:category).all.sort_by_category
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
  end

  # GET /accounts/new
  def new
    @account = Account.new
    @account.build_category
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: 'Account was successfully created.' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def generate_password
    render json: {suggested_password: secure_password}
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_account
    @account = Account.includes(:category).find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def account_params
    params.require(:account).permit(:title, :username, :password, :url, :category_id)
  end

  def secure_password
    password.split('').shuffle.join
  end

  # 10 letters (with at least one capital letter),
  # 3 numbers and
  # one special character
  def password
    password_len = rand(9..14)
    small_letter_len = rand(3..4)
    capital_letter_len = rand(2..3)
    number_len = rand(1..(password_len - (small_letter_len + capital_letter_len)))
    special_character = '$'

    small_letter(small_letter_len) + natural_number(number_len) + capital_letter(capital_letter_len) + special_character
  end

  def small_letter(len)
    ('a'..'z').to_a.shuffle.first(len).join
  end

  def capital_letter(len)
    ('A'..'Z').to_a.shuffle.first(len).join
  end

  def natural_number(len)
    (0..9).to_a.shuffle.first(len).join
  end
end
