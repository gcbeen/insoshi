# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string(255)
#  locked_at              :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string(255)
#  uid                    :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
		 :confirmable, :lockable, :omniauthable, :omniauth_providers => [:google_oauth2, :google, :github, :weibo, :qq_connect, :tqq]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :provider, :uid, :city, :nickname, :signature, :introduction #, :current_password
  # attr_accessible :title, :body

  has_many :blogs, :dependent => :nullify
  has_many :topics, :dependent => :nullify
  has_many :comments, :dependent => :nullify
  has_many :photoes, :dependent => :nullify

  acts_as_followable
  acts_as_follower
  
  acts_as_liker

  has_many :favorites
  
  include Gravtastic  
  gravtastic

  def following_activity
	PublicActivity::Activity.where(owner_type: 'User').where(owner_id: self.all_following.map(&:id))
  end

  def self.from_omniauth(auth)
	#Rails.logger.info "----------auth----#{auth.info.email}--------"
	#Rails.logger.info(auth.info.nil? ? auth : auth.info)
    if auth.info.email && user = User.find_by_email(auth.info.email)
      user.provider = auth.provider
      user.uid = auth.uid
      user
    else
      where(auth.slice(:provider, :uid)).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.nickname = auth.info.nickname
        user.email = auth.info.email || ''
        user.avatar = auth.info.image
      end
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def email_required?
    super && provider.blank?
  end

  def password_required?
    super && provider.blank?
  end
  
  def confirmation_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  def favables(type)
	favorites.favables type
  end

  def favable?(obj)
	!!favorites.favable(obj)
		#where(favable_type: obj.class.to_s, favable_id: obj.id)
	#favables(obj.class.to_s).include? obj
  end

  def favable(obj)
	@favable = favorites.new()
	@favable.favable = obj
	@favable.save
	#favable_type: obj.class.to_s, favable_id: obj.id)
  end

  def unfavable(obj)
	@favable = favorites.favable(obj)#first(favable_type: obj.class.to_s, favable_id: obj.id)
	@favable.destroy if @favable
  end

  # overwrite nickname
  def nickname
	read_attribute(:nickname) || email
  end

end
