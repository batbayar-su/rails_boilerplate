# User model (table: users)
class User < ActiveRecord::Base
  rolify
  acts_as_paranoid
  # scope :not_deleted, -> { where('is_deleted = 0') }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable

  validates :first_name, presence: true, length: { maximum: 255 }
  validates :last_name, length: { maximum: 255 }
  validates :display_name, length: { maximum: 255 }
  validates :phone_number, length: { maximum: 255 }
  validates :address, length: { maximum: 255 }
  validates :post_code, postal_format: true
  validates :role_ids, presence: true, on: :update

  # before_create :not_deleted_status
  after_create :assign_default_role

  # def self.find_for_authentication(conditions)
  #   super(conditions.merge(is_deleted: 0))
  # end

  # uusgehiin omno ustgagdaagui baigaag shalgah
  # def not_deleted_status
  #   self.is_deleted = 0
  # end

  # uusgesnii daraa default role zaaj ogoh
  def assign_default_role
    add_role('User') if roles.blank?
  end

  # role-uudiig ustgah
  def delete_roles
    roles.delete(roles.where(id: roles.ids))
  end
end
