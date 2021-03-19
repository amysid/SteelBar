class GeneralPanelsController < ApplicationController
  layout 'admin_lte_2'
  

  def edit
  	@gp = GeneralPanel.first
  end

  def update
  	@gp = GeneralPanel.first
  	if @gp && @gp.update(gp_params)
      flash[:notice] = ["General Panel updated successfully."]
      render :edit

    else
      flash[:alert] = (@gp.present? ? @gp.errors.full_messages : ["Invalid Request."] )
      render :edit
    end
  end

  
  private
  
  def gp_params
    params.require(:general_panel).permit(:tax_ref, :exch_rate, :local_transportation_cost, :exp)
  end
end
