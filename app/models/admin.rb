class Admin < ActiveRecord::Base

  ROLES = {:full_access => 0, :restricted_access => 1}

  enum role: ROLES
  #0 = admin   ||   1 = User normal
  scope :with_full_access, -> { where(role: ROLES[:full_access]) }
  scope :with_restricted_access, -> { where(role: ROLES[:restricted_access]) }

  # Ex:- scope :active, -> {where(:active => true)}

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def role_br
    if self.role == "full_access"
      return "Acesso Completo"
    else
      return "Acesso Restrito"
    end
  end
  
    
end
