module ExceptionHandler
  extend ActiveSupport::Concern

  class BaseError < StandardError
    attr_reader :errors, :message

    def initialize(errors, message)
      super(message)
      @errors = errors
      @message = message
    end
  end

  class InvalidAccess < StandardError; end
  class ValidationError < BaseError; end

  included do
    rescue_from ActiveRecord::RecordInvalid do |e|
      render json: { message: e.message }, status: :unprocessable_entity
    end

    rescue_from InvalidAccess do |e|
      render json: { message: e.message }, status: :forbidden
    end

    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: { message: e.message }, status: :not_found
    end

    rescue_from ValidationError do |e|
      render json: { errors: e.errors, message: e.message }, status: :internal_server_error
    end
  end
end
