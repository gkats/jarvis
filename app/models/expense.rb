class Expense < ActiveRecord::Base
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates_numericality_of :price
  validates_presence_of :date

  def tag_list
    tags.map(&:name).sort.join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def as_json(options = {})
    super(only: [:id, :price, :date, :description]).merge({ 'tag_list' => tag_list })
  end
end