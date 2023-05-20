# frozen_string_literal: true

class ConfigsController < ApplicationController
  before_action :set_config, only: %i[show edit update]

  # GET /configs/1 or /configs/1.json
  def show; end

  # GET /configs/1/edit
  def edit; end

  # PATCH/PUT /configs/1 or /configs/1.json
  def update
    respond_to do |format|
      if @config.update(config_params)
        format.html { redirect_to config_url(@config), notice: 'Config was successfully updated.' }
        format.json { render :show, status: :ok, location: @config }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @config.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_config
    @config = current_user.config
  end

  # Only allow a list of trusted parameters through.
  def config_params
    params.require(:config).permit(:slack_api_key, :discord_api_key, :slack_relax_channel, :discord_relax_channel)
  end
end
