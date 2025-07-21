class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def receive
    webhook_data = {
      timestamp: Time.current,
      headers: request.headers.env.select { |k, v| k.start_with?('HTTP_') },
      params: params.except(:controller, :action).to_unsafe_h,
      body: request.body.read
    }

    Rails.logger.info "Webhook received: #{webhook_data.to_json}"

    render json: { status: 'received', timestamp: Time.current }, status: :ok
  end
end
