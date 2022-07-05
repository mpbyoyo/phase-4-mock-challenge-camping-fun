class SignupsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_signup

  def create
    Signup.create!(parameters)
    activity = Activity.find(params[:activity_id])
    render json: activity, status: :created
  end

  private

  def parameters
    params.permit(:time, :camper_id, :activity_id)
  end

  def unprocessable_signup(invalid)
    render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
  end
end
