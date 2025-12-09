# app/serializers/series_serializer.rb
class SeriesSerializer < JSONAPI::Serializer
  attributes :title, :synopsis, :kind, :status, :episodes_count,
             :seasons_count, :view_count, :year, :total_episodes,
             :release_date, :end_date, :created_at, :updated_at

  attribute :titles do |series|
    series.titles
  end

  # attribute :average_rating do |series|
  #   series.ratings.average(:score)&.round(2) || 0.0
  # end

  # attribute :total_ratings do |series|
  #   series.ratings.count
  # end

  # Active Storage URLs
  # attribute :cover_image do |series|
  #   rails_blob_url(series.cover) if series.cover.attached?
  # end

  # attribute :banner_image do |series|
  #   rails_blob_url(series.banner) if series.banner.attached?
  # end

  # Computed attributes
  # attribute :is_popular do |series|
  #   series.view_count > 100_000
  # end

  # Relationships (optional)
  # has_many :ratings
end
