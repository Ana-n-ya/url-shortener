class Url < ApplicationRecord
  validates :original_url, presence: true, format: URI::regexp(%w[http https]), if: :original_url_present?
  validates :short_code, uniqueness: true

  private

  def original_url_present?
    original_url.present?
  end
end

