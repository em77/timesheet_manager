class AddCompanyReferenceToJob < ActiveRecord::Migration[5.0]
  def change
    add_reference(:jobs, :company, index: true)
  end
end
