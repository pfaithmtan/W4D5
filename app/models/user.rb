class User < ApplicationRecord
  validates :email, :password_digest, :session_token, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }, presence: true
  
  attr_reader :password
  #giving user a username and password
  #when we save we also need a password_digest and a session_token
  after_initialize :ensure_session_token
  
  has_many :comments
  
  #belongs_to then the foreign key will be in the table that you're currently in, then it
  # be otherThing_id
  
  #has_many foreign key is in the other table, then it should be called user_id
  
  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    
    user && user.is_password?(password) ? user : nil
  end
  
  def password=(pw)
    @password = pw
    self.password_digest = BCrypt::Password.create(pw)
  end
  
  def is_password?(pw)
    BCrypt::Password.new(self.password_digest).is_password?(pw)
  end
  
  def ensure_session_token
    self.session_token ||= generate_session_token
  end
  
  def generate_session_token
    SecureRandom.urlsafe_base64
  end
  
  def reset_session_token
    self.session_token = generate_session_token
    self.save!
    self.session_token 
  end
  
  
end 