class CheckingAccounts::Serialize
  extend Pagination

  def self.as_json(checking_account)
    checking_account.as_json(
      include: %i[
        user
        account
      ]
    )
  end

  def self.collection_as_json(checking_account)
    paginated_json(checking_account, json_options: {
                     include: %i[
                       user
                       account
                     ]
                   })
  end
end
