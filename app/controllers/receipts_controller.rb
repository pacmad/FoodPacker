class ReceiptsController < ApplicationController

  before_filter :login_required

  # GET /receipts
  # GET /receipts.json
  def index
    @receipts = Receipt.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @receipts }
    end
  end

  # GET /receipts/1
  # GET /receipts/1.json
  def show
    @receipt = Receipt.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @receipt }
    end
  end

  # GET /receipts/new
  # GET /receipts/new.json
  def new
    @receipt = Receipt.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @receipt }
    end
  end

  # GET /receipts/1/edit
  def edit
    @receipt = Receipt.find(params[:id])
  end

  # POST /receipts
  # POST /receipts.json
  def create
    @receipt = Receipt.new(params[:receipt])

    respond_to do |format|
      if @receipt.save
        format.html { redirect_to @receipt, notice: t('messages.model.created', model: t('receipts.singular')) }
        format.json { render json: @receipt, status: :created, location: @receipt }
      else
        format.html {
          flash.now[:error] = t('errors.template.header', model: t('receipts.singular'), count: @product.errors.count)
          render action: "new"
          }
        format.json { render json: @receipt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /receipts/1
  # PUT /receipts/1.json
  def update
    @receipt = Receipt.find(params[:id])

    respond_to do |format|
      if @receipt.update_attributes(params[:receipt])
        format.html { redirect_to @receipt, notice: t('messages.model.updated', model: t('receipts.singular')) }
        format.json { head :ok }
      else
        format.html { 
          flash.now[:error] = t('errors.template.header', model: t('receipts.singular'), count: @product.errors.count)
          render action: "edit"
          }
        format.json { render json: @receipt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /receipts/1
  # DELETE /receipts/1.json
  def destroy
    @receipt = Receipt.find(params[:id])
    @receipt.destroy

    respond_to do |format|
      if @receipt.destroyed?
        format.html { redirect_to receipts_url, notice: t('messages.model.destroyed', model: t('receipts.singular'), name: @receipt.name) }
        format.json { head :ok }
      else
        format.html {
          begin
            redirect_to :back, flash: {error: t('messages.model.cant_delete', model: t('receipts.singular')), warning: @receipt.errors[:base].to_sentence }
          rescue ActionController::RedirectBackError
            redirect_to receipts_url, flash: {error: t('messages.model.cant_delete', model: t('receipts.singular')), warning: @receipt.errors[:base].to_sentence }
          end
        }
        format.json { render json: @receipt.errors, status: :unprocessable_entity }
      end
    end
  end
end
