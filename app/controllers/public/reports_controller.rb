class Public::ReportsController < ApplicationController
  before_action :authenticate_user!

  def new
    @report = Report.new
    @user = User.find(params[:user_id])
  end

  def create
    @user = User.find(params[:user_id])
    @report = Report.new(report_params)
    @report.reporter_id = current_user.id
    @report.reported_id = @user.id
    if @report.save
      redirect_to user_path(current_user.id)
      flash[:notice] = "ご報告ありがとうございます"
    else
      render :new
    end
  end

  private
  def report_params
    params.require(:report).permit(:reason, :url)
  end
end
