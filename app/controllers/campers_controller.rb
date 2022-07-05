class CampersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_camper

  def index
    campers = Camper.all
    render json: campers
  end

  def show
    camper = find_camper
    render json: camper, serializer: CamperByIdSerializer
  end

  def create
    camper = Camper.create!(parameters)
    render json: camper, status: :created
  end

  private

  def parameters
    params.permit(:name, :age)
  end

  def find_camper
    Camper.find(params[:id])
  end

  def record_not_found
    render json: { error: "Camper not found" }, status: :not_found
  end

  def unprocessable_camper(invalid)
    render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
  end
end
