class Folder < ApplicationRecord

  company_scoped optional: true

  before_save :set_path

  belongs_to :parent_folder, class_name: "Folder", optional: true
  has_many :child_folders, class_name: "Folder", foreign_key: "parent_folder_id", dependent: :destroy

  scope :parents, -> { where(parent_folder_id: nil).order(:name) }

  validates :name, presence: true

  def has_parent?
    parent_folder_id.present?
  end

  def path
    path_value = super
    path_value.nil? ? name : path_value
  end


  private

  def set_path
    return if parent_folder_id.nil?
    return if persisted? && !will_save_change_to_parent_folder_id?

    self.path = "#{parent_folder.path}/#{name}"
  end
end
