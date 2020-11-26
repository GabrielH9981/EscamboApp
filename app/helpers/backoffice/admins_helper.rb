module Backoffice::AdminsHelper
   OptionsForRoles = Struct.new(:id, :description)
   

    def options_for_roles()
        roles_i = {"full_access" => "Acesso Completo", "restricted_access" => "Acesso Restrito"}
        roles_i.map do |key, value|
            OptionsForRoles.new(key, value)
        end
    end
end
