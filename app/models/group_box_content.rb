class GroupBoxContent < ActiveRecord::Base

  belongs_to :group_box_meal
  belongs_to :product
  
  has_one :group, through: :group_box_meal
  has_one :box, through: :group_box_meal

  def human_readable_quantity
    begin
      ActionController::Base.helpers.number_to_human(quantity, :units => "units.#{product.unit}", :precision => 3)
    rescue I18n::MissingTranslationData
      ActionController::Base.helpers.number_to_human(quantity, :units => {unit: product.unit}, :precision => 3)
    end
  end
  
end
