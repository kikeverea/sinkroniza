module EmergencyRequestsHelper

  def emergency_request_badge(emergency_request)
    color =
      case emergency_request.status
        when "request"
          "primary"
        when "approved"
          "success"
        when "granted"
          "success"
        when "rejected"
          "danger"
        when "cancelled"
          "warning"
        when "expired"
          "gray-600"
        else
          raise "Invalid status: #{status}"
      end

    badge(emergency_request.status_text, color)
  end
end