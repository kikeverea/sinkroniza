module CompanyScoped
  extend ActiveSupport::Concern

  class_methods do
    def company_scoped(optional: false, uniq_fields: [])
      before_validation :set_company, on: :create

      belongs_to :company, optional: optional

      validates :company_id, presence: true unless optional

      uniq_fields.each do |uniq_attribute|
        validates uniq_attribute.to_sym, uniqueness: { scope: :company_id }
      end
    end
  end

  private

  def set_company
    self.company ||= Current.company if defined?(Current)

    errors.add(:current_user, "debes pertenecer a una compañía para realizar esta acción") if
      Current.user && !self.company && !Current.user.super_admin?
  end
end
