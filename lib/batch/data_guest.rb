class Batch::DataGuest

  # guestuserの投稿を削除
  def self.data_reset
    customer = Customer.find_by(email: "guest@example.com")
    Rails.logger.info("----------------------------------------")
    Rails.logger.info customer
    Rails.logger.info("----------------------------------------")
    customer.posts.destroy_all
    customer.comments.destroy_all
  end
end