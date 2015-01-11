class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar,
                    :storage => :s3,
                    :s3_credentials => Proc.new{|a| a.instance.s3_credentials },
                    :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :default_url => "https://s3.amazonaws.com/predikt-app/missing.jpg"

  validates_attachment_content_type :avatar, 
                                    :content_type => /\Aimage\/.*\Z/

  def s3_credentials
    {:bucket => ENV['S3_BUCKET'], :access_key_id => ENV['ACCESS_KEY_ID'], :secret_access_key => ENV['SECRET_ACCESS_KEY']}
  end
end
